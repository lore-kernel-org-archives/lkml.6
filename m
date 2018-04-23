Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1465131-1524502374-2-1508335963867295299
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524502373; b=jVbAKEv4QExkaVdPiZGTq75R2qxxad92jk39rVb/+y3qPKs19R
    6P1XyNpoTSzhDJDy21LAV2FCGRSPKCEhs2yOj6Nm7ahHjM2O/1MWjkZ5DaY5rK5Y
    k5W7FhmFElGLkM+PTicq8xPX/KdhwLkEyEhL/Bz5q+HMYMqDDjOHPPuP5J8yK/y2
    znNjJZ62pgdPAXcqmK2tvgYuBVCfj+TM2/o8KoLCslRDa3KD7ljRIo9cquPWtNUU
    HteOYo8grcXxMRA9juyH4bNyvx2ZpRy0bfsseBP+jqUjFV+8AmTlvedknMf6vmOC
    FSSDtsCoEAh6BxgSu3sRjtrXrAlgVRFPEpyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524502373; bh=bvdFZKKRfIYZLkyuOlkfGuk4cz7NT5
    QYuj8LVfL5Pio=; b=Kv/+plSrozzCBGFut0BCqpNvd/ClYZIAd7KPtUqu5q7ECG
    2mqTJKVdrQ2KQqtvMB28KwTJuG85b3ziE0G1E460P4NDPF1CCBSNKdCXGCg11vtC
    l/59w2dnDvI2mgvPz3pvpwlhjtMhXaBvq516DSoJPaW30wEB9YGlNxAa9aGqAAYK
    D/Vt3Gc5OYw+Rf2jsRe5XhkMYEPK+SpMXV5S3oqTaq02voeXktkTzJe/abWu7+7w
    aor68ZIkjfUFipHPhtMxBhqeBVWLciOwxEqj6IzKQaIx/kFWN2HFSjxEizuIF+0q
    UAavWXKHmjRr613DKsAxNiPF6dM/LIgxffImcFjQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=roeck-us.net header.i=@roeck-us.net header.b=IqTBdWI7 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=roeck-us.net header.i=@roeck-us.net header.b=IqTBdWI7 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJcq37Ypidd9TC4Ab6sW3Gqplfc91Yfs0BWUeVHZ1iHooma/jp+Jd6bjyT8rgCjHSdWQMsgy0b/Furt/p5CTKfmaDQSw0TPYZCCYosLECkajGac1OS08
    aOW1Af3hZHttHP9MO3jwlqsvlIaJrTsS4QBjtJZW8nMtpZRmWktC7O051raG5KaE+EjzMAZFc9pj5geb2Q+xFZhxBOF0BG4PoLoGktedfz361q6BcDoGhhWv
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=9+rZDBEiDlHhcck0kWbJtElFXBc=:19
    a=kj9zAlcOel0A:10 a=XatMZvNwr2AA:10 a=Kd1tUaAdevIA:10 a=YWtRXzOXAAAA:8
    a=4xprMFNNEUxhqQMAOkEA:9 a=CjuIK1q_8ugA:10 a=eX-Bu5Fvq_kA:10
    a=XosyFl2cby_8ldcV-F0Q:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755871AbeDWQwf (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 12:52:35 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:59333 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755925AbeDWQwb (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Apr 2018 12:52:31 -0400
Date: Mon, 23 Apr 2018 09:52:28 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/52] 3.18.106-stable review
Message-ID: <20180423165228.GA12958@roeck-us.net>
References: <20180422135315.254787616@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180422135315.254787616@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 22, 2018 at 03:53:33PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.106 release.
> There are 52 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue Apr 24 13:53:02 UTC 2018.
> Anything received after that time might be too late.
> 

For v3.18.105-53-g0d52b30:

Build results:
	total: 136 pass: 136 fail: 0
Qemu test results:
	total: 119 pass: 119 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
