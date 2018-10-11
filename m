Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236CDC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 11:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C81F42087A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 11:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="NjLmh4wJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C81F42087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbeJKSt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 14:49:29 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:46401 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbeJKSt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 14:49:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1539256961; x=1570792961;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=M/8RQ58dt8BbSSw6quOSaGV5lK6u7jNT5N0bQmb20r4=;
  b=NjLmh4wJ8bffxHva+KyGzU4GAQCxLCsoObrZXLJa2NKQ4Gyn8brPuKO2
   +QM/0yJcYhs0IsbHvRgpDhaxIuigjTd6bu+a08vaJJ0iD7RC6sy+4o7cr
   qTXTCyuSoKgF0HBUON6ftPROg0gjkcoZ4zPd+bSHqRWWz0fDtZ+rMB9YX
   k=;
X-IronPort-AV: E=Sophos;i="5.54,368,1534809600"; 
   d="scan'208";a="763378672"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 11 Oct 2018 11:22:39 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w9BBMZx9039677
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 11 Oct 2018 11:22:38 GMT
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 11 Oct 2018 11:22:38 +0000
Received: from [10.55.103.19] (10.43.160.245) by EX13D01EUB001.ant.amazon.com
 (10.43.166.194) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 11 Oct
 2018 11:22:32 +0000
Subject: Re: [PATCH 2/2] dw: spi: add support for Alpine spi controller
To:     Trent Piepho <tpiepho@impinj.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        "jonnyc@amazon.com" <jonnyc@amazon.com>,
        "ronenk@amazon.com" <ronenk@amazon.com>,
        "barakw@amazon.com" <barakw@amazon.com>
References: <1539155293-21750-1-git-send-email-talel@amazon.com>
 <1539184516-8200-1-git-send-email-talel@amazon.com>
 <1539184516-8200-2-git-send-email-talel@amazon.com>
 <1539209339.1944.23.camel@impinj.com>
From:   Talel Shenhar <talel@amazon.com>
Message-ID: <a319e310-1296-3b9e-abfe-bd33c3d8bb9d@amazon.com>
Date:   Thu, 11 Oct 2018 14:22:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1539209339.1944.23.camel@impinj.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.43.160.245]
X-ClientProxiedBy: EX13D13UWA004.ant.amazon.com (10.43.160.251) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/11/2018 01:08 AM, Trent Piepho wrote:
> On Wed, 2018-10-10 at 18:15 +0300, Talel Shenhar wrote:
>> Add support for a new devicetree compatible string called
>> 'al,alpine-apb-ssi', which is necessary for the Amazon Alpine spi
>> controller. 'al,alpine-dw-apb-ssi' is used in the dw spi driver if
>> specified in the devicetree.  Otherwise, fall back to driver default
>> behavior, i.e. original dw IP hw driver behavior.
>>
>> Signed-off-by: Talel Shenhar <talel@amazon.com>
>> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> Shouldn't this be "amzn,alpine-apb-ssi"?  The convention, and this IS
> documented, is to the use company's stock ticker symbol as the prefix,
> so as to have something grounded in the real world.  I don't know of
> anyone else using a product line name as the company name in their dt
> bindings.  Example, "snps,dw-apb-ssi", is named for Synopsis, not the
> Designware line.
>
updated the vendor prefix to "amazon" as described in bindings/vendor-prefixes.txt.
