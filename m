Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB876ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71B2521019
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:15:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71B2521019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbeKIAvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 19:51:08 -0500
Received: from mga01.intel.com ([192.55.52.88]:44710 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbeKIAvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 19:51:07 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Nov 2018 07:15:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,480,1534834800"; 
   d="scan'208";a="278183687"
Received: from ibanaga-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.75])
  by fmsmga005.fm.intel.com with ESMTP; 08 Nov 2018 07:15:05 -0800
Date:   Thu, 8 Nov 2018 17:15:04 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Subject: Re: [PATCH v4 4/6] tpm: modify tpm_pcr_read() definition to pass a
 TPM hash algorithm
Message-ID: <20181108151504.GD14072@linux.intel.com>
References: <20181106150159.1136-1-roberto.sassu@huawei.com>
 <20181106150159.1136-5-roberto.sassu@huawei.com>
 <20181108140454.GE8922@linux.intel.com>
 <7a43680a-a216-a191-62a3-c2fb4e72d699@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a43680a-a216-a191-62a3-c2fb4e72d699@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 03:16:03PM +0100, Roberto Sassu wrote:
> On 11/8/2018 3:04 PM, Jarkko Sakkinen wrote:
> > On Tue, Nov 06, 2018 at 04:01:57PM +0100, Roberto Sassu wrote:
> > > Currently the TPM driver allows other kernel subsystems to read only the
> > > SHA1 PCR bank. This patch modifies the parameters of tpm_pcr_read() and
> > > tpm2_pcr_read() to pass a tpm_digest structure, which contains the desired
> > > hash algorithm. Also, since commit 125a22105410 ("tpm: React correctly to
> > > RC_TESTING from TPM 2.0 self tests") removed the call to tpm2_pcr_read(),
> > > the new parameter is expected to be always not NULL.
> > > 
> > > Due to the API change, IMA functions have been modified.
> > > 
> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > Acked-by: Mimi Zohar <zohar@linux.ibm.com>
> > 
> > Does not apply to the current upstream (with tpm1-cmd.c).
> 
> Unfortunately, I cannot fetch the repository as infradead.org only
> supports the git protocol (I'm behind a proxy).
> 
> Roberto

I use a proxy script similar to this:

https://gist.github.com/sit/49288

(random googling but gives the idea)

/Jarkko
