Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DFACC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4898F21871
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfADI5A convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 03:57:00 -0500
Received: from [38.106.11.25] ([38.106.11.25]:38854 "EHLO
        barracuda02.hxt-semitech.com" rhost-flags-FAIL-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727107AbfADI47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 03:56:59 -0500
X-ASG-Debug-ID: 1546592208-107606139ff32a0001-xx1T2L
Received: from HXTBJIDCEMVIW02.hxtcorp.net ([10.128.0.15]) by barracuda02.hxt-semitech.com with ESMTP id zstSvGxvyz0eteag (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Fri, 04 Jan 2019 16:56:51 +0800 (CST)
X-Barracuda-Envelope-From: shunyong.yang@hxt-semitech.com
Received: from HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) by
 HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 4 Jan 2019 16:56:44 +0800
Received: from HXTBJIDCEMVIW02.hxtcorp.net ([fe80::3e:f4ff:7927:a6f6]) by
 HXTBJIDCEMVIW02.hxtcorp.net ([fe80::3e:f4ff:7927:a6f6%12]) with mapi id
 15.00.1395.000; Fri, 4 Jan 2019 16:56:44 +0800
From:   "Yang, Shunyong" <shunyong.yang@hxt-semitech.com>
To:     "vkoul@kernel.org" <vkoul@kernel.org>
CC:     "andy.gross@linaro.org" <andy.gross@linaro.org>,
        "david.brown@linaro.org" <david.brown@linaro.org>,
        Sinan Kaya <okaya@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zheng, Joey" <yu.zheng@hxt-semitech.com>
Subject: Re: [PATCH 2/2] dmaengine: qcom_hidma: assign channel cookie
 correctly
Thread-Topic: [PATCH 2/2] dmaengine: qcom_hidma: assign channel cookie
 correctly
X-ASG-Orig-Subj: Re: [PATCH 2/2] dmaengine: qcom_hidma: assign channel cookie
 correctly
Thread-Index: AQHUjeVi0WVpnH1GL02j01lRgeSliA==
Date:   Fri, 4 Jan 2019 08:56:43 +0000
Message-ID: <16bbdd233f1d45249eb2f6592418efd5@HXTBJIDCEMVIW02.hxtcorp.net>
References: <81c9fe2de4b5dac1d5b974f5305e35bf1cf5d127.1544156508.git.shunyong.yang@hxt-semitech.com>
 <ea6c6317dabffdcfa28cdb391b50edce98ce875d.1544156508.git.shunyong.yang@hxt-semitech.com>
 <88ef21bd-4e4f-8cce-39b3-53da45740f0f@kernel.org>
 <79da1c31d3e14e6e91cf6a7cc0fea31a@HXTBJIDCEMVIW01.hxtcorp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.64.6.199]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Barracuda-Connect: UNKNOWN[10.128.0.15]
X-Barracuda-Start-Time: 1546592211
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA384
X-Barracuda-URL: https://192.168.50.102:443/cgi-mod/mark.cgi
X-Barracuda-Scan-Msg-Size: 2010
X-Virus-Scanned: by bsmtpd at hxt-semitech.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0405 1.0000 -1.7599
X-Barracuda-Spam-Score: -1.26
X-Barracuda-Spam-Status: No, SCORE=-1.26 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=BSF_RULE_7582B
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.65068
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.50 BSF_RULE_7582B         Custom Rule 7582B
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Vinod,

Gentle ping. Would you please help to review these two patches and merge?

On 2018/12/14 9:03, Yang, Shunyong wrote:
> Hi, Sinan
> 
> On 2018/12/9 4:28, Sinan Kaya wrote:
>> On 12/6/2018 11:29 PM, Shunyong Yang wrote:
>>> When dma_cookie_complete() is called in hidma_process_completed(),
>>> dma_cookie_status() will return DMA_COMPLETE in hidma_tx_status(). Then,
>>> hidma_txn_is_success() will be called to use channel cookie
>>> mchan->last_success to do additional DMA status check. Current code
>>> assigns mchan->last_success after dma_cookie_complete(). This causes
>>> a race condition of dma_cookie_status() returns DMA_COMPLETE before
>>> mchan->last_success is assigned correctly. The race will cause
>>> hidma_tx_status() return DMA_ERROR but the transaction is actually a
>>> success. Moreover, in async_tx case, it will cause a timeout panic
>>> in async_tx_quiesce().
>>>
>>>   Kernel panic - not syncing: async_tx_quiesce: DMA error waiting for
>>>   transaction
>>>   ...
>>>   Call trace:
>>>   [<ffff000008089994>] dump_backtrace+0x0/0x1f4
>>>   [<ffff000008089bac>] show_stack+0x24/0x2c
>>>   [<ffff00000891e198>] dump_stack+0x84/0xa8
>>>   [<ffff0000080da544>] panic+0x12c/0x29c
>>>   [<ffff0000045d0334>] async_tx_quiesce+0xa4/0xc8 [async_tx]
>>>   [<ffff0000045d03c8>] async_trigger_callback+0x70/0x1c0 [async_tx]
>>>   [<ffff0000048b7d74>] raid_run_ops+0x86c/0x1540 [raid456]
>>>   [<ffff0000048bd084>] handle_stripe+0x5e8/0x1c7c [raid456]
>>>   [<ffff0000048be9ec>] handle_active_stripes.isra.45+0x2d4/0x550 [raid456]
>>>   [<ffff0000048beff4>] raid5d+0x38c/0x5d0 [raid456]
>>>   [<ffff000008736538>] md_thread+0x108/0x168
>>>   [<ffff0000080fb1cc>] kthread+0x10c/0x138
>>>   [<ffff000008084d34>] ret_from_fork+0x10/0x18
>>>
>>> Cc: Joey Zheng<yu.zheng@hxt-semitech.com>
>>> Signed-off-by: Shunyong Yang<shunyong.yang@hxt-semitech.com>
>>
>>
>> Acked-by: Sinan Kaya <okaya@kernel.org>
>>
>> to both patches 1/2 and 2/2.
>>
>>
> Thanks for the ACKs.
> 
> Shunyong.
> 
> 

