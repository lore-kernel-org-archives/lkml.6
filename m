Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC6DC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D5632077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:14:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D5632077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hxt-semitech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbeIGV4S convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 17:56:18 -0400
Received: from mx01.hxt-semitech.com ([223.203.96.7]:52666 "EHLO
        barracuda.hxt-semitech.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726583AbeIGV4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 17:56:18 -0400
X-ASG-Debug-ID: 1536340459-093b7e54e612050001-xx1T2L
Received: from HXTBJIDCEMVIW02.hxtcorp.net ([10.128.0.15]) by barracuda.hxt-semitech.com with ESMTP id s0THDWXe4NXTpzsn (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Sat, 08 Sep 2018 01:14:19 +0800 (CST)
X-Barracuda-Envelope-From: dongsheng.wang@hxt-semitech.com
Received: from HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) by
 HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sat, 8 Sep 2018 01:14:22 +0800
Received: from HXTBJIDCEMVIW02.hxtcorp.net ([fe80::3e:f4ff:7927:a6f6]) by
 HXTBJIDCEMVIW02.hxtcorp.net ([fe80::3e:f4ff:7927:a6f6%12]) with mapi id
 15.00.1395.000; Sat, 8 Sep 2018 01:14:22 +0800
From:   "Wang, Dongsheng" <dongsheng.wang@hxt-semitech.com>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "jeffrey.t.kirsher@intel.com" <jeffrey.t.kirsher@intel.com>
CC:     "jacob.e.keller@intel.com" <jacob.e.keller@intel.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] net: ethernet: i40evf: fix underlying build error
Thread-Topic: [PATCH v3 2/2] net: ethernet: i40evf: fix underlying build error
X-ASG-Orig-Subj: Re: [PATCH v3 2/2] net: ethernet: i40evf: fix underlying build error
Thread-Index: AQHURpyuUEMtiCDf+EGRwpahWdajkw==
Date:   Fri, 7 Sep 2018 17:14:22 +0000
Message-ID: <548f5b78369047b584b30b04ffed1794@HXTBJIDCEMVIW02.hxtcorp.net>
References: <1536319175-3660-1-git-send-email-dongsheng.wang@hxt-semitech.com>
 <1536319175-3660-3-git-send-email-dongsheng.wang@hxt-semitech.com>
 <59fd149c-bacc-c39c-b0d8-a4fb9366f26a@cogentembedded.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.168.50.12]
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Barracuda-Connect: UNKNOWN[10.128.0.15]
X-Barracuda-Start-Time: 1536340459
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA384
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at hxt-semitech.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.4987 1.0000 0.0000
X-Barracuda-Spam-Score: -0.00
X-Barracuda-Spam-Status: No, SCORE=-0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=ISO2022JP_CHARSET
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.57077
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        -0.00 ISO2022JP_CHARSET      ISO-2022-JP message
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/2018 11:33 PM, Sergei Shtylyov wrote:
> On 09/07/2018 02:19 PM, Wang Dongsheng wrote:
>
>> Can't have non-inline function in a header file.
>> There is a risk of "Multiple definition" from cross-including.
>>
>> Tested on: x86_64, make ARCH=i386
>>
>> Modules section .text:
>> i40e: 00019380 <__i40e_add_stat_strings>:
>> i40evf: 00006b00 <__i40e_add_stat_strings>:
>>
>> Buildin section .text:
>> i40e: c351ca60 <__i40e_add_stat_strings>:
>> i40evf: c354f2c0 <__i40e_add_stat_strings>:
>>
>> Signed-off-by: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
>> ---
>> V3: add static 
>> ---
>>  .../intel/i40evf/i40e_ethtool_stats.h         | 23 +-----------------
>>  .../ethernet/intel/i40evf/i40evf_ethtool.c    | 24 +++++++++++++++++++
>>  2 files changed, 25 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/i40evf/i40e_ethtool_stats.h b/drivers/net/ethernet/intel/i40evf/i40e_ethtool_stats.h
>> index 60b595dd8c39..62ab67a77753 100644
>> --- a/drivers/net/ethernet/intel/i40evf/i40e_ethtool_stats.h
>> +++ b/drivers/net/ethernet/intel/i40evf/i40e_ethtool_stats.h
>> @@ -181,29 +181,8 @@ i40evf_add_queue_stats(u64 **data, struct i40e_ring *ring)
>>  	*data += size;
>>  }
>>  
>> -/**
>> - * __i40e_add_stat_strings - copy stat strings into ethtool buffer
>> - * @p: ethtool supplied buffer
>> - * @stats: stat definitions array
>> - * @size: size of the stats array
>> - *
>> - * Format and copy the strings described by stats into the buffer pointed at
>> - * by p.
>> - **/
>>  static void __i40e_add_stat_strings(u8 **p, const struct i40e_stats stats[],
>    There's no point to keeping *static* function in the header file (unless it's
> also *inline*).

Yes， we need it for now. Because there is a copy file at i40e dir, and
a "Multiple definition" will show up when we buildin i40e&i40evf and
remove this *static* .

Cause the header file is only used  in ethtool.c so we can keep this
static, and another option is not touch this header.

As I replied to Jacob's email earlier, we can do without touch i40evf at
all. Because this header is only for one and not included in another.


Cheers,

Dongsheng

>> -				    const unsigned int size, ...)
>> -{
>> -	unsigned int i;
>> -
>> -	for (i = 0; i < size; i++) {
>> -		va_list args;
>> -
>> -		va_start(args, size);
>> -		vsnprintf(*p, ETH_GSTRING_LEN, stats[i].stat_string, args);
>> -		*p += ETH_GSTRING_LEN;
>> -		va_end(args);
>> -	}
>> -}
>> +				    const unsigned int size, ...);
>>  
>>  /**
>>   * 40e_add_stat_strings - copy stat strings into ethtool buffer
> [...]
>
> MBR, Sergei
>

