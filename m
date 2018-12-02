Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360D4C65BAE
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 23:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F194821473
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 23:04:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F194821473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725811AbeLBXE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 18:04:29 -0500
Received: from mga07.intel.com ([134.134.136.100]:64623 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbeLBXE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 18:04:29 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Dec 2018 15:04:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,308,1539673200"; 
   d="scan'208";a="104104321"
Received: from trhammer-mobl.amr.corp.intel.com (HELO localhost) ([10.254.49.188])
  by fmsmga007.fm.intel.com with ESMTP; 02 Dec 2018 15:04:26 -0800
Date:   Sun, 2 Dec 2018 15:04:26 -0800
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: Extend trusted keys documentation for TPM 2.0
Message-ID: <20181202230426.GA6718@linux.intel.com>
References: <20181019101758.1569-1-stefanb@linux.ibm.com>
 <20181106164603.w46wspmdj5e4slwe@cantor>
 <1541528254.8568.48.camel@linux.ibm.com>
 <20181130234507.GA3792@linux.intel.com>
 <20181130234646.GB3792@linux.intel.com>
 <1543763436.4216.196.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1543763436.4216.196.camel@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 02, 2018 at 10:10:36AM -0500, Mimi Zohar wrote:
> Are you asking about coordinating staging the trusted key patches to
> be upstreamed or about moving portions of the encrypted keys code out
> of the keyring subsystem?
> 
> I'm not sure there needs to be a separate encrypted-keys pull request.
>  Either they can be upstreamed via the TPM or the integrity subsystem
> for now.

Nothing that ought to be rushed.

I'm speaking about this situation:

1. TPM 1.x trusted keys code is inside keyring subsystem.
2. TPM 2.0 trusted keys code is inside tpm subsystem.

We are doing effort to make TPM subsystem more friendly to send custom
commands outside (tpm_buf, my unnesting effort in progress, Tomas' clean
ups for TPM 1.x code) so I'm more dilated to the 2nd option.

/Jarkko
