Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BD7C4161D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8784C20658
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:28:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8784C20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbeJKUzO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 16:55:14 -0400
Received: from mga06.intel.com ([134.134.136.31]:21241 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727160AbeJKUzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 16:55:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2018 06:28:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,368,1534834800"; 
   d="scan'208";a="91126945"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga003.jf.intel.com with ESMTP; 11 Oct 2018 06:27:59 -0700
Received: from fmsmsx120.amr.corp.intel.com (10.18.124.208) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Thu, 11 Oct 2018 06:28:00 -0700
Received: from lcsmsx154.ger.corp.intel.com (10.186.165.229) by
 fmsmsx120.amr.corp.intel.com (10.18.124.208) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Thu, 11 Oct 2018 06:27:59 -0700
Received: from HASMSX109.ger.corp.intel.com ([169.254.3.28]) by
 LCSMSX154.ger.corp.intel.com ([169.254.7.171]) with mapi id 14.03.0319.002;
 Thu, 11 Oct 2018 16:27:59 +0300
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Peter Huewe <peterhuewe@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] tpm: fix unused-value issues in tpm_try_transmit
Thread-Topic: [PATCH] tpm: fix unused-value issues in tpm_try_transmit
Thread-Index: AQHUYJ6p/SuLBw4aaUml2bYnZz2LwqUYUWMAgAFvawCAADdeYA==
Date:   Thu, 11 Oct 2018 13:27:58 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9D9EEC12@hasmsx109.ger.corp.intel.com>
References: <20181010133817.GA11485@embeddedor.com>
 <20181010140638.GA3894@ziepe.ca> <20181011120140.GA15767@linux.intel.com>
In-Reply-To: <20181011120140.GA15767@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNTgyMTEyYmItZDc3OS00OThjLTg2NDItN2FiYzk1ODdkZTY5IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZ0pDeTM3eFNMWm44VW5rdFYyZ0hpTG1GVkVWUDRKVVl4eGVSeldVU2VlSmdPZG1nQ2VSNG5MWTVER095UEdhRCJ9
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.12.116.95]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Wed, Oct 10, 2018 at 08:06:38AM -0600, Jason Gunthorpe wrote:
> > On Wed, Oct 10, 2018 at 03:38:17PM +0200, Gustavo A. R. Silva wrote:
> > > Currently, there are some values assigned to variable *rc*, which
> > > are never actually used in any computation, because such variable is
> > > updated at line 550, before they can be used:
> > >
> > > 549out:
> > > 550        rc = tpm_go_idle(chip, flags);
> > > 551        if (rc)
> > > 552                goto out;
> > >
> > > Fix this by removing such assignments.
> >
> > Should this be done by not quashing rc during the error unwind rather
> > than dropping the errors?
> 
> Yeah.`
> 
> Wondering if tpm_go_idle() should simply be a void-function i.e. issue just a
> warning inside (disclaimer: did not revisit its code when writing this).

We did have rather a long discussion about it when it was merged.
There are two flows that may crash 
rc = tpm2_commit_space()

but you still can need to 

rc  = go_idle()  

which also may crash which may override the previous value. 

Frankly the second one is fatal, the stack will go out of sync.
We may do void here as the stack will crash in a subsequent command. 

The 'goto out' is quite a  bug, probably caused by code movement.


Thanks
Tomas







