Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-154247-1527081804-2-9791613798242107711
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527081804; b=GYYDQpQumjV74FIARJk6/PcvNdA4Yl7rB6+rs6T0NXpSavgl2O
    Wgg/evHEojEtmkeapZr1HpK0R6enDbkGgyeBTXnwmodHFKv+MnviKuPdQfmo+72X
    eV59fTzX1zlw0b+CFBehy56rkdZcUhTagJYKWLyHIrYK67USbqd8xbzF1pR6lfAb
    3ewbovBJ/I0JQjoR6In7poKsjN1hmeMyOCIC3+/x5N8tXneCwD+dpCeUvoD31iDK
    4q7vliqokAzGbJ9HVZlStVB1kfdPOlPPNGQ0F4oub71zuD5KRucUpqYD4M0U/nYI
    +PFgWR6g6ghBhmYvjn/cOVGLW0FyB6pcc87Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527081804; bh=kxneoc9dfJOhDZjS37RNI7EfawjQFm
    pKab1/Xa+Hgnk=; b=VbRKq/TbevRqdMw5D2msDS88PDN1wu/mxYGj8+nOf8Ymo5
    w/oXyn8MDX/mkhHxAbgLwfIsU71bCSMG9I5hAr4BwVn/cysOII/s/TF0lQn6ZRsb
    JKty1vYAy+wpc8fs199BjerlupwhfSbgaRurEXqoYMqkhO/6m7EVx0SId2rbBsxx
    H1KMtciRau4GJK8UNrbQ2pxI9YnuK8lO9n+Y124n/Gi9EYy/IBXy6nVrFc4zVyaR
    tvFUCHviyaGF2hxhPos663h4fZgHg1DAD6fW2JA8khX9ZZy79L8XHpcPFM21oID1
    z2nJQxM+vfHe1QyMHBMJaaEXHQ7rZOp0nF3aBXnQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
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
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.intel.com header.result=pass
      header_org.domain=intel.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDGrKv4/frc1uBCIqGN0KbY46/yLpHe67ImiObTw0ZplmjrkZtTQRarBMkcx438jffetcj1SMA2d18KtHD2w8/GEoC3qSE+ow130egFQ7W30TYzply51
    901J5e5CgPbcxrGpxUGFnKeLZ7Q6Rk34Q/CK8s7wbS5wEWdOV38JAb5rQwLN+SNuHNnJAGCOnDHUznioMxt3NWA76xKwp62CqAa8bI9DTBnyJcaxSfxmxi94
    y6i0Ik7KoqXKfSHqfBKz0g==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=h2uKYACVnLByjsR3BpsA:9 a=CjuIK1q_8ugA:10
    a=aE8qyUIWALEA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932894AbeEWNXV (ORCPT <rfc822;linux@kroah.com>);
        Wed, 23 May 2018 09:23:21 -0400
Received: from mga06.intel.com ([134.134.136.31]:5076 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932845AbeEWNXV (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 23 May 2018 09:23:21 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,433,1520924400";
   d="scan'208";a="58362003"
Date: Wed, 23 May 2018 16:23:18 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tadeusz Struk <tadeusz.struk@intel.com>
Cc: jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] tpm: fix race condition in tpm_common_write()
Message-ID: <20180523132318.GE363@linux.intel.com>
References: <152701036671.19968.17347263774570787595.stgit@tstruk-mobl1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152701036671.19968.17347263774570787595.stgit@tstruk-mobl1.jf.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 22, 2018 at 10:32:46AM -0700, Tadeusz Struk wrote:
> There is a race condition in tpm_common_write function allowing two
> threads on the same /dev/tpm<N>, or two different applications on
> the same /dev/tpmrm<N> to overwrite eachother requests/responses.
> 
> Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>

Ouch o_O Do you have a fixes tag for this one?

Thank you.

Reviewed-by: Jarkko Sakkien <jarkko.sakkinen@linux.intel.com>

/Jarkko
