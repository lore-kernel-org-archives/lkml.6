Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB1FC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 17:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1566620874
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 17:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+ndPH/C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbeLZRuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 12:50:10 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34054 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727153AbeLZRuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 12:50:09 -0500
Received: by mail-wm1-f68.google.com with SMTP id y185so22641132wmd.1;
        Wed, 26 Dec 2018 09:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NfWUGBtM9viN9C4UC/IjCRTQC8kLLjM37k48i3T85SE=;
        b=P+ndPH/CR+feCJX/hg0VK9NP5sYDKTetz6KcnB5YhDJ61roMNQ7GliTnNAfa5jHTTa
         Frz4qne6KrjiczPCyK5pAmUn+439MAVVFSn4lhLOyc04Twsr83YV0xAE3XGJC4QPgPWK
         RJjcAbHyQhQQxlHpoRCMt6raq3TTE7DjSRaPrGBvOC39mN7pZDqFe40Oung7uNhZM56E
         Tr979hgT+XKFuOel+f/0s8+GHD7CE+eCy2jjUI8OvIf3Y1Pi/3q8eodFVnBQRfbiHLtd
         K1CUd5lQWoIsyPdqYkw81NMsg84zV1aUcPiWN/U6vDL+uw0n4Y8Lfn/YYx1JwBwDWr3j
         1gkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NfWUGBtM9viN9C4UC/IjCRTQC8kLLjM37k48i3T85SE=;
        b=pzQUCfQ5JBF7XmF8hHJEfQmyteV2YzFqjjuuEn4WlY1bxlBWlI/5aEVvWZrkCfyI0c
         S/7f1fQuLdB6dQu2oM2xTlbJt0ONXDMC5+p1DpfUPQAKdDmb2IKDlJWlUtPWdzApJeHo
         mmfFVT44a0zUgo+sY6tkC2+0hkkORsreOGxfyNVx1N88ToafmeY72bERulbD7cfW7Jyl
         Trd+GP9zOt2zfPGThJXyR46SNk2Np9efZGWznsnKsFlFqKhSkP8PRS0V2GgyHd8Um1HA
         So6GnTCfKYAeEIMPWm9nPD+ppUQ8FfTQxjlsp7U7k0b/NqCALfQZantZldPsPiSMW287
         Q7Mw==
X-Gm-Message-State: AA+aEWZ+TQ9M5Es5VJMQ9B6XKFmwHXFMd4MPtc3Ck9HbaN1QDa4MsY1B
        wYWRPN8WO0yG12yG3jwgfr5L3mIO
X-Google-Smtp-Source: ALg8bN4rAUtMEhYKzAoGCy2xI8GcVZe6CAQLRMwogB1vFRswE/AJv4Qc68SnxPl0bQMqsoDx9cEAJA==
X-Received: by 2002:a1c:8148:: with SMTP id c69mr18340636wmd.126.1545846607515;
        Wed, 26 Dec 2018 09:50:07 -0800 (PST)
Received: from ?IPv6:2003:ea:8bcf:e300:6194:598:7f5e:b2e? (p200300EA8BCFE300619405987F5E0B2E.dip0.t-ipconnect.de. [2003:ea:8bcf:e300:6194:598:7f5e:b2e])
        by smtp.googlemail.com with ESMTPSA id z206sm27591314wmc.18.2018.12.26.09.50.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Dec 2018 09:50:06 -0800 (PST)
Subject: Re: [PATCH] net:phy: Add a return value check on bus write
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Michal Simek <michal.simek@xilinx.com>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181226173717.7113-1-pakki001@umn.edu>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <07044950-bd40-11be-dced-5c880010088c@gmail.com>
Date:   Wed, 26 Dec 2018 18:50:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20181226173717.7113-1-pakki001@umn.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.12.2018 18:37, Aditya Pakki wrote:
> xgmiitorgmii_read_status() could fail when writing to the bus via
> mdiobus_write(). The fix adds a check and returns an error in case
> of failure.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---

Two more things:
- subject should be: "net: phy: xgmiitorgmii: check bus write return value"
  See also git history of this file.
- patch needs to be properly annotated as "net" or "net-next".
  net-next is closed currently, please re-submit once it's open again in
  ~ 2-3 weeks.

Heiner
