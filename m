Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238D0C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 01:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC8FC2080C
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 01:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="G8oNVOdL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC8FC2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730702AbeKTLpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 06:45:14 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:20327 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729913AbeKTLpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 06:45:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1542676724; x=1574212724;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=KDp4SV5wa6FEhU/tN43Qt3FuqMoswbj9h1vKtM2TQe4=;
  b=G8oNVOdLf+/7vKAjuH8kCIcoqqKd4j4pXjThGgQ4uzLaiKv+LRtaWiZn
   3jcozyd7YdKPUa+PLUb++udlpFztPKht8WohdS3iXsDspwVvhZ1U2mYBS
   KqT8dlqLuAU67CyKFTRRmH7JA9QlysgbHVcCNLP1JswQfz2hx3PzOt7uO
   NroFGQZeyKK/Y8NYe/Hai2qp5BAA1ol4501Zh/RdaoRCW9PTDW8sTMmid
   E6GeaUCFUzw5r6FAtv8pU7hoKyQnnGuW63+3ZfQ2J5TOPBV9m9p4KScJf
   wyGeO7cvCihDDP56xrmlr9YjY8LbSxKFB8IbVws6XTdkqOUbVKr9kZXIB
   w==;
X-IronPort-AV: E=Sophos;i="5.56,255,1539619200"; 
   d="scan'208";a="199186970"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Nov 2018 09:18:43 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 19 Nov 2018 17:01:59 -0800
Received: from cnf003109.ad.shared (HELO [10.86.54.248]) ([10.86.54.248])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Nov 2018 17:18:44 -0800
Subject: Re: [RFC PATCH] Documentation: DT: arm: add support for sockets
 defining package boundaries
To:     Rob Herring <robh@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "anup@brainfault.org" <anup@brainfault.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "mick@ics.forth.gr" <mick@ics.forth.gr>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "zong@andestech.com" <zong@andestech.com>,
        "alankao@andestech.com" <alankao@andestech.com>
References: <20181107171344.983-1-sudeep.holla@arm.com>
 <5bea0ecf.1c69fb81.7820a.2052@mx.google.com>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <e599eaf5-381b-e2e0-067a-4225bb348b80@wdc.com>
Date:   Mon, 19 Nov 2018 17:18:42 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <5bea0ecf.1c69fb81.7820a.2052@mx.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/18 3:37 PM, Rob Herring wrote:
> On Wed, Nov 07, 2018 at 05:13:44PM +0000, Sudeep Holla wrote:
>> The current ARM DT topology description provides the operating system
>> with a topological view of the system that is based on leaf nodes
>> representing either cores or threads (in an SMT system) and a
>> hierarchical set of cluster nodes that creates a hierarchical topology
>> view of how those cores and threads are grouped.
>>
>> However this hierarchical representation of clusters does not allow to
>> describe what topology level actually represents the physical package or
>> the socket boundary, which is a key piece of information to be used by
>> an operating system to optimize resource allocation and scheduling.
>>
>> Lets add a new "socket" node type in the cpu-map node to describe the
>> same.
>>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>   .../devicetree/bindings/arm/topology.txt      | 52 ++++++++++++++-----
>>   1 file changed, 39 insertions(+), 13 deletions(-)
>>
>> (Note patch generated with -b option to avoid 60+ of whitespace changes)
>>
>> Hi Rob,
>>
>> You had expressed your interest to generalise the CPU topology bindings
>> accross multiple architectures. Do you want to move to the generic
>> bindings before adding this $subject socket support or is it OK to
>> finalise on this and then move the majority(based on the agreement)
>> to generic binding.
> 
> Doesn't really matter to me as long as Risc-V folks are in agreement.
> 
> Otherwise, this looks fine to me.
> 
> Rob
> 
> 
I can apply this patch in my unify topology series and resend everything 
together as one series.


Regards,
Atish
