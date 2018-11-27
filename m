Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CEDC43610
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 23:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D0BC20989
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 23:13:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D0BC20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbeK1KNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 05:13:17 -0500
Received: from mga05.intel.com ([192.55.52.43]:21205 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbeK1KNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 05:13:17 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2018 15:13:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,288,1539673200"; 
   d="scan'208";a="93162206"
Received: from jsakkine-mobl1.jf.intel.com (HELO localhost) ([10.24.8.96])
  by orsmga007.jf.intel.com with ESMTP; 27 Nov 2018 15:13:48 -0800
Date:   Tue, 27 Nov 2018 15:13:48 -0800
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Joey Pabalinas <joeypabalinas@gmail.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH] selftests: add TPM 2.0 tests
Message-ID: <20181127231348.GB26051@linux.intel.com>
References: <20181127221059.25966-1-jarkko.sakkinen@linux.intel.com>
 <20181127224900.fpbqujcsqwgxpwyq@gmail.com>
 <20181127225307.3wc3gd7zmfauie6i@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127225307.3wc3gd7zmfauie6i@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 12:53:07PM -1000, Joey Pabalinas wrote:
> On Tue, Nov 27, 2018 at 12:49:00PM -1000, Joey Pabalinas wrote:
> > > +    def start_auth_session(self, session_type, name_alg = TPM2_ALG_SHA1):
> > > +        fmt = '>HII IIH16sHBHH'
> > > +        cmd = struct.pack(fmt,
> > > +                          TPM2_ST_NO_SESSIONS,
> > > +                          struct.calcsize(fmt),
> > > +                          TPM2_CC_START_AUTH_SESSION,
> > > +                          TPM2_RH_NULL,
> > > +                          TPM2_RH_NULL,
> > > +                          16,
> > > +                          '\0' * 16,
> > > +                          0,
> > > +                          session_type,
> > > +                          TPM2_ALG_NULL,
> > > +                          name_alg)
> > > +
> > > +        return struct.unpack('>I', self.send_cmd(cmd)[10:14])[0]
> > > +
> > > +    def __calc_pcr_digest(self, pcrs, bank_alg = TPM2_ALG_SHA1,
> > > +                          digest_alg = TPM2_ALG_SHA1):
> > > +        x = []
> > 
> > Is there a reason for using `'\0' * 16` there instead of just 0?
> 
> Nevermind, I keep forgetting that the * operator on strings performs
> repetition. I've been programming too much C lately, it seems.
> 
> Acked-By: Joey Pabalinas <joeypabalinas@gmail.com>

Thank you! Would be good to have these merged to the kernel tree so that
one can include both functionality and test case when needed to the
patch set.

/Jarkko
