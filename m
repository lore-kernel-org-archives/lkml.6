Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-772761-1518807148-2-8053459517686707946
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518807148; b=uk2WygY/tau0BOu8wc1xGumrmVhgGJpBM28B52hwPmtbInO
    DI7KzWyRw5XTncJDeCzJEvAyBPsP8Oqdcq9gLyLNqPEOP2hsms5fbpNrvKHjy9cE
    SSuAv0AFZhYQFkf8SdDo9Qgr+Crgfg4OWF7CwQla1JOg1iOxdPeQao+udKDMmYH1
    PHISNMWcgk9cgLbFxUJ393JDgtJi+VVeZmHACCy2AV8HTGOiwfe97YOtPiKXBrZT
    PDHEMANB1k5BCsHopKTcgeKGrdxAm/zacnxrPKpKyJ7tN0aPwukAyi2DeBlrK5FB
    vuL2EsdtvOs5dNVGQ9UdavgGW+O2kKGABW/kcZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518807148; bh=u/ZJsXFnDDFidKzMWIy6H7SGCW
    fDgH3DkPc9WP1EnS4=; b=wtx5P+OXj6RkNNREOtO2zuH+zentznlJC4gmKKcPci
    SdnU4Altt8UWbQL9lM5i6vOuI72nbyAS5SkgtInwVdscDOPgSsfUkq/o3HN929cE
    xu43PH4/WKU3HU37lHffVmT1qIExY+mFpuv6KJ0uhb/Sj76rheYeZ6VEtyl+Y3Bj
    JS2ZdLVqzrS48cDEel8zZ/STndADPD0Qu21Mm1UDCpltuBbWG24gPNbChT5kQ+Fc
    2Gc4LsTevkPeN1wlFIWrWTg6XGHQpd3imsVe0ocA7sjDaiuFkDX5jQgFSo3r49Mr
    xeWwG/BHBwx5THfxiB5GR8Yozi6lVufFs9l0mWmQ2ZrA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=I7G3mYpZ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=aBP2RCmt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=I7G3mYpZ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=aBP2RCmt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751876AbeBPSwZ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Feb 2018 13:52:25 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:37153 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751255AbeBPSwX (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Feb 2018 13:52:23 -0500
X-Google-Smtp-Source: AH8x2255HPMsrLwE2tzywLuxEkZ+7OLdyDocKeA5DKktrCdIP1FU+3DOkngbxzpSyZlTRE2GBboTHg==
Date: Fri, 16 Feb 2018 10:52:20 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Brian Norris <briannorris@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Leif Liddy <leif.linux@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Daniel Drake <drake@endlessm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 4.4 095/108] Bluetooth: btusb: Restore QCA Rome
 suspend/resume fix with a "rewritten" version
Message-ID: <20180216185220.GA29352@roeck-us.net>
References: <20180215151222.267507937@linuxfoundation.org>
 <20180215151235.620152736@linuxfoundation.org>
 <20180216023147.GB69988@rodete-desktop-imager.corp.google.com>
 <20180216064850.GA26224@kroah.com>
 <20180216181043.GA84497@rodete-desktop-imager.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216181043.GA84497@rodete-desktop-imager.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 16, 2018 at 10:10:44AM -0800, Brian Norris wrote:
> On Fri, Feb 16, 2018 at 07:48:50AM +0100, Greg Kroah-Hartman wrote:
> > On Thu, Feb 15, 2018 at 06:31:48PM -0800, Brian Norris wrote:
> > > On Thu, Feb 15, 2018 at 04:17:32PM +0100, Greg Kroah-Hartman wrote:
> > > > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > > 
> > > Consider this an objection:
> > > 
> > > I'm currently arguing that this is unnecessarily regressing power
> > > consumption here:
> > > 
> > > https://patchwork.kernel.org/patch/10149195/
> > > 
> > > I'll leave it up to you what to do with this, but if this ends up in
> > > Chromium OS kernels, I'm likely to revert it there...
> > 
> > Is that patch in Linus's tree yet?  If so, I'll be glad to also apply it
> > here.
> 
> The link is the original patch, where I'm (too late?) complaining about
> its side effects. Hans and Marcel are discussing potential alternatives.
> This stuff happens in -rc kernels. But you're already ready to push it
> out to -stable users? I can try to push another few reverts into Linus's
> tree if that really helps, or else you can wait on pushing these to
> -stable until 4.16 settles down.

FWIW, here are the various commit SHAs.

Upstream:			61f5acea8737
v4.15 (queued for v4.15.4):	e766a2d7f7c2
v4.14 (queued for v4.14.20):	736385472dfa
v4.9 (queued for v4.9.82):	1c6fc2167678
v4.4 (queued for v4.4.116):	575538a5371d

I didn't check older stable kernels.

Guenter
