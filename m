Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A136FFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3587F20873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:53:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3587F20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbeG3L2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 07:28:07 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:53283 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726709AbeG3L2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 07:28:07 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="42818774"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 30 Jul 2018 17:53:50 +0800
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
        by cn.fujitsu.com (Postfix) with ESMTP id C68414B6ADE1;
        Mon, 30 Jul 2018 17:53:45 +0800 (CST)
Received: from localhost.localdomain (10.167.226.106) by
 G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.399.0; Mon, 30 Jul 2018 17:53:48 +0800
Subject: Re: [PATCH 1/2] x86/tsc: Avoid a double call if TSC initializes
 earlier.
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>
References: <20180730075421.22830-1-douly.fnst@cn.fujitsu.com>
 <20180730075421.22830-2-douly.fnst@cn.fujitsu.com>
 <20180730093447.GF2494@hirez.programming.kicks-ass.net>
From:   Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <a2d372a3-a7cc-34ae-679d-cf71d243ee04@cn.fujitsu.com>
Date:   Mon, 30 Jul 2018 17:53:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180730093447.GF2494@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: C68414B6ADE1.ABA8A
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

At 07/30/2018 05:34 PM, Peter Zijlstra wrote:
> On Mon, Jul 30, 2018 at 03:54:20PM +0800, Dou Liyang wrote:
>> static_branch_enable(&__use_tsc) may be called twice in common case, that
>> is redundant.
> 
> It is also really not a problem...
> 

Yes, right. Just avoid the second useless setting.

Thanks,
	dou

> 
> 


