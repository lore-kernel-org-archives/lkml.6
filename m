Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C12C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 10:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A212420835
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 10:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="kWKE//up"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A212420835
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbeJJR4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 13:56:07 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:12561 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbeJJR4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 13:56:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1539167675; x=1570703675;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=9zpHVI0ZWqxiY/gnEHnp6P5L1B98SvXaI+4zs/F/1aE=;
  b=kWKE//upUlJFyjggz8kSIgQFmEeNenJWVD8ulihVYjou+53wux0l09fR
   XFAgwu2MbB/IQvvXecD74mT+dkQzwNeBwcAmseeNRGsFjMOGGNocpkKaS
   DOMMxVvY0xV7uUriSd0+mMy+B7wYPC/FiZ9UVXLtgoHiud1dBjDQ+IPFb
   s=;
X-IronPort-AV: E=Sophos;i="5.54,364,1534809600"; 
   d="scan'208";a="367020121"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 10 Oct 2018 10:34:33 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w9AAYQIn069344
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 10 Oct 2018 10:34:32 GMT
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 10 Oct 2018 10:34:31 +0000
Received: from [10.55.103.19] (10.43.160.173) by EX13D01EUB001.ant.amazon.com
 (10.43.166.194) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 10 Oct
 2018 10:34:25 +0000
Subject: Re: [PATCH 1/2] dt-bindings: spi: dw: add cs-override property
To:     <"ronenk@amazon.com; jonnyc"@amazon.com>
CC:     <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ronenk@amazon.com>,
        <barakw@amazon.com>, David Woodhouse <dwmw@amazon.co.uk>
References: <1539155293-21750-1-git-send-email-talel@amazon.com>
 <20181010101825.GA6294@sirena.org.uk>
From:   Talel Shenhar <talel@amazon.com>
Message-ID: <e4c91e84-34f6-2c3f-4e26-62e6bd25a96f@amazon.com>
Date:   Wed, 10 Oct 2018 13:34:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181010101825.GA6294@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.43.160.173]
X-ClientProxiedBy: EX13D08UWC002.ant.amazon.com (10.43.162.168) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Oct 10, 2018 at 10:08:12AM +0300, Talel Shenhar wrote:
>
>> The dw spi controller has an auto-deselect of Chip-Select, in case there is
>> no data inside the Tx FIFO. While working on platforms with Alpine chips,
> Why would we ever want to use this behaviour?  It will be broken for any
> non-trivial SPI message such as those made with multiple transfers
> anyway.  Why not just unconditionally control it manually?
Thank you for your prompt response.

This behavior (auto-deselect of Chip-Select) is the default behavior of dw spi controller hw.
On Alpine chip there is additional behavior added to the dw spi controller hw that allows the sw to disable this behavior.
This patch allows the dw driver to enable this hw workaround and add the needed sw manual control for it.
