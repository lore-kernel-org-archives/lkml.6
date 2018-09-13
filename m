Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0847C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 18:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F4E7204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 18:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOyDeaFI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F4E7204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbeIMXVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 19:21:02 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46773 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbeIMXVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 19:21:02 -0400
Received: by mail-pg1-f194.google.com with SMTP id b129-v6so3101728pga.13;
        Thu, 13 Sep 2018 11:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zelb0aJmMQZ19erNLEPdROuLDtG3wiCyLh3Ea5ED+YM=;
        b=XOyDeaFIWQ+G5VHY5zR2qvhx04Ezj4Ra/68lkPz64hzbXq/QE3sS/LT/0Flae5y+HP
         aZnTpqFU0qbV5CgEmqeRCGUg0YQ83teMaM/ahr3lPV911mZCrmRGK+Tx4ZOI8SgCWnwU
         ci6TcWC9vj4557prAkqZA7xwJLEeE2JtdUxUwImEGc5WkREVhzlkF4/yCOOG45XrDIvr
         e9AZf9rRhEhI18BcdIFIxOPTPWdcH3H0xfkjR9Njvg1IHXtB4wttUZ2jBBIjkmpUELDH
         r5uUO4zd/WVDmrr6V4qSlN4OkPZBSJ2/niOpikmyQAAp0WFjgDeKw33SERV1e00vslTX
         ghzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zelb0aJmMQZ19erNLEPdROuLDtG3wiCyLh3Ea5ED+YM=;
        b=P9GcxhGAK7zEWfzxXC4cwrThAiqmM2kyxl27QTHgfj9LRaB7Nn++TTbPKWK2bS/3zw
         Tizq5aYNTLKMRwd0Ju/GR0jtG+hQs5ka46WtgZFzTMB+2TvmbBdRdJikhZ7k78EBJWXf
         jTtQMv0uobI8gwZszWNX0feSwyOvegv0cqkcnTRHAEfy+n6bEpWQnOtq0BxNm2QVDW1a
         V7PfHP9eq40AkTpEpVSqkvbf5ZlBCpY6bUine1aG7u2P3eBgvmzwzTQ561zp9tcooC1t
         zrk+TbosPTkfZzYuCCeIL6u84g2cfJgicADGPSspXvaVjJCZ68DP+qDKlh5KoLxaqy/t
         Imfw==
X-Gm-Message-State: APzg51B46lCinVrba6FuuvS4xLrYpLZayuujO/WlP34kT7IJe/m13gZk
        nz0UfD5ldNw5GJNz7aDQUvPRFY/Q
X-Google-Smtp-Source: ANB0VdYalMgyS3XIS/WO7pzuJy2W3epPGeX03mOjQvv7Pp4af8H+yRFCrlhPFTnI7utI/+uo3L9t5w==
X-Received: by 2002:a62:6711:: with SMTP id b17-v6mr8587483pfc.243.1536862225682;
        Thu, 13 Sep 2018 11:10:25 -0700 (PDT)
Received: from [10.0.2.15] ([192.19.218.250])
        by smtp.gmail.com with ESMTPSA id y3-v6sm8271212pfi.24.2018.09.13.11.10.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 11:10:24 -0700 (PDT)
Subject: Re: [PATCH v3 0/3] ARM: NSP updates to support switch interrupts/SFP
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        "maintainer:BROADCOM IPROC ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, andrew@lunn.ch,
        rmk+kernel@armlinux.org.uk
References: <20180831192039.11842-1-f.fainelli@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <5751f9e2-6056-37cc-4749-cb8509b56916@gmail.com>
Date:   Thu, 13 Sep 2018 11:10:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180831192039.11842-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/31/18 12:20, Florian Fainelli wrote:
> Hi all,
> 
> This patch series updates the ARM NSP DTS and BCM958625HR in order to
> support the SFP connected to port 5 on these reference boards.
> 
> I will be submitting the functional changes to drivers/net/dsa/b53 once
> net-next opens back up, but this is largely independent from getting
> these 3 patches out.

Series applied to devicetree/next.
-- 
Florian
