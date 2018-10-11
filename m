Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC6BC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 07:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ECB621477
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 07:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="OniMaIpQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ECB621477
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbeJKPFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 11:05:42 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:38322 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbeJKPFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 11:05:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1539243579; x=1570779579;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=+pVD6oOHFmz2iQxakNe65nKKC9Tj6IQQ5kYUkQd/q/M=;
  b=OniMaIpQPM9ZQnXSouw8u7qmpJdgLBRtxNEhCZmCCRuhH3xghu3fIVIG
   FNlphQx5ii7dT2Ojmd9IaG48XDn7nYlPwXqANJc1WoSVXJeV3RjyjLpJ9
   RdSl6iHi/hdu47VE55scErQ/bDwwafBvcHbIQFbjLLF/28M7ezsKyn3In
   4=;
X-IronPort-AV: E=Sophos;i="5.54,367,1534809600"; 
   d="scan'208";a="758269250"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 11 Oct 2018 07:39:36 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w9B7dXlM072493
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 11 Oct 2018 07:39:34 GMT
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 11 Oct 2018 07:39:33 +0000
Received: from [10.55.103.19] (10.43.160.245) by EX13D01EUB001.ant.amazon.com
 (10.43.166.194) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 11 Oct
 2018 07:39:27 +0000
Subject: Re: [PATCH 1/2] dt-bindings: spi: dw: add cs-override property
To:     Trent Piepho <tpiepho@impinj.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "barakw@amazon.com" <barakw@amazon.com>,
        "ronenk@amazon.com" <ronenk@amazon.com>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>, <jonnyc@amazon.com>
References: <1539155293-21750-1-git-send-email-talel@amazon.com>
 <1539210111.1944.31.camel@impinj.com>
From:   Talel Shenhar <talel@amazon.com>
Message-ID: <3ad7fac8-2f13-690b-9e4b-c6b2373756b0@amazon.com>
Date:   Thu, 11 Oct 2018 10:39:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1539210111.1944.31.camel@impinj.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.43.160.245]
X-ClientProxiedBy: EX13D05UWC002.ant.amazon.com (10.43.162.92) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/2018 01:21 AM, Trent Piepho wrote:
> On Wed, 2018-10-10 at 10:08 +0300, Talel Shenhar wrote:
>> The dw spi controller has an auto-deselect of Chip-Select, in case there is
>> no data inside the Tx FIFO. While working on platforms with Alpine chips,
>> auto-deselect mode causes an issue for some spi devices that can't handle
>> the Chip-Select deselect in the middle of a transaction. It is a normal
>> behavior for a Tx FIFO to be empty in the middle of a transaction, due to
>>
> So that's the problem!  I, like everyone else I suspect, switched to
> using GPIO chip selects with this driver because of this.  I narrowed
> it down to a CS de-assert when the bus switched from TX to RX, which of
> course makes a SPI register read fail on most devices.  The TX FIFO
> would empty at this point, so that would explain it.
>
> Did the designers of this IP ever read a SPI device datasheet???
>
> Got to agree with Mark Brown, why would anyone ever want to NOT have it
> work properly?  The previous behavior is not "alternate correct", it's
> Broken.
This patch allow the Amazon changed hw to work in a correct way.
Unfortunately, the original hw doesn't support auto-deselect disable.
auto-deselect disable is a hw fixup Amazon hw engineers added on top
of the original dw IP.
The fix was to disable the auto-deselect and to allow sw
to manually control the chip-select.
This patch enables the above described Amazon hw fixup and
adds manual control over chip-select.
