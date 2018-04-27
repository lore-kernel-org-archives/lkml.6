Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4147413-1524822282-2-2890617183936255889
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FSL_HELO_FAKE 2.361, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524822281; b=iZEA5a0JvRfwUhXq2zvlYuFRQl8QOEpQ1bC2niPyYeLr499Eco
    Ny6nJsOv1KdrrMOdyblf49liUGRMgN9cRlXA0DqR5a8Ht9ZrWASx9DBdjO0+dyc/
    xs7qR0kK3Z5u90nNrfwLNXO3fgJHiJO99tMVuWqeKm/ANZ9fpSMX3yFpzeNgW+ad
    cUiyLGsHXfpdT4Q3le4TwruaqSWnkvf7WwA7uBm6gm0q6MRV/JsyUy9bSt/NNUou
    itqzc5kiuyRKFPBSEHM+p+A6RMbvTG63wpK6MHNBGD+qe7xIoYG0/KlZZAkwT0Tl
    HHDszjlW0rQuNBD8s+pz6gACIKp9vFuyMqMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524822281; bh=w/0/85goPhf4WLUJFYR5MXCJzkV318
    FcLsp+G2Lyr+E=; b=iUF/vZwnoFSYNy3z9DU+wtoQuGZdEtBkU1d86I21EGiEm3
    d3n6oLiXOpYeSCyb6c4G0br0MYKNkmB4V1VxrANfjuw6VvKJznqEROlDBpIxPCzB
    o7nP/6okWI7JA25JhItHl8g5OBsxNSZihInNiMPgw/dabCLMAgRQ2fxqmB+WyryW
    epg9u+9WgSq91OXlWpykXY4Qqf+rVwolydRCb2V95sSGtpF004aFGRRlPtLUh3Z/
    b/S/WDKGSFjc/rKFlpHjd/T466VkBN0tZ8YY/CukzPJTAxvVUN2daRDH7OP0mAR0
    aV/D0Y7yqoLyuxeB3WpifR+McBFPCwa4AmwIlzXQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=MBK0VcJq x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=GmnBruiO;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=MBK0VcJq x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=GmnBruiO;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfChOk/AKByBmoIXgTMFcS3meJcQ5Dyanwr6HzOLF7v3G9ql82/lZZej0ly60dZiIvFnW5BX6hD6fcrBFQpT+cxwHFQ26uJCUSRhcRLBcyeUpqJuSaFzz
    K5Hr1jSr/hst7++3uqWZVM/UHxjNqEtWOnbXn4V/BlyZZ2wvc/pn4vNLFGWnsvq19Ga2QwlsZZ34UKGuSYd4VtUCAtcg+P00HDJQU0K3hXU5Ce7eekBHm5Gd
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=gu6fZOg2AAAA:8 a=VwQbUJbxAAAA:8 a=M6dewCKOPjwJVl_dLgQA:9 a=CjuIK1q_8ugA:10
    a=-FEs8UIgK8oA:10 a=NWVoK91CQyQA:10 a=2RSlZUUhi9gRBrsHwhhZ:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757657AbeD0Joi (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 05:44:38 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55244 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757538AbeD0Joh (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 27 Apr 2018 05:44:37 -0400
X-Google-Smtp-Source: AB8JxZqUoihmJqjLhi+AH8v23673/q0shDmgtHd8rwntsXH0IT7WErm8dqMxvmSmZDZ28G8TBOwvKw==
Date: Fri, 27 Apr 2018 11:44:33 +0200
From: Ingo Molnar <mingo@kernel.org>
To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        gregkh@linuxfoundation.org, ben@decadent.org.uk,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        jannh@google.com, carnil@debian.org
Subject: Re: [PATCH 4.9 75/95] random: set up the NUMA crng instances after
 the CRNG is fully initialized
Message-ID: <20180427094433.ptowxets5r7bdmc7@gmail.com>
References: <20180422135210.432103639@linuxfoundation.org>
 <20180422135213.491879480@linuxfoundation.org>
 <49fa7d5f484a06f02946afec0688c33849e018de.camel@decadent.org.uk>
 <20180423071520.GC28186@kroah.com>
 <201804231921.DGB18791.QOVFLFMJFtSOHO@I-love.SAKURA.ne.jp>
 <20180423155637.GB8194@thunk.org>
 <20180426060434.b7fwrem77ht7n5qa@gmail.com>
 <201804260653.w3Q6rwVO028104@www262.sakura.ne.jp>
 <20180426172947.GC5965@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426172947.GC5965@thunk.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Theodore Y. Ts'o <tytso@mit.edu> wrote:

> On Thu, Apr 26, 2018 at 03:53:58PM +0900, Tetsuo Handa wrote:
> > Oh, pull request was already sent. Should be merged shortly.
> > 
> > https://marc.info/?l=linux-kernel&m=152472466201090&w=2
> 
> More testing, either before or after merging, would be greatly
> appreciated.  One of the challenges is that there are a lot of systems
> out there with different amounts of boot entropy available.  So this
> pull request was needed to help deal with issues on crazy big machines
> (CONFIG_NUMA) and crazy small laptops (old/small chromebooks
> repurposed to support Ubuntu and small ARM systems) --- neither of
> which I had access to when I was putting together the fixes to the
> random driver.
> 
> So any feedback before 4.17 gets released would be really helpful!
> 
> Thanks!!

I tested this upstream commit:

  665fa0000aed: Merge tag 'random_for_linus_stable' of git://git.kernel.org/pub/scm/linux/kernel/git/tytso/random

... and the bug is fixed here too, my test machine is back to 'perfect'.

Thanks!

	Ingo
