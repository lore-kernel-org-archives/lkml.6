Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DFFC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC70420673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:38:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC70420673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbeGZIyK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 04:54:10 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42270 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728690AbeGZIyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 04:54:09 -0400
Received: from mail-pl0-f71.google.com ([209.85.160.71])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1fiar4-0000t6-6C
        for linux-kernel@vger.kernel.org; Thu, 26 Jul 2018 07:38:34 +0000
Received: by mail-pl0-f71.google.com with SMTP id w1-v6so684541plq.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 00:38:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=B4wJZGAXMifKAgCH9OHsU241nyQ5w9g4nnrEmwQSeWQ=;
        b=Unmhhla5HsTO7+/L2IsS5hKtrImPaO0AM6DJry12gzbonYjxXgmL4Tfn/0ukevKJxq
         sibrQiAWFg7nYZwMDPMpW3wa6W2SiHs6mF3shvDQCgitl8wCaFELdThUq+wzIiXLE12E
         3FGfEQsQsOU5zOFqShkY2VT8i7dmSqoVvnUfFJT6IM8hS4Ssf7NqaHplYKU3wQfok48q
         Mn34XahiLYaJDMsH+M2TE2J+gMCihDFgfZADvquApvPY2LY5ZoGolefyT+uEhpN2miuk
         sCXxlc/PU/G2HpwqR6xNrZw1GeWEcGzauSWwTb7325vtkSsfF+4Ddr0bFxFbZljqOLoi
         4wJA==
X-Gm-Message-State: AOUpUlEF35MqC0xr/5t4cPhJU13PlQWoddsry6hvFvaHAabtMWEDyP1i
        juPQfwwhaPBdcQWuL8xVbpOy0bFB2GCMByE6hKoKGW9l/R6shujvU5+e4G+il94OmyhIbKbhtV9
        tpbBz3oj1BUkGIeMjyqa+Fx1EdOIpmCrWOBdirZv/qg==
X-Received: by 2002:a62:d842:: with SMTP id e63-v6mr1006865pfg.88.1532590712898;
        Thu, 26 Jul 2018 00:38:32 -0700 (PDT)
X-Google-Smtp-Source: AAOMgpfHMNXUnGD0+ZzCcElkR1cAPrgQh7dviDQs8Xa7NuhjMBmGm0X4wuPfDz+SZOsxuL2zhfJ7JQ==
X-Received: by 2002:a62:d842:: with SMTP id e63-v6mr1006842pfg.88.1532590712603;
        Thu, 26 Jul 2018 00:38:32 -0700 (PDT)
Received: from [192.168.20.35] (1-161-137-98.dynamic-ip.hinet.net. [1.161.137.98])
        by smtp.gmail.com with ESMTPSA id w5-v6sm1091701pfn.44.2018.07.26.00.38.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 00:38:32 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH 4/5] memstick: rtsx_usb_ms: Support runtime power
 management
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <Pine.LNX.4.44L0.1807251357000.1467-100000@iolanthe.rowland.org>
Date:   Thu, 26 Jul 2018 15:38:27 +0800
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org, ulf.hansson@linaro.org,
        bauer.chen@realtek.com, ricky_wu@realtek.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <ADB156F9-27D6-4484-A2E7-AD0EFF41735B@canonical.com>
References: <Pine.LNX.4.44L0.1807251357000.1467-100000@iolanthe.rowland.org>
To:     Alan Stern <stern@rowland.harvard.edu>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 2018Jul26, at 01:59, Alan Stern <stern@rowland.harvard.edu> wrote:
> 
> On Wed, 25 Jul 2018, Kai-Heng Feng wrote:
> 
>> In order to let host's parent device, rtsx_usb, to use USB remote wake
>> up signaling to do card detection, it needs to be suspended. Hence it's
>> necessary to add runtime PM support for the memstick host.
>> 
>> To keep memstick host stays suspended when it's not in use, convert the
>> card detection function from kthread to delayed_work, which can be
>> scheduled when the host is resumed and can be canceled when the host is
>> suspended.
>> 
>> Use an idle function check if there's no card and the power mode is
>> MEMSTICK_POWER_OFF. If both criteria are met, put the device to suspend.
>> 
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> 
> I'm not familiar enough with this driver to comment on specific
> instances, but you should carefully go through the code and make sure
> that you use pm_runtime_get_noresume() and pm_runtime_put_noidle()
> correctly.
> 
> The basic idea is to use these when you know beforehand that the device
> is already at full power (for _get_noresume) and the usage count will
> not go to 0 (for _put_noidle).  If you aren't certain of these
> requirements then you should call pm_runtime_get_sync() and
> pm_runtime_put().

There are two different uses for pm_runtime helpers.

The first use case is to prevent parent device, rtsx_usb, from suspending:
pm_runtime_get_noresume()
rtsx_usb_read_register()
pm_runtime_put_noidle()

The second use case, to manage memstick host itself.
memstick_detect_change() powers the host on if there’s a card in slot, and it powers host off when there’s no card.
Once memstick_detect_change() is done, we can check if the host can be suspended.

So we are sure the timing when the power is on or off.

Kai-Heng

> 
> Alan Stern
> 

