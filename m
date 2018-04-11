Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3216147-1523476503-2-18057090974155999922
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: yes ("Address greg@kroah.com in From header is in addressbook");
 in-addressbook; shared/fdfaecbe-d8f0-4518-a17e-0d89bf6dc529 ("Greg")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523476503; b=mgN62SIC79qM/7AmBGIVTymh6T6KoTy6l7e1lpjAod9Y+lL6jR
    ZX/EwJWpn6RqOqBGaXcLdEj5rlK2DAlM4zWAbNMwCDy4nrTw3yDfTr2JR4yyZS6/
    yzFUYYC18UP7R7F4XlIzLSKbQeLCqcxkgQWwmckuKpkOXiXDN5Q5r2liCQTbJx0x
    aSq4X77ndH9EwP/iFefJdbrdCBcYQarmaUaUc1qVNbO799kQZH6uezu/FCvPg54u
    R4tvIoQMgB/ZBtCzAnqUt+Bt0m91PBT5HhzSVQ4tSUu1XsVSUivOnzKiYMplkG4G
    ENgUoe4buBHJ40ZggOcFPP8MwW7XKx4BGM3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523476503; bh=Htl3oYgHsNJGJBBtUQXUCaNPE4HRiC
    apBYUFBk1Ft2Y=; b=G+p0lHbq1ZBm2tSMaNrUNQNOVMS7dn9fs8V8KMuckj5P/l
    CUr8P99QXGGxdjOgJtruGDakEvdUX4wJNAvYsQSIiqKjmy4+DXyDTIyTSXGVJzy4
    k/qtWyvYCETgRh9PRU2gzfBIZFPaELNWASW58jzNd6pXKZ0YfJDe9pz1Aw3hAbnd
    7JsFlOvjjP0AHuULF1CRoJI8X+LFJDWnk7M3Mcofbsr+IMYL8lX3qeRzVE4VLQ1R
    4SAW8H3YfMMFaFs2ARlGWbDUXHpBFHKUjBMDh6HG7BoxNmnnQh8ut6BMsOjOmH4C
    yY2kuvfEE5D1XHUtHKNRiJIoI6pAaZK4RC21zFkw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=EV3dUIcJ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kroah.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=EV3dUIcJ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kroah.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLTMhW2SYITSHb3rdaT3jNcyWnWrqUDk+iuvdkWk3TAhcigebyXl7VF2y7GkhomUsN+5K92Xk25B77fKniXxnqAOPdNVT0JAH1E3J6uVGmKKu6YZWcGh
    o/pt2kfYFGMBdEnPwTFa+1vp1qa8hS8VvnRWsAMcSW97FMriopAIA6XhsNIj7CG74IyJ1i7PgYaKsr07x3dz9/I7skZzxiQ3sWjKViHDlQ2V3ZIc09QqQnXb
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=nhvMRwm8HjG6GMaE3xkA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933154AbeDKTyr (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 15:54:47 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:36819 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756700AbeDKTyo (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 11 Apr 2018 15:54:44 -0400
X-ME-Sender: <xms:A2jOWhHQRheTzDg42iGuNrQt__7CM-noPpi9itoSSSuythL_Uph3Mg>
Date: Wed, 11 Apr 2018 21:54:36 +0200
From: Greg KH <greg@kroah.com>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@linux-foundation.org, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, jmorris@namei.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 24/24] debugfs: Restrict debugfs when the kernel is
 locked down
Message-ID: <20180411195436.GA7126@kroah.com>
References: <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
 <152346403637.4030.15247096217928429102.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152346403637.4030.15247096217928429102.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 11, 2018 at 05:27:16PM +0100, David Howells wrote:
> Disallow opening of debugfs files that might be used to muck around when
> the kernel is locked down as various drivers give raw access to hardware
> through debugfs.  Given the effort of auditing all 2000 or so files and
> manually fixing each one as necessary, I've chosen to apply a heuristic
> instead.  The following changes are made:
> 
>  (1) chmod and chown are disallowed on debugfs objects (though the root dir
>      can be modified by mount and remount, but I'm not worried about that).
> 
>  (2) When the kernel is locked down, only files with the following criteria
>      are permitted to be opened:
> 
> 	- The file must have mode 00444
> 	- The file must not have ioctl methods
> 	- The file must not have mmap
> 
>  (3) When the kernel is locked down, files may only be opened for reading.
> 
> Normal device interaction should be done through configfs, sysfs or a
> miscdev, not debugfs.
> 
> Note that this makes it unnecessary to specifically lock down show_dsts(),
> show_devs() and show_call() in the asus-wmi driver.
> 
> I would actually prefer to lock down all files by default and have the
> the files unlocked by the creator.  This is tricky to manage correctly,
> though, as there are 19 creation functions and ~1600 call sites (some of
> them in loops scanning tables).

Why not just disable debugfs entirely?  This half-hearted way to sorta
lock it down is odd, it is meant to not be there at all, nothing in your
normal system should ever depend on it.

So again just don't allow it to be mounted at all, much simpler and more
obvious as to what is going on.

thanks,

greg k-h
