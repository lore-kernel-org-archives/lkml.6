Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C247C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 120CB2075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:29:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 120CB2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hxt-semitech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbeIGWLx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 18:11:53 -0400
Received: from mx01.hxt-semitech.com ([223.203.96.7]:52869 "EHLO
        barracuda.hxt-semitech.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726002AbeIGWLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 18:11:52 -0400
X-ASG-Debug-ID: 1536341387-093b7e54e6124a0001-xx1T2L
Received: from HXTBJIDCEMVIW01.hxtcorp.net ([10.128.0.14]) by barracuda.hxt-semitech.com with ESMTP id nXgfgClEkgidVyZT (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Sat, 08 Sep 2018 01:29:47 +0800 (CST)
X-Barracuda-Envelope-From: dongsheng.wang@hxt-semitech.com
Received: from HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) by
 HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sat, 8 Sep 2018 01:29:50 +0800
Received: from HXTBJIDCEMVIW02.hxtcorp.net ([fe80::3e:f4ff:7927:a6f6]) by
 HXTBJIDCEMVIW02.hxtcorp.net ([fe80::3e:f4ff:7927:a6f6%12]) with mapi id
 15.00.1395.000; Sat, 8 Sep 2018 01:29:50 +0800
From:   "Wang, Dongsheng" <dongsheng.wang@hxt-semitech.com>
To:     "Wyborny, Carolyn" <carolyn.wyborny@intel.com>,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>,
        "sergei.shtylyov@cogentembedded.com" 
        <sergei.shtylyov@cogentembedded.com>
CC:     "Keller, Jacob E" <jacob.e.keller@intel.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] net: ethernet: i40evf: fix underlying build error
Thread-Topic: [PATCH v3 2/2] net: ethernet: i40evf: fix underlying build error
X-ASG-Orig-Subj: Re: [PATCH v3 2/2] net: ethernet: i40evf: fix underlying build error
Thread-Index: AQHURpyuUEMtiCDf+EGRwpahWdajkw==
Date:   Fri, 7 Sep 2018 17:29:49 +0000
Message-ID: <5ed6f32940644d7f9a13ac55e2015165@HXTBJIDCEMVIW02.hxtcorp.net>
References: <1536319175-3660-1-git-send-email-dongsheng.wang@hxt-semitech.com>
 <1536319175-3660-3-git-send-email-dongsheng.wang@hxt-semitech.com>
 <77898840b49847a7a835b20b383e21a2@HXTBJIDCEMVIW02.hxtcorp.net>
 <9BBC4E0CF881AA4299206E2E1412B6267C604A79@ORSMSX102.amr.corp.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.168.50.12]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Barracuda-Connect: UNKNOWN[10.128.0.14]
X-Barracuda-Start-Time: 1536341387
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA384
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at hxt-semitech.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.1937 1.0000 -0.8611
X-Barracuda-Spam-Score: -0.86
X-Barracuda-Spam-Status: No, SCORE=-0.86 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.57077
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/2018 11:27 PM, Wyborny, Carolyn wrote:
>> -----Original Message-----
>> From: Wang, Dongsheng [mailto:dongsheng.wang@hxt-semitech.com]
>> Sent: Friday, September 07, 2018 5:34 AM
>> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>;
>> sergei.shtylyov@cogentembedded.com
>> Cc: Keller, Jacob E <jacob.e.keller@intel.com>; davem@davemloft.net;
>> intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
>> kernel@vger.kernel.org; Wyborny, Carolyn <carolyn.wyborny@intel.com>
>> Subject: Re: [PATCH v3 2/2] net: ethernet: i40evf: fix underlying build error
>>
>> Hello Jacob,
>>
>> Since Carolyn' team is working this, I think we don't need this patch
>> anymore because this header file is only for ethtool.c.
>> [..]
> Hello Dongsheng,
>
> The commonization effort we're working on is prioritizing our newest drivers.  The i40e work is still being scoped, so we should fix this problem as needed now and not wait.

After Sergei agree.  ;)


Cheers,

Dongsheng

> I apologize for any miscommunication.  Was trying to let people know that we aware of the issue and are trying to make progress in that direction.
>
> Thanks,
>
> Carolyn
>

