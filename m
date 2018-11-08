Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9290DC32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54204208A3
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+pXONkW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54204208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbeKHUg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 15:36:27 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:54693 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbeKHUg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 15:36:26 -0500
Received: by mail-wm1-f51.google.com with SMTP id r63-v6so807028wma.4;
        Thu, 08 Nov 2018 03:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r/fjqMoHWiHN9DBSUYfKBKENXxv3ZwkoVd5pR5hamHA=;
        b=H+pXONkW1bRCab/tXPE9afk0/XdSKvOjjLG54pNQqeN1m5PSTyynG3ZY/xczI/T82L
         3t6ZiU0ypW37N7kV86TlEVvMFVHpNBIdawJ7OZM3Qg8WPew0BoUr+96Dpg3c4ea3jLei
         5VXFqCkAzLw/VNKipYz4KZg49sX35ufIf9PD/T84rbudmFuir6hdwkO4dC5jRoOPHhwx
         hwMy4i4jqg5ReaTnMtHMgbTNEHw1vDiLxaKwp03xNvJI2I+W/mK2F6r+av1Wjd2nuECZ
         In9K2RDOaljIHBtgo4a8ipvV1RnLWHoU4B4YEP0w9JGFkTR1/7p9+6o+YeyuwYMWv3Sw
         Ud1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r/fjqMoHWiHN9DBSUYfKBKENXxv3ZwkoVd5pR5hamHA=;
        b=iMMS+mhnuO3IxmbrtvSY9p4YNd4w42cPiCMmT0ZV52puPzGEUIgDFiq5FfU+1TZr7z
         Heq0lklmnGqKVj/LBjDVriZdFo4NXyMsOs2swOBmL1kopLOO5ruQdDdPtDLSCs1ykfoh
         RRG8O7xvzD9tAw+BHiPCUUMv2SbOY6waJiygLX8EIchtJCH0rQQpOqpbNlWPo/Y6dlc9
         hiVqG+VdsBpBDUYAF6xMQEYJX/m5ANzyqHyonV9FR+Yj28zvditiw9vb+4gzUJFc/esi
         VYHvFzbW2OAZ0+4aIO1Lodk7J6+GzpDevmpfKnIHJldQHBFNIOs1S3d3NkCNNyTto007
         qcrA==
X-Gm-Message-State: AGRZ1gKXAyDj3o2CpMDe1mx4eYcfDg2R1s3QPGresvgQ4i8lwT1hHdnd
        HdgeEexqHS66Lf+IAHCjr+Q=
X-Google-Smtp-Source: AJdET5dQD/IedPScH6EfGAd/Jaou0kSMo0NB29/TvUntvBvDx6CVzjBI9oV08PQmrBrCZRInSwr3iQ==
X-Received: by 2002:a1c:5507:: with SMTP id j7-v6mr806955wmb.98.1541674889084;
        Thu, 08 Nov 2018 03:01:29 -0800 (PST)
Received: from gmail.com (net-2-42-72-229.cust.vodafonedsl.it. [2.42.72.229])
        by smtp.gmail.com with ESMTPSA id i10-v6sm3282772wrr.69.2018.11.08.03.01.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 03:01:28 -0800 (PST)
Date:   Thu, 8 Nov 2018 12:01:27 +0100
From:   Paolo Pisati <p.pisati@gmail.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Paolo Pisati <p.pisati@gmail.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        netdev@vger.kernel.org, stable@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [stable, netdev 4.4+] lan78xx: make sure RX_ADDRL &
 RX_ADDRH regs are always up to date
Message-ID: <20181108110127.GA8415@harukaze>
References: <1541609457-28725-1-git-send-email-p.pisati@gmail.com>
 <20181108001751.GA8097@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108001751.GA8097@sasha-vm>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 07:17:51PM -0500, Sasha Levin wrote:
> So why not just take 760db29bdc completely? It looks safer than taking a
> partial backport, and will make applying future patches easier.
> 
> I tried to do it and it doesn't look like there are any dependencies
> that would cause an issue.

Somehow i was convinced it didn't build on 4.4.x... can you pick it up?

commit 760db29bdc97b73ff60b091315ad787b1deb5cf5
Author: Phil Elwell <phil@raspberrypi.org>
Date:   Thu Apr 19 17:59:38 2018 +0100

    lan78xx: Read MAC address from DT if present
    
    There is a standard mechanism for locating and using a MAC address from
    the Device Tree. Use this facility in the lan78xx driver to support
    applications without programmed EEPROM or OTP. At the same time,
    regularise the handling of the different address sources.
    
    Signed-off-by: Phil Elwell <phil@raspberrypi.org>
    Signed-off-by: David S. Miller <davem@davemloft.net>
-- 
bye,
p.
