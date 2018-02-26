Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3538075-1519671966-2-5175233710301453532
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519671965; b=uYfJMTFjycXmr371XQ9PmapQ5/VhdiI5FS53J09Pabgh6rf
    CiGSvRLCik09ieWwV2mnXai0jtCnBOmmRw5bq+TwJ0Ussh8NmdsJ6dCa2SLulbWt
    hMr9UH+Se9W5HKhvVFT2328EnFFvMmfapFX2+fa2SfjohXzoZiY7D+jdcu9ItCB4
    OCZdbBmwV0zx3/ZJCNf6joeF7P4MvK/xCnqmi5VJ8y4GZxZL0lPVk6vaaQUkeW30
    J7zZ/MB+d8QPiy0IXN8OorqOIeuqRfqYD6TA/mAzdvHnTV2SSlr1u9udOXnF1364
    GqyDJAnPcCBhFkegvANB/pLfGvmQsnoj+QS8AZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519671965; bh=SYDQFbMG+igDbGYbT97Rk2e67C
    JTlGaM5zSeDY9IHcU=; b=O71RqvYUs6dsicQC6c5vML5CPh7BG2wZm+FNVcmYXI
    96+58+02b0X3g+ZgHMGkd9kesv+wLH0jCg7xrSGJf638tqCijgloPprBAP0MZDlD
    spQHv+4NpPgk3xgR44rbyLajdpyte/ArlOFSerDspQ0VriEmHb1RbiHSau4ZiXHg
    0bUUK9yXeOYNr/k04qCdLNhBiK/2WqsYEnXGPc31CLRwqUU7bCdPLzQkhT2+c5Vv
    YtKozJvpzHWKmD/0Tp4PHMjeaffLSK78LY8r129ONblpKa9vqoySR8KcB+ijgBxT
    lrqV5MrxSsp230CfxxupGwYM1MmCxpcm/kMWrUaiRxZw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=SVCiQjhn x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rS+fQZ1X;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=SVCiQjhn x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rS+fQZ1X;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751677AbeBZTGD (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 14:06:03 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:41558 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751668AbeBZTGC (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 14:06:02 -0500
X-Google-Smtp-Source: AH8x22456RB299DaZm2gClnke9R5OjSFa6PDeKTuFYefyW9jfmPFX2rvkwz3F32aVZyxS98VzjTjVg==
Date: Mon, 26 Feb 2018 11:05:59 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Eric Biggers <ebiggers3@gmail.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        syzbot <syzkaller@googlegroups.com>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [4.4, 027/193] binder: check for binder_thread allocation
 failure in binder_poll()
Message-ID: <20180226190559.GA15268@roeck-us.net>
References: <20180223170330.322805082@linuxfoundation.org>
 <20180226172119.GA10044@roeck-us.net>
 <20180226185754.GA177108@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180226185754.GA177108@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 26, 2018 at 10:57:54AM -0800, Eric Biggers wrote:
> Hi Guenter,
> 
> On Mon, Feb 26, 2018 at 09:21:19AM -0800, Guenter Roeck wrote:
> > On Fri, Feb 23, 2018 at 07:24:20PM +0100, gregkh@linuxfoundation.org wrote:
> > > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > > 
> > > ------------------
> > > 
> > > From: Eric Biggers <ebiggers@google.com>
> > > 
> > > commit f88982679f54f75daa5b8eff3da72508f1e7422f upstream.
> > > 
> > > If the kzalloc() in binder_get_thread() fails, binder_poll()
> > > dereferences the resulting NULL pointer.
> > > 
> > > Fix it by returning POLLERR if the memory allocation failed.
> > > 
> > > This bug was found by syzkaller using fault injection.
> > > 
> > > Reported-by: syzbot <syzkaller@googlegroups.com>
> > > Fixes: 457b9a6f09f0 ("Staging: android: add binder driver")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > >  drivers/android/binder.c |    2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > --- a/drivers/android/binder.c
> > > +++ b/drivers/android/binder.c
> > > @@ -2622,6 +2622,8 @@ static unsigned int binder_poll(struct f
> > >  	binder_lock(__func__);
> > >  
> > >  	thread = binder_get_thread(proc);
> > > +	if (!thread)
> > > +		return POLLERR;
> > >  
> > Noticed while merging into chromeos-4.4:
> > 
> > This will cause trouble in v4.4.y. Notice the call to "binder_lock(__func__)"
> > above. This call has been removed upstream, but not in v4.4.y. As a result,
> > the lock won't be released, which will result in subsequent hangups
> > if/when the function is called again.
> > 
> > v4.9.y has the same problem. v4.14.y+ are fine.
> > 
> > Greg - can you fix this up yourself or do you want me to send fixup
> > patches ? It might take a few days for me to get to it.
> > 
> > Guenter
> 
> Thanks for spotting this!  I'll send a patch to fix it.
> 
Thanks!

Guenter
