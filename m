Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E801C43143
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 01:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA59020839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 01:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Qm0Ay2nD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA59020839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbeIKGdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 02:33:40 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:28871 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbeIKGdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 02:33:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1536629844; x=1568165844;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=NC0Oy3jaT/HJuCJGrkjXSBksiKsBn+8YRgsIxoBwnDw=;
  b=Qm0Ay2nDRC0/W4VtYrEZi5IrvZoPpoTAnQL9tuOWptG4SDrjrBErXdYE
   yVa7aKgQyPIxQ8TCLCL+NN+BcEyiSgXcm7EFzoZxWpL+H7NDw+cy5+vP1
   DQJmPjL11iha3gyG2nowPe1KfVyXn9s0zW50VNQY6tR1Gb/E97zdglSi3
   MoKHCPaDBl2Wv5Pt7UdmKFrukvmUiNspTiWF0zO2SR+NjNveV6gAsBQMV
   yZP6dPBVpZslpIOMkDWbUierfKJgD3VL9RVQUFVGv+w0/aBz1wgVzvvLx
   zqvaQLg8BlLMMM+5RHF9GJInUx05Z/vAXVR9duzfeTJ6ZdcTA00Jz8PR/
   g==;
X-IronPort-AV: E=Sophos;i="5.53,358,1531756800"; 
   d="scan'208";a="187006441"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2018 09:37:23 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 10 Sep 2018 18:23:28 -0700
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.196.159.148]) ([10.196.159.148])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Sep 2018 18:36:53 -0700
Subject: Re: [PATCH v3 06/12] RISC-V: Rename riscv_of_processor_hart to
 riscv_of_processor_hartid
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "palmer@sifive.com" <palmer@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "dmitriy@oss-tech.org" <dmitriy@oss-tech.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jeremy.linton@arm.com" <jeremy.linton@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
References: <1536221135-182613-1-git-send-email-atish.patra@wdc.com>
 <1536221135-182613-7-git-send-email-atish.patra@wdc.com>
 <20180910112548.GF12979@infradead.org>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <6acd4eec-bdfb-cfc8-6dca-782eb9ec01b0@wdc.com>
Date:   Mon, 10 Sep 2018 18:36:52 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180910112548.GF12979@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/18 4:26 AM, Christoph Hellwig wrote:
> On Thu, Sep 06, 2018 at 01:05:29AM -0700, Atish Patra wrote:
>> From: Palmer Dabbelt <palmer@sifive.com>
>>
>> It's a bit confusing exactly what this function does: it actually
>> returns the hartid of an OF processor node, failing with -1 on invalid
>> nodes.  I've changed the name to _hartid() in order to make that a bit
>> more clear, as well as adding a comment.
>>
>> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> 
> Looks generally good, but it is going to conflict with the dt iterators
> series from Rob.  Given that this is just a little cleanup it might be
> worth deferring until the next merge window.
> 

Sure. np. I guess the entire series can be parked in for-next until the 
next merge window opens.

Regards,
Atish
> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 

