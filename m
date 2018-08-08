Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9A5C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E56FD21771
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:12:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E56FD21771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbeHHScV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:32:21 -0400
Received: from mga18.intel.com ([134.134.136.126]:6476 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727062AbeHHScV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:32:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2018 09:12:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,458,1531810800"; 
   d="scan'208";a="63569893"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga008.jf.intel.com with ESMTP; 08 Aug 2018 09:11:59 -0700
Received: from fmsmsx115.amr.corp.intel.com (10.18.116.19) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 8 Aug 2018 09:11:59 -0700
Received: from HASMSX109.ger.corp.intel.com (10.184.198.21) by
 fmsmsx115.amr.corp.intel.com (10.18.116.19) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 8 Aug 2018 09:11:59 -0700
Received: from hasmsx108.ger.corp.intel.com ([169.254.9.74]) by
 hasmsx109.ger.corp.intel.com ([169.254.3.28]) with mapi id 14.03.0319.002;
 Wed, 8 Aug 2018 19:11:56 +0300
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [char-misc-next 00/12] mei: Add DMA ring
Thread-Topic: [char-misc-next 00/12] mei: Add DMA ring
Thread-Index: AQHUKjmHmbQCYUhKGke9jCjWQjnb1qS2D/vA
Date:   Wed, 8 Aug 2018 16:11:56 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9D983269@hasmsx108.ger.corp.intel.com>
References: <20180731063544.25540-1-tomas.winkler@intel.com>
 <20180802081921.GB8969@kroah.com>
In-Reply-To: <20180802081921.GB8969@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZWQ0MTNhMzYtYTA3Zi00NDBhLWEwMmMtOWM2YjA5YzA2ZjIxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiWER5STJJVUVoM3pNSEVFXC9weTYyUytNNXE1M2U0Z0hRNWRsWjlRZUlkN3dIcWR2aExpa2hvSHdDM1F4TVRweTcifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.12.116.129]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Jul 31, 2018 at 09:35:32AM +0300, Tomas Winkler wrote:
> > This series adds an alternative method for transferring data between
> > the mei driver and the device via a DMA ring. The DMA ring allows
> > transferring data in bigger chunks, up to 128K, than the HW ring 512B.
> > The actual sizes depend on particular MEI generations.
> > The HW ring is faster for packets that fits into the HW ring while a
> > packet that would require fragmentation is faster to send via the DMA
> > ring.
> 
> I've applied the first 5 patches now.  Please fix up and resend the rest.

Greg, as I wrote, we wish to stay with the dual license in that file,  please can you apply the patches as they are?

Thanks
Tomas

