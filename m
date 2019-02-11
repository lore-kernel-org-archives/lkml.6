Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA0EC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DCC921B68
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729568AbfBKRzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 12:55:38 -0500
Received: from mga04.intel.com ([192.55.52.120]:2752 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbfBKRzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 12:55:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2019 09:55:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,359,1544515200"; 
   d="scan'208";a="115355335"
Received: from tstruk-mobl1.jf.intel.com ([10.7.196.56])
  by orsmga006.jf.intel.com with ESMTP; 11 Feb 2019 09:55:36 -0800
Subject: Re: [PATCH 2/2] selftests: tpm2: Extend tests to cover partial reads
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kselftest@vger.kernel.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, PeterHuewe@gmx.de,
        jgg@ziepe.ca
References: <154939851385.18477.481518864800562919.stgit@tstruk-mobl1.jf.intel.com>
 <154939851969.18477.13778157467131576825.stgit@tstruk-mobl1.jf.intel.com>
 <20190211164803.GG8431@linux.intel.com>
From:   Tadeusz Struk <tadeusz.struk@intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=tadeusz.struk@intel.com; prefer-encrypt=mutual; keydata=
 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
 FheFfUJaD4iEjuL98uUjS/AI
Message-ID: <9b879fd2-5c0a-aecc-b6cb-02e5255c22f6@intel.com>
Date:   Mon, 11 Feb 2019 09:55:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190211164803.GG8431@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/19 8:48 AM, Jarkko Sakkinen wrote:
> You are missing a cover letter from this patch set. Please have it in
> v2. Also use tag "selftests/tpm2" instead of having two tags in the
> short summaries. Now they look a bit weird.

Since when is the cover letter mandatory?
I understand that is helps for a complicated patch set
to explain the problem and solution in the cover letter,
but for this simple test case addition what's the point?
And there is nothing forcing a cover letter in
https://www.kernel.org/doc/html/v4.20/process/submitting-patches.html

Also double tags seams to be quite common for selftest.
See git log tools/testing/selftests/
Thanks,
-- 
Tadeusz
