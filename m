Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E89BC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 15:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 568B72086B
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 15:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="Jip0B2Gx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 568B72086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387905AbeKNBiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 20:38:22 -0500
Received: from aer-iport-3.cisco.com ([173.38.203.53]:10936 "EHLO
        aer-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732298AbeKNBiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 20:38:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=906; q=dns/txt; s=iport;
  t=1542123585; x=1543333185;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=CdIwWZikJRLzjjIT6UfO8R4VN7qEx+kQwjNGe35Xhww=;
  b=Jip0B2GxTT+OC+eLTAXhp/Xy0+mJFPryK313w7TKF0ju3T5vxgmJLgb+
   W23Diq7fpNNTvLSHhgyfkC07euLEFIKzfvY3Y/aMowFzj69dfFg9yZ/A7
   QNGz/r+nP6eSlqPceBlxjHiTPf1SK0z/fBlIFHUGvidS9VEH/LwUn/y2h
   8=;
X-IronPort-AV: E=Sophos;i="5.54,499,1534809600"; 
   d="scan'208";a="7959715"
Received: from aer-iport-nat.cisco.com (HELO aer-core-2.cisco.com) ([173.38.203.22])
  by aer-iport-3.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2018 15:39:43 +0000
Received: from [10.47.79.81] ([10.47.79.81])
        (authenticated bits=0)
        by aer-core-2.cisco.com (8.15.2/8.15.2) with ESMTPSA id wADFdg1m024672
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 13 Nov 2018 15:39:42 GMT
Subject: Re: [PATCH 3/5] media: sunxi: Add A10 CSI driver
To:     Joe Perches <joe@perches.com>, Hans Verkuil <hverkuil@xs4all.nl>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
References: <cover.71b0f9855c251f9dc389ee77ee6f0e1fad91fb0b.1542097288.git-series.maxime.ripard@bootlin.com>
 <c53e1cdc3b139382b00ee06bf3980d3fd1742ec0.1542097288.git-series.maxime.ripard@bootlin.com>
 <f34c79f5-66d6-2c2f-5616-020ad2b96400@xs4all.nl>
 <71d315a34e4b12b0eb1d4c9003b297e46695f9cf.camel@perches.com>
From:   Hans Verkuil <hansverk@cisco.com>
Message-ID: <6153b08e-b81d-8e4a-9fd2-0f593523d8da@cisco.com>
Date:   Tue, 13 Nov 2018 16:39:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <71d315a34e4b12b0eb1d4c9003b297e46695f9cf.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-User: hansverk
X-Outbound-SMTP-Client: 10.47.79.81, [10.47.79.81]
X-Outbound-Node: aer-core-2.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/18 16:19, Joe Perches wrote:
> On Tue, 2018-11-13 at 13:24 +0100, Hans Verkuil wrote:
>> On 11/13/18 09:24, Maxime Ripard wrote:
>>> The older CSI drivers have camera capture interface different from the one
>>> in the newer ones.
> []
>>> diff --git a/drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.h b/drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.h
> []
>>> +	// Videobuf2
>>
>> Doesn't checkpatch.pl --strict complain about the use of '//'?
> 
> No, not since
> 
> commit dadf680de3c2eb4cba9840619991eda0cfe98778
> Author: Joe Perches <joe@perches.com>
> Date:   Tue Aug 2 14:04:33 2016 -0700
> 
>     checkpatch: allow c99 style // comments
>     
>     Sanitise the lines that contain c99 comments so that the error doesn't
>     get emitted.
> 
> 

Huh, I'm really out of date. But the good news is that I learned something
new today!

Thank you,

	Hans
