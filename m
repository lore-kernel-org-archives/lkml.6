Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BC8C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EE1A21902
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392655AbfBMQdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 11:33:21 -0500
Received: from mga02.intel.com ([134.134.136.20]:59529 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392610AbfBMQdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 11:33:18 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2019 08:33:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,366,1544515200"; 
   d="scan'208";a="122171776"
Received: from sorenthe-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.151])
  by fmsmga007.fm.intel.com with ESMTP; 13 Feb 2019 08:33:13 -0800
Date:   Wed, 13 Feb 2019 18:33:16 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Tadeusz Struk <tadeusz.struk@intel.com>
Cc:     linux-kselftest@vger.kernel.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, PeterHuewe@gmx.de,
        jgg@ziepe.ca
Subject: Re: [PATCH v2 2/2] selftests/tpm2: Extend tests to cover partial
 reads
Message-ID: <20190213163316.GB18666@linux.intel.com>
References: <155001492513.13014.3572730050393346659.stgit@tstruk-mobl1.jf.intel.com>
 <155001493022.13014.6810778681032295955.stgit@tstruk-mobl1.jf.intel.com>
 <9d3e78706b2fdbe0427f675592df5d7920d2c030.camel@linux.intel.com>
 <dc02e064-9c95-cb51-60d8-4a6219f77430@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc02e064-9c95-cb51-60d8-4a6219f77430@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 08:27:44AM -0800, Tadeusz Struk wrote:
> On 2/13/19 7:13 AM, Jarkko Sakkinen wrote:
> > On Tue, 2019-02-12 at 15:42 -0800, Tadeusz Struk wrote:
> >> Three new tests added:
> >> 1. Send get random cmd, read header in 1st read, read the rest in second
> >>    read - expect success
> >> 2. Send get random cmd, read only part of the response, send another
> >>    get random command, read the response - expect success
> >> 3. Send get random cmd followed by another get random cmd, without
> >>    reading the first response - expect the second cmd to fail with -EBUSY
> >>
> >> Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>
> > 
> > Getting still some garbage in the output:
> > 
> > $ sudo ./test_smoke.sh 
> > [sudo] password for jsakkine: 
> > test_read_partial_overwrite (tpm2_tests.SmokeTest)
> > Reads only part of the response and issue a new cmd ... ok
> > test_read_partial_resp (tpm2_tests.SmokeTest)
> > Reads random in two subsequent reads ... ok
> > test_seal_with_auth (tpm2_tests.SmokeTest) ... ok
> > test_seal_with_policy (tpm2_tests.SmokeTest) ... ok
> > test_seal_with_too_long_auth (tpm2_tests.SmokeTest) ... ok
> > test_send_two_cmds (tpm2_tests.SmokeTest)
> > Send two cmds without reading a response ... ok
> > test_too_short_cmd (tpm2_tests.SmokeTest) ... ok
> > test_unseal_with_wrong_auth (tpm2_tests.SmokeTest) ... ok
> > test_unseal_with_wrong_policy (tpm2_tests.SmokeTest) ... ok
> 
> Looks like python unittest prints out the docstrings:
> 
> +    def test_read_partial_resp(self):
> +        """Reads random in two subsequent reads"""
> 
> I can remove them if it makes more difficult to process the output.

Yeah, I mean it also outputs the function name, which is good enough
IMHO.

/Jarkko
