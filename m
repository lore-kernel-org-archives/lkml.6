Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FBEEECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 02:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2FC22088F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 02:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bO4GRHFW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2FC22088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbeIRH5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 03:57:16 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38474 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbeIRH5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 03:57:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1537237622; x=1568773622;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=guZjoxpwvGeJhJJaUh65SNm583dTapTaQdlYPi2VTy8=;
  b=bO4GRHFWgPiNchFr9qWsKBGkl31b0/11mGroprfl+h5hESudrnsORmqZ
   Av/F6+IXTsuVTJEBbXx8sIpDngWDceJQyg4UIU+h2ddEEn2/WPXacnGVt
   BiTaQcIzNJztwiAFtCNHdvjMSLy8fTwwBxUyKrojrMGqrfObp23kudXBB
   kOcD7GFmvwDBsMNY1wrqr7mGKfO6yoFvzmBmR1w1tlbdqV5E6FCfsjMCu
   Gf5XBDu5PmARDolzKP4WHWfxmnip+qkI/z7wqWz/rJFAgEeXAFjr/CD16
   wUMHf3Z1sBrwVZVB3v2RmLIS/yCvyfBnqA8Ep5g37X3bBBZXQuivjbvBn
   w==;
X-IronPort-AV: E=Sophos;i="5.53,387,1531756800"; 
   d="scan'208";a="91008021"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Sep 2018 10:26:53 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 17 Sep 2018 19:13:04 -0700
Received: from d4bdf12.ad.shared (HELO [10.86.55.130]) ([10.86.55.130])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Sep 2018 19:26:53 -0700
Subject: Re: [RFC 1/3] dt-bindings: Correct RISC-V's timebase-frequency
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "palmer@sifive.com" <palmer@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>
References: <1536962096-233842-1-git-send-email-atish.patra@wdc.com>
 <1536962096-233842-2-git-send-email-atish.patra@wdc.com>
 <20180917142017.GA15588@infradead.org>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <b397a711-90e8-8c35-c49a-8d60b129c384@wdc.com>
Date:   Mon, 17 Sep 2018 19:26:52 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180917142017.GA15588@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/18 7:20 AM, Christoph Hellwig wrote:
> On Fri, Sep 14, 2018 at 02:54:54PM -0700, Atish Patra wrote:
>> From: Palmer Dabbelt <palmer@sifive.com>
>>
>> Someone must have read the device tree specification incorrectly,
>> because we were putting timebase-frequency in the wrong place.  This
>> corrects the issue, moving it from
> 
> Last time this was brought up we actually had realy life DTs with
> the timebase-frequency under cpus and not the invidual cpu node.
> 

Unfortunately, it still is. I hope SiFive can publish the updated 
firmware with correct DT entries. I can patch BBL to fix these DT issues 
until the firmware update if that's accepted.


> I think we need to just document both possibilities and live with
> them.
> 
Yup. That was the intention. I will update the document/commit text to 
reflect that.


Regards,
Atish
