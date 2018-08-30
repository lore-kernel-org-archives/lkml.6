Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001FEC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C95520661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ettus-com.20150623.gappssmtp.com header.i=@ettus-com.20150623.gappssmtp.com header.b="kYpeiH5N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C95520661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ettus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbeH3Umj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 16:42:39 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:35072 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbeH3Umj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 16:42:39 -0400
Received: by mail-yw1-f66.google.com with SMTP id 14-v6so3816243ywe.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 09:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ettus-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UC8JHC7hrUNBKkOeSGV9nkeySuMkGgUWiA4NRqL57xo=;
        b=kYpeiH5NFmDenzPo0hnoDNWnFrNkiJnnIKFLo9eT55ppTT3rkz54V6EpQcBaxBAtEA
         I/jNa5cBuFZ/ug8BaqJJXpiPqzggexqMkaiZiWXMhY+ozyxdcfPgjoBUdBnV6lTQvLnh
         +gh9VITl4JidCVWIAZWnEiNU3oimjiwjm27TJUvTLIQJuO9+wv1ENowvxRZFQ9Kp+eB/
         wJW25df7sjO0GJUbeQn6QEoVtzhP/YkgNw7hXvdue8/LlrKOE8nw5NnSYZ1YVZXO/+Mo
         D7EYxbsRsEGmuV2hBRlBaVD+PjjWyaXnSaLldF6LGQpttzw5oN/wRRyv/6M8nfTIwXdY
         jH0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UC8JHC7hrUNBKkOeSGV9nkeySuMkGgUWiA4NRqL57xo=;
        b=BGYrDm4VQ9Ga/STfERgd1Y6G31arWhigi4z1riVxPvFuuBZrGUEnyC734uIzVelyx7
         5e69MUe2kZ7w/LjqOtdbhvay5RXVlD4JqXgPqzkXnOpCfvyxo0mKZg+ncR3CdbbiyMFA
         w6LWlbgtp7mwI79XYZVKHIM9EZWibZms+ip7ENxExzfALjapBdGUcxXaRUzlMVpftWKo
         eKIFIjtH5oU5XY4QicwfsqI1lJ1XLTVDwSwU9q3LbffslkNOLFCo0tR/p5wmPpRneM/0
         rcLUX/cfUIs8jgf99tlQgb8bRIlnhKV2tkIZof9E50iEbbK1boj5E0NriV+JQdaQcxqm
         iNMw==
X-Gm-Message-State: APzg51BkhaXCue0ObPxJILjLA1rhYye7ZQ59gHD8ldPMBz0BT/9a3+W8
        r2uOIINCIQ4ifRrrTVEkDFQAtaZ4uFb8SuL+p77Zrg==
X-Google-Smtp-Source: ANB0VdbN/jkxD0raj9f4N4BczKXfc+iF3oV0HtunpdtJKFmJ5uXVCGqLqSJkPXTDrg04E6Yz+JEDl03lVJ/PeyWRHCs=
X-Received: by 2002:a25:d657:: with SMTP id n84-v6mr6226903ybg.62.1535647179899;
 Thu, 30 Aug 2018 09:39:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a81:3c0a:0:0:0:0:0 with HTTP; Thu, 30 Aug 2018 09:39:39
 -0700 (PDT)
In-Reply-To: <20180830031110.GC16896@lunn.ch>
References: <20180830004046.9417-1-mdf@kernel.org> <20180830004046.9417-3-mdf@kernel.org>
 <20180830031110.GC16896@lunn.ch>
From:   Moritz Fischer <moritz.fischer@ettus.com>
Date:   Thu, 30 Aug 2018 09:39:39 -0700
Message-ID: <CAAtXAHceYgPx4A7F14AYEQs9RFo2hP6JTkApHa_GtbxVcdiQNA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] net: nixge: Add support for having nixge as subdevice
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, Alex Williams <alex.williams@ni.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Wed, Aug 29, 2018 at 8:11 PM, Andrew Lunn <andrew@lunn.ch> wrote:

> Could you tell us more about the parent device. I'm guessing PCIe.  Is
> it x86 so no device tree? Are there cases where it does not have a PHY
> connected? What is connected instead? SFP? A switch? Can there be
> multiple PHYs on the MDIO bus?

The device is part of a larger FPGA design. One use case that I was trying
to support with this patch is PCIe with x86 (hopefully on it's own PF...)
Since the whole design isn't completely done, these are the use cases I
see upcoming and current:

ARM(64):
a) DT: PHY over MDIO (current use case), fixed-link with GPIO (coming)
b) DT: SFP (potentially coming)

x86:
a) no PHY (coming)-> fixed-link with GPIO
b) SFP (potentially), PHY over MDIO (potentially)

Thanks for your help,

Moritz
