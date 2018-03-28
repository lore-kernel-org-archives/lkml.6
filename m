Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1763006-1522225315-2-1814514730629424747
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522225315; b=s4VHjaPOM2K7gtVcZkTG0wVWVUZlAHOZXVn++HDBN56oMZ6
    cpjQRnufubW+R7dktV1HVOe9ML0elZlJ92dUkFPbLHbMTRqaw7EstiZ4UB1BWPuC
    3BjSBSB5JAXpRW3TT+X7zrtwArTcTWuGEBEz3udINiSUb3VslDTUai1cHNLto1WI
    gaJJ7M80wu40S0cbi/laGa64y0IU2ylkKlQfnpUTRq56LIuVtP5f4vpX5vz8fthz
    zQIvZHYADjLUTt3jr+8parRJc1tnRcDenttCNKrruIatUYDCLzaczzu9hgRc65DT
    F6GYZxYVwk/N3g8wF7ppA5VGflZTXUgieow0PiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1522225315; bh=5by0qpLQOHz6fc3v/MuKxjqNgM
    S/CSf7GJXqfGtnMGU=; b=qZ0eT+HKU5S+BJ0itESwMGmQyPT/PjPb5Jl+dxpqmW
    mciiMXpaZASOcTQL0Qh7HL1+dsKLCcrWZDJwjW1rUrwOK4vo9q07IbmsYw1TmB2W
    aXvn4TvY8a8+7+WFDXIC4p57ZEr9bheUyd9B1FLusO2VS8z/acn2NW50rfHy/RP7
    GMGzFSIJKDEKRNhiyT45cqVzkvNLLtEJ8E48SXXsRHEfIClUkMHKIuAVOgtOPBfY
    4YcfKzZIEvkFZR4zGG6T4deRX8svpgAnmdrYe76vcOuSfo43leSRdw5CneajWmYT
    ks6fCRaV2a2zZajUDrB4cXAqPJHkoIuzrTFQofjBwlNQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfNP1RkgJehERm0BW6WI30+DEdQMtraroQ5cc6tU/HSpKALJiWZoAPRAetHJIU4jkP6XM3sTTcZc6tILWQn7FItevWJ01O7jkb4SOVvOtBeajxjG77jtt
    WLK6Erb5ekuROMO8GJDXq523xXo0PezHAPgx3Lyt28oCTGZQpmEo1VngV8UfN0QHId5jcGBi2kFkgppBsBndOEyYmCRVqWHdx4L0UpMuePzmLcvjPqGiAKPc
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=ONKqiAgnDjwA:10
    a=v2DPQv5-lfwA:10 a=xZz5CmW9f14RYhSFsB4A:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751903AbeC1IVw (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 04:21:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43462 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751114AbeC1IVv (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Mar 2018 04:21:51 -0400
Date: Wed, 28 Mar 2018 10:21:45 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/67] 4.9.91-stable review
Message-ID: <20180328082145.GB14201@kroah.com>
References: <20180327162726.702411083@linuxfoundation.org>
 <20180328013501.vdeqlxn525m4cex6@xps>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328013501.vdeqlxn525m4cex6@xps>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 27, 2018 at 08:35:01PM -0500, Dan Rue wrote:
> qemu_x86_64
> * boot - pass: 21
> * kselftest - skip: 28, pass: 52

Do you have a list of what you are skipping anywhere?  There was some
x86 changes that I had to backport that I was worried about getting
right here, are you running the x86 kselftests?

thanks,

greg k-h
