Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C43C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 19:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E59F721570
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 19:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linuxvaults.com header.i=@linuxvaults.com header.b="QgkiBWxy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E59F721570
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxvaults.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753174AbeGDT6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 15:58:22 -0400
Received: from crystal.urlnameserver.com ([99.198.127.110]:36892 "EHLO
        crystal.urlnameserver.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752826AbeGDT6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 15:58:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linuxvaults.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=GgTYbeVGiNdvD4T1csxiKDtiB4fxPDTQ6tXey8k2LNo=; b=QgkiBWxySElsDI2bR+HMEQBkKt
        UYCUBt5AaG/4XcT3Z50XFP1HASzJMo/GhRHBq9hI9gNjw1aBHZUuSXv3kdWHj/BUsNPQa2Quurkio
        BjvtHIX1QvUCELVB7mugxBcIFtknvXGj+IHCdjV9ZxB6n5svFv9nmS9w6oG0+Y/+t4HrFL4WEa/9e
        Mq4Xb7G9kq8tQ5ixBNaaU0PDTUPUCshSW0+ut5BN8SS1j/qbEQ93O/SJZcJXwuYWKYTEyztpAOHGz
        kSU4ywkpsc9gtvg/p7IC1S2BQJNhQBGPcwePOpe45xd+ERuB7MG12CQtv+0QhTSTUlr4lmhE1tF8R
        D/JIspYg==;
Received: from [46.186.216.156] (port=58618 helo=[127.0.0.1])
        by crystal.urlnameserver.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <tsuliman@linuxvaults.com>)
        id 1fanuj-0005NY-4w; Wed, 04 Jul 2018 14:58:09 -0500
Subject: Re: [PATCH 1/2] FBTFT: fb_sh: Fix alignment and style problems Fixed
 Coding style issues Signed-off-by: Tamir Suliman <tsuliman@linuxvaults.com>
To:     Joe Perches <joe@perches.com>, thomas.petazzoni@free-electrons.com
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
References: <1530369159-23872-1-git-send-email-tsuliman@linuxvaults.com>
 <fc7149540b1e70e82adb0f2698da78ed65e45ffb.camel@perches.com>
From:   Tamir Suliman <tsuliman@linuxvaults.com>
Message-ID: <ed714b1b-c082-d0e8-8673-7cf9bf2dddcc@linuxvaults.com>
Date:   Wed, 4 Jul 2018 22:58:08 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <fc7149540b1e70e82adb0f2698da78ed65e45ffb.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - crystal.urlnameserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linuxvaults.com
X-Get-Message-Sender-Via: crystal.urlnameserver.com: authenticated_id: tsuliman@linuxvaults.com
X-Authenticated-Sender: crystal.urlnameserver.com: tsuliman@linuxvaults.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes I did ..the misalignment and indentations were not intentional 
forgot to fix that but It was added to the patch.. will fix that on v 2  
my first patch still working on how to do things properly :(

On a different note , I made some changes to the function.

Thanks for your message.


On 6/30/2018 7:20 PM, Joe Perches wrote:
> On Sat, 2018-06-30 at 14:32 +0000, Tamir Suliman wrote:
>> ---
>>   drivers/staging/fbtft/fb_sh1106.c | 26 +++++++++++++-------------
>>   1 file changed, 13 insertions(+), 13 deletions(-)
> Adding to what Greg's patchbot already wrote:
>
>> diff --git a/drivers/staging/fbtft/fb_sh1106.c b/drivers/staging/fbtft/fb_sh1106.c
> []
>> @@ -36,27 +36,27 @@ static int init_display(struct fbtft_par *par)
>>   	par->fbtftops.reset(par);
>>   
>>   	/* Set Display OFF */
>> -	write_reg(par, 0xAE);
>> +		write_reg(par, 0xAE);
>
> Nope.
>
> You are overly indenting already correctly indented code.
> Statements start in the same column unless following an
> if/for/do/while/else/case.
>
>> @@ -89,8 +89,8 @@ static void set_addr_win(struct fbtft_par *par, int xs, int ys, int xe, int ye)
>>   
>>   static int blank(struct fbtft_par *par, bool on)
>>   {
>> -	fbtft_par_dbg(DEBUG_BLANK, par, "%s(blank=%s)\n",
>> -		      __func__, on ? "true" : "false");
>> +	fbtft_par_dbg(DEBUG_BLANK, par, "%s(_func_=%s)\n",
>> +			__func__, on ? "true" : "false");
> Again, nope.
>
> Here you are misaligning a multi-line continuation
> which is correctly aligned to the open parenthesis.
>

