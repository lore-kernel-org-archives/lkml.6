Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C33CC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D81F823CF0
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="MJueZ+iT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D81F823CF0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934139AbeGFRj2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:39:28 -0400
Received: from vern.gendns.com ([206.190.152.46]:49673 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933633AbeGFRjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:39:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=CI3+1NVokqKdMD2GQLtxzmJcJcChHiNJfP4hzuTzTl0=; b=MJueZ+iTpV8/C9878EiVsTHrgU
        xvw4ot6bQuOUoaGxqXSLv0UFhT1/Z8xnocJQCIAX6pvdGQOa0gPFSdpgRRpp8CYZR33FYItQAyNBz
        aII0XftpdzqHQQyEwTcJ9qAL2k15CgePPmTWIoZHmvJA1KNQrUqyBQsecEiVGejT3QvxX1YNnqaqq
        0yCFHHJndEwoeuNz99Pia+GwGAXlEHtkSE+EDYvT+Qn3/dorRPgpNrgqpmpV8N8LYy8gkXmV5hFGz
        ui7g1p5JqN5abXeHRtSIAgizkTNfyTmM0GR3u8lA5wh/p67D6ddU8aZT0tVUiI0uqJm+7MbGy0j/J
        kzdOIHEQ==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:36608 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1fbUhX-00BMvv-Bd; Fri, 06 Jul 2018 13:39:23 -0400
Subject: Re: [PATCH v3 00/13] ARM: davinci: remove duplicate aemif support
To:     Sekhar Nori <nsekhar@ti.com>, Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180628095748.4462-1-brgl@bgdev.pl>
 <52a274f1-283a-a14a-54f3-4b95b6605c4f@ti.com>
 <59fdc532-bb72-ffae-cfb6-a7f156c14771@lechnology.com>
 <e1222b3c-dfa4-4cb0-eebf-8e2550e9d674@ti.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <125d73f7-7311-866f-1e9d-d3c1f9473899@lechnology.com>
Date:   Fri, 6 Jul 2018 12:39:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <e1222b3c-dfa4-4cb0-eebf-8e2550e9d674@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2018 01:35 AM, Sekhar Nori wrote:
> Hi David,
> 
> On Monday 02 July 2018 09:02 PM, David Lechner wrote:
>> On 07/02/2018 07:28 AM, Sekhar Nori wrote:
>>> Hi David, Stephen,
>>>
>>> On Thursday 28 June 2018 03:27 PM, Bartosz Golaszewski wrote:
>>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>>
>>>> This series moves all aemif/nand users to using the ti-aemif platform
>>>> driver located in drivers/memory instead of the older API located in
>>>> mach-davinci.
>>>>
>>>> First five patches add necessary changes to the clock driver. Next
>>>> seven convert the board files to using the ti-aemif driver. Last patch
>>>> removes now dead code.
>>>
>>> How do you want to handle this series? I can apply the series and
>>> provide you an immutable branch on v4.18-rc1 with the clock patches
>>> applied if that can work.
>>
>> Sounds good to me. But I'm new to this maintainer thing, so maybe
>> there is something to consider that I haven't thought of?
> 
> I don't think there is more to it. Ultimately there should not be two
> commits for the same patch. Either you can apply and share the commit to
> use or I can do that as well. I am equally fine either way.
> 
> Regards,
> Sekhar
> 

I've created a branch for-sekhar at https://github.com/dlech/linux.git
with the clk commits.
