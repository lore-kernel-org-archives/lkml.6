Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3927C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CD1020658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YfHc5/My"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CD1020658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727475AbeH3UOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 16:14:17 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:17569 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbeH3UOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 16:14:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1535645485; x=1567181485;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=UsFHpu4yAhoGXgR4kvN0CxQ5g8NoPJQROJxiFaGgf+s=;
  b=YfHc5/My+4d59EOYYFY3jVzIqHo0fTPozzwv8HJvRnH0XfdXhbheO2LD
   ZzXf3oN+qAYQxr/6KgUO2Sp4ArJFivywEz/BUHBji6KKoCjGIP9GrLYrA
   +qGdiZbuReaQGYD2d9NT7aVPpG17ASGUJCyztaOXWrZzU2psyM/E57G72
   v3KEiYq5X9uN4+wMfcBYSZz+WgEX8hxAolm+UlaZs33AX0eex+YuVcuV5
   4JZ5HTfG3Skr4HGvi8y+fFcHIwIhj8QXLgmfCjliGkAImUFRtFsbMn2z3
   4Z25Y+HiPa851IO/qT+kvJkUqI4GNpNt86FgXEnxatAgBNON7ud664mSz
   g==;
X-IronPort-AV: E=Sophos;i="5.53,307,1531756800"; 
   d="scan'208";a="89668618"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 31 Aug 2018 00:11:14 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 30 Aug 2018 08:58:17 -0700
Received: from lpt-kim-271.ad.shared (HELO [10.86.62.101]) ([10.86.62.101])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Aug 2018 09:11:12 -0700
Subject: Re: [PATCH 5/8] RISC-V: Rename im_okay_therefore_i_am to
 found_boot_cpu
To:     Christoph Hellwig <hch@infradead.org>,
        Palmer Dabbelt <palmer@sifive.com>
Cc:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "dmitriy@oss-tech.org" <dmitriy@oss-tech.org>,
        "jeremy.linton@arm.com" <jeremy.linton@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        Greg KH <gregkh@linuxfoundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>
References: <20180827184243.25344-1-palmer@sifive.com>
 <20180827184243.25344-6-palmer@sifive.com>
 <20180830144118.GA27233@infradead.org>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <30229ef5-ce4e-e78b-32f9-7c563f63827b@wdc.com>
Date:   Thu, 30 Aug 2018 09:11:11 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180830144118.GA27233@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/18 7:41 AM, Christoph Hellwig wrote:
>>   	struct device_node *dn = NULL;
>> -	int hart, im_okay_therefore_i_am = 0;
>> +	int hart, found_boot_cpu = 0;
> 
> If you rename this anyway please switch to use a bool.
> 

I can address the comment on this patch and fold it in my series to 
avoid unnecessary conflict.

@Palmer: You can drop this patch.

Regards,
Atish
