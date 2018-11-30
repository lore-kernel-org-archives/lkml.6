Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA26C65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 117EA20834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:41:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 117EA20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbeLAGwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 01:52:10 -0500
Received: from mga11.intel.com ([192.55.52.93]:7823 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbeLAGwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 01:52:10 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Nov 2018 11:41:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,299,1539673200"; 
   d="scan'208";a="279429331"
Received: from jsakkine-mobl1.jf.intel.com (HELO localhost) ([10.241.225.27])
  by orsmga005.jf.intel.com with ESMTP; 30 Nov 2018 11:41:49 -0800
Date:   Fri, 30 Nov 2018 11:41:49 -0800
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     zohar@linux.ibm.com, david.safford@ge.com, monty.wiseman@ge.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Subject: Re: [PATCH v5 2/7] tpm: remove definition of TPM2_ACTIVE_PCR_BANKS
Message-ID: <20181130194149.GA18584@linux.intel.com>
References: <20181114153108.12907-1-roberto.sassu@huawei.com>
 <20181114153108.12907-3-roberto.sassu@huawei.com>
 <20181116133851.GB4163@linux.intel.com>
 <1602133e-6a41-ea97-d985-6eca0831898d@huawei.com>
 <4a55ba02-87e6-9258-038e-e4c57f00f033@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4a55ba02-87e6-9258-038e-e4c57f00f033@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 01:04:40PM +0100, Roberto Sassu wrote:
> > > > +    struct tpm2_digest digests[0];
> > > >       struct tcg_event_field event;
> > > >   } __packed;
> > > > -- 
> > > > 2.17.1
> > > > 
> > > 
> > > NAK for the same reason as last time.
> > 
> > I added this comment to include/linux/tpm_eventlog.h:
> > 
> > /*
> >   * http://www.trustedcomputinggroup.org/tcg-efi-protocol-specification/
> >   *
> >   * Set the size of 'digest_sizes' and 'digests', members of
> > tcg_efi_specid_event
> >   * and tcg_pcr_event2, to zero. Structures with variable-sized arrays
> > placed
> >   * midway are not suitable for type casting.
> >   */
> > 
> 
> If this comment is ok, I will send a new version of the patch set.
> 
> Roberto

Even after looking at the spec the last field does not make sense as the
event after digests and digests are not in union. It is just not right.

The comment does not fix that.

/Jarkko
