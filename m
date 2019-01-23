Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB65C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0FC920870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfAWO7O convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 09:59:14 -0500
Received: from mail.emypeople.net ([216.220.167.73]:40833 "EHLO
        mail.emypeople.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfAWO7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 09:59:13 -0500
X-Greylist: delayed 726 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Jan 2019 09:59:12 EST
Received: from Shop7 ([166.182.241.35])
        by mail.emypeople.net (12.1.1 build 4 DEB9 x64) with ASMTP id 201901230947053176;
        Wed, 23 Jan 2019 09:47:05 -0500
From:   "Edwin Zimmerman" <edwin@211mainstreet.net>
To:     "'Jani Nikula'" <jani.nikula@linux.intel.com>,
        "'Greg KH'" <gregkh@linuxfoundation.org>,
        "'Kees Cook'" <keescook@chromium.org>
Cc:     <dev@openvswitch.org>,
        "'Ard Biesheuvel'" <ard.biesheuvel@linaro.org>,
        <netdev@vger.kernel.org>, <intel-gfx@lists.freedesktop.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <linux-mm@kvack.org>,
        <linux-security-module@vger.kernel.org>,
        <kernel-hardening@lists.openwall.com>,
        <intel-wired-lan@lists.osuosl.org>,
        <linux-fsdevel@vger.kernel.org>, <xen-devel@lists.xenproject.org>,
        "'Laura Abbott'" <labbott@redhat.com>,
        <linux-kbuild@vger.kernel.org>,
        "'Alexander Popov'" <alex.popov@linux.com>
References: <20190123110349.35882-1-keescook@chromium.org> <20190123110349.35882-2-keescook@chromium.org> <20190123115829.GA31385@kroah.com> <874l9z31c5.fsf@intel.com>
In-Reply-To: <874l9z31c5.fsf@intel.com>
Subject: RE: [Intel-gfx] [PATCH 1/3] treewide: Lift switch variables out of switches
Date:   Wed, 23 Jan 2019 09:47:06 -0500
Message-ID: <000001d4b32a$845e06e0$8d1a14a0$@211mainstreet.net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQK1qhpX7cEQ8qlEpLW6qt3JZ7VVWQH3EeYfAWqRE0oCq0D606PKlQEg
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2019, Jani Nikula <jani.nikula@linux.intel.com> wrote:
> On Wed, 23 Jan 2019, Greg KH <gregkh@linuxfoundation.org> wrote:
> > On Wed, Jan 23, 2019 at 03:03:47AM -0800, Kees Cook wrote:
> >> Variables declared in a switch statement before any case statements
> >> cannot be initialized, so move all instances out of the switches.
> >> After this, future always-initialized stack variables will work
> >> and not throw warnings like this:
> >>
> >> fs/fcntl.c: In function ‘send_sigio_to_task’:
> >> fs/fcntl.c:738:13: warning: statement will never be executed [-Wswitch-unreachable]
> >>    siginfo_t si;
> >>              ^~
> >
> > That's a pain, so this means we can't have any new variables in { }
> > scope except for at the top of a function?
> >
> > That's going to be a hard thing to keep from happening over time, as
> > this is valid C :(
> 
> Not all valid C is meant to be used! ;)

Very true.  The other thing to keep in mind is the burden of enforcing a prohibition on a valid C construct like this.  
It seems to me that patch reviewers and maintainers have enough to do without forcing them to watch for variable
declarations in switch statements.  Automating this prohibition, should it be accepted, seems like a good idea to me.

-Edwin Zimmerman

