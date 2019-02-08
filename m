Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CBAC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 21:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 415C821924
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 21:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfBHVvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 16:51:17 -0500
Received: from mga17.intel.com ([192.55.52.151]:42767 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbfBHVvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 16:51:17 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Feb 2019 13:51:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,348,1544515200"; 
   d="scan'208";a="318812715"
Received: from mwesterb-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.154])
  by fmsmga005.fm.intel.com with ESMTP; 08 Feb 2019 13:51:12 -0800
Date:   Fri, 8 Feb 2019 23:51:10 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Peter Huewe <PeterHuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v4 1/2] tpm: =?iso-8859-1?Q?Uni?=
 =?iso-8859-1?Q?fy_the_send_callback_behaviour=E4?=
Message-ID: <20190208215110.GA13567@linux.intel.com>
References: <20190208180857.12330-1-jarkko.sakkinen@linux.intel.com>
 <20190208180857.12330-2-jarkko.sakkinen@linux.intel.com>
 <4072b2b6-0f95-be50-0772-7e2869c2c24e@linux.ibm.com>
 <20190208190057.GA3439@linux.intel.com>
 <20190208191710.GA30645@linux.intel.com>
 <6a86e3e8-e311-7a0f-585d-3f0435b0143a@linux.ibm.com>
 <20190208202353.GB1836@linux.intel.com>
 <36dc691e-4f00-7f6b-5a53-763c12d4fa16@linux.ibm.com>
 <20190208204635.GA24938@linux.intel.com>
 <32faca9e-5099-4ff5-6fe7-5e6e840b109b@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32faca9e-5099-4ff5-6fe7-5e6e840b109b@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 04:18:40PM -0500, Stefan Berger wrote:
> On 2/8/19 3:46 PM, Jarkko Sakkinen wrote:
> > On Fri, Feb 08, 2019 at 03:32:32PM -0500, Stefan Berger wrote:
> > > 
> > > tpm_del_char_device also needs the start/stop!
> > Done and updated the commit message to have all the call sites:
> > 
> >      * tpm_chip_register()
> >      * tpm_class_shutdown()
> >      * tpm_del_char_device()
> >      * tpm_pm_suspend()
> >      * tpm_try_get_ops() and tpm_put_ops()
> >      * tpm2_del_space()
> 
> 
> I tested this now with tpm_vtpm_proxy, TPM 1.2, (TIS|CRB) + TPM 2.0. Looks
> good now - rock solid so to say. And while we are at it ... :-)

Thank you for your support. I don't think these quite distruptive
changes would have made in without any growing pains. The way
tpm_transmit() used to be had become quite a mess with all the nested
calls and weird locking flags. Now we have a good baseline to forward
:-)

I rebased the branches to the latest security/next-general. Probably
do the PR after the middle week (ETA Thu).

/Jarkko
