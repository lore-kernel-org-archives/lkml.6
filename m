Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8CFC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 20:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D759208DA
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 20:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r8M9Wkx2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D759208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966370AbeFOUQe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 16:16:34 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:33827 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966118AbeFOUQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 16:16:32 -0400
Received: by mail-ot0-f193.google.com with SMTP id r18-v6so12342242otk.1;
        Fri, 15 Jun 2018 13:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=waaXL1f1SUYHw+AtqubN/O2I4wMCT4W6oyLqRDEkLi8=;
        b=r8M9Wkx2uSnSvZL0+zPRBYvUjNUhba78ydUbV4xvEIVt7A7fBJSCGWkOBDqco9rA9w
         aFH2id9y75vshWOGdxGuUwPS6hOvSM+4vkrkRW3TWQSJ6UcXPpLwGNPqEGotmCRUdLoa
         14/2TWskGTzmbUZ8aZ6/4LDCn65q1+4jpB5uIw/22b4ku7NDdQbqgkA8JEoI0cLkQn6d
         n+CKLsw9RBgd1m5F8nZSu5lr7Krctfj4rQexlw0ZEWG1E00N9UAMr+8Ob7dGLhIgK8ki
         Cu/VkEOmZQwn4DwrPlEd/mBH7hDsweJ3OTS6Ep/S2LWaN6IjFeyuUkL2IxfNvDgMGNS3
         zWOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=waaXL1f1SUYHw+AtqubN/O2I4wMCT4W6oyLqRDEkLi8=;
        b=NuxhawoC5QDEokbh/CdM6hRouMaAGsPtzl5JKoOKQ+TbxpwgvLYO+X4N77YUP+1NMS
         ua3viXBYzq9qe6l/MQdqUra47l6eOL7M3PlOQXi+2238RdxMNdCjnvVSdT/LV+XIgwmg
         y25KWZ3x7Gof8l8swB6NCnDSVuzmqLXw2G08PQ8cKiPIgpXTOFsPYoAs1pTwLOWDG/98
         vh7BS3eJ69DG2FN/+Pw8kxWaN+r1+UaNOYLNLr5MZ+Sx4CBEDVNRHYe6F4idFV1x/DeD
         sPqqIXiwzSigpqjQ6XBPAcYIcGsCemfd9zINUwkdzrfIsYFUDgYtFY0SPbVfX9H3f7aE
         ot4g==
X-Gm-Message-State: APt69E18b3AHSE+6IwfkGGfRcBsmGSgBYx7deLzzfQSHpydNBBrpw2wp
        aLTkl+5lkcdS9IhBSxbOdYGUc2uwHAOSRPokEaI=
X-Google-Smtp-Source: ADUXVKK2busIxdsoCvYCDaqhv6n6cSxJEKWTf6TUS1ZII6vhGwLfZVG8FRVvdT5aGWNvrOvOYbcdr6mxgZLKZKpktl4=
X-Received: by 2002:a9d:cc8:: with SMTP id o8-v6mr2107022otd.38.1529093791584;
 Fri, 15 Jun 2018 13:16:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1049:0:0:0:0:0 with HTTP; Fri, 15 Jun 2018 13:16:31
 -0700 (PDT)
In-Reply-To: <a20cc6a0c278cc2791c0bdfc30a79b022de396ef.camel@nxp.com>
References: <b31ca3ff50566c193003614d0bbf5e0a0e95901c.1528390418.git.leonard.crestez@nxp.com>
 <CAOMZO5Czf1bO7vJZ1UG46DyVhzApqS82GFw+NFm_HN5tjD=xoQ@mail.gmail.com> <a20cc6a0c278cc2791c0bdfc30a79b022de396ef.camel@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 15 Jun 2018 17:16:31 -0300
Message-ID: <CAOMZO5D0fBcwD+6SHor+mGvB=7m8WrTmi-QPTYWjMnQchVATOg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: imx6qdl-sabreauto: Add sensors
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Duan <fugang.duan@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "slongerbeam@gmail.com" <slongerbeam@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 7:17 AM, Leonard Crestez
<leonard.crestez@nxp.com> wrote:

> Should I also assign a label, like "isl29023: light-sensor@44"? I
> couldn't find any recommendation on this.
>
> There are no immediate uses for a label but this practice is very
> common. Having labels allows creating minor board variants with reduced
> churn in the base dts so it seems good.

In the case of this specific board we don't have board variants, so no
need to add a label.
