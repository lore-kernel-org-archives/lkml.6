Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C95ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 20:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCC5C20881
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 20:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vZrPXFxm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCC5C20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbeIPCUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 22:20:00 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41327 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727640AbeIPCUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 22:20:00 -0400
Received: by mail-pl1-f194.google.com with SMTP id b12-v6so5681866plr.8;
        Sat, 15 Sep 2018 13:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zudtQS51SCIrdtfWJx6oLJ1w9oWTAJ5FDHxyWdLfGSU=;
        b=vZrPXFxmSLyW57RAcikeyQLi830HLCjI2vrL0ebPvxwDp7Y7RB4x+OX+WRsUZRFU3D
         gRXWw436r9Suh7R9B09TLAuewRNn7H0TYmQ/+l/jyI4epKkyiVYmmP8W8ofT1/MR0M4A
         H6t0rgWijjURHAhYD8gSh2FKuQWdEuUwdJ6sUmexT67ggvKOCTadnzSxmL2jF7JlTzd6
         cCNKrfXact5mSsrU1NfuMHoicRAZG+IGQZ+WtLEXtjJHZ8fLJMtWHJujUCrRfdvRnW3J
         Dw2hBsPjEfvYfM3m6ZLNoAXugXGJyUsOm1KYmZa5Vp+nUvh1C0jwZbkLp6wi2XcJpQhP
         k3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zudtQS51SCIrdtfWJx6oLJ1w9oWTAJ5FDHxyWdLfGSU=;
        b=Wk8lOsaVn0UnbkheKi0fnfzFdhMeqnyMH7oFfpn070Kas41JZ5tmG0d8qc551O18hl
         ayMICHYdbQIxyQ06JK5PxUH1D26Gws6OMsbK8tBTyXIM0P7iD2B9E8u5GpYsqsDLgd04
         ySAHHfZ5ibMLMTe5DegbdxTCv5FYQv1FSEOxX8oWn+mhOuMPoL+FIlVI098zFu8xajZC
         R2N0zeAJCccndpTmb4K7aetAIFKR+qiBgNt6C/pHJkDLzG0MQzPQYOLQ1p85t8NI3qxA
         tUXCpB3jWJlLXwOqQMkMqu01QaP/HfN4rfzDZoVFvx/wmW3ibEdF/SFuatiYi1+PC6nD
         ZSRw==
X-Gm-Message-State: APzg51DW8b3t/5/xyOcdYnC+4uCKsFj3+ae5Ant7h0doaI0Si3bRR1sO
        5aErZ8zIiXx30i6vvJIOaoOHdusc
X-Google-Smtp-Source: ANB0VdbgWPbDV866mNql+VINGJochxOFa5KIOXKVfpX7qMNY9B0m+8msuLrdaKey/bdLI3FG1X799g==
X-Received: by 2002:a17:902:26c:: with SMTP id 99-v6mr18082641plc.341.1537045181323;
        Sat, 15 Sep 2018 13:59:41 -0700 (PDT)
Received: from [10.0.2.15] (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id r25-v6sm12828262pgm.59.2018.09.15.13.59.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Sep 2018 13:59:40 -0700 (PDT)
Subject: Re: [PATCH net-next 5/5] net: phy: mscc: remove unneeded temporary
 variable
To:     Quentin Schulz <quentin.schulz@bootlin.com>, davem@davemloft.net,
        andrew@lunn.ch
Cc:     allan.nielsen@microchip.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com
References: <cover.616d15610d44a0e3d463acd8119859f243163ad2.1536913944.git-series.quentin.schulz@bootlin.com>
 <d9cca8eef36bb8918c9ed28574b79b7674fd36f6.1536913944.git-series.quentin.schulz@bootlin.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <f102358e-bc40-e1df-1a75-ba6989e5ddc9@gmail.com>
Date:   Fri, 14 Sep 2018 19:19:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <d9cca8eef36bb8918c9ed28574b79b7674fd36f6.1536913944.git-series.quentin.schulz@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/14/18 01:33, Quentin Schulz wrote:
> Here, the rc variable is either used only for the condition right after
> the assignment or right before being used as the return value of the
> function it's being used in.
> 
> So let's remove this unneeded temporary variable whenever possible.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
