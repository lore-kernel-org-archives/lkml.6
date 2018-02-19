Return-Path: <garsilva@embeddedor.com>
X-Google-Smtp-Source: AH8x225QIhvxCQlY+k7zMe6rRqxZQt5GmRqGtmV7ysUkksOsdlSzjPB8kcAfeQCUAlAs/8aUBbxq
ARC-Seal: i=1; a=rsa-sha256; t=1519058892; cv=none;
        d=google.com; s=arc-20160816;
        b=KnEd+1Hc465SlLBy3MBKfBFtX1cewAazLCzF+mb9SZJICW8lDk2c4uwchd51g/JDLm
         HMy486eD90hDF46bJT37ZYDnxivyIN2nx/u/ltzsanPyewdCMHVbZ17JXXLyfpWHF9JT
         nrEUf9lqdP5WMPfSm268/iMC3itvbHvnjC0V0VITIpCHTewqH1lcrNkjnEoV6Kxb6ked
         l0fPr7er70kEbzbRq4Ak2xIZ8ILnsFYev1fNvyS/GCzK8yEauzYp/t0OwMzeQjDKjqs0
         2V2ljm29h+RHf0xDGwPJutZMjgCTzQh3CRJpA61O3M7Siggv+fGWUqM+H/cFuVP4w/+e
         FBfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=TKKcMGFc5RpvPiiq0w+qdu2B+5UKAwmsR3a2VCu5lqM=;
        b=fqcyPOZ6GtOGn9MRyPiJMqVnj8PXgNjaTUINtZ5GZIdZ6xUchZIBwhy+72+Kus0aQy
         YtroesTr8LmTh9HuVKoJk8hsqkCLCuOeTnC7N/SUT8ZhQw6uYL1A8O/KBWQ0oyM9QMl6
         VO94njauxO/nq+ULIaUB9RGc38R70FsaB6RYqL83OiUYfZzxlznR/eYzyTnEsDPEFzFn
         1+tIBLuwVt67mkVSEzlNTWCJlEFm9iaO8ius2CZUgstd2+yvKXU9oE4FCAmUt5lkHGBj
         DuwH7BfWvryHJz4OYa+tj4hs+ygVL/u7fo4ZaQGVLrdEzgH8sPKfUlqtypAMTj2QxMqU
         Df8w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of garsilva@embeddedor.com designates 192.185.47.129 as permitted sender) smtp.mailfrom=garsilva@embeddedor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of garsilva@embeddedor.com designates 192.185.47.129 as permitted sender) smtp.mailfrom=garsilva@embeddedor.com
Subject: Re: [PATCH] staging: imx-media-vdic: fix inconsistent IS_ERR and
 PTR_ERR
To: Philipp Zabel <p.zabel@pengutronix.de>,
 Steve Longerbeam <slongerbeam@gmail.com>,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>
Cc: linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org
References: <20180124004340.GA25212@embeddedgus>
 <5e53d6d8-d336-da37-fe12-0638904e1799@gmail.com>
 <4305212e-5946-0bb3-1624-ec23a0f37708@embeddedor.com>
 <1519050231.3408.21.camel@pengutronix.de>
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Message-ID: <3bccf3a8-2dd4-ed59-7a37-1ca30741efcb@embeddedor.com>
Date: Mon, 19 Feb 2018 10:48:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519050231.3408.21.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - linuxfoundation.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.175.117.58
X-Source-L: No
X-Exim-ID: 1enobr-000H0l-Rm
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.66]) [189.175.117.58]:54592
X-Source-Auth: garsilva@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590432494114663836?=
X-GMAIL-MSGID: =?utf-8?q?1592848697380459516?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Philipp,

On 02/19/2018 08:23 AM, Philipp Zabel wrote:
> Hi Gustavo,
> 
> On Wed, 2018-02-14 at 14:57 -0600, Gustavo A. R. Silva wrote:
>> Hi all,
>>
>> I was just wondering about the status of this patch.
> 
> It is en route as commit dcd71a9292b1 ("staging: imx-media-vdic: fix
> inconsistent IS_ERR and PTR_ERR") in Hans' for-v4.17a branch:
>    git://linuxtv.org/hverkuil/media_tree.git for-v4.17a
> 

Awesome.

Thanks for the info.
--
Gustavo
