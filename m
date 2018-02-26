Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3594401-1519671481-2-1387642868499716940
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  FSL_HELO_FAKE 3.2, HEADER_FROM_DIFFERENT_DOMAINS 0.001,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519671480; b=w3XGm2rdikhYqHC8aaeme90FD3Jz67wc+oNkmkdTMPGyckD
    e4cGVx8aIETB5L2ZwwbShBzNmPWCVA3abWoRd6MJuvgysXPI/Gz86vZUjrXje71P
    ff/cPCs9kyV3dBAUZ8mdfp8ab1iD9JmEsAMxqKi1uMv8Ybht3zrSJU1hel9L2k09
    UecEy9KgOUvDTBKblYUSgRX2YjX8lta4sEJyoYg6PbZ5qj7UNjPVSC/SwENQKBpf
    txptKzj2ObCBgz2/RTmZ3JrpUEK3w208YOQBdie+BcXhfaUgtX6cUjyq/pKyDAeo
    rHVOGRm83AEZuvLY6rHb6VH4rtzhdwsUChVWf9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519671480; bh=CPBPbnzZFC/qUnfFAkbrGpkNmS
    fH8O05c1kla4C38yo=; b=vSsOtya83YjEhZmOyTHZn9isMeqHwdt8gGJh9iX2Lf
    nGos+HtnitAcCrbIBzTJ/TE8qybRGY6HokEe0pMT6Ct3ecZuZX18YOO8DW/1nSlj
    ACaSdbfh75ZcfWJOHJTouVPEh6o/M9KI3w/TaP2+IPeLD0yQsbTmmf9G7QWzAOeH
    iBHG6WJQjfZrVVmtho98fofRyBVeMMR/8P8YM7MDAmkIyN6mYqDt5Z5TT6FqObLM
    0VSBu3GnjkUKJzMVk3K+MY5dDmSY7B2I82/M1GgvlZSGrQyKy/CUyd0fRj5eJGJ6
    S2a3aF5eqXDWrK8YGwTwwwm+KQQMJk5/hmZjBDfyXn8Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=snckNP1C x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=eRn2lwMm;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=snckNP1C x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=eRn2lwMm;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751702AbeBZS56 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 13:57:58 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:33874 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751175AbeBZS55 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 13:57:57 -0500
X-Google-Smtp-Source: AH8x225stIQyw0jT4PsVvUQZIJg8ujHJWkCdq4orp836becX/5DlxYpi7oJ9YUjxyxpotYcAJ2Ijag==
Date: Mon, 26 Feb 2018 10:57:54 -0800
From: Eric Biggers <ebiggers3@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        syzbot <syzkaller@googlegroups.com>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [4.4, 027/193] binder: check for binder_thread allocation
 failure in binder_poll()
Message-ID: <20180226185754.GA177108@gmail.com>
References: <20180223170330.322805082@linuxfoundation.org>
 <20180226172119.GA10044@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180226172119.GA10044@roeck-us.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Guenter,

On Mon, Feb 26, 2018 at 09:21:19AM -0800, Guenter Roeck wrote:
> On Fri, Feb 23, 2018 at 07:24:20PM +0100, gregkh@linuxfoundation.org wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > commit f88982679f54f75daa5b8eff3da72508f1e7422f upstream.
> > 
> > If the kzalloc() in binder_get_thread() fails, binder_poll()
> > dereferences the resulting NULL pointer.
> > 
> > Fix it by returning POLLERR if the memory allocation failed.
> > 
> > This bug was found by syzkaller using fault injection.
> > 
> > Reported-by: syzbot <syzkaller@googlegroups.com>
> > Fixes: 457b9a6f09f0 ("Staging: android: add binder driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/android/binder.c |    2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > --- a/drivers/android/binder.c
> > +++ b/drivers/android/binder.c
> > @@ -2622,6 +2622,8 @@ static unsigned int binder_poll(struct f
> >  	binder_lock(__func__);
> >  
> >  	thread = binder_get_thread(proc);
> > +	if (!thread)
> > +		return POLLERR;
> >  
> Noticed while merging into chromeos-4.4:
> 
> This will cause trouble in v4.4.y. Notice the call to "binder_lock(__func__)"
> above. This call has been removed upstream, but not in v4.4.y. As a result,
> the lock won't be released, which will result in subsequent hangups
> if/when the function is called again.
> 
> v4.9.y has the same problem. v4.14.y+ are fine.
> 
> Greg - can you fix this up yourself or do you want me to send fixup
> patches ? It might take a few days for me to get to it.
> 
> Guenter

Thanks for spotting this!  I'll send a patch to fix it.

Eric
