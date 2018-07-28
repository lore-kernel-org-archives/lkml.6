Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F308C67790
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 02:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B3EA20673
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 02:00:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B3EA20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389346AbeG1DYv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 23:24:51 -0400
Received: from mga14.intel.com ([192.55.52.115]:12373 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388893AbeG1DYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 23:24:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jul 2018 19:00:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,412,1526367600"; 
   d="scan'208";a="57797384"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by fmsmga007.fm.intel.com with ESMTP; 27 Jul 2018 19:00:16 -0700
Received: from fmsmsx101.amr.corp.intel.com (10.18.124.199) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 27 Jul 2018 19:00:16 -0700
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
 fmsmsx101.amr.corp.intel.com (10.18.124.199) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 27 Jul 2018 19:00:16 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.57]) by
 SHSMSX103.ccr.corp.intel.com ([169.254.4.100]) with mapi id 14.03.0319.002;
 Sat, 28 Jul 2018 10:00:14 +0800
From:   "Wang, Wei W" <wei.w.wang@intel.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: RE: [PATCH v2 0/2] virtio-balloon: some improvements
Thread-Topic: [PATCH v2 0/2] virtio-balloon: some improvements
Thread-Index: AQHUJY+X2m1M+XGKJkKV2YG1ggYCw6SilMmAgAFMxHA=
Date:   Sat, 28 Jul 2018 02:00:13 +0000
Message-ID: <286AC319A985734F985F78AFA26841F7397114A2@SHSMSX101.ccr.corp.intel.com>
References: <1532683495-31974-1-git-send-email-wei.w.wang@intel.com>
 <20180727170605-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180727170605-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMjY0ZTJhYjAtY2U3Ni00MDY0LTg1ODgtZWI3YjQ4MDA2MDJkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiUjVlbE5YZG5rMUFPQUxBdEw4M1wvT3FVcTFWaUFMYlZhZzZJYWlnUHRtZXBcLzBYa3FHWEROYmdwdm0zVGkrQkUzIn0=
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

On Friday, July 27, 2018 10:06 PM, Michael S. Tsirkin wrote:
> On Fri, Jul 27, 2018 at 05:24:53PM +0800, Wei Wang wrote:
> > This series is split from the "Virtio-balloon: support free page
> > reporting" series to make some improvements.
> >
> > v1->v2 ChangeLog:
> > - register the shrinker when VIRTIO_BALLOON_F_DEFLATE_ON_OOM is
> negotiated.
> >
> > Wei Wang (2):
> >   virtio-balloon: remove BUG() in init_vqs
> >   virtio_balloon: replace oom notifier with shrinker
> 
> Thanks!
> Given it's very late in the release cycle, I'll merge this for the next Linux
> release.

No problem. Thanks!

Best,
Wei
