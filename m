Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-669745-1523937051-2-13525154365331616609
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='dk',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523937051; b=l/uWkY9CSlZtL96wk1e8yuD6xOgX5CnNBmuSPKct33KX2N33g/
    Yxdf7vecM2QeXaENdtLaJoU6UpdJ7wqg8P86KocRXsbvZ/J6tuzI+k8Z16dMRlDK
    30NYwp/f00sEbjkEMSwbDojyH3wKrLtgn9ricnDn6SQRuxYBbI7+yWRxrUF2aQ+U
    EaKw9To8TpQ8RW9r87aNLL4uHn2y09FU5AxlJp5+eKqYe4ZDAGj4XskxpyUcaxV1
    gjLK7uxKAh1w8hNPBqsTbv1NvK9Mt4ce8YCXqQnAfy08pnCYx/WuISaDYPLoxsKj
    FCrEd6hnOJCm4k4MhElkgsJ6mPE0He5VJ20g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523937051; bh=s1L2bmJeEHUyzGKzjAnWNK+gBLHXQb
    kVHqv35Tvob+c=; b=thYk5fBMESZK/+8YIgvRRNUfhuvs/HyC2FE6NQYwwiKRc3
    vsr/0Jdu+9kSc2Xb+QMRN1JeqhITZWms1tb4DDsJ3AN4z23Q0dj/HOxuwpvghcP8
    H/gj/aOjiE7QlqfF/yENu0SAorZZVDXwLGPbrf1Yql+2zzcF1ziOFrfH069SJf8D
    qtJtjQnYLLshy39oC2A13lzJMQLguBFnfKXfrIoWKoDn5QwN1TP3JGhCJpYRFu8g
    zYg96fJ2CUSHNa4g2UWsiPmSl+8Jeze4ZhuH6btMdaAvc7jPW2tK2RonSNTzPcva
    qSSY6Nb9WGOyZu0vh8szz6JbdJjV/wk3a2zUX5Pg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b=NO3ciq6B x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.dk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=FjOX1Gmk;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.dk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b=NO3ciq6B x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.dk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=FjOX1Gmk;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.dk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJffiBWexiRpNUwiCRsffm4vbprtdaLEiQtzSRmmK81Kj1HWVMJgdDvc8LZdfVphJb1ULsQQfYO8AISzhUVn7TWrUW/322FZKcUVTUd4zJV8LbXYFkD9
    zWNe94JZ73iUzhwX6L6YG7bY1oR5NHoFNZwKxbE6QuFMlv58EJnlp83cyJ0nXpWQl3DnZ+5tCXTRIMjjqkgvEjCbDvPHCLd5hBxAbSIZpVXizcBzTBydNpYI
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=OfmbUza8v7VWR6ORrgUA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751970AbeDQDus (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 23:50:48 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:33302 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751270AbeDQDur (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Apr 2018 23:50:47 -0400
X-Google-Smtp-Source: AIpwx4+aUyVQmIwlcvJXxrM4lXZ8pB2J5CM/NNgulOSYGWSJ0xUu4FVG1PFtuTybf4xuzxFwUIv2Dg==
Date: Mon, 16 Apr 2018 21:50:43 -0600
From: Jens Axboe <axboe@kernel.dk>
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Vivier <lvivier@redhat.com>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 00/10] SWIM driver fixes
Message-ID: <20180417035041.GA19502@kernel.dk>
References: <cover.1523493475.git.fthain@telegraphics.com.au>
 <alpine.LNX.2.21.1804160904530.8@nippy.intranet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.21.1804160904530.8@nippy.intranet>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 17 2018, Finn Thain wrote:
> On Wed, 11 Apr 2018, I wrote:
> 
> > This patch series has fixes for bugs in the SWIM floppy disk controller 
> > driver, including an oops and a soft lockup.
> > 
> 
> Apparently no-one is authorized to push this series intact.
> 
> Geert, would you please take just the first two patches?
> 
> Jens, would you please take the remaining 8 patches?
> 
> I have confirmed that no merge conflicts or bisection issues arise from 
> splitting up this series in this way. However, I can re-send these patches 
> as separate submission(s) if need be...

I've picked up 3-10, thanks.

-- 
Jens Axboe
