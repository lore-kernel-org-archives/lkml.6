Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB14C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3F2D2084A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732140AbeLTM4W convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 07:56:22 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:54866 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729731AbeLTM4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 07:56:22 -0500
Received: from mail-pf1-f199.google.com ([209.85.210.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1gZxsC-0002Es-DW
        for linux-kernel@vger.kernel.org; Thu, 20 Dec 2018 12:56:20 +0000
Received: by mail-pf1-f199.google.com with SMTP id d18so1604840pfe.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 04:56:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=43+pXsJIiz0pw6JXkUdFd/OMoi5qXnd2qQwt4cSXuU4=;
        b=JzRieBDzjlvqbduk33bZcvibgtJdkNMJCi62YKYqNar2FYsYnVraM4V3FDi2iiJawe
         XX4H7WyN4LAEZyJv6C2jOxIwmULgxYe7S4O5zwOn2KFTFFdYQxruSlGNRXmreBsSVq7y
         mWPN9S87vF6H6X9kPw/1d6Pc8Vf8mA/QepnM540HBx7/l2fQapUWtVAFT4xBWAw7EPN1
         7ndrVZsZ9lVd6Bs7ghMkAqJZQ6bV9+b5lJmp+XlSonS27s3JMLNCLonqdKeBeMz3I3M9
         c5i8XUFTsx/+MOBqHL2l8FNWJZbWmhAhBDJho/R8VHen4CbaXmfrnmrkdH/K2hCbhn68
         Dr3A==
X-Gm-Message-State: AA+aEWYKLZfG9o7tO8125ugReh/eCZP9UKsyZTuh9eTy8UG5Brr2tXmN
        XHsJGCBiLl/8Tdvb+i00UmDRslLzVOfEQlb0S7DgDigWr4WbLtoeu4hYoZTUo4IdH2c2BfW70Ec
        KlgrgpVubwflRJ5qQRqg0hi/qVxVAjNRQ7XrbZ5w/ZA==
X-Received: by 2002:a17:902:6a4:: with SMTP id 33mr23288183plh.99.1545310579140;
        Thu, 20 Dec 2018 04:56:19 -0800 (PST)
X-Google-Smtp-Source: AFSGD/X01OityrlBqPtw4fEfYVnBChInD4/Ppbg5l4TPZ/8NUkOkVatqlLUUOXJUz4PLWwerD/m22A==
X-Received: by 2002:a17:902:6a4:: with SMTP id 33mr23288160plh.99.1545310578721;
        Thu, 20 Dec 2018 04:56:18 -0800 (PST)
Received: from 2001-b011-380f-3f3d-b410-59e8-c783-3401.dynamic-ip6.hinet.net (2001-b011-380f-3f3d-b410-59e8-c783-3401.dynamic-ip6.hinet.net. [2001:b011:380f:3f3d:b410:59e8:c783:3401])
        by smtp.gmail.com with ESMTPSA id z14sm25777391pgv.47.2018.12.20.04.56.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 04:56:17 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] rtlwifi: Fix non-working BSS STA mode
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20181220064209.E5AD9606FC@smtp.codeaurora.org>
Date:   Thu, 20 Dec 2018 20:56:15 +0800
Cc:     pkshih@realtek.com, davem@davemloft.net,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <3AE7BCCE-8202-42B8-95AF-8B32FB9E33AA@canonical.com>
References: <20181212051335.22580-1-kai.heng.feng@canonical.com>
 <20181220064209.E5AD9606FC@smtp.codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 20, 2018, at 14:42, Kalle Valo <kvalo@codeaurora.org> wrote:
> 
> Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> 
>> Once BSS STA mode gets started, it can be scanned by other clients but
>> cannot entablish a connection.
>> 
>> Turns out the set_bcn_reg() and its *_set_beacon_related_registers()
>> callbacks never get called so it has problem beaconing.
>> 
>> Enable the function in rtl_op_bss_info_changed() can make BSS STA mode
>> start to work.
>> 
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> 
> The commit log is quite misleading. It implies that the client mode is broken
> for all rtlwifi hardware and that can't be the case, otherwise we would be
> flooded by bug reports. So please improve the commit log and describe clearly
> the problem you are solving.

You are right. I'll wait for PKShih’s test result and update commit log afterwards.

Kai-Heng

> 
> -- 
> https://patchwork.kernel.org/patch/10725537/
> 
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
> 

