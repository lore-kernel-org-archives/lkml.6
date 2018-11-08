Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA76DECDE4C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 19:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A19922081C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 19:08:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A19922081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbeKIEpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 23:45:32 -0500
Received: from mga12.intel.com ([192.55.52.136]:53864 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbeKIEpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 23:45:31 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Nov 2018 11:08:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,480,1534834800"; 
   d="scan'208";a="90556687"
Received: from smartikx-mobl2.ger.corp.intel.com (HELO localhost) ([10.249.254.135])
  by orsmga008.jf.intel.com with ESMTP; 08 Nov 2018 11:08:36 -0800
Date:   Thu, 8 Nov 2018 21:08:35 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Peter Huewe <peterhuewe@gmx.de>
Cc:     Roberto Sassu <roberto.sassu@huawei.com>, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Subject: Re: [PATCH v4 4/6] tpm: modify tpm_pcr_read() definition to pass a
 TPM hash algorithm
Message-ID: <20181108190835.GF20608@linux.intel.com>
References: <20181106150159.1136-1-roberto.sassu@huawei.com>
 <20181106150159.1136-5-roberto.sassu@huawei.com>
 <20181108140454.GE8922@linux.intel.com>
 <7a43680a-a216-a191-62a3-c2fb4e72d699@huawei.com>
 <20181108151504.GD14072@linux.intel.com>
 <289C0413-4FFB-4831-B82A-D0C3A965053D@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <289C0413-4FFB-4831-B82A-D0C3A965053D@gmx.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 04:19:09PM +0100, Peter Huewe wrote:
> 
> 
> Am 8. November 2018 16:15:04 MEZ schrieb Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>:
> >On Thu, Nov 08, 2018 at 03:16:03PM +0100, Roberto Sassu wrote:
> >> On 11/8/2018 3:04 PM, Jarkko Sakkinen wrote:
> >> > On Tue, Nov 06, 2018 at 04:01:57PM +0100, Roberto Sassu wrote:
> >> > > Currently the TPM driver allows other kernel subsystems to read
> >only the
> >> > > SHA1 PCR bank. This patch modifies the parameters of
> >tpm_pcr_read() and
> >> > > tpm2_pcr_read() to pass a tpm_digest structure, which contains
> >the desired
> >> > > hash algorithm. Also, since commit 125a22105410 ("tpm: React
> >correctly to
> >> > > RC_TESTING from TPM 2.0 self tests") removed the call to
> >tpm2_pcr_read(),
> >> > > the new parameter is expected to be always not NULL.
> >> > > 
> >> > > Due to the API change, IMA functions have been modified.
> >> > > 
> >> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> >> > > Acked-by: Mimi Zohar <zohar@linux.ibm.com>
> >> > 
> >> > Does not apply to the current upstream (with tpm1-cmd.c).
> >> 
> >> Unfortunately, I cannot fetch the repository as infradead.org only
> >> supports the git protocol (I'm behind a proxy).
> >> 
> >> Roberto
> >
> >I use a proxy script similar to this:
> >
> >https://gist.github.com/sit/49288
> >
> >(random googling but gives the idea)
> >
> >/Jarkko
> Moving to a kernel.org repo would be really a benefit or convincing them to have a https interface as well.
> We have the same proxy issue with infradead.
> Peter
> -- 
> Sent from my mobile

So you are unable to use core.gitproxy to configure the proxy?

/Jarkko
