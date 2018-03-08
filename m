Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-551923-1520473602-2-3146352709199511410
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520473601; b=nHCEzuaYjEqzb8/d0RdVCA2mlh6x+EsOT8fsxW+FjOJuNsd
    aKX8dL1iiEceYYZIazzGLi4ibqYS2UVorQhAoL/yu/+V7gUMP09xKFjRBOJkyY//
    p8SswCTIPZtFzrJp1FAbfqTy4B7YJt9yQ3B8Esa26h5pGL7QksrI2lgKAqOHfyLN
    x1l07uNIrjB/KvgwuZNfAPKOIHSn9TZeXGGbFqZIIQNwnTrtIe6hX4pFmHiyx1/V
    LOpj3Qe1rbh01Jlf+zDH/6Y+3hi8n+m8x6G5kxwY7fj7p/ejFCNUs7y9KrZ6sZH8
    bgK1mlGIxo+qpqCCviG0c/00odDFLe5ka3FggHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520473601; bh=fBNHTP//AJCNZ6NCRI5DBOG5ZX
    EPrxX8m3X0ELSHu7Y=; b=XGejpGIvLJzqlWm8t/w0Sb0QEZn7Zq3EJHyV1/OppQ
    l7HWLr2MtLaWpW1s3SvdJAoYRrl8Ne+YYRO+0vYN+rzZptpQmPwlBUNYzN7v5Cpw
    qnfsSxiVRiaRuAeepRBbgrCM2Vk98aSK8ilv8lsSGBelTkwrg1lf1YIDAJqw/icC
    NfKMa0GZLgtTvYwIirL5q44gs1GBjBEFKIa0XmvHaXPQMq98y4+QszmZFPpTIMM4
    bKb7g1TSNYZ+ZKjIlhd/tjvVuj/CzqUNeK3D2o2YcH874ws+B35sXaFPJMwp071z
    m5KrR1mL6BK+Wk+yCspDtx/fHCrLAkf0dxDtYwkYBJmQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934521AbeCHBqk (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 20:46:40 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:48370 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933351AbeCHBqk (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 20:46:40 -0500
Date: Wed, 7 Mar 2018 17:46:42 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Mario.Limonciello@dell.com
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        pali.rohar@gmail.com, andriy.shevchenko@linux.intel.com
Subject: Re: [PATCH 4.15 004/122] platform/x86: dell-laptop: Allocate buffer
 on heap rather than globally
Message-ID: <20180308014642.GA24330@kroah.com>
References: <20180307191729.190879024@linuxfoundation.org>
 <20180307191729.867541449@linuxfoundation.org>
 <1a37a9b60e8c49ce9955e1d04ba7ff8e@ausx13mpc124.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a37a9b60e8c49ce9955e1d04ba7ff8e@ausx13mpc124.AMER.DELL.COM>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 08, 2018 at 01:14:39AM +0000, Mario.Limonciello@dell.com wrote:
> Greg,
> 
> Can you please make sure that the one that came in right after this is also applied at the same time?
> https://www.spinics.net/lists/stable/msg215268.html
> 
> As you recommended before they weren't squashed together, but they should both come in at the
> same time.

Oops, for some reason I thought that was going to have a stable@ tag on
it.  Now queued up.

greg k-h
