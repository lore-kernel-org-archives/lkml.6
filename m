Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37480C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E4AA2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:31:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E4AA2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbeLCRbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 12:31:31 -0500
Received: from mga04.intel.com ([192.55.52.120]:18443 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbeLCRba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 12:31:30 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2018 09:31:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,311,1539673200"; 
   d="scan'208";a="280564084"
Received: from jsakkine-mobl1.jf.intel.com (HELO localhost) ([10.24.10.74])
  by orsmga005.jf.intel.com with ESMTP; 03 Dec 2018 09:31:24 -0800
Date:   Mon, 3 Dec 2018 09:31:23 -0800
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     zohar@linux.ibm.com, david.safford@ge.com, monty.wiseman@ge.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Subject: Re: [PATCH v5 2/7] tpm: remove definition of TPM2_ACTIVE_PCR_BANKS
Message-ID: <20181203173123.GB8813@linux.intel.com>
References: <20181114153108.12907-1-roberto.sassu@huawei.com>
 <20181114153108.12907-3-roberto.sassu@huawei.com>
 <20181116133851.GB4163@linux.intel.com>
 <1602133e-6a41-ea97-d985-6eca0831898d@huawei.com>
 <4a55ba02-87e6-9258-038e-e4c57f00f033@huawei.com>
 <20181130194149.GA18584@linux.intel.com>
 <20181130194527.GB18584@linux.intel.com>
 <95aa61ad-6319-8d9a-dc08-153d80402dfa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95aa61ad-6319-8d9a-dc08-153d80402dfa@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 10:59:10AM +0100, Roberto Sassu wrote:
> On 11/30/2018 8:45 PM, Jarkko Sakkinen wrote:
> > On Fri, Nov 30, 2018 at 11:41:49AM -0800, Jarkko Sakkinen wrote:
> > > Even after looking at the spec the last field does not make sense as the
> > > event after digests and digests are not in union. It is just not right.
> > > 
> > > The comment does not fix that.
> > 
> > You should remove the last field and rename the struct as maybe
> > struct tcg_pcr_event2_head. If we ever need the very last field
> > we can create struct *_tail.
> > 
> > Not your fault but there is clear bug in the struct definition
> > that should be fixed in a commit of its own.
> 
> Given that I explain the problem in the new patch, I would also remove
> TPM2_ACTIVE_PCR_BANKS in the same patch. Is it ok?

Yes.

/Jarkko
