Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28852C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D95DB223CB
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="NIFaIYNc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D95DB223CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387546AbeKMXfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 18:35:21 -0500
Received: from aer-iport-2.cisco.com ([173.38.203.52]:48052 "EHLO
        aer-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732728AbeKMXfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 18:35:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=690; q=dns/txt; s=iport;
  t=1542116231; x=1543325831;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=7L4JnNhNef97sMIBe/Xt8VukAeB+gj04mVrAGsvI9Jw=;
  b=NIFaIYNcVyjnbbEerSWUCDsu6kaaHkhMvxO/Z7MImww359sWyDh5fV9I
   +f3NA01q3XstsjRhtW84Kt/QVtQHaE9pK4EIivJiBsUwH3n4U4d4UX6li
   5MnmuXjrfzvRoDNkZ+tz4fsZaqwafYXigD6lPhS0a68sd1NwOVH2E4use
   Y=;
X-IronPort-AV: E=Sophos;i="5.54,499,1534809600"; 
   d="scan'208";a="8014524"
Received: from aer-iport-nat.cisco.com (HELO aer-core-4.cisco.com) ([173.38.203.22])
  by aer-iport-2.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2018 13:37:09 +0000
Received: from [10.47.79.81] ([10.47.79.81])
        (authenticated bits=0)
        by aer-core-4.cisco.com (8.15.2/8.15.2) with ESMTPSA id wADDb8FA032563
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 13 Nov 2018 13:37:09 GMT
Subject: Re: [PATCH 3/5] media: sunxi: Add A10 CSI driver
To:     Fabio Estevam <festevam@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Hans Verkuil <hans.verkuil@cisco.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media <linux-media@vger.kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
References: <cover.71b0f9855c251f9dc389ee77ee6f0e1fad91fb0b.1542097288.git-series.maxime.ripard@bootlin.com>
 <c53e1cdc3b139382b00ee06bf3980d3fd1742ec0.1542097288.git-series.maxime.ripard@bootlin.com>
 <CAOMZO5CjFt1dyu8KOK+jKd88x8hwGNy9aJ-sGgooS9970TGTVQ@mail.gmail.com>
From:   Hans Verkuil <hansverk@cisco.com>
Message-ID: <9a9616d2-a189-bd0e-e2e6-f84bdcb1dfd1@cisco.com>
Date:   Tue, 13 Nov 2018 14:37:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAOMZO5CjFt1dyu8KOK+jKd88x8hwGNy9aJ-sGgooS9970TGTVQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-User: hansverk
X-Outbound-SMTP-Client: 10.47.79.81, [10.47.79.81]
X-Outbound-Node: aer-core-4.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/18 13:48, Fabio Estevam wrote:
> On Tue, Nov 13, 2018 at 6:25 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> 
>> --- /dev/null
>> +++ b/drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c
>> @@ -0,0 +1,275 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
> 
> According to Documentation/process/license-rules.rst this should be:
> 
> +// SPDX-License-Identifier: GPL-2.0+
> 
> Same applies to other places in this patch.
> 

Actually, LICENSES/preferred/GPL-2.0 has GPL-2.0-or-later
as a valid license:

Valid-License-Identifier: GPL-2.0-or-later

Personally I very much prefer GPL-2.0-or-later since I think it is
much clearer.

Regards,

	Hans
