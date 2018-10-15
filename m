Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D32DC28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 08:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1398420644
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 08:17:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1398420644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbeJOQCD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 12:02:03 -0400
Received: from mga14.intel.com ([192.55.52.115]:41363 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbeJOQCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 12:02:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2018 01:17:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,384,1534834800"; 
   d="scan'208";a="82648099"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga006.jf.intel.com with ESMTP; 15 Oct 2018 01:17:50 -0700
Received: from fmsmsx124.amr.corp.intel.com (10.18.125.39) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 15 Oct 2018 01:17:49 -0700
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
 fmsmsx124.amr.corp.intel.com (10.18.125.39) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 15 Oct 2018 01:17:50 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.48]) by
 SHSMSX103.ccr.corp.intel.com ([169.254.4.245]) with mapi id 14.03.0319.002;
 Mon, 15 Oct 2018 16:16:26 +0800
From:   "Jin, Zhi" <zhi.jin@intel.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] stm class: increase pos if no free channels found
Thread-Topic: [PATCH] stm class: increase pos if no free channels found
Thread-Index: AQHURbKpgeGbhBBNZUWI+1TOC4KxRKUfo8eAgACGtRA=
Date:   Mon, 15 Oct 2018 08:16:26 +0000
Message-ID: <11D2FE4DB4B8114EA7D818424F28D1414289C3B9@SHSMSX104.ccr.corp.intel.com>
References: <1536218530-18601-1-git-send-email-zhi.jin@intel.com>
 <87h8hn64gi.fsf@ashishki-desk.ger.corp.intel.com>
In-Reply-To: <87h8hn64gi.fsf@ashishki-desk.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYzM4NGEzODMtNzk4NS00Mjc1LWEzMTctNTkwMTVjNTNjYTE3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiK01xOVJTdlNacmhlN2pYd3BkSGRKTDFHaHpmWXJuY1ZwWStaZ2d6S3ZxTlkrSDk5M3I4S2RpR1NYUVpOc24wUiJ9
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



> -----Original Message-----
> From: Alexander Shishkin [mailto:alexander.shishkin@linux.intel.com]
> Sent: Monday, October 15, 2018 3:43 PM
> To: Jin, Zhi <zhi.jin@intel.com>
> Cc: linux-kernel@vger.kernel.org; Jin, Zhi <zhi.jin@intel.com>
> Subject: Re: [PATCH] stm class: increase pos if no free channels found
> 
> Zhi Jin <zhi.jin@intel.com> writes:
> 
> > Considering this case in find_free_channels():
> >
> > bitmap:
> >        +------------------+-+-+-+-+-+-+-+-+-+-+
> >        |     ......       |0|0|0|0|0|0|0|1|0|0|
> >        +------------------+-+-+-+-+-+-+-+-+-+-+
> >
> > 1. Channel #2 has been occupied, so bit #2 is 1, and the others
> >    are all 0.
> > 2. Another thread tries to find 4 free channels from #0.
> > 3. In the 1st loop, pos starts from 0, and then it checks if the
> >    following 4 bits are all 0, but fails, as bit#2 is 1.
> > 4. In the 2st loop, pos is not updated, and still starts from 0,
> >    so nothing changes against loop #1.
> > 5. Dead loop ...
> >
> > This patch is to update the pos in step #3 to avoid the issue.
> 
> The description is slightly confusing, but the patch looks correct and
> the original code is clearly wrong. Thank you for finding this!
> 
> Basically, if you request 1 channel 3 times, release the first two and
> then request 4 channels, you'll be stuck, right?

Yes, you are right.
But the real case that I reproduced the issue is a little different:
I have 2 stp-policy:
"console": masters "256 259"  channels "7 10"
"user"   : masters "256 1024" channels "0 127"
I understand the policies should not be overlapped, which is caused by some
other issues.
So if someone uses "console" to request a channel (who will get Channel #7)
and then another uses "user" to request more than 8 channels, it will be stuck.
The commit message is what I trying to abstract the above case, sorry for the
confusion.

> 
> Thanks,
> --
> Alex
