Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E4DC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 08:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0927A2148E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 08:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Yjw3R1d0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0927A2148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390013AbeHPLah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 07:30:37 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36240 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729008AbeHPLah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 07:30:37 -0400
Received: by mail-wm0-f66.google.com with SMTP id w24-v6so3534158wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 01:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oHST4KJG/oLlBlcO3FJia5ZTBJE+VizzTAVCt8Chva4=;
        b=Yjw3R1d0rWdEvqafHcy6vCEuV7JpbRievBLFSvHgi7fx5hlK0hVLD6GXfAQbvVLbZt
         4wUUfZ4XZwc0Ukm6xWzhOPmEmJRDWAZUCvp18Mh/Rx4PvC1jHMHYYyjx8q4KwDyAdlWI
         H5VxITgXpwzJnCXDvBhbdi2GsnhFAchnoxN6AxaWWFpwwjVITRdqDKCuxoFJOMJgoEF6
         3jKobrE5r0ctosZsAwvOfmBqgpbbnms8TF6K02D3peXurmJ0UXUdKFZFsfuDwwVXByyU
         Wyb8FXdSUP7dyA8+VSDwCqnmLfm/vh6itaGGgOdVxWhwC+NaZC2ojjbKX+wz5OWZbGvi
         t79g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oHST4KJG/oLlBlcO3FJia5ZTBJE+VizzTAVCt8Chva4=;
        b=BU+N0b8B1YbaHYFmj+X5QNcQAlvnTFdgWJm2W+FU99mCwsslSVEiyl9oH2QK+0kQ9Z
         V4IWNrKwSN88xrGMd50PyR+qoVPhp2l26crEeoj2qE2Rey3UX5w8yEZ035DojyTngBo2
         aKo/jcQlgz0Aiuhhc/02z/VUg8PAHtgIJ0ZiprGxuwtTVReWGjKW/Aozjv5wwO3e/Yfl
         FpGfZiwZl9CsFFCEYDKVjXvE6US7IvrJj0jYYg+3ufrYWGEVN1ag7x36gDZrvjNpftAa
         Y6HKCNiFx+grddgY1M5DMZRAPfI582ecO7jFcUuW3tosN6OcC64VMD9ySVFbm5xIjIie
         Etkw==
X-Gm-Message-State: AOUpUlHZnuRriOolHuv5Pbr+qFqEcGEX+r0Ro3RJf9i/5pgIuCLUkJbG
        msxeKOCI2tFv4LTnPuuYQUQ5Ww==
X-Google-Smtp-Source: AA+uWPyp7fV2p4HiamMT7Mx5HhpHsOGrCDhdkVAEDVoDbfJruUEhBEst+vvMFtRXs4bJXSD5guej4g==
X-Received: by 2002:a1c:5c4:: with SMTP id 187-v6mr15574786wmf.10.1534408421714;
        Thu, 16 Aug 2018 01:33:41 -0700 (PDT)
Received: from boomer ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id i125-v6sm883575wmd.23.2018.08.16.01.33.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Aug 2018 01:33:41 -0700 (PDT)
Message-ID: <e5d9d89e79f8ec37b6337e54912f49a0b0856874.camel@baylibre.com>
Subject: Re: [PATCH 2/2] PCI: meson: add the Amlogic Meson PCIe phy driver
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Hanjie Lin <hanjie.lin@amlogic.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Yue Wang <yue.wang@amlogic.com>, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Rob Herring <robh@kernel.org>,
        shawn.lin@rock-chips.com
Date:   Thu, 16 Aug 2018 10:33:39 +0200
In-Reply-To: <2b87e834-41e3-e418-95f0-c6d695cd8b3f@amlogic.com>
References: <1534227134-151584-1-git-send-email-hanjie.lin@amlogic.com>
         <1534227134-151584-3-git-send-email-hanjie.lin@amlogic.com>
         <486e8ab477cc22ff231d2e18d7de22efba2c5abd.camel@baylibre.com>
         <2b87e834-41e3-e418-95f0-c6d695cd8b3f@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-16 at 11:05 +0800, Hanjie Lin wrote:
> 
> On 2018/8/14 18:41, Jerome Brunet wrote:
> > On Tue, 2018-08-14 at 02:12 -0400, Hanjie Lin wrote:
> > > From: Yue Wang <yue.wang@amlogic.com>
> > > 
> > > The Meson-PCIE-PHY controller supports the 5-Gbps data rate
> > > of the PCI Express Gen 2 specification and is backwardcompatible
> > > with the 2.5-Gbps Gen 1.1 specification with only
> > > inferred idle detection supported on AMLOGIC SoCs.
> > 
> > It looks like the sole purpose of this driver is to provide the reset lines to
> > pcie driver.
> > 
> > I wonder why we need this ? Can't the pcie driver claim the reset lines itself.
> > 
> > Also, an init of this phy will always reset both port. What will happen if the
> > first port is in use and the 2nd port comes up ?? 
> > 
> > Looks the the pcie driver should claim 'apb' and 'phy' reset lines as "shared"
> > reset and the required 'port' as 'exclusive'
> > 
> 
> Thank you for your response.
> 
> Yes, 'apb' and 'phy' reset lines are shared, and ‘port' reset line is exclusive.
> If we handle all reset lines during the first port initial sequence, 
> and when the second port comes up, we will do nothing about the rest lines, 
> and don't need a extra API to do ‘port' reset;

With which other driver are your control shared ?

Looks it is the answer is none since this phy driver will reset both port
already, even if one is used.

In this case the fact that you are using shared control is just abusing the
framework to reset once.

As far as I can tell, this driver makes no sense. The appropriate reset lines
should be given directly to your pcie driver. 



