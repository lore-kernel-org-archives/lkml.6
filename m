Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E88C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 11:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DA7621479
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 11:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="LgDWdZM3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DA7621479
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbeJJSpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 14:45:49 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:55540 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbeJJSpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 14:45:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1539170646; x=1570706646;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=fYlrLp/L7Kmuo/R+ki9vFMVAEW+lf9NsbV9sklGyBhY=;
  b=LgDWdZM31I0010QpnmrpYt/M14UkEj6yibsLkM/VycJmEoeoAeswvOGY
   kb3iTEb/hyo/UHS4UMpqvOjb4sajVer2Vf6gybE74fDq2HzOHHs1oB3Xb
   s8NDUzOmyRLKaOAoGJ4ayhEUBkG+8iJB3XOtZTzICuS9EkP2ktMAwRc+Z
   8=;
X-IronPort-AV: E=Sophos;i="5.54,364,1534809600"; 
   d="scan'208";a="635357556"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1e-a70de69e.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 10 Oct 2018 11:24:00 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-a70de69e.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w9ABNtGx050899
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 10 Oct 2018 11:23:58 GMT
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 10 Oct 2018 11:23:57 +0000
Received: from [10.55.103.19] (10.43.160.4) by EX13D01EUB001.ant.amazon.com
 (10.43.166.194) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 10 Oct
 2018 11:23:49 +0000
Subject: Re: [PATCH 1/2] dt-bindings: spi: dw: add cs-override property
To:     Mark Brown <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ronenk@amazon.com>,
        <barakw@amazon.com>, David Woodhouse <dwmw@amazon.co.uk>
References: <1539155293-21750-1-git-send-email-talel@amazon.com>
 <20181010101825.GA6294@sirena.org.uk>
From:   Talel Shenhar <talel@amazon.com>
Message-ID: <dbac7f00-e9cc-ddac-5734-9763b5985ead@amazon.com>
Date:   Wed, 10 Oct 2018 14:23:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181010101825.GA6294@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.43.160.4]
X-ClientProxiedBy: EX13D24UWA002.ant.amazon.com (10.43.160.200) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/10/2018 01:18 PM, Mark Brown wrote:
> On Wed, Oct 10, 2018 at 10:08:12AM +0300, Talel Shenhar wrote:
>
>> The dw spi controller has an auto-deselect of Chip-Select, in case there is
>> no data inside the Tx FIFO. While working on platforms with Alpine chips,
> Why would we ever want to use this behaviour?  It will be broken for any
> non-trivial SPI message such as those made with multiple transfers
> anyway.  Why not just unconditionally control it manually?

This behavior (auto-deselect of Chip-Select) is the default behavior of dw spi controller hw.
On Alpine chip there is additional behavior added to the dw spi controller hw that allows the sw to disable this behavior.
This patch allows the dw driver to enable this hw workaround and add the needed sw manual control for it.

