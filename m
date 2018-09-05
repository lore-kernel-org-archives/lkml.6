Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775B7C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 01:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 378D520867
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 01:32:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 378D520867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hxt-semitech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbeIEGA0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 02:00:26 -0400
Received: from mx01.hxt-semitech.com ([223.203.96.7]:50059 "EHLO
        barracuda.hxt-semitech.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725825AbeIEGAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 02:00:25 -0400
X-ASG-Debug-ID: 1536111151-093b7e636b124b20001-xx1T2L
Received: from HXTBJIDCEMVIW01.hxtcorp.net ([10.128.0.14]) by barracuda.hxt-semitech.com with ESMTP id 7oyZmNstXN6MDCVF (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 05 Sep 2018 09:32:32 +0800 (CST)
X-Barracuda-Envelope-From: dongsheng.wang@hxt-semitech.com
Received: from HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) by
 HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 5 Sep 2018 09:32:37 +0800
Received: from HXTBJIDCEMVIW02.hxtcorp.net ([fe80::3e:f4ff:7927:a6f6]) by
 HXTBJIDCEMVIW02.hxtcorp.net ([fe80::3e:f4ff:7927:a6f6%12]) with mapi id
 15.00.1395.000; Wed, 5 Sep 2018 09:32:36 +0800
From:   "Wang, Dongsheng" <dongsheng.wang@hxt-semitech.com>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "jeffrey.t.kirsher@intel.com" <jeffrey.t.kirsher@intel.com>
CC:     "jacob.e.keller@intel.com" <jacob.e.keller@intel.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: ethernet: i40e: fix build error
Thread-Topic: [PATCH] net: ethernet: i40e: fix build error
X-ASG-Orig-Subj: Re: [PATCH] net: ethernet: i40e: fix build error
Thread-Index: AQHURDSC/LGm4sy0d0azq1hmU6eJbg==
Date:   Wed, 5 Sep 2018 01:32:36 +0000
Message-ID: <543739fcaa474cb2bcc5604e27527358@HXTBJIDCEMVIW02.hxtcorp.net>
References: <1536054527-34184-1-git-send-email-dongsheng.wang@hxt-semitech.com>
 <84982f95-940e-d278-f6a2-13a9f76823c9@cogentembedded.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.64.6.85]
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Barracuda-Connect: UNKNOWN[10.128.0.14]
X-Barracuda-Start-Time: 1536111152
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA384
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at hxt-semitech.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.4069 1.0000 0.0000
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.56895
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/4 18:54, Sergei Shtylyov wrote:
> On 9/4/2018 12:48 PM, Wang Dongsheng wrote:
>
>> Remove "inline" from __i40e_add_stat_strings.
>>
>> In file included from
>> drivers/net/ethernet/intel/i40e/i40e_ethtool.c:9:0:
>> drivers/net/ethernet/intel/i40e/i40e_ethtool.c: In function
>> ‘__i40e_add_stat_strings’:
>> drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h:193:20: error:
>> function ‘__i40e_add_stat_strings’ can never be inlined because it uses
>> variable argument lists
>>   static inline void __i40e_add_stat_strings(u8 **p, const struct
>> 					    i40e_stats stats[],
>>
>> Signed-off-by: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
>> ---
>>   drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h b/drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h
>> index bba1cb0..0290ade 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h
>> +++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h
>> @@ -190,7 +190,7 @@ struct i40e_stats {
>>    * Format and copy the strings described by stats into the buffer pointed at
>>    * by p.
>>    **/
>> -static inline void __i40e_add_stat_strings(u8 **p, const struct i40e_stats stats[],
>> +static void __i40e_add_stat_strings(u8 **p, const struct i40e_stats stats[],
>     You can't have non-inline function in a header file. Please move it, 
> leaving only prototype here.
:(. Oops, a stupid mistake...fix an error and bring in another
error...Thanks.

Cheers,
-Dongsheng
>>   				    const unsigned int size, ...)
>>   {
>>   	unsigned int i;
> MBR, Sergei
>

