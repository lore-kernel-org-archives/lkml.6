Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCCEC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E89F20663
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qmmt7s5v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730087AbfBEPpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 10:45:16 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:42173 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729815AbfBEPpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 10:45:16 -0500
Received: by mail-ot1-f53.google.com with SMTP id v23so6363784otk.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 07:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fYq3wHJRiEUQYz1qs8P8cUA+dgwTRO8dIxATL5QPICE=;
        b=qmmt7s5vjOFw7IeeXu5/iM5qpc7v3pYOZul+/rFmctCCxGE24f5Kf2a5MBBHPSc05G
         oDwxr9HQK+RiQLtsFfrwlbaH/HnGdkDuaoCDmgyszvDmucW9q6n2KYlPbIhYWPAShZwa
         gwl/PHWdbsVfkYbSiG8KiZl5IsP5de60hH2Q1MXpvMStMAKIM/17QYM3WMRc525qQQ3j
         o9haB/y+jp5nbzKYZk8JWqajNqPY52QTQ6fhlF4Q2mZ159AgtTL5rpppU01EleaQC4Y8
         WWfaAUrHXd5XUacVoY/wTZ1hKUmke/RM8MzGBql78gEwc9jMN+GrNr4ycjMPg+BzjK3Z
         LlHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fYq3wHJRiEUQYz1qs8P8cUA+dgwTRO8dIxATL5QPICE=;
        b=Ug9Js/nn5MAyFmqpeLuVAXc94qB+1vMmQJlOeD+3hD/rDett7ZwR6xUhCXRFLhEfAt
         GcHeRR6uopQb4+j3jIFlShJoYwjS73l1CTpttErOIdi68FrzMXxEFR/tyXoVmVMrO0DC
         jiXRlWLPiurs4Ei9y5FgyzPapX6lQ5IxzecBO3HB/xo59CF+xPZKVOj8dGGKt4mvLnkg
         c0I6H1hB1LqYkyzoPQLfq1h4QPTjDUatJmBFP+D7NSyASTjiAVIaQYLctuN/W9c+VRaE
         H6pYAjr3Xa+pxL4ZhRbuP5B50Ka2bfbJ4asLn6Jnt1SadRZvooRM5kSLK4FP+KcS+w4f
         sYGg==
X-Gm-Message-State: AHQUAuZDcBMmfYrN2kueplbH/6Ks1zH2hRZJG5XIKE57Lz8AY+vRF1nk
        JtOAwm8/+HHpqX4fjFLvSp1m0OwkocPVvt40ubNk3Q==
X-Google-Smtp-Source: AHgI3IbSeg9YA4CNc0hy/OOoEqmD0WnfDiL7wwpwv5bkWXbd5yttWfwM1ebkoEf5PBfhncH8I3hgCIa2fH/6sDjutZM=
X-Received: by 2002:aca:3092:: with SMTP id w140mr2911879oiw.237.1549381515227;
 Tue, 05 Feb 2019 07:45:15 -0800 (PST)
MIME-Version: 1.0
References: <20190129153700.18717-1-martink@posteo.de> <20190205135946.64eda55c@xps13>
 <CAOMZO5Cbhr-Wxu8W-oCKBP9NS3UN92=NUfYdkyYp-yy2oy12SQ@mail.gmail.com> <ff0c92b8-f26c-eb86-30bf-ec9f255b8ed5@ginzinger.com>
In-Reply-To: <ff0c92b8-f26c-eb86-30bf-ec9f255b8ed5@ginzinger.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 5 Feb 2019 13:45:11 -0200
Message-ID: <CAOMZO5AOcjbvhd+SJVL==+ieFH1pvpCzE7ZHBA+N8MPp_=a+mw@mail.gmail.com>
Subject: Re: [PATCH] mtd: rawnand: gpmi: fix MX28 bus master lockup problem
To:     Martin Kepplinger <martin.kepplinger@ginzinger.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Martin Kepplinger <martink@posteo.de>, bbrezillon@kernel.org,
        Manfred Schlaegl <manfred.schlaegl@ginzinger.com>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org, Han Xu <han.xu@nxp.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On Tue, Feb 5, 2019 at 1:42 PM Martin Kepplinger
<martin.kepplinger@ginzinger.com> wrote:

> Actually I rebased this from our 4.14 stable tree, so yes, I just forgot
> about that and I guess it would be
>
> Fixes: 6f2a6a52560a ("mtd: nand: gpmi: reset BCH earlier, too, to avoid
> NAND startup problems")
>
> Do you want me to add this and CC stable?

That would be nice. You can also add:

Reviewed-by: Fabio Estevam <festevam@gmail.com>

Thanks
