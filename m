Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43425C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 18:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E449B204FD
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 18:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXIbP+2a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E449B204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbeKDDYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 23:24:51 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:43706 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727281AbeKDDYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 23:24:51 -0400
Received: by mail-wr1-f46.google.com with SMTP id y3-v6so4822784wrh.10
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 11:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:from:to:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=CEFGNE/blA4VWwsVpNAzGFxp9W6nyjCOOGFMCYGalN8=;
        b=HXIbP+2azKfIhpvzvOiS2efYBJFtwJbNbXbCKD474kn9+COSj2XdvOS7VDFaCKh2M5
         aTSGQWwuJtnDJwAU9LyUBlzRhfhu9pOMhSAB9kxZkRC1muOVu4o4ii2pFTIQc7pnvcZU
         LInRkFQV5Cg+8K1SR43cIr8/wEpDi3GxgH4FDEV45rE7LPV0Ndv8vcIR0NWXs2nSH8B+
         sisNIDc1hl4aLIK25BkEjRnQIoNCIGuE9WGprVupRs9GJuVrYeEXnOGxEp04c5TAcf8S
         La+KK1qaqe3gbV/aq6z1EygDgqiIbOJGyybAOeeODMmXUWDzZ8pStjZ4rcE3Tlqa7ehb
         bJ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:from:to:subject:message-id:date
         :user-agent:mime-version:content-transfer-encoding:content-language;
        bh=CEFGNE/blA4VWwsVpNAzGFxp9W6nyjCOOGFMCYGalN8=;
        b=KvEFBYgo7MiUd0gVJjHAN/BN3ntKFQKvqCR8qGquwzrEZGfM0Zl4lyhvKxfWKQlq7n
         9a+2/aX/xg9HkzzZtfOhGkbvU9eTPepnwCIoLbsB4DzWBYSRl5+0p/BAwrqs+z2N+wjK
         ecJfMJwWD0+BD/jia8hraWfphctcW/FLRbezacbcRZeqs6s/RMzWaRsCTKZZZnxPKhX9
         d3MLXM+Mo9JGQK5qXWP0m+mnxBUr9QwrOq1MVwq5gaO287owoCIbGSxHnifCoWOujm8h
         e1F8oeY6mWr//HNj3QhFD6iBbz9r2SnDrGNoXjjNzPqy+nUFcV07LaaJRQv22uIHwqE2
         sd8g==
X-Gm-Message-State: AGRZ1gIKZZ1bk3NOfeuOrtPqxBL3sYwvRdlzZwCIPes5wiWfyBqpJ2u1
        qEM2KtXow2JXZeD96JF8YnnXAHnT
X-Google-Smtp-Source: AJdET5ecb0Chg/Y5BI3+2QX4IroAfSyK1/SXbhLkBvgjjoA/ZEj8X7kvbbHjPfNTBQuyW61Aaml/6w==
X-Received: by 2002:adf:d090:: with SMTP id y16-v6mr4865881wrh.314.1541268297200;
        Sat, 03 Nov 2018 11:04:57 -0700 (PDT)
Received: from [192.168.1.215] (host109-156-61-147.range109-156.btcentralplus.com. [109.156.61.147])
        by smtp.gmail.com with ESMTPSA id r188-v6sm19812619wmg.19.2018.11.03.11.04.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 11:04:56 -0700 (PDT)
Reply-To: tjcw@cantab.net
From:   Chris Ward <tjcw01@gmail.com>
To:     linux-kernel@vger.kernel.org
Subject: dual-band WiFi adapter for Linux
Message-ID: <1dd0164d-731c-e911-116c-bb8636003a29@gmail.com>
Date:   Sat, 3 Nov 2018 18:04:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amazon UK are selling a dual-band WiFi adapter for about 11 GBP (approx 
15 USD). It contains a RealTek chip, and it comes with a CD with source 
for a linux kernel driver which says it is rtl8821ae .

I have a patch to make this work with a 4.19 kernel (Fedora Rawhide a 
few days ago).

I believe the driver from Amazon is GPL2, and I am content for my patch 
to be taken as GPL2 as well.

If anyone wants to integrate this into the Linux kernel, they should 
contact me directly (tjcw at cantab.net) and I will supply the material 
which I have.

-- 
Chris Ward

