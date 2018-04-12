Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1364822-1523552075-2-171723460356288403
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523552075; b=Z4JuaN6ywCyhGgBvxe5f+Se8WQg77GjNcYAJpy51gYIdEh/2Y2
    WF9j0O+cKBl2GooQjx5H1Awg+gf5gKwYg7pG4TeRU5ItbSOA/BdKJW8Swdy8QS/Y
    rO9U1/yswq3PEcYyJHcej4iyxL0AUshAq70w1LRc89SVquNYyNV5ken5o4Ltpaq0
    TNTuv+j3KxdlJ/Kk3tFjaNGSX4Qn+wMamSVK3u53nyuRearEsoeTtxfQOSSsKMRa
    0Sk9l4tev0gcotWwBxGIcr39DpmZsUdCbv/3FDYsqoWp0NoBIdGl60N0fM0g4lDm
    K9gT8ln5BoFOWzstig25ejmXoaBi84kMqfmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523552075; bh=Ml51F56OpVlu71rxpzH0VnkMMiTQk3
    338JHKU257H2k=; b=XoIyOn6bn6dBJYFbPnIy71dYg6V1NLIAVs7Pjl2iJJAvRJ
    U216tHblYvYOxconhh9zDXc9Tk/gpaXdu0u2GbUA3T3A603lcsNClwv/pXHJBE7O
    KLRkb3As0YOUKJpTwLr9rMsHx6F91bEkBdgjF5De4lMj1rEPXRwFF8KZnZNOIEK9
    K5Wf6HRpGryUrrNmKvMAaapCnP+diQpJ1H42bYSXMnBRkEioZVb2tmvxpLs3lx+i
    9/PZ+rbMVyVj+gwtk/r1c9IyAswE6zGZJ9GOZf3u/KiPqbCX9OMMtXKt9/5gtNr4
    UXpuWp/n1VAflnvO5jQ/UlvEqpaM+Wbik6tbQVbA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKoKi39nseaxm08Z2Y2xgjeIifnPOiCuXwsdkHuZVsge1XQwmYDwoBJK+mxo85SLneRlCAtMru+3GzSIW42iabXBWdHxC5oazt3WYl5ZcBZ7dnDVBZfP
    NcTaxChbuctDjmQFcmHrR9zSV8d0GnF245dWqxZQRwYi2+u9B9cZ5P0TncCMrkscCZRgBXhV7O0d5516OfRB5nJmW7oKf6CcgPJ3McOjOhOqTuMotFBbKhrN
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=USzuPbOPRRIA:10
    a=Kd1tUaAdevIA:10 a=YWtRXzOXAAAA:8 a=cefJTwFQu7W5hKvPlacA:9 a=CjuIK1q_8ugA:10
    a=eX-Bu5Fvq_kA:10 a=XosyFl2cby_8ldcV-F0Q:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752896AbeDLQyU (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 12:54:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40562 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752930AbeDLQyT (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 12 Apr 2018 12:54:19 -0400
Date: Thu, 12 Apr 2018 18:54:07 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 3.18 000/121] 3.18.105-stable review
Message-ID: <20180412165407.GB23951@kroah.com>
References: <20180411183456.195010921@linuxfoundation.org>
 <cfd7bfd8-4051-5ce8-7a60-db14d36eb69d@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfd7bfd8-4051-5ce8-7a60-db14d36eb69d@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 12, 2018 at 06:15:08AM -0700, Guenter Roeck wrote:
> On 04/11/2018 11:35 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 3.18.105 release.
> > There are 121 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Fri Apr 13 18:34:28 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 136 pass: 136 fail: 0
> Qemu test results:
> 	total: 119 pass: 119 fail: 0
> 
> Details are available at http://kerneltests.org/builders.

Thanks for testing these three and letting me know.

greg k-h
