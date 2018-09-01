Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD154C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 09:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E2832083C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 09:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AX1Osqn1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E2832083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbeIANU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 09:20:26 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41893 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbeIANUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 09:20:25 -0400
Received: by mail-pg1-f193.google.com with SMTP id s15-v6so6482525pgv.8;
        Sat, 01 Sep 2018 02:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=lN4XCwO975RIo5FOR8E6anZeXFMQCOCSh3afMOb9Mjw=;
        b=AX1Osqn1QZfzOceVPQK3YBAb37gjgix3eKqCmmtI71d+xzGtZihN0sFcxNwVCTiYw8
         T2sdF7ML0CeRB0OkkjCfNKR9K0cRWVrB3lIZduQM0Fwt9GWMYpEEKJttWpZrulkbgB13
         GJheAznj3pCt/ZLDxtt1wt63jAtKupOYZkrB0B6sDbxAG1ETc3V71E5/SqiIH2+rrZ/G
         zgwwxY0UoJa6hIhfis+VeIR2Y1n5yBoLOMrs5VsXrNB08MkjqTIWNahhXUKWJo3N44Ks
         Bd3jkshJdeNwG78YMe1RRLvmDhjW6vKNqdi3Qzmxfww+rboLgWrFXuVJIYLWAfuwtSAl
         N5pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=lN4XCwO975RIo5FOR8E6anZeXFMQCOCSh3afMOb9Mjw=;
        b=lSujKczY8Y/glNllOqgeHUdM29cqwxc8Ye6ZWkQ+U0yHUSPD2BsrDV6JWOYp88Zx+i
         ifpvofDxE5T914Tuxrm6e2nfOgmdhJW+OsORREQXQTXhc/dYjFvxGIOxxF+zrp0Sa276
         BVcAp5MJl7r+9vvqhAs+6WzdNflUW3FVve4hBLxNl2imc8+GfAjHENz+D/jaI1q1kVR6
         qznNTBlomNG4zaUvPneD1ZAsGJP0nJJKvk6O8HKwR3TRbPX82/qSFj3LoC+sq/8YF+6d
         9HJssywDuT8MkTEYGRTNoV0TyYaqlUr7qGAG0e61EbhK5loKu7qT8JnyJY1aq8m7Mbmq
         uXEw==
X-Gm-Message-State: APzg51BdL+jPH3SdkXXHEjx0V2CtTNTornDeAIRVcY+ENZ0907I0b3b7
        bCNXkw38grkIMLK01i8RaLzDCAXx
X-Google-Smtp-Source: ANB0VdbTvIafKB7HRFrrVJ9OjAR0FUZMlnUOooNvMwyrg2XZA3iwc2WxcMHa/xHgZgbqzZUGKZNTMQ==
X-Received: by 2002:a63:7b4b:: with SMTP id k11-v6mr18418577pgn.64.1535792946607;
        Sat, 01 Sep 2018 02:09:06 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.71.15? ([2402:f000:1:1501:200:5efe:a66f:470f])
        by smtp.gmail.com with ESMTPSA id w72-v6sm39111011pfa.26.2018.09.01.02.09.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Sep 2018 02:09:06 -0700 (PDT)
To:     amitkarwar@gmail.com, nishants@marvell.com, gbhat@marvell.com,
        huxinming820@gmail.com, kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] net: wireless: mwifiex: A possible sleep-in-atomic-context bug
 in mwifiex_wait_queue_complete()
Message-ID: <35980039-f268-2db3-5c7d-19ab0c917d44@gmail.com>
Date:   Sat, 1 Sep 2018 17:08:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mwifiex_usb_tx_complete() is a completion handler function for the
USB driver. So it should not sleep, but it is can sleep according to the
function call paths (from bottom to top) in Linux-4.16:

[FUNC] schedule_timeout
drivers/net/wireless/marvell/mwifiex/sta_ioctl.c, 63:
     schedule_timeout in mwifiex_wait_queue_complete
drivers/net/wireless/marvell/mwifiex/cmdevt.c, 673:
     mwifiex_wait_queue_complete in mwifiex_send_cmd
drivers/net/wireless/marvell/mwifiex/main.c, 1046:
     mwifiex_send_cmd in mwifiex_multi_chan_resync
drivers/net/wireless/marvell/mwifiex/usb.c, 288:
     mwifiex_multi_chan_resync in mwifiex_usb_tx_complete

I do not find a good way to fix this bug, so I only report it.

This bug is found by my static analysis tool DSAC.


Best wishes,
Jia-Ju Bai
