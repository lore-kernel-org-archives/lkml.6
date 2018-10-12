Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD3BC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 05:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5C3D20868
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 05:37:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5C3D20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbeJLNId convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 09:08:33 -0400
Received: from mga09.intel.com ([134.134.136.24]:63578 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727056AbeJLNIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 09:08:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2018 22:37:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,371,1534834800"; 
   d="scan'208";a="91346666"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by orsmga003.jf.intel.com with ESMTP; 11 Oct 2018 22:37:31 -0700
Received: from fmsmsx115.amr.corp.intel.com (10.18.116.19) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Thu, 11 Oct 2018 22:37:31 -0700
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
 fmsmsx115.amr.corp.intel.com (10.18.116.19) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Thu, 11 Oct 2018 22:37:31 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.48]) by
 SHSMSX103.ccr.corp.intel.com ([169.254.4.245]) with mapi id 14.03.0319.002;
 Fri, 12 Oct 2018 13:36:23 +0800
From:   "Jin, Zhi" <zhi.jin@intel.com>
To:     "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Jin, Zhi" <zhi.jin@intel.com>
Subject: RE: [PATCH] stm class: increase pos if no free channels found
Thread-Topic: [PATCH] stm class: increase pos if no free channels found
Thread-Index: AQHURbKpgeGbhBBNZUWI+1TOC4KxRKUbTxUA
Date:   Fri, 12 Oct 2018 05:36:22 +0000
Message-ID: <11D2FE4DB4B8114EA7D818424F28D1414289A041@SHSMSX104.ccr.corp.intel.com>
References: <1536218530-18601-1-git-send-email-zhi.jin@intel.com>
In-Reply-To: <1536218530-18601-1-git-send-email-zhi.jin@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNWI1NzlhNTQtNjBkZS00MTAxLTg2NzUtZjJiZTRlYjY0NWRiIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiOXVPMXNVOTFZMFEzcTRoc2hVdGFSeHA0WGRYeWFtZEdSK2N5WWM4WEdnWGtWdHdZMmZiWHpUa05PNmFvVGgxaiJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

Any comments about this patch?

BRs
Zhi Jin

> -----Original Message-----
> From: Jin, Zhi
> Sent: Thursday, September 06, 2018 3:22 PM
> To: alexander.shishkin@linux.intel.com
> Cc: linux-kernel@vger.kernel.org; Jin, Zhi <zhi.jin@intel.com>
> Subject: [PATCH] stm class: increase pos if no free channels found
> 
> Considering this case in find_free_channels():
> 
> bitmap:
>        +------------------+-+-+-+-+-+-+-+-+-+-+
>        |     ......       |0|0|0|0|0|0|0|1|0|0|
>        +------------------+-+-+-+-+-+-+-+-+-+-+
> 
> 1. Channel #2 has been occupied, so bit #2 is 1, and the others
>    are all 0.
> 2. Another thread tries to find 4 free channels from #0.
> 3. In the 1st loop, pos starts from 0, and then it checks if the
>    following 4 bits are all 0, but fails, as bit#2 is 1.
> 4. In the 2st loop, pos is not updated, and still starts from 0,
>    so nothing changes against loop #1.
> 5. Dead loop ...
> 
> This patch is to update the pos in step #3 to avoid the issue.
> 
> Fixes: 7bd1d4093c2f ("stm class: Introduce an abstraction for System
> Trace Module devices")
> Signed-off-by: Zhi Jin <zhi.jin@intel.com>
> ---
>  drivers/hwtracing/stm/core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
> index 10bcb5d73f90..c86a979b9bd7 100644
> --- a/drivers/hwtracing/stm/core.c
> +++ b/drivers/hwtracing/stm/core.c
> @@ -244,6 +244,8 @@ static int find_free_channels(unsigned long *bitmap,
> unsigned int start,
>  			;
>  		if (i == width)
>  			return pos;
> +
> +		pos += i;
>  	}
> 
>  	return -1;
> --
> 2.7.4

