Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD6AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2929221473
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbfARPBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 10:01:50 -0500
Received: from mga07.intel.com ([134.134.136.100]:58973 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727415AbfARPBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 10:01:49 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jan 2019 07:01:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,491,1539673200"; 
   d="scan'208";a="115700491"
Received: from unknown (HELO localhost) ([10.249.254.249])
  by fmsmga007.fm.intel.com with ESMTP; 18 Jan 2019 07:01:43 -0800
Date:   Fri, 18 Jan 2019 17:01:41 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Peter Huewe <PeterHuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Shuah Khan <shuah@kernel.org>,
        Tadeusz Struk <tadeusz.struk@intel.com>
Subject: Re: [PATCH,RESEND] selftests: add TPM 2.0 tests
Message-ID: <20190118150141.GG4080@linux.intel.com>
References: <20190116213102.25268-1-jarkko.sakkinen@linux.intel.com>
 <87r2dcqkq4.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r2dcqkq4.fsf@morokweng.localdomain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 08:52:03PM -0200, Thiago Jung Bauermann wrote:
> 
> Hello,
> 
> Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> writes:
> 
> > Added the tests that I've been using for testing TPM 2.0 functionality
> > for long time but have out-of-tree so far residing in
> >
> > https://github.com/jsakkine-intel/tpm2-scripts
> >
> > Cc: Tadeusz Struk <tadeusz.struk@intel.com>
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > Acked-By: Joey Pabalinas <joeypabalinas@gmail.com>
> > ---
> >  tools/testing/selftests/Makefile           |   1 +
> >  tools/testing/selftests/tpm2/Makefile      |   3 +
> >  tools/testing/selftests/tpm2/test_smoke.sh |   4 +
> >  tools/testing/selftests/tpm2/test_space.sh |   4 +
> >  tools/testing/selftests/tpm2/tpm2.py       | 696 +++++++++++++++++++++
> >  tools/testing/selftests/tpm2/tpm2_tests.py | 227 +++++++
> >  6 files changed, 935 insertions(+)
> >  create mode 100644 tools/testing/selftests/tpm2/Makefile
> >  create mode 100755 tools/testing/selftests/tpm2/test_smoke.sh
> >  create mode 100755 tools/testing/selftests/tpm2/test_space.sh
> >  create mode 100644 tools/testing/selftests/tpm2/tpm2.py
> >  create mode 100644 tools/testing/selftests/tpm2/tpm2_tests.py
> >
> > diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> > index 1a2bd15c5b6e..e4556132cbc4 100644
> > --- a/tools/testing/selftests/Makefile
> > +++ b/tools/testing/selftests/Makefile
> > @@ -47,6 +47,7 @@ TARGETS += sysctl
> >  ifneq (1, $(quicktest))
> >  TARGETS += timers
> >  endif
> > +TARGETS += tpm
> 
> This should be tpm2, right?

Yes, it should, thank you.

/Jarkko
