Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E49FC6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 19:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C23420865
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 19:00:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C23420865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbeJMCek convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 22:34:40 -0400
Received: from mga18.intel.com ([134.134.136.126]:17370 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbeJMCek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 22:34:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Oct 2018 12:00:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,373,1534834800"; 
   d="scan'208";a="271930953"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga006.fm.intel.com with ESMTP; 12 Oct 2018 12:00:45 -0700
Received: from fmsmsx121.amr.corp.intel.com (10.18.125.36) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 12 Oct 2018 12:00:45 -0700
Received: from fmsmsx122.amr.corp.intel.com ([169.254.5.127]) by
 fmsmsx121.amr.corp.intel.com ([169.254.6.136]) with mapi id 14.03.0319.002;
 Fri, 12 Oct 2018 12:00:45 -0700
From:   "Mani, Rajmohan" <rajmohan.mani@intel.com>
To:     Bing Bu Cao <bingbu.cao@linux.intel.com>,
        "kieran.bingham+renesas@ideasonboard.com" 
        <kieran.bingham+renesas@ideasonboard.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Zhi, Yong" <yong.zhi@intel.com>,
        "Cao, Bingbu" <bingbu.cao@intel.com>,
        "Qiu, Tian Shu" <tian.shu.qiu@intel.com>,
        "Zheng, Jian Xu" <jian.xu.zheng@intel.com>
CC:     "tfiga@chromium.org" <tfiga@chromium.org>
Subject: RE: [PATCH] media: intel-ipu3: cio2: Remove redundant definitions
Thread-Topic: [PATCH] media: intel-ipu3: cio2: Remove redundant definitions
Thread-Index: AQHUYCtjdI14ZeLIEEe7sNsKmkXxRqUaP+eAgAAFtICAAbUS8A==
Date:   Fri, 12 Oct 2018 19:00:44 +0000
Message-ID: <6F87890CF0F5204F892DEA1EF0D77A5981515F2D@fmsmsx122.amr.corp.intel.com>
References: <20181009234245.25830-1-rajmohan.mani@intel.com>
 <33c53caf-633a-f359-4312-9c2dc317efc5@ideasonboard.com>
 <39c26dd4-4454-f557-f510-ae973f5d9c89@linux.intel.com>
In-Reply-To: <39c26dd4-4454-f557-f510-ae973f5d9c89@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZTMwMzgxMGUtMDAyNy00ZjIxLWIxYTUtMThlOTljZDJjYzEyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiV1BqVlU5cGZweWx3NGpDRlwvRXQ5S2dwZlplbGdPa25iVDZQazIyR1VlNTdURGcxYWZsQmtFazQ0R2JOa2t0VEEifQ==
x-originating-ip: [10.1.200.107]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bingbu, Kieren,

> Subject: Re: [PATCH] media: intel-ipu3: cio2: Remove redundant definitions
> 
> 
> 
> On 10/11/2018 05:33 PM, Kieran Bingham wrote:
> > Hi Rajmohan
> >
> > Thank you for the patch,
> >
> > On 10/10/18 00:42, Rajmohan Mani wrote:
> >> Removed redundant CIO2_IMAGE_MAX_* definitions
> >>
> >> Fixes: c2a6a07afe4a ("media: intel-ipu3: cio2: add new MIPI-CSI2
> >> driver")
> >>
> >> Signed-off-by: Rajmohan Mani <rajmohan.mani@intel.com>
> > Reviewed-by: Kieran Bingham
> <kieran.bingham+renesas@ideasonboard.com>
> >
> > Looks like this {sh,c}ould be bundled in with  "[PATCH 0/2] Trivial
> > CIO2 patches" from Sakari at integration.
> Raj and Sakari, I think this change could be bundled into the Trivial patch sets,
> what do you think?
> >

Sounds good to me.
I will leave this up to Sakari.

Thanks
Raj
