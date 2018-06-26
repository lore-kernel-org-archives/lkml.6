Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC73AC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 22:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55F73269A9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 22:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6MmWVD4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55F73269A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933269AbeFZWIc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 18:08:32 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:39403 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932107AbeFZWIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 18:08:30 -0400
Received: by mail-ot0-f193.google.com with SMTP id l15-v6so20766986oth.6;
        Tue, 26 Jun 2018 15:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LkLiI+xNFB0DvUJhRiPcaspx0iJ7gMOJLuboIlBtnHQ=;
        b=k6MmWVD4CKFJH+3ysRxrNwREbE8dO3nE+LXrPNAKfbCr3dXIVOXqfuxTlRrwdUz+op
         bjIkJisYwZMsCQ60OAYQDxgLtJrS3W4mCThzS9eqp214D08UITG8ChwFpf8n8ttAmNc2
         h64MdC9LbIWoUhxLt+2YNWSUDfkJStDhmMmgLtO11Fqj1icIVQu7gmQErFgorhbeHH27
         5pXd2mHsgtSEGoyNUzqxD0gnM7ciYlL23CmMIeFfJnGmMe6pcN41tKrATFK23XkDFrKK
         L8SESo9YEJhvVNnTManOjH3CXoM7c5zknyegM5yBiIjG04wytaZZyUmyZLZRylkVinP3
         O6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LkLiI+xNFB0DvUJhRiPcaspx0iJ7gMOJLuboIlBtnHQ=;
        b=fernoWhCKdTZPayq9UqO3Y2967huVfNSsTHxyS4hsEU/f/ZV8H4+KBR2SNJJZ32EHd
         +DclZxWVNOCQqbmhseRbnGYxCFl+EGVuL4NPkGFLImWk4OJwsxhvH3FuxydGSH1n8WOX
         9wL8GuGas9GSB6f4svRCGB5U2vGy5MUw8X3HJ0y8/gnjG/gwO9Gtf6brjtnTQn4mNXqw
         7LRcmvQ+Ks85xU+hcNrCCVUlKuEZpDWKaP1Exuo3pax9//OeGnawewTRra5PTEW/22Ow
         04c6C35e7yNiw3IazfEBb+4AyZ2fzj9zJI2AqmBP2yxM+wCp4O4lwFpqKUTLW22CXBX9
         beJA==
X-Gm-Message-State: APt69E0FtorPPAR3wDEeiOTAX18OxRVi6lrMOXOlU649j+qvEACH0JPh
        zcYooHjLjTLZbNavUCFXTfSWxPEU0dz9qjdN4Lk=
X-Google-Smtp-Source: AAOMgpcshIidg1FaeK2lsXzBtHbAF2GXPZQsbA4wk7Li6UqVQKcDcxVG++SNbbKQBRp9jbaNrbqRZjOYLhWvSDt1YGg=
X-Received: by 2002:a9d:62d3:: with SMTP id z19-v6mr1805063otk.159.1530050910096;
 Tue, 26 Jun 2018 15:08:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1049:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 15:08:29
 -0700 (PDT)
In-Reply-To: <1529603100-31958-2-git-send-email-andrey.gusakov@cogentembedded.com>
References: <1529603100-31958-1-git-send-email-andrey.gusakov@cogentembedded.com>
 <1529603100-31958-2-git-send-email-andrey.gusakov@cogentembedded.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 26 Jun 2018 19:08:29 -0300
Message-ID: <CAOMZO5DavdUwke_ErO-mB6RWe3e20390GhDfB91F7QmLvr3VQw@mail.gmail.com>
Subject: Re: [PATCH 1/3] ARM: dts: imx51-zii-common: create common include dtsi
To:     Andrey Gusakov <andrey.gusakov@cogentembedded.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chris Healy <cphealy@gmail.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 2:44 PM, Andrey Gusakov
<andrey.gusakov@cogentembedded.com> wrote:
> Make shared include file. Move common stuff from rdu1 dts file to
> dtsi for future reuse by other imx51 based boards from ZII.
>
> Signed-off-by: Andrey Gusakov <andrey.gusakov@cogentembedded.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
