Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-738662-1518804653-2-2653292413365360974
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518804652; b=mbY3dwZbdMXtkAqRVuAluZbG9gqqnSQBpvDpGBQUl0ibSHD
    e2ANW2EgciF+1CG+6+lFLUJnLTowLDRuRYBhun+gdGZZiJ2cfXetU8XkdxjzHXXb
    Gpy6od3bG1n/QYBDkdzspF7IBBr2+9gudLIaCnr7DByZlU1YzpD7PicdAieObKcX
    zrZJmFapDCoDuI5zNyeGv56Wy4scjvT3bDDrJzQfv+RAX6k51hKfggZk+2kxwfnl
    hNN724eJi+dyGZpEvBabuR3jUVkqVAlTnrnV8AsnYQneiIhdyCYZQbZF4R4qWWbS
    +Efly784FhVT1lRjUWQJWQwBWgirQ/EUZSxd/1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518804652; bh=vjoqzfkeUL8yuQHAz2Vs+0+LmM
    PBpcC2DAgwCBhDmzM=; b=uWxeXDWcBdSuIw5VGH3js59M5eOd/VtgiwWkR1Oqj3
    EdCCK0+gNBcWdGZLqmWAR7UJQMNsulyVF9sugs9CEf2vtApSrwFQZjxrIOQSjL6x
    Bcs69K1E1/IAk0xlRdMs+HFMsyZ+sItd7fIVOSIHejh0TUhAahy5N/MbUqckCxAJ
    u41N5Ueb2rkHeUCfUQBCOjibMJlyZcF9ZwsHOdXYtEEb96C+zcJZ/eV1OBjX/sj0
    EdR9XcRQpDG7NkrOkXAG6T8zpmF3HjEfawyWdEJkcOmp3xZ/GcLnnGLCp1TtLhk1
    gAmWsmYqvH9gugavpg73kyX/MHH5m27ba2BVQKX9276A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=VPmULu+e x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=JjUAILDc;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=VPmULu+e x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=JjUAILDc;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162895AbeBPSKt (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Feb 2018 13:10:49 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36986 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162415AbeBPSKs (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Feb 2018 13:10:48 -0500
X-Google-Smtp-Source: AH8x224wkly66ZhcXF9x9tdd5Uv2AIBnVjM8LTLQblIC+li4X5VGCxvf7pBW2fHmLNgV/xf0IQF52Q==
Date: Fri, 16 Feb 2018 10:10:44 -0800
From: Brian Norris <briannorris@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Leif Liddy <leif.linux@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Daniel Drake <drake@endlessm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 4.4 095/108] Bluetooth: btusb: Restore QCA Rome
 suspend/resume fix with a "rewritten" version
Message-ID: <20180216181043.GA84497@rodete-desktop-imager.corp.google.com>
References: <20180215151222.267507937@linuxfoundation.org>
 <20180215151235.620152736@linuxfoundation.org>
 <20180216023147.GB69988@rodete-desktop-imager.corp.google.com>
 <20180216064850.GA26224@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216064850.GA26224@kroah.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 16, 2018 at 07:48:50AM +0100, Greg Kroah-Hartman wrote:
> On Thu, Feb 15, 2018 at 06:31:48PM -0800, Brian Norris wrote:
> > On Thu, Feb 15, 2018 at 04:17:32PM +0100, Greg Kroah-Hartman wrote:
> > > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > Consider this an objection:
> > 
> > I'm currently arguing that this is unnecessarily regressing power
> > consumption here:
> > 
> > https://patchwork.kernel.org/patch/10149195/
> > 
> > I'll leave it up to you what to do with this, but if this ends up in
> > Chromium OS kernels, I'm likely to revert it there...
> 
> Is that patch in Linus's tree yet?  If so, I'll be glad to also apply it
> here.

The link is the original patch, where I'm (too late?) complaining about
its side effects. Hans and Marcel are discussing potential alternatives.
This stuff happens in -rc kernels. But you're already ready to push it
out to -stable users? I can try to push another few reverts into Linus's
tree if that really helps, or else you can wait on pushing these to
-stable until 4.16 settles down.

Or you can ignore my objection. But I don't really like that option ;)

Brian
