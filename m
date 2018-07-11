Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61C3C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D5A520B6F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:57:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D5A520B6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbeGKJAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 05:00:42 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45499 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbeGKJAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 05:00:42 -0400
Received: from 1.general.ikepanhc.us.vpn ([10.172.69.54])
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <ike.pan@canonical.com>)
        id 1fdAw7-0007ca-Tf; Wed, 11 Jul 2018 08:57:24 +0000
Subject: Re: [Bisect] ext4_validate_inode_bitmap:98: comm stress-ng: Corrupt
 inode bitmap
To:     dann frazier <dann.frazier@canonical.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, yanaijie@huawei.com,
        colin.king@canonical.com, kamal.mostafa@canonical.com
References: <20180706174324.GA3049@xps13.dannf>
 <20180707041018.GB3546@thunk.org> <20180710165143.GA20459@xps13.dannf>
 <20180710204329.GB20459@xps13.dannf>
From:   Ike Panhc <ike.pan@canonical.com>
Message-ID: <b39169ad-2237-0a4f-e3d1-afc51ac10fa5@canonical.com>
Date:   Wed, 11 Jul 2018 16:57:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180710204329.GB20459@xps13.dannf>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2018 04:43 AM, dann frazier wrote:
> On Tue, Jul 10, 2018 at 10:51:43AM -0600, dann frazier wrote:
>> On Sat, Jul 07, 2018 at 12:10:18AM -0400, Theodore Y. Ts'o wrote:
>>> On Fri, Jul 06, 2018 at 11:43:24AM -0600, dann frazier wrote:
>>>> Hi,
>>>>   We're seeing a regression triggered by the stress-ng[*] "chdir" test
>>>> that I've bisected to:
>>>>
>>>> 044e6e3d74a3 ext4: don't update checksum of new initialized bitmaps
>>>>
>>>> So far we've only seen failures on servers based on HiSilicon's family
>>>> of ARM64 SoCs (D05/Hi1616 SoC, D06/Hi1620 SoC). On these systems it is
>>>> very reproducible.
>>>
>>> Thanks for the report.  Can you verify whether or not this patch fixes
>>> things for you?
>>
>> hey Ted,
>>   Sorry for the delayed response - was afk for a long weekend.
>> Your patch does seem to fix the issue for me - after applying the
>> patch, I was able to survive 20 iterations (and counting), where
>> previously it would always fail the first time.
>>
>> However, I've received a conflicting report from a colleague who
>> appears to still be seeing errors. I'll get back to you ASAP once I am
>> able to (in-?)validate that observation.
> 
> OK - I believe I found an explanation for my colleague's continued
> test failures after applying the patch. The filesystem being used may
> have already been corrupted from a previous run, and the test w/ your
> patch just tripped over it. Details are here starting in comment #9 if
> you'd like to look them over:
> 
>   https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1780137
> 
>   -dann
> 

Review console log and on each run I have filesystem rebuild. The problem
is that mke2fs I am using is 1.44.3-rc2. I am now reseting the environment
and re-test.

-- Ike
