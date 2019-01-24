Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF51C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B021218A3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548317430;
	bh=mVuhrQqk7Q0zWlxIFBTAwmH57rC+LNUGq0bYNV+P8nY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Q178CWSN4DtfqQH9D7vRjxFpq32RAf1XfVZgY+8ZWGsUw3U+WE/Ndqj1vQnHM+uZo
	 z8kmI+M1KeAIYbf/qfWi5Bvd5PhCYFTEyDX9Igd77eFzwkyWdjpTn2h8dqrXk3BySD
	 sIsa9GReJUvdpAZRyY0CUdzrPhQIaPKh+Qq8naRM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfAXIK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 03:10:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:54386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbfAXIK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 03:10:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8738621872;
        Thu, 24 Jan 2019 08:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548317427;
        bh=mVuhrQqk7Q0zWlxIFBTAwmH57rC+LNUGq0bYNV+P8nY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZEkD/omuTC/6WRsTLYnibk+sJ8XC+aSzvbF+D1UtelBBhWFwJCz4p3BgG898PP/WK
         EQqKpEKsH1ZCIh3xFKyM4r1WaPA8pegt/aOxYMcbdJRPPz7va8v2Z7lHYQ/DD8I6Zc
         TL6esem5HPhSos0hjBMX2YhzVQlPCdBuq/WP6cMI=
Date:   Thu, 24 Jan 2019 09:10:24 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Edwin Zimmerman <edwin@211mainstreet.net>, dev@openvswitch.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Network Development <netdev@vger.kernel.org>,
        intel-gfx@lists.freedesktop.org, linux-usb@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Linux-MM <linux-mm@kvack.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        intel-wired-lan@lists.osuosl.org,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Laura Abbott <labbott@redhat.com>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Alexander Popov <alex.popov@linux.com>
Subject: Re: [Intel-gfx] [PATCH 1/3] treewide: Lift switch variables out of
 switches
Message-ID: <20190124081024.GA1108@kroah.com>
References: <20190123110349.35882-1-keescook@chromium.org>
 <20190123110349.35882-2-keescook@chromium.org>
 <20190123115829.GA31385@kroah.com>
 <874l9z31c5.fsf@intel.com>
 <000001d4b32a$845e06e0$8d1a14a0$@211mainstreet.net>
 <87va2f1int.fsf@intel.com>
 <CAGXu5jJUxHtFq0rBJ9FwzMcZDWnusPUauC_=MaOz7H0_PF25jQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXu5jJUxHtFq0rBJ9FwzMcZDWnusPUauC_=MaOz7H0_PF25jQ@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 07:55:51AM +1300, Kees Cook wrote:
> On Thu, Jan 24, 2019 at 4:44 AM Jani Nikula <jani.nikula@linux.intel.com> wrote:
> >
> > On Wed, 23 Jan 2019, Edwin Zimmerman <edwin@211mainstreet.net> wrote:
> > > On Wed, 23 Jan 2019, Jani Nikula <jani.nikula@linux.intel.com> wrote:
> > >> On Wed, 23 Jan 2019, Greg KH <gregkh@linuxfoundation.org> wrote:
> > >> > On Wed, Jan 23, 2019 at 03:03:47AM -0800, Kees Cook wrote:
> > >> >> Variables declared in a switch statement before any case statements
> > >> >> cannot be initialized, so move all instances out of the switches.
> > >> >> After this, future always-initialized stack variables will work
> > >> >> and not throw warnings like this:
> > >> >>
> > >> >> fs/fcntl.c: In function ‘send_sigio_to_task’:
> > >> >> fs/fcntl.c:738:13: warning: statement will never be executed [-Wswitch-unreachable]
> > >> >>    siginfo_t si;
> > >> >>              ^~
> > >> >
> > >> > That's a pain, so this means we can't have any new variables in { }
> > >> > scope except for at the top of a function?
> 
> Just in case this wasn't clear: no, it's just the switch statement
> before the first "case". I cannot imagine how bad it would be if we
> couldn't have block-scoped variables! Heh. :)

Sorry, it was not clear at first glance.  So no more objection from me
for this change.

greg k-h
