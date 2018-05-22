Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2845700-1527011217-2-11579809512666910305
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527011216; b=W+cdgW5kmCbvgeaxxM/CJEpcTL/iTDvzIauhvVXIWsNWEMo3NK
    FDkukkAjrHGOcLrN6ncc8R6nU0njy9RCeMhJUJNOKZ/+ge8yo/kYOH8S/z0YIoZB
    hYKM2rALfMyzadFAb4YRbdBL7U8aAKBsKBDtjVailauXunS180Gc+4LdEgamYrLk
    u3lfCbml3bsdpLmUiMetdIZE4qHrI+SYoZOQM75TC5LITxjRN2C5JUn7jAPRocz9
    djwhvCXTSL9oyWDKp5hjn2PPGMHpNbXRug3Wt/rx9l5OMrBScHzJ1PBH5xqQFYA5
    j9owlYJLA/v+OcI1uGyGXe2a62sakTMh4Npw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527011216; bh=7YEHm33Fs01ZiRrt5V2HKQe1LFOhzK
    xZ5NSKj6X8cz8=; b=Ua45ptUiaqgWnJYYYco8kRwEYKlBX/H5UMewLfy1SUQEaw
    y2sbqtvaBag41ZChH6Vqlzmch19aOs8r1dJlAemYn128a9kQdjtqNAGM5jJU6pm9
    noBrK4R80vqyBm5jhnKh+J2NZe+G+TCjuIEjLSvOqFFMO+qQxT5GBhd7OH0pV1Ok
    J7JVUfTQfFBy/zzn7mW2HBfuCYjDakN+03rTdqxmVuOTSAEmgiSb6MNb5Z44430d
    aWzu4i0Lg6rgEzdQfM/CaH3sbXlbQ22dvbvHouTqOH3iDG9pu38BpNA8VlKyzSpk
    n6WARugkhKKgBvsF9ckqCDJtkQGBDdD8hV3TJ04g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=RRgnKm0q x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=RRgnKm0q x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDuBYMIvbhWgpocU5cwMWIQaB1PYo6TqsVTHS8fQsFTAn5OVeR78EOZgjWdNuMOuQ4xXttEGa3fa1oFr6MmudjxcQMcmGrs6ERJE9AtC9xdhfqLv/YJP
    Av8E1jxSfS0JsMgS9TLgfxV21VX6KTz8LieRL2cVNXphZebidr0JCyPKbXS2NpsumDcrpmQqnWTP9fvULvdnlbEjSwR7zJWKh+5c37oCpwRsrqFyuLbLY+6R
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=UIbBetWhaY0A:10
    a=VUJBJC2UJ8kA:10 a=sXq4KJOczCTGCFNjOVsA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751326AbeEVRqz (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 13:46:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:46224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751287AbeEVRqy (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 22 May 2018 13:46:54 -0400
Date: Tue, 22 May 2018 19:46:36 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.16 000/110] 4.16.11-stable review
Message-ID: <20180522174636.GA18669@kroah.com>
References: <20180521210503.823249477@linuxfoundation.org>
 <1254867b-5d61-7cb3-ecb7-70107afa1233@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1254867b-5d61-7cb3-ecb7-70107afa1233@roeck-us.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 22, 2018 at 06:35:27AM -0700, Guenter Roeck wrote:
> On 05/21/2018 02:10 PM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.16.11 release.
> > There are 110 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Tue May 22 21:04:14 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 143 pass: 141 fail: 2
> Failed builds:
> um:defconfig
> xtensa:allmodconfig
> Qemu test results:
> total: 139 pass: 139 fail: 0
> 
> The um build failure is transient; it applies to all recent releases,
> including upstream. Rebuilding usually solves it, and indeed solved it
> here as  well. I am listing it to make people aware of it; maybe someone
> has an idea how to fix it.
> 
> Building um:defconfig ... failed
> --------------
> Error log:
> make[2]: *** No rule to make target 'archheaders'.  Stop.
> make[1]: *** [archheaders] Error 2
> make[1]: *** Waiting for unfinished jobs....
> make: *** [sub-make] Error 2
> --------------
> 
> The xtensa build failure has been fixed upstream with commit
> e3ca34880652 ("net/mlx5: Fix build break when CONFIG_SMP=n").

Ah, thanks for pointing me at that, I'll pick it up next.

And thanks for testing all of these, much appreciated.

greg k-h
