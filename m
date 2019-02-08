Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24F2C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C860220863
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbfBHPmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 10:42:54 -0500
Received: from mga17.intel.com ([192.55.52.151]:16175 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727411AbfBHPmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 10:42:52 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Feb 2019 07:42:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,347,1544515200"; 
   d="scan'208";a="124969651"
Received: from shivamur-mobl1.gar.corp.intel.com (HELO localhost) ([10.249.254.162])
  by orsmga003.jf.intel.com with ESMTP; 08 Feb 2019 07:42:45 -0800
Date:   Fri, 8 Feb 2019 17:42:44 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Peter Huewe <PeterHuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] tpm: Unify the send callback behaviour
Message-ID: <20190208154244.GA3963@linux.intel.com>
References: <20190208140600.24996-1-jarkko.sakkinen@linux.intel.com>
 <20190208140600.24996-2-jarkko.sakkinen@linux.intel.com>
 <b53745b6-ed49-9e97-6f56-1378561888eb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b53745b6-ed49-9e97-6f56-1378561888eb@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 09:42:16AM -0500, Stefan Berger wrote: > On 2/8/19 9:05 AM, Jarkko Sakkinen wrote:
> At least tpm_nsc_send (tpm_nsc.c) and tpm_inf_send (tpm_infineon.c) are also
> returning the number of bytes sent. I would consider tpm_crb the outlier
> that returns 0 and should return the length even though we don't need it...

That would be absolutely wrong way the fix the *actual* issue i.e.
callbacks returning garbage (sometimes just passing the length parameter
back as a return value).

/Jarkko
