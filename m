Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4491FC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC15A2086A
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:53:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC15A2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752216AbeGDNxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 09:53:00 -0400
Received: from mga12.intel.com ([192.55.52.136]:45151 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750855AbeGDNw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 09:52:58 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2018 06:52:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,306,1526367600"; 
   d="scan'208";a="213406925"
Received: from saamir-mobl.ger.corp.intel.com (HELO localhost) ([10.252.34.242])
  by orsmga004.jf.intel.com with ESMTP; 04 Jul 2018 06:52:36 -0700
Date:   Wed, 4 Jul 2018 16:52:35 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <jejb@linux.vnet.ibm.com>
Cc:     James Morris <jmorris@namei.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com,
        jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, dhowells@redhat.com,
        keyrings@vger.kernel.org
Subject: Re: [PATCH 2/2] KEYS: trusted: Find tpm_chip and use it until module
 shutdown
Message-ID: <20180704135235.GA6724@linux.intel.com>
References: <20180626193040.2509798-1-stefanb@linux.vnet.ibm.com>
 <20180626193040.2509798-3-stefanb@linux.vnet.ibm.com>
 <edf4aeaab76713579016cb009a0e632d7417c5f8.camel@linux.intel.com>
 <1530631615.3142.6.camel@linux.vnet.ibm.com>
 <20180703165102.GB19800@linux.intel.com>
 <alpine.LRH.2.21.1807040450340.32123@namei.org>
 <1530644783.3142.37.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1530644783.3142.37.camel@linux.vnet.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 12:06:23PM -0700, James Bottomley wrote:
> On Wed, 2018-07-04 at 04:51 +1000, James Morris wrote:
> > On Tue, 3 Jul 2018, Jarkko Sakkinen wrote:
> > 
> > > On Tue, Jul 03, 2018 at 08:26:55AM -0700, James Bottomley wrote:
> > > 
> > > OK, I was not sure how that discussion went. I could add myself as
> > > co-maintainer to MAINTAINERS because I anyway need to go through
> > > all of these.
> > > 
> > > If anyone does not vote against, I'll send a patch.
> > > 
> > 
> > For Keys?  That would would be useful to help reduce the workload on 
> > David.
> 
> Well, no, this was for trusted keys, which is the part of the key
> infrastructure that goes via the TPM: The KEYS-TRUSTED part in the
> MAINTAINERs file.  There's still KEYS-ENCRYPTED, KEYS/KEYRING and
> ASYMETRIC KEYS, which don't use the TPM.
> 
> However, I've no objection to consolidating the lot under a larger set
> of maintainers ... I recently agreed to look at the asymmetric key TPM
> patch because it's my area, but it also strays over into crypto,
> keyring and asymmetric keys.

Should 2/2 be rolled through my tree? 1/2 is a tpm patch.

/Jarkko
