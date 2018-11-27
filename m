Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A493DC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7267520873
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:09:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7267520873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lucaceresoli.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730012AbeK0UGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:06:24 -0500
Received: from srv-hp10-72.netsons.net ([94.141.22.72]:54477 "EHLO
        srv-hp10-72.netsons.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729387AbeK0UGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 15:06:24 -0500
Received: from [109.168.11.45] (port=46886 helo=[192.168.101.125])
        by srv-hp10.netsons.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <luca@lucaceresoli.net>)
        id 1gRZMi-00Glv0-A9; Tue, 27 Nov 2018 10:09:08 +0100
Subject: Re: [PATCH 1/3] media: imx274: don't declare events, they are not
 implemented
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-media@vger.kernel.org, Leon Luo <leonl@leopardimaging.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20181127083445.27737-1-luca@lucaceresoli.net>
 <20181127083859.zljff4wk4hikel56@paasikivi.fi.intel.com>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <dcd7ded2-7876-c017-0d8c-1f3d159e5d2f@lucaceresoli.net>
Date:   Tue, 27 Nov 2018 10:09:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181127083859.zljff4wk4hikel56@paasikivi.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - srv-hp10.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: srv-hp10.netsons.net: authenticated_id: luca@lucaceresoli.net
X-Authenticated-Sender: srv-hp10.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

On 27/11/18 09:38, Sakari Ailus wrote:
> Hi Luca,
> 
> On Tue, Nov 27, 2018 at 09:34:43AM +0100, Luca Ceresoli wrote:
>> The V4L2_SUBDEV_FL_HAS_EVENTS flag should not be set, event are just
>> not implemented.
>>
>> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> 
> The driver supports controls, and so control events can be subscribed and
> received by the user. Therefore I don't see a reason to remove the flag.

Thanks, good to know.

Would it be worth adding a note where V4L2_SUBDEV_FL_HAS_EVENTS is
#defined, to make this clear?

-- 
Luca
