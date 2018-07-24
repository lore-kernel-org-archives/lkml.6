Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53856ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FAC02064D
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tjlR2exB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FAC02064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388668AbeGXQCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 12:02:09 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38520 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388528AbeGXQCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 12:02:08 -0400
Received: by mail-lj1-f193.google.com with SMTP id p6-v6so3856248ljc.5;
        Tue, 24 Jul 2018 07:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9+5hKwv5kBROIdF/SY+QXS0Q/cPQu29zK930oQGb2mY=;
        b=tjlR2exBL21hjwgJB168eRbmfrPFbtRFgWtjyaaCAKvvYPvjqoWITM/4auRE/EkHRo
         cGlf5IXIOQ/niF12/CuksH7XFSFIY5I7j/murtLaRgwqrYY/zFiTGogrHw8tiT8FE6W6
         43zW5a0viKcL5lTZMLfnB/mXXVxOJW2rcPXCrV6gNYxJTC3jp1sf0dJZpmsLb2fvVrUo
         Sy21JaP7iWkgWKT9sHaqusS5g2wPo5ezTbD/W66vdI1JMoQ11SkHzPit4TXITaDUPgF5
         UaYpw0aje7wkBgUhAd6YVWtTg6SBku8NQO0zLI86Uy1PLBEvtStEe+nFwqVZQcNepm72
         O/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9+5hKwv5kBROIdF/SY+QXS0Q/cPQu29zK930oQGb2mY=;
        b=UwiVMEPRiKpoHN8KXs3JzlT9vit/RwTLsR8RH4t/4AHFg+/kDnWPqimo/uhzUwqpMq
         lNw4s6pY4Q7BW6Wnw09crC/hk++tQT0trqTT0hFkajEGKForGZH9rSPJgB9kdhAI5cog
         kalxj+q9GOkGoogE6QswWDW2gaJabBlrUn/og0o+dQ5U9lpMLYd5rJ+BRx5LoRcPb5ZP
         HKJEd7GrlZgEEGgka/XdhF4LfcZ4J+BNlJiMDqZUlqtVmfZK2ScTCNKjQgEwdTXVRP1h
         8VLfiA8ui9qdtFwGC4kEwDNyT6yQxYdFE2JoakVOYFfD8W45ao1P+alIHjR1pGHiY4QP
         iMNw==
X-Gm-Message-State: AOUpUlERhhroESH6o6M/yE2st+wKY/S2qReMK6N40jD1iibM9qaQpfEC
        zhywH2//ElLhp+qCwinYJkw=
X-Google-Smtp-Source: AAOMgpfDg+cQ0TjoPJnUKtx7oPV0ve4o2WIqM2Jsvc1+KxhAZZ16iTaWWOS2Vp7NkP/gTrEkrgL2AA==
X-Received: by 2002:a2e:9599:: with SMTP id w25-v6mr3833693ljh.6.1532444115630;
        Tue, 24 Jul 2018 07:55:15 -0700 (PDT)
Received: from dimapc.localnet (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id a9-v6sm1823224lfi.59.2018.07.24.07.55.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 07:55:15 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH 01/28] ARM: tegra: apalis_t30: enable broken-hpi on emmc
Date:   Tue, 24 Jul 2018 17:55:14 +0300
Message-ID: <3879609.rmqHIZXFHx@dimapc>
In-Reply-To: <1532442416.6124.28.camel@toradex.com>
References: <20180722164936.20581-1-marcel@ziswiler.com> <1992775.WBgY65Ajyy@dimapc> <1532442416.6124.28.camel@toradex.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 24 July 2018 17:26:58 MSK Marcel Ziswiler wrote:
> On Tue, 2018-07-24 at 17:03 +0300, Dmitry Osipenko wrote:
> 
> > On Sunday, 22 July 2018 19:49:09 MSK Marcel Ziswiler wrote:
> > 
> > > From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > > 
> > > Avoid eMMC issues by specifying broken-hpi.
> > > 
> > > Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > > 
> > > ---
> > 
> > 
> > Is it a specific eMMC card model that has broken HPI or it is a host 
> > controller bug?
> 
> 
> That is a very good question. So far we only have confirmation that at
> least some eMMCs from Hynix resp. SKHynix definitely do have bad
> firmware. I also found out that ASUS resp. Google did disable HPI on
> their Nexus 7 tablet. Therefore, we also disabled HPI quite a while ago
> in our downstream BSPs which we successfully validated & verified doing
> power cuts and running stress tests in our temperature chambers. I
> guess we would have to run more extensive tests with mainline with and
> without this setting to be able to really answer your question. For now
> I just successfully run a few Apalis T30 and Colibri T30 modules with
> this setting over the weekend doing both hdparm -t as well as dding
> some urandom files to the eMMC in a loop without seeing any issues.

The broken-hpi quirk was added for the Hynix cards specifically in [0]. Maybe 
you should just extend the mmc_ext_csd_fixups list in [1] with another OEM ID?

[0] https://patchwork.kernel.org/patch/9168455/
[1] drivers/mmc/core/quirks.h



