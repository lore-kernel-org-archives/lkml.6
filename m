Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FA2C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B26C1208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synesis-ru.20150623.gappssmtp.com header.i=@synesis-ru.20150623.gappssmtp.com header.b="ytXKibh3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B26C1208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synesis.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732105AbeKNDoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 22:44:34 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41776 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731280AbeKNDod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 22:44:33 -0500
Received: by mail-oi1-f196.google.com with SMTP id g188-v6so11072535oif.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 09:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=synesis-ru.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vx2/4wUFRzu5D7MkzlkLNthh/OFBcMbFMGJaUkdFXZo=;
        b=ytXKibh3KDj/FQVZtrSWn3sdUcvFZiEfj0Z/7h13/7ncTvyaH8xc5xV3Bny9x5fcF4
         riL94uGDOJWyfhxlAaA9vxZvtyixSgqVhiGvWPo6ddgFRKnO3t3n8Me+hRpbXq4w5V0Q
         9hpVweitvDonIsDNyShs+h1sATpICBz6TY+9JoUIw3OxBhx1YuTxd4TPlGusdf8Aip93
         9Pk8P2Povp/hetgdaFiA9Xoowl5lqthqrgiAnMDWVxaveN36le9axzvF0pGl2oyUivQB
         uPgs0KYW8pXgRpFPVUkYeP/D9IaFFbp19htftvk+ZGlwC4nuTkFWS+7mQXCJcAg/pSTP
         4YsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vx2/4wUFRzu5D7MkzlkLNthh/OFBcMbFMGJaUkdFXZo=;
        b=WI4v3bmTOW2mFm/bBodDapuwOSUDrkDI3Jdq7nP3I5NrlThO0Cs/NrclJPj0O5R18i
         UFPAzITKzpLXP5duXPkKA35s9rGNDiTx+uTQdbcHJanPK5JLZh5u5v8AiHe6BmDMr1VX
         B35TVIFBHCSudsRCPDmfqpPUg5Z1pLiXa3KlA5AjVLaZfmTwq4cdk9MROGkGma/9lNfN
         xUlzyCbml06xEPFWvgDUx0ilYgxWmuZRnBvlE3MrMpLG2WzKHFulDX6zh3M3J8l1+6TF
         rhthpnb3WoKNVt04AXk8caHX53nKmn55Ou/iMq0LdUDnOWk7EHSB+5vglkUKpRuK4Xeu
         G7Jw==
X-Gm-Message-State: AGRZ1gJ+UNEonmzVGDpg/jbMqqpCHzEUSCD1x/PtHS/8A1vALkJwpYmU
        Rs6h5ncVjYmfaHzySSwBynrg2ST3GL/YE0KN
X-Google-Smtp-Source: AJdET5c7xThq5Dvx9JQa9LS53z5A2Puu3rBX1KBPCHINgi7Iir2FKc+Rq3kWSHRnnXnJRsDGvGZfuQ==
X-Received: by 2002:aca:ba84:: with SMTP id k126-v6mr3649083oif.159.1542131126067;
        Tue, 13 Nov 2018 09:45:26 -0800 (PST)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com. [209.85.210.43])
        by smtp.gmail.com with ESMTPSA id w31sm10168239otb.57.2018.11.13.09.45.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 09:45:24 -0800 (PST)
Received: by mail-ot1-f43.google.com with SMTP id 40so12133067oth.4;
        Tue, 13 Nov 2018 09:45:24 -0800 (PST)
X-Received: by 2002:a9d:2d81:: with SMTP id g1mr3430247otb.111.1542131123903;
 Tue, 13 Nov 2018 09:45:23 -0800 (PST)
MIME-Version: 1.0
References: <d45addefdf05b84af96fb494d52b4ec4@natalenko.name>
 <CAGqmi77Ok0usUt5gfyPMYx22FdgqntSrwiap7=DT81HZuvNm_Q@mail.gmail.com> <5a9ef9a0c8ed688e1566fc7380915837@natalenko.name>
In-Reply-To: <5a9ef9a0c8ed688e1566fc7380915837@natalenko.name>
From:   Timofey Titovets <timofey.titovets@synesis.ru>
Date:   Tue, 13 Nov 2018 20:44:47 +0300
X-Gmail-Original-Message-ID: <CAGqmi75sDjHRT0efM4RW06UQEXvfneGoOtahidbk_jaSMzXCxw@mail.gmail.com>
Message-ID: <CAGqmi75sDjHRT0efM4RW06UQEXvfneGoOtahidbk_jaSMzXCxw@mail.gmail.com>
Subject: Re: [PATCH V3] KSM: allow dedup all tasks memory
To:     oleksandr@natalenko.name
Cc:     linux-doc@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=B2=D1=82, 13 =D0=BD=D0=BE=D1=8F=D0=B1. 2018 =D0=B3. =D0=B2 20:27, Oleks=
andr Natalenko <oleksandr@natalenko.name>:
>
> On 13.11.2018 18:10, Timofey Titovets wrote:
> > You mean try do something, like that right?
> >
> > read_lock(&tasklist_lock);
> >   <get reference to task>
> >   task_lock(task);
> > read_unlock(&tasklist_lock);
> >     last_pid =3D task_pid_nr(task);
> >     ksm_import_task_vma(task);
> >   task_unlock(task);
>
> No, task_lock() uses spin_lock() under the bonnet, so this will be the
> same.
>
> Since the sole reason you have to lock/acquire/get a reference to
> task_struct here is to prevent it from disappearing, I was thinking
> about using get_task_struct(), which just increases atomic
> task_struct.usage value (IOW, takes a reference). I *hope* this will be
> enough to prevent task_struct from disappearing in the meantime.
>
> Someone, correct me if I'm wrong.

That brilliant, i just missing that api.
That must do exactly what i want.

Thanks!

> --
>    Oleksandr Natalenko (post-factum)
>
