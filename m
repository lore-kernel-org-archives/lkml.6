Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54D7C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 766A22152A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:04:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 766A22152A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbeI0DTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 23:19:01 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:52442 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbeI0DTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 23:19:01 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 5B08AC1C03;
        Wed, 26 Sep 2018 21:04:11 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo01-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1BTg8MaGPLbF; Wed, 26 Sep 2018 21:04:11 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 71543C1C02;
        Wed, 26 Sep 2018 21:04:03 +0000 (UTC)
Subject: Re: [V2 PATCH] selftests: watchdog: Add gettimeout and get|set
 pretimeout
To:     Jerry.Hoemann@hpe.com
Cc:     erosca@de.adit-jv.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <1537817767-78918-1-git-send-email-jerry.hoemann@hpe.com>
 <1537817767-78918-2-git-send-email-jerry.hoemann@hpe.com>
 <16941ebb-85ca-ad4c-de7b-c26f193ca611@kernel.org>
 <20180926162920.GB3948@anatevka.americas.hpqcorp.net>
 <ce60e815-10f1-08fd-d853-2629992a4a98@kernel.org>
 <20180926200320.GB14558@anatevka.americas.hpqcorp.net>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <07a8e98e-1e25-d87d-51e5-66ff9dd65245@kernel.org>
Date:   Wed, 26 Sep 2018 15:04:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180926200320.GB14558@anatevka.americas.hpqcorp.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/26/2018 02:03 PM, Jerry Hoemann wrote:
> On Wed, Sep 26, 2018 at 01:47:25PM -0600, Shuah Khan wrote:
>> On 09/26/2018 10:29 AM, Jerry Hoemann wrote:
>>> On Tue, Sep 25, 2018 at 02:51:15PM -0600, Shuah Khan wrote:
>>>> Hi Jerry,
>>>>
>>>>
>>>> The rest looks good to me.
>>
>> I spoke too soon. I ran your patch on softdog and error messages in unsupported
>> cases could you refinement. Please see below:
>>
>> Sorry for not catching this earlier.
>>
>>>>
>>>>>  }
>>>>>  
>>>>>  int main(int argc, char *argv[])
>>>>> @@ -135,6 +142,30 @@ int main(int argc, char *argv[])
>>>>>  			else
>>>>>  				printf("WDIOC_SETTIMEOUT errno '%s'\n", strerror(errno));
>>>>>  			break;
>>>>> +		case 'T':
>>>>> +			oneshot = 1;
>>>>> +			ret = ioctl(fd, WDIOC_GETTIMEOUT, &flags);
>>>>> +			if (!ret)
>>>>> +				printf("WDIOC_GETTIMEOUT returns %u seconds.\n", flags);
>>>>> +			else
>>>>> +				printf("WDIOC_GETTIMEOUT errno '%s'\n", strerror(errno));
>>
>> Either remove "errno" or change it to "error '%s'"
> 
> Oh, I see. I did a cut/paste from prior printf in file which have same issue.
> I'll fix those while I'm at it.
> 
> 
> 

Thanks. That will be awesome.

-- Shuah
