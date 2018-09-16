Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13449ECE561
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 10:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1F6E208AE
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 10:14:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1F6E208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbeIPPhP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 11:37:15 -0400
Received: from mga09.intel.com ([134.134.136.24]:58837 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbeIPPhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 11:37:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2018 03:14:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,381,1531810800"; 
   d="scan'208";a="73627518"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga008.jf.intel.com with ESMTP; 16 Sep 2018 03:14:27 -0700
Received: from fmsmsx152.amr.corp.intel.com (10.18.125.5) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Sun, 16 Sep 2018 03:14:26 -0700
Received: from hasmsx112.ger.corp.intel.com (10.184.198.40) by
 FMSMSX152.amr.corp.intel.com (10.18.125.5) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Sun, 16 Sep 2018 03:14:26 -0700
Received: from hasmsx111.ger.corp.intel.com ([169.254.5.163]) by
 HASMSX112.ger.corp.intel.com ([169.254.11.230]) with mapi id 14.03.0319.002;
 Sun, 16 Sep 2018 13:14:23 +0300
From:   "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To:     "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>,
        Pavel Machek <pavel@ucw.cz>,
        Johannes Berg <johannes@sipsolutions.net>
CC:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linuxwifi <linuxwifi@intel.com>
Subject: RE: [linuxwifi] [PATCH] fix iwlwifi on old cards in v4.19 was Re:
 4.19-rc[23] iwlwifi: BUG in swiotlb
Thread-Topic: [linuxwifi] [PATCH] fix iwlwifi on old cards in v4.19 was Re:
 4.19-rc[23] iwlwifi: BUG in swiotlb
Thread-Index: AQHUTaQhJ/10LR3YFkOF2mTRvf6JLaTysDXQgAAAeyA=
Date:   Sun, 16 Sep 2018 10:14:22 +0000
Message-ID: <0BA3FCBA62E2DC44AF3030971E174FB301336B2111@HASMSX111.ger.corp.intel.com>
References: <0c5e53e5-2afa-8d38-0b48-272c670c4bc5@infradead.org>
 <1536651177.3224.106.camel@sipsolutions.net> <20180916093414.GA4299@amd>
 <20180916094142.GB4299@amd> <20180916095535.GA4245@amd>
 <20180916095935.GA4388@amd>
 <0BA3FCBA62E2DC44AF3030971E174FB301336B20F4@HASMSX111.ger.corp.intel.com>
In-Reply-To: <0BA3FCBA62E2DC44AF3030971E174FB301336B20F4@HASMSX111.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZjEyMzlkMDYtZjBjNi00ZTc1LWEzNmQtMjE4OWI5MGJmZDVkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoidnc1NnZPZkZZdVhmaUZ4R2c4ZUhBZTFFaTR3V3FvRkJYVlNrQ2oyZzlcL3llZCtFdWVCMnNuNTVKYXFUemJBNnkifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.12.124.71]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> >
> >
> > .max_tfd_queue_size was ommited for old cards, leading to oops in
> swiotlb.
> >
> > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> >
> 
> I picked it up in our tree with minor commit message fixes.
> I also added the Fixes tag for stable.
> 

Ah, of course... not needed... Sorry...
