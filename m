Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3954036-1524035855-2-16076913994329993484
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='cc',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524035855; b=WcABGm6PCF8FdIZhH1KdXN37IILrbAX0He+7rkyo1UdnnyJzQ3
    dnQHWslNJKkCGgG11G6jWkPu+3h3YyWnNVGsxqr/AeheWnywPeFU6oS0HH5N4BNK
    mNfkV/hLrft96b6CY+K4YxMRHK4cW4AVGiGcZFGiPFlo6Jq+LVGz5gp86p453QZP
    cO9pPCsa5utq7v/8bNQMuU8F0KU4A5lvzHx7I2wMZjgcZNzXxO0LQK8Jr8I94cx1
    23Cq9smCmGTwexhWo+OW2DDGtZke7bPUuyN2eRlzewDHC4WJx8kJ9Kxuld+XlIZd
    VtQ4dF1475bDLcrON66HlWcJO/5I1FPFlBKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524035855; bh=m3udHh2WEbRUHUuZktMbk/lJ7nLAwR
    hyCtc5+i3w+34=; b=gvFX41anWpwveTmpZdxvJmRgB9A5EhmuC40nVgUzBE8aOn
    CvLwomxPrHzKiAbJR+gjq03ezxFmNMBzXDBTxn2GhdbvRtfA5J9DeqoIL2tA3YrF
    dtgq2597iZ3N5Mb5fZbgqRKC9pcc6Zuta6Z60CqH35U2T7iXA6pycy5Wv6OyRJiP
    Tg45Dt9Xp49/LAOv2jfDcBGsVLooUcLmtYDWpRwVbQ/aifEg/Mm1nXexC1vN0qVN
    YXt+otIcqawOEUP/CtZsOylBErY+xHqBhQNprzylA56FMeozr/z+m6UFJ7kaJYpK
    wMsaT1CWeWtvXGpNbOhHhnwnV3Q3rtTEO/R6xKHA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=B4BmMWvu x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dkim=pass (2048-bit rsa key sha256) header.d=tobin.cc header.i=@tobin.cc header.b=eXcUqS2H x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tobin.cc;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=tobin.cc header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-85 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=B4BmMWvu x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dkim=pass (2048-bit rsa key sha256) header.d=tobin.cc header.i=@tobin.cc header.b=eXcUqS2H x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tobin.cc;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=tobin.cc header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-85 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfF4kExEyMHGxcPW1eZEEBllBoP/vyogwRMMTK1LwHL1R6n31d7NCd0W2iQhAeKI+qdcMdnjC0/Y4vue8UWrzwvltUFfNGGJz07kMWbMQsT2nazFNbC+h
    lFV6LU4IO955N4kvGxUvXfZkMrzGQKIIiDxNh1w99uYOnwGtO5dk6+D5XCLkbOCN3iT3gSWb/V6vK/TEkPcalqgrcIaEXkdTZp8TL2vEufwgUslrbX9UxRlc
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=MKtGQD3n3ToA:10
    a=Kd1tUaAdevIA:10 a=l8r7VdMIr1gA:10 a=ZZnuYtJkoWoA:10 a=VwQbUJbxAAAA:8
    a=Z4Rwk6OoAAAA:8 a=VnNF1IyMAAAA:8 a=70R3_l1qOrHw7qaBexIA:9
    a=CtipUIh7WegSUYyT:21 a=H9lJBXVSZGYfec9o:21 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=HkZW87K1Qel5hWWM3VKY:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753306AbeDRHRb (ORCPT <rfc822;greg@kroah.com>);
        Wed, 18 Apr 2018 03:17:31 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:50421 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753144AbeDRHRa (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 18 Apr 2018 03:17:30 -0400
X-ME-Sender: <xms:CfHWWj7J_seZ_rd_DG6dH6YBkLMp0g5R3VFL6SCE_qEHgwFMM6wulw>
Date: Wed, 18 Apr 2018 17:17:24 +1000
From: "Tobin C. Harding" <me@tobin.cc>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: jeyu@kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, borntraeger@de.ibm.com,
        schwidefsky@de.ibm.com, brueckner@linux.vnet.ibm.com,
        heiko.carstens@de.ibm.com, peterz@infradead.org, acme@kernel.org,
        keescook@chromium.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] module: Fix display of wrong  module .text address
Message-ID: <20180418071724.GA6892@eros>
References: <20180418071436.21392-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180418071436.21392-1-tmricht@linux.ibm.com>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 18, 2018 at 09:14:36AM +0200, Thomas Richter wrote:
> Reading file /proc/modules shows the correct address:
> [root@s35lp76 ~]# cat /proc/modules | egrep '^qeth_l2'
> qeth_l2 94208 1 - Live 0x000003ff80401000
> 
> and reading file /sys/module/qeth_l2/sections/.text
> [root@s35lp76 ~]# cat /sys/module/qeth_l2/sections/.text
> 0x0000000018ea8363
> displays a random address.
> 
> This breaks the perf tool which uses this address on s390
> to calculate start of .text section in memory.
> 
> Fix this by printing the correct (unhashed) address.
> 
> Thanks to Jessica Yu for helping on this.
> 
> Fixes: ef0010a30935 ("vsprintf: don't use 'restricted_pointer()' when not restricting")
> Cc: <stable@vger.kernel.org> # v4.15+
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Cc: Jessica Yu <jeyu@kernel.org>
> ---

What's changed in each version please?


thanks,
Tobin.
