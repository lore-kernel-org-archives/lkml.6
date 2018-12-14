Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44178C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 07:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 093182054F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 07:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lbr2PfbU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 093182054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbeLNHhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 02:37:02 -0500
Received: from mail-wm1-f48.google.com ([209.85.128.48]:55657 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbeLNHhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 02:37:01 -0500
Received: by mail-wm1-f48.google.com with SMTP id y139so4656446wmc.5;
        Thu, 13 Dec 2018 23:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=M9rsy7kEE2qps5I+XY9s4gc+irbhtakT87FqxZkPCLs=;
        b=Lbr2PfbUvtOUHctm05lawsst4uFawG8ewNUK0BmYVglrUXBDvqwy+x9ow2lzIqXO0I
         Ei0idcoZNQw6KzkOuPhLZfOg2BB4EKF5j3WEYeGh6u2oqYz72N4I9/q2Aw1Nel84vkh3
         qrEWRvxas2ns6apJ37oQgf7rWZFPnCn1jY3BJ7v42UVfjaIpbiPseZYhBuLT8bluwflG
         4kWY3JHt6GSq1ORFm1qAHyCR5MXmyFOIYmjFOf7r+l972onldNt1kMbjptzk77VJdblx
         1tvdHB3eaJ2sNmfv21d9f/O5XApqmhjNuSxGv1e/TdT9O/jk90jzcWT+AWc4LlSV5uiP
         +Ptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M9rsy7kEE2qps5I+XY9s4gc+irbhtakT87FqxZkPCLs=;
        b=AcUlCBpMx/aogtdil1pzF/xu5K6RN7rcxORKuWkI0YX8z6O2rHmYtTatqKw1x1PYXl
         9G+M+u5B7nJR0h7jO8dGUWJQrgHJW4yZzwqSGfNtJ6doISRsd3M2AGzkhz5aUONBXrqM
         7bB668JYGp3iA7Iz4gUYk+723Et4lwaRVo0o58rfMZIiaU+dKDsd6vGXLCHH5ZDW/+oL
         Ti1jUv6XQ4evlLRCXOQabrbumvaGFn2XjKGA6yhm0MMRgGOuqqh011ciVskiBXXlzv+q
         8XfUVVSWm5lNVLLat6D5t2Wc9EUmANXmqGiEMehIi71mYwfg8vxCpySPyc7KWPFvPFn2
         5Daw==
X-Gm-Message-State: AA+aEWbRBKYMF7j1aQBymSwCHnvQswJE90OMIMckQGhOLnCbtgPFCCKq
        mcc87vqGROOxZGcmKzMqz+A=
X-Google-Smtp-Source: AFSGD/Xi2rJylhRTsoyf5z78oE67SuiQmyidNh6nNmvSYBLhDh7wJliviS0jKCRavzJODahfNGeqfg==
X-Received: by 2002:a7b:c442:: with SMTP id l2mr2240779wmi.140.1544773019898;
        Thu, 13 Dec 2018 23:36:59 -0800 (PST)
Received: from ?IPv6:2003:ea:8bcf:e300:2c36:9817:9638:c365? (p200300EA8BCFE3002C3698179638C365.dip0.t-ipconnect.de. [2003:ea:8bcf:e300:2c36:9817:9638:c365])
        by smtp.googlemail.com with ESMTPSA id g198sm7388884wmd.23.2018.12.13.23.36.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 23:36:59 -0800 (PST)
Subject: Re: A weird problem of Realtek r8168 after resume from S3
To:     Chris Chiu <chiu@endlessm.com>, nic_swsd <nic_swsd@realtek.com>,
        davem@davemloft.net, netdev@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
References: <CAB4CAwfH156yEd-XAkt==u+S8bO0U2=sg8nVr4o57C1q3K97Kw@mail.gmail.com>
 <CAB4CAwc4ubdXn7kzPeu2L--ciATgZWYkO350fvFF43-jj180xw@mail.gmail.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <59069da6-befc-2ebe-f2e2-e95a6a714013@gmail.com>
Date:   Fri, 14 Dec 2018 08:36:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CAB4CAwc4ubdXn7kzPeu2L--ciATgZWYkO350fvFF43-jj180xw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.12.2018 04:33, Chris Chiu wrote:
> On Thu, Dec 13, 2018 at 10:20 AM Chris Chiu <chiu@endlessm.com> wrote:
>>
>> Hi,
>>     We got an acer laptop which has a problem with ethernet networking after
>> resuming from S3. The ethernet is popular realtek r8168. The lspci shows as
>> follows.
>> 02:00.1 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd.
>> RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller [10ec:8168] (rev 12)
>>
Helpful would be a "dmesg | grep r8169", especially chip name + XID.

>>     The problem is the ethernet is not accessible after resume. Pinging via
>> ethernet always shows the response `Destination Host Unreachable`. However,
>> the interesting part is, when I run tcpdump to monitor the problematic ethernet
>> interface, the networking is back to alive. But it's dead again after
>> I stop tcpdump.
>> One more thing, if I ping the problematic machine from others, it achieves the
>> same effect as above tcpdump. Maybe it's about the register setting for RX path?
>>
You could compare the register dumps (ethtool -d) before and after S3 sleep
to find out whether there's a difference.

>>     I tried the latest 4.20 rc version but the problem still there. I
>> also tried some
>> hw_reset or init thing in the resume path but no effect. Any
>> suggestion for this?
>> Thanks
>>
Did previous kernel versions work? If it's a regression, a bisect would be
appreciated, because with the chip versions I've got I can't reproduce the issue.

>> Chris
> 
> Gentle ping. Any additional information required?
> 
> Chris
> 
Heiner
