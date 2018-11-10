Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA9DC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 05:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 684A420840
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 05:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="boCZY01F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 684A420840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbeKJPZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 10:25:56 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44550 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728548AbeKJPZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 10:25:56 -0500
Received: by mail-ot1-f67.google.com with SMTP id z33so3605957otz.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 21:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=SL5CuRiOvJyDY5N/G6cMVSUBSSVFS1sOGU9ssPcvbLA=;
        b=boCZY01FjydSo/c4J+iw/PiJC0cTmPoSOAWeSVmnzmsVaIt4/m88Z+GfF4SZl3QBi1
         Ckl/Qrb+KOOWUzNHdAhxDh1jc0DVn0Qf9WSPzuQaYl+URqKkllN2uQM6ET+325RpTPf+
         js+jGU+toj6b9e4VFAcxuiSxCTh93U0bnfNZ/fB9BEATFiYQ1i7f3WArj2UNl1Q/m3ja
         jBIZc5faC1N/Cr/TFKOhU3Mpv2PZKJ0HfeJmkcUbKuOcC2Wu9qYMQWGFjYRR1llkfcKZ
         1X2Wy5fKXdhJHQGoG+t7vmzqArAggntmNVcLAOye6MeZXO9+muIRgqBRPycTjvGaPB4Q
         LPzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=SL5CuRiOvJyDY5N/G6cMVSUBSSVFS1sOGU9ssPcvbLA=;
        b=aPJnUsqOaa/aip1Tyld7LSep3EruPlkDNSV/fIofq681uSykLHRoePFTK9mSxLtVu+
         E3KDwlto73AaTJs3Bv+cdFuJwfLW+Xlc1cm9ZeySYFeMFKsJ+a0qteS2dVMk9cnnAxAu
         wgkZ1bbcDVWjNB4Khd4CnVZse0/hI/mslLYhu7SnOzTOki76eBnej3kj/o4yJwFl5zVz
         d/G2eX03zphY/iYN0+0dpWv+X6G5bSATIBRbktw2hAW9R1twKWkzIc4eAolC8YMh1VvL
         7jxB305zlC5NPzyZbj01nWg5oiXfld68QywSWeVPIO8gdyHP1fWNRczRSxplzeb5hbjE
         hZTg==
X-Gm-Message-State: AGRZ1gKMesLUY0SSXVXBPtunL7BD3M5cTcnXz2GaesU36ThjG2sKzdaJ
        nhbeSIo2PFOxVJzil2FaRbm4wZncLUPMGrKdUJo=
X-Google-Smtp-Source: AJdET5eYwMexDJB+z3bBsKLUQat3OzjixNuTHXcWO720QtZSsETNCid0V3m3NSORy5YHK4wZRyNqruspVebp71tDEmM=
X-Received: by 2002:a9d:2ea9:: with SMTP id w38mr6403885ota.99.1541826756860;
 Fri, 09 Nov 2018 21:12:36 -0800 (PST)
MIME-Version: 1.0
References: <20181109031303.GA20906@altlinux.org> <20181109031712.GL21511@altlinux.org>
 <CAEn-LTpbzdpeWv8wqo_ptBw2t3Ypzzp0JcB+TGMG4NZbEGBnkw@mail.gmail.com> <20181109222839.GB2054@altlinux.org>
In-Reply-To: <20181109222839.GB2054@altlinux.org>
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
Date:   Sat, 10 Nov 2018 06:12:25 +0100
Message-ID: <CAEn-LTpYOL1-MYdgOXXvv8DmsGeb5-Syt+HZBcmwgyz-wVvB6Q@mail.gmail.com>
Subject: Re: [PATCH 12/13] riscv: define syscall_get_arch()
To:     luto@kernel.org, Palmer Dabbelt <palmer@sifive.com>,
        aou@eecs.berkeley.edu, Paul Moore <paul@paul-moore.com>,
        eparis@redhat.com, lineprinter@altlinux.org,
        linux-riscv@lists.infradead.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 9, 2018 at 11:28 PM Dmitry V. Levin <ldv@altlinux.org> wrote:
>
> P.S. It would be great if you replied to me as well.
>

My apologies. I did hit "Reply All", but that somehow didn't
include all records from to, cc, to-replay fields :/
