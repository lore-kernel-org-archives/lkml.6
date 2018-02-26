Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3288027-1519665698-2-3529467344175155098
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
    t=1519665697; b=jGIbyX05jU7drJInTaJIH9C5fjQ6KSDDCZM0XfGjRJ2YIDJ
    X9VEJW9FnxbPbsEnR0h9NmZ75GBdEsFpaz3zDICA8VKryr/NcD0vPO3Cd/EwA+xb
    J9Q3Chj0/GOLb5wobvvB056UqrftsQPYG1MALbvJjcesNpaCwU3sGgSYhHDJ7SrF
    GR3XhArXoEJQfEJkJItNFKt2nF4pAIUYXa/be74QXxkt1D+StBB3n4UXUd5znfiL
    Osm4WKrYNwksUP1rsNsBT5lmM50mcsagEE5KiRadiVjxhkwBc/JYEXbR/Hiv8Wwn
    rCF76zRGKw0h9DyTglfrfkf08oHCDq2m1GRU2bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519665697; bh=2dLkQItMJaHlar0Pd17dzoJHqr
    hRw0OXwVZagPdx7Vs=; b=mCk90an6Px67LmUjClk4ZKDRzS1Up9FEKAS5KmpeBU
    euG1FPwP3sRrgJn+9Pqece9Kxe207RmspGUr6cbNmiJZQaroz2xXEQRoj3yfej7q
    3LCwho45mWTS+qXoNeegUdA8ukVtpYRErqOyXcQ35UMA1QsrzoW68sw2jwzCnxXV
    q06qD1G9A3T7yVpLJq54SnR6vY0M7gkJsvndTlzB3nhZX4jvjra3jUkztVtwxTbm
    OTS3ceOSL1VCcIwJo6/Fd+8U/8AH8JdndXtkzqc2R7yI4Y0hJTH00yvitPszb7q+
    1N2BPCx7IV6CAL+sGrGsZ8MqkodJa3f0TxOvOHwMV6+Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=kKmi0YKa x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=H8V4w1r7;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=kKmi0YKa x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=H8V4w1r7;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751186AbeBZRVY (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 12:21:24 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34517 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751269AbeBZRVX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 12:21:23 -0500
X-Google-Smtp-Source: AH8x227WR1cJUmvS6hGtulvVAeMLSZYbRyjFFauXriYu060b6B6enKYTumb8f5GrLLpLF8psRA8xlg==
Date: Mon, 26 Feb 2018 09:21:19 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        syzbot <syzkaller@googlegroups.com>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [4.4, 027/193] binder: check for binder_thread allocation
 failure in binder_poll()
Message-ID: <20180226172119.GA10044@roeck-us.net>
References: <20180223170330.322805082@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223170330.322805082@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 23, 2018 at 07:24:20PM +0100, gregkh@linuxfoundation.org wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Eric Biggers <ebiggers@google.com>
> 
> commit f88982679f54f75daa5b8eff3da72508f1e7422f upstream.
> 
> If the kzalloc() in binder_get_thread() fails, binder_poll()
> dereferences the resulting NULL pointer.
> 
> Fix it by returning POLLERR if the memory allocation failed.
> 
> This bug was found by syzkaller using fault injection.
> 
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Fixes: 457b9a6f09f0 ("Staging: android: add binder driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/android/binder.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -2622,6 +2622,8 @@ static unsigned int binder_poll(struct f
>  	binder_lock(__func__);
>  
>  	thread = binder_get_thread(proc);
> +	if (!thread)
> +		return POLLERR;
>  
Noticed while merging into chromeos-4.4:

This will cause trouble in v4.4.y. Notice the call to "binder_lock(__func__)"
above. This call has been removed upstream, but not in v4.4.y. As a result,
the lock won't be released, which will result in subsequent hangups
if/when the function is called again.

v4.9.y has the same problem. v4.14.y+ are fine.

Greg - can you fix this up yourself or do you want me to send fixup
patches ? It might take a few days for me to get to it.

Guenter

>  	wait_for_proc_work = thread->transaction_stack == NULL &&
>  		list_empty(&thread->todo) && thread->return_error == BR_OK;
