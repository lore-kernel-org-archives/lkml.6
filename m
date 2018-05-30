Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3705410-1527678082-2-59858537035428847
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527678081; b=LmBdqt+M4krwM8czxhKsDahRwpLQd+nwL/DcQ1yVI7jGVZVbDE
    jBimE9HUVOLa5DpgV1I3I1pWlG/9oWwid4SDjXqW/L/wSeU9ZlwOJ1nQKxomQUkd
    vjs1Rvg7uyVfzTyWbEkNlcZNCMX4v54gmrre7JW4tlogwzGvQxkJdaIdHppqlSTV
    6Av9hzGOTl1wRHRKqs93eCHR4mfVo2M1lLx+TYeps4Sbz3oYiGnLzct5yw1r1/cG
    vofSIPBURjb8noT+0EZuzbRc15jrH5ivz24N6uZXA5E+EDZCXxPtsqaxJp1/uw1N
    bZkza6G1nzaSuct7f7c6/WzelW/iwOzbMpXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527678081; bh=+eZLNyUZSoFzzv+BTBK4+X7zB/1Hxd
    C6CgzY1QKf2+M=; b=SmiUGQ/9WExAaL+RCMzeGbAfY6Q4DPZm5yBuXwuCPF4W/T
    1FNEUDVBkDwDVvK58YT8+xNBOVEV75j6gZOq72nNpCjwjF5STcJarGezqWR2MsEp
    46TMP48X18eQwLd2V1iF9TaUOjHX5nLdxNTS2LqG6csAhu7QdazwbeM6DtwfVVY4
    3gusKwrQEfVkXqwNP9kbdwGTFKo4ipUCHpGt87HULCI2tAS/fhtWwBtacrJA2rcU
    H4ItQQapqW3oNLPliDkaPIbL9f/9oM3sIvpZTW1GsX7+SPnX2DkOhn6i/MxD12NJ
    JZg0ejTI2h4YLZJB00QiM8UCIVNl4IeIQCLHTREg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.intel.com header.result=pass
    header_org.domain=intel.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.intel.com header.result=pass
      header_org.domain=intel.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAJlCmm5sXxUlU7Ai/eYRtsTbAgKEJuijXFb6nL2aNrifEsekL3nIlrAu7Q5ysbqnwD7N88clZwROqy9cEmiGxcpoNAf8k/29A/wi7sZeRP+g1OmWB/k
    BWN6xlCq5GZqudzq3VwzF+fE+dgmIJkaftusfkIDTqFlo45RnSZVEN5/k77SfEJ/nkbAUSS0q9aQLzOexpq2wkhBR5Tv6m4L1qCrvB7kGmKBxKGg8rcWjx4m
    t1m4dqgrERug/pLBMZ4VZA==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=YG_GpJ4tajcoB6vf054A:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751651AbeE3LBR (ORCPT <rfc822;linux@kroah.com>);
        Wed, 30 May 2018 07:01:17 -0400
Received: from mga11.intel.com ([192.55.52.93]:6283 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751765AbeE3LBR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 30 May 2018 07:01:17 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,460,1520924400";
   d="scan'208";a="43915556"
Date: Wed, 30 May 2018 14:01:12 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tadeusz Struk <tadeusz.struk@intel.com>
Cc: jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] tpm: fix race condition in tpm_common_write()
Message-ID: <20180530110112.GB14905@linux.intel.com>
References: <152701036671.19968.17347263774570787595.stgit@tstruk-mobl1.jf.intel.com>
 <20180523132318.GE363@linux.intel.com>
 <fb9c3d0c-d6fe-25ee-6452-92ade053c75a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb9c3d0c-d6fe-25ee-6452-92ade053c75a@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 23, 2018 at 10:57:07AM -0700, Tadeusz Struk wrote:
> On 05/23/2018 06:23 AM, Jarkko Sakkinen wrote:
> > Ouch o_O Do you have a fixes tag for this one?
> > 
> 
> This one is quite tricky.
> The original bug was introduced by abce9ac292e13 (tpm: Propagate error from tpm_transmit to fix a timeout hang)
> and the code back then was in drivers/char/tpm/tpm-interface.c file
> 
> Then there were two other commits that moved the code around:
> afdba32e2a9ea (tpm: Pull everything related to /dev/tpmX into tpm-dev.c)
> which moved it from drivers/char/tpm/tpm-interface.c into drivers/char/tpm/tpm-dev.c
> 
> and last one, ecb38e2f521b0 (tpm: split out tpm-dev.c into tpm-dev.c and tpm-common-dev.c)
> which moved it from drivers/char/tpm/tpm-dev.c into tpm-common-dev.c
> 
> I have no idea how to tag it. Maybe we can use:
> Fixes: ecb38e2f521b0 ("tpm: split out tpm-dev.c into tpm-dev.c and tpm-common-dev.c")
> 
> And then it probably needs to be back ported manually all the way back to abce9ac292e13.
> 
> Thanks,
> -- 
> Tadeusz

Thank you. I'll cc this to stable.

/Jarkko
