Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DB0C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 14:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C99020837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 14:58:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C99020837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933293AbeFUO6c (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 10:58:32 -0400
Received: from mga01.intel.com ([192.55.52.88]:13547 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933002AbeFUO6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 10:58:30 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jun 2018 07:58:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,252,1526367600"; 
   d="scan'208";a="65149987"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.44])
  by fmsmga004.fm.intel.com with ESMTP; 21 Jun 2018 07:58:29 -0700
Date:   Thu, 21 Jun 2018 09:01:43 -0600
From:   Keith Busch <keith.busch@intel.com>
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        martin.petersen@oracle.com, josef@toxicpanda.com,
        ulf.hansson@linaro.org, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5]stop normal completion path entering a timeout req
Message-ID: <20180621150143.GA26712@localhost.localdomain>
References: <1529500964-28429-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180620181601.GA24145@localhost.localdomain>
 <e87f5946-bb21-942e-2dcc-b24cee1ad23c@oracle.com>
 <20180621081900.GA5183@lst.de>
 <df1633e8-7df4-976b-a7d5-77679c92843a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df1633e8-7df4-976b-a7d5-77679c92843a@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 09:13:30PM +0800, jianchao.wang wrote:
> Hi Christoph
> 
> On 06/21/2018 04:19 PM, Christoph Hellwig wrote:
> > On Thu, Jun 21, 2018 at 09:43:26AM +0800, jianchao.wang wrote:
> >> So we have to preserve the ability of block layer that it could prevent
> >> IO completion path from entering a timeout request.
> >>
> >> With scsi-debug module, I tried to simulate a scenario where timeout and IO
> >> completion path could occur concurrently, the system ran into crash easily.
> > 
> > Trace, please.  With the latest kernel.  I'm not saying that there
> > is nothing to fix, but the mode of never completing once timeout
> > requests as currently done is SCSI is clearly broken.
> > 
> 
> Sorry, I don't quite get your point.
> Do you mean we should do the modification in the scsi layer ?

I think it would just be helpful to start with the stack trace of your
observed crash + the reproduction steps so the problem (and hopefully
a solution) can be better understood.
