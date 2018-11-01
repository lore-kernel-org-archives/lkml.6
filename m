Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98980ECDE44
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 02:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 697E520664
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 02:19:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 697E520664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbeKALUJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 07:20:09 -0400
Received: from mga17.intel.com ([192.55.52.151]:32491 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbeKALUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 07:20:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Oct 2018 19:19:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,450,1534834800"; 
   d="scan'208";a="104993503"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by orsmga002.jf.intel.com with ESMTP; 31 Oct 2018 19:19:14 -0700
Received: from fmsmsx152.amr.corp.intel.com (10.18.125.5) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 31 Oct 2018 19:19:14 -0700
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
 FMSMSX152.amr.corp.intel.com (10.18.125.5) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 31 Oct 2018 19:19:14 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.84]) by
 SHSMSX103.ccr.corp.intel.com ([169.254.4.161]) with mapi id 14.03.0415.000;
 Thu, 1 Nov 2018 10:19:12 +0800
From:   "Li, Philip" <philip.li@intel.com>
To:     "Wu, Fengguang" <fengguang.wu@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>
CC:     Olof Johansson <olof@lixom.net>,
        Palmer Dabbelt <palmer@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "Albert Ou" <aou@eecs.berkeley.edu>, Zong Li <zongbox@gmail.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "kbuild@lists.01.org" <kbuild@lists.01.org>, lkp <lkp@intel.com>
Subject: RE: [PATCH 0/3] RISC-V: A few build/warning fixes and cleanup
Thread-Topic: [PATCH 0/3] RISC-V: A few build/warning fixes and cleanup
Thread-Index: AQHUcYRXg2HZSSw3bUyv4TesH6RGy6U6LxLw
Date:   Thu, 1 Nov 2018 02:19:11 +0000
Message-ID: <831EE4E5E37DCC428EB295A351E662495131B2E7@shsmsx102.ccr.corp.intel.com>
References: <20181031064709.30981-1-olof@lixom.net>
 <mhng-74b51433-1762-4741-935d-56ca1b3548a0@palmer-si-x1c4>
 <CAOesGMgWDM+Etng3bNU-Yem6+WRJEu+TfddzKoN-htno1Az3=w@mail.gmail.com>
 <861817b9-c5f3-e995-2e18-9526d89d6561@deltatee.com>
 <20181101014345.cdlte4grtaexb234@wfg-t540p.sh.intel.com>
In-Reply-To: <20181101014345.cdlte4grtaexb234@wfg-t540p.sh.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMjkyOTk2M2ItZWJjOC00YjlhLWE2MWMtOTRiMjdjNzQ2Njg4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiODdhbnJiRDYzU29lVTNYMzVXcFg5R2NcL0ZabXBSRnM0MERWWjJxcEViQ3dENkpHazIxWGlLYlJMN0xqUVlGeHoifQ==
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

> Subject: Re: [PATCH 0/3] RISC-V: A few build/warning fixes and cleanup
> 
> CC Philip, current kbuild test robot maintainer.
> 
> On Wed, Oct 31, 2018 at 12:12:21PM -0600, Logan Gunthorpe wrote:
> >
> >On 2018-10-31 11:52 a.m., Olof Johansson wrote:
> >> I've migrated machines to a new system and that CI is up and running.
> >> Right now the emails don't go anywhere but me, but let me know where
> >> you want them sent and I'll be happy to do so (probably not
> >> linux-riscv due to volume/noise). They're also uploaded to
> >> http://arm-soc.lixom.net/buildlogs/riscv/.
> >>
> >> Since you keep single-patch branches in your tree, and I compile
> >> everything for every branch, I've restricted what branches I poll and
> >> build. Right now it's "for*" and "riscv*".
> >
> >I think it would also be very nice to get the existing kbuild test robot
> >to start compile testing a few riscv configs. It already does most of
thanks Logan, the support to riscv and nds32 has been in our TODO list for
a while, but whole team is blocked by other effort. We will focus on this soon
to complete it within 2-3 weeks.

> >the other arches. This would help us catch these kinds of issues even
> >earlier seeing that test robot tests patches on mailing lists and many
> >other repos before Palmer would even pull them into his branch.
> >(Including a repo I routinely push branches to before sending out patches.)
> >
> >I'm not sure who's currently responsible for the robot but I've copied
> >Fenguang who, I believe, set it up originally as well as the kbuild
> >lists. Hopefully he can point us in the right direction to help get this
> >set up.
> >
> >Thanks,
> >
> >Logan
> >
