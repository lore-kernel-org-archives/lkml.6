Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA138C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 18:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FD1420BF2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 18:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nexb-com.20150623.gappssmtp.com header.i=@nexb-com.20150623.gappssmtp.com header.b="AQyroKRE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FD1420BF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nexb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbeHVVnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 17:43:24 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35772 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727678AbeHVVnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 17:43:23 -0400
Received: by mail-wm0-f66.google.com with SMTP id o18-v6so3165080wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 11:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexb-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CHyn/FOH65N8moIzKXLMI6oINRaLGEgNFVKgwfxC2jA=;
        b=AQyroKREv0t5MCftpsFMv0mRCjkJSWI0IbUFhS3ikCcrZnR3oI5jFrnhNeGVYwgHQ5
         8tZJOpD1i+xWOjmaw+UL51mh06/S8WhuMKuoTsRU5SOVeaArUp38wprPVdcpyG2CvhQu
         rLnWVCRmhVYEyB1+E3OOEtCRC7Xp8KhM2vpC7LNFZfZxnYVbapuaBO2SfO47j3ToD5hf
         RvW4RQ+u6w0FKtGEAKy+xH3ESuUVAod14cJ2c085VKmZVXDM0wkYOc0S7+ETWCVPljVX
         XfbDsEATIB1uxi8QLWcym2Z2YO3W4HGvH8+1D+5O6w0oInsmzmHeQXObqyViPXIwkJ+3
         XVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CHyn/FOH65N8moIzKXLMI6oINRaLGEgNFVKgwfxC2jA=;
        b=lIcsv91cPm0H9cT27YXw3wQ7RPBo/gJdc8s3GLO26fBPV5lRMr+jiehl3Odj60wDxR
         rlnddP+Iv0KYapj2GmENNI5MbbDToRwwmAIbkL/ssyCyggRuiBHTEwrWyTRCqx/zaToh
         6aHJG0Pufnyv8Cnymfflqyzmc3yDpjr5R1dfjz73L1Vz7qH0N8zisN1ReCJRN+yh3gzb
         zjUaKsoISt2TvD8PUtkFnbGLoIEtV1tUc36o2lRrjKufqtPuVTqE3/spshpGtgjqh/Ur
         GDQ17sopBLhHcdSiSj2oOUXve+kCLY9LZH3CPIjgpVQ/Sf9uMUfIOkG+gpFrwrDbFpdd
         vOCw==
X-Gm-Message-State: APzg51DzCBMkTfuPmWUmVGzkoNkauQXD6wHnaXgVvaT5hLwde4kTe1NG
        RO4V89VzLW+FvUnkghmh8oDRxLh2YN3IuJkujNfh+w==
X-Google-Smtp-Source: ANB0Vdac/IsySZfzq9hUZb3owfqnY1m9FpofQpzXuDHdZOIbngr7qamPU92QUBGLye9jEMdOblNqMfCSFNbRlVMjySQ=
X-Received: by 2002:a1c:9945:: with SMTP id b66-v6mr2948953wme.159.1534961845663;
 Wed, 22 Aug 2018 11:17:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:e8ca:0:0:0:0:0 with HTTP; Wed, 22 Aug 2018 11:16:45
 -0700 (PDT)
In-Reply-To: <CAOMZO5BiAyDMSR=2Y-4-1ftNuVtRS59sSJd_cdFmzX=0kgF0Bw@mail.gmail.com>
References: <20180821220233.9202-1-wsa+renesas@sang-engineering.com>
 <20180821220233.9202-6-wsa+renesas@sang-engineering.com> <CAOMZO5AkVNiYMGdED9erL=YMaKcmtS5BzZxw2gO1KLXEaPnD7A@mail.gmail.com>
 <20180822063005.535lytz7hl32rsha@katana> <CAOMZO5BiAyDMSR=2Y-4-1ftNuVtRS59sSJd_cdFmzX=0kgF0Bw@mail.gmail.com>
From:   Philippe Ombredanne <pombredanne@nexb.com>
Date:   Wed, 22 Aug 2018 20:16:45 +0200
Message-ID: <CAOFm3uF9_rbELx0aYLDXpDnZfi2Z11V1Z4Ktw+DDJT62o2S1kQ@mail.gmail.com>
Subject: Re: [PATCH 05/11] can: rcar: use SPDX identifier for Renesas drivers
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>, linux-can@vger.kernel.org,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,
On Wed, Aug 22, 2018 at 2:55 PM, Fabio Estevam <festevam@gmail.com> wrote:
> On Wed, Aug 22, 2018 at 3:30 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
>>
>>> > +// SPDX-License-Identifier: GPL-2.0-or-later
>>>
>>> According to Documentation/process/license-rules.rst the format should
>>> be like this instead:
>>>
>>> // SPDX-License-Identifier: GPL-2.0+
>>
>> According to https://spdx.org/licenses/ it should be what I did above.
>
> Previous advice I saw was to follow the format described in
> Documentation/process/license-rules.rst
>
> Greg/Philippe,
>
> Any inputs on this matter?
>
> Thanks

IMHO we should always treat and use the
Documentation/process/license-rules.rst as the reference and not SPDX
proper who moves at its own pace and evolves its specs and license ids
independently of where we stand in the kernel.
If this is not right Doc patches are welcomed!
In this is very specific case this has been discussed on list a few
times. If I recall correctly Thomas also had an opinion on this...
So you are correct and this should be for now:
// SPDX-License-Identifier: GPL-2.0+

-- 
Cordially
Philippe Ombredanne
