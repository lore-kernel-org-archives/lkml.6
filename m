Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C74C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 368A22152C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:47:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 368A22152C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbeI0CCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 22:02:07 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:38139 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbeI0CCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 22:02:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id D481A22294;
        Wed, 26 Sep 2018 19:47:32 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo02-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id E0bWXYLIbEqO; Wed, 26 Sep 2018 19:47:32 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id B1D89220F7;
        Wed, 26 Sep 2018 19:47:26 +0000 (UTC)
Reply-To: shuah@kernel.org
Subject: Re: [V2 PATCH] selftests: watchdog: Add gettimeout and get|set
 pretimeout
To:     Jerry.Hoemann@hpe.com
Cc:     erosca@de.adit-jv.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <1537817767-78918-1-git-send-email-jerry.hoemann@hpe.com>
 <1537817767-78918-2-git-send-email-jerry.hoemann@hpe.com>
 <16941ebb-85ca-ad4c-de7b-c26f193ca611@kernel.org>
 <20180926162920.GB3948@anatevka.americas.hpqcorp.net>
From:   Shuah Khan <shuah@kernel.org>
Openpgp: preference=signencrypt
Autocrypt: addr=shuah@kernel.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <ce60e815-10f1-08fd-d853-2629992a4a98@kernel.org>
Date:   Wed, 26 Sep 2018 13:47:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180926162920.GB3948@anatevka.americas.hpqcorp.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/26/2018 10:29 AM, Jerry Hoemann wrote:
> On Tue, Sep 25, 2018 at 02:51:15PM -0600, Shuah Khan wrote:
>> Hi Jerry,
>>
>> On 09/24/2018 01:36 PM, Jerry Hoemann wrote:
>>>  	{"disable",             no_argument, NULL, 'd'},
>>> @@ -27,6 +27,9 @@
>>>  	{"help",                no_argument, NULL, 'h'},
>>>  	{"pingrate",      required_argument, NULL, 'p'},
>>>  	{"timeout",       required_argument, NULL, 't'},
>>> +	{"gettimeout",          no_argument, NULL, 'T'},
>>> +	{"pretimeout",    required_argument, NULL, 'n'},
>>> +	{"getpretimeout",       no_argument, NULL, 'N'},
>>>  	{NULL,                  no_argument, NULL, 0x0}
>>>  };
>>>  
>>> @@ -71,9 +74,13 @@ static void usage(char *progname)
>>>  	printf(" -h, --help          Print the help message\n");
>>>  	printf(" -p, --pingrate=P    Set ping rate to P seconds (default %d)\n", DEFAULT_PING_RATE);
>>>  	printf(" -t, --timeout=T     Set timeout to T seconds\n");
>>> +	printf(" -T, --gettimeout    Get the timeout\n");
>>> +	printf(" -n, --pretimeout=T  Set the pretimeout to T seconds\n");
>>> +	printf(" -N, --getpretimeout Get the pretimeout\n");
>>>  	printf("\n");
>>>  	printf("Parameters are parsed left-to-right in real-time.\n");
>>>  	printf("Example: %s -d -t 10 -p 5 -e\n", progname);
>>> +	printf("Example: %s -t 12 -T -n 7 -N\n", progname);
>>
>> Would this work the way you want it though, since -N now is oneshot?
>> Should this be just "printf("Example: %s -t 12 -T -n 7\n", progname); ??
> 
> 
> Example shows how to set/query the timers to make sure value set was what
> was intended.
> 
> Note: "oneshot" is a bit of a misnomer as it causes clean exit before
> going into the keep alive loop, but one can still specify multiple
> options.
> 
> 
>>
>> The rest looks good to me.

I spoke too soon. I ran your patch on softdog and error messages in unsupported
cases could you refinement. Please see below:

Sorry for not catching this earlier.

>>
>>>  }
>>>  
>>>  int main(int argc, char *argv[])
>>> @@ -135,6 +142,30 @@ int main(int argc, char *argv[])
>>>  			else
>>>  				printf("WDIOC_SETTIMEOUT errno '%s'\n", strerror(errno));
>>>  			break;
>>> +		case 'T':
>>> +			oneshot = 1;
>>> +			ret = ioctl(fd, WDIOC_GETTIMEOUT, &flags);
>>> +			if (!ret)
>>> +				printf("WDIOC_GETTIMEOUT returns %u seconds.\n", flags);
>>> +			else
>>> +				printf("WDIOC_GETTIMEOUT errno '%s'\n", strerror(errno));

Either remove "errno" or change it to "error '%s'"

>>> +			break;
>>> +		case 'n':
>>> +			flags = strtoul(optarg, NULL, 0);
>>> +			ret = ioctl(fd, WDIOC_SETPRETIMEOUT, &flags);
>>> +			if (!ret)
>>> +				printf("Watchdog pretimeout set to %u seconds.\n", flags);
>>> +			else
>>> +				printf("WDIOC_SETPRETIMEOUT errno '%s'\n", strerror(errno));

Same as above.

>>> +			break;
>>> +		case 'N':
>>> +			oneshot = 1;
>>> +			ret = ioctl(fd, WDIOC_GETPRETIMEOUT, &flags);
>>> +			if (!ret)
>>> +				printf("WDIOC_GETPRETIMEOUT returns %u seconds.\n", flags);
>>> +			else
>>> +				printf("WDIOC_GETPRETIMEOUT errno '%s'\n", strerror(errno));

Same as above.

>>> +			break;
>>>  		default:
>>>  			usage(argv[0]);
>>>  			goto end;
>>>
>>

thanks,
-- Shuah

