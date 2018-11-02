Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E0FC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 20:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FB6F2082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 20:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ve/93AEt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FB6F2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbeKCGCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 02:02:32 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:26270 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbeKCGCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 02:02:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1541192033; x=1572728033;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=h21NZ+6tpNhp03nxgXgjSEzvrceBjFMbjb2yIRYXHWg=;
  b=Ve/93AEtmm9pBUKTPCU+gXgsGjbh3coV4zZV1YbM5mI24ZmMdJYtw2hy
   F70+GcVhaof6kkFHwcHpc017EhRsNWsM/KYdUbF1FbdKsa+ZkkfPU/kbT
   kUSaeLqhvRkoYLCK4Jyv2N1/K++4SLbcRhw//xM0K/5s2iMXIu552jNKb
   IAznrrOOP/p9LpGO1pQFzsedn4eaQxdMlobVhwgayGbRvJAQffIhEPr3q
   WtmyrqqzrrBHdc/F2dn/EbBFZljDnRTuj1CCbuoghq+5bB5al4NCT6YTr
   qyqp17cfN+plaOFLrUObhMypXGFZ1i0HNdh2Ur1mcLcA6gheOhRvq0EZ+
   Q==;
X-IronPort-AV: E=Sophos;i="5.54,457,1534780800"; 
   d="scan'208";a="197865208"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2018 04:53:52 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 02 Nov 2018 13:37:46 -0700
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.111.69.187]) ([10.111.69.187])
  by uls-op-cesaip01.wdc.com with ESMTP; 02 Nov 2018 13:53:53 -0700
Subject: Re: [RFC 1/2] dt-bindings: topology: Add RISC-V cpu topology.
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        Christoph Hellwig <hch@infradead.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "alankao@andestech.com" <alankao@andestech.com>,
        Zong Li <zong@andestech.com>
References: <1541113468-22097-1-git-send-email-atish.patra@wdc.com>
 <1541113468-22097-2-git-send-email-atish.patra@wdc.com>
 <CAL_Jsq+wProNynprMjQnrz1jmbZT9TmmA-_=vPUxCEED_8xONg@mail.gmail.com>
 <20181102133100.GA13130@e107155-lin>
 <CAL_JsqLO+cOcHkr41ebPtONwrzOWGhksH1ypph+tihsuOVDOug@mail.gmail.com>
 <20181102155038.GA21067@e107155-lin>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <0c94f752-cc18-ae0c-36e7-7e0dd6b1d307@wdc.com>
Date:   Fri, 2 Nov 2018 13:53:51 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181102155038.GA21067@e107155-lin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/18 8:50 AM, Sudeep Holla wrote:
> On Fri, Nov 02, 2018 at 10:11:38AM -0500, Rob Herring wrote:
>> On Fri, Nov 2, 2018 at 8:31 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>>>
>>> On Fri, Nov 02, 2018 at 08:09:39AM -0500, Rob Herring wrote:
>>>> On Thu, Nov 1, 2018 at 6:04 PM Atish Patra <atish.patra@wdc.com> wrote:
>>>>>
>>>>> Define a RISC-V cpu topology. This is based on cpu-map in ARM world.
>>>>> But it doesn't need a separate thread node for defining SMT systems.
>>>>> Multiple cpu phandle properties can be parsed to identify the sibling
>>>>> hardware threads. Moreover, we do not have cluster concept in RISC-V.
>>>>> So package is a better word choice than cluster for RISC-V.
>>>>
>>>> There was a proposal to add package info for ARM recently. Not sure
>>>> what happened to that, but we don't need 2 different ways.
>>>>
>>>
>>> We still need that, I can brush it up and post what Lorenzo had previously
>>> proposed[1]. We want to keep both DT and ACPI CPU topology story aligned.
>>
>> Frankly, I don't care what the ACPI story is. I care whether each cpu
> 
> Sorry I meant feature parity with ACPI and didn't refer to the mechanics.
> 
>> arch does its own thing in DT or not. If a package prop works for
>> RISC-V folks and that happens to align with ACPI, then okay. Though I
>> tend to prefer a package represented as a node rather than a property
>> as I think that's more consistent.
>>
> 
> Sounds good. One of the reason for making it *optional* property is for
> backward compatibility. But we should be able to deal with that even with
> node.
> 

If you are introducing a package node, can we make cluster node 
optional? I feel it is a redundant node for use cases where one doesn't 
have a different grouped cpus in a package.

We may have some architecture that requires cluster, it can be added to 
the DT at that time, I believe.

>> Any comments on the thread aspect (whether it has ever been used)?
>> Though I think thread as a node level is more consistent with each
>> topology level being a node (same with package).
>>
> Not 100% sure, the only multi threaded core in the market I know is
> Cavium TX2 which is ACPI.
> 

Any advantages of keeping thread node if it's not being used. If I am 
not wrong, we can always use multiple cpuN phandles to represent SMT 
nodes. It will result in less code and DT documentation as well.


Regards,
Atish
> --
> Regards,
> Sudeep
> 

