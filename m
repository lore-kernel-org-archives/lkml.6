Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C473CC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B1E320870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbfAVNez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 08:34:55 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:59377 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728439AbfAVNey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 08:34:54 -0500
Received: from [192.168.1.110] ([95.115.125.104]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N8XgH-1hGgMQ3skD-014UWa; Tue, 22 Jan 2019 14:34:16 +0100
Subject: Re: Can we drop upstream Linux x32 support?
To:     =?UTF-8?Q?Thomas_Sch=c3=b6bel-Theuer?= <thomas@schoebel-theuer.de>,
        Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Florian Weimer <fweimer@redhat.com>,
        Mike Frysinger <vapier@gentoo.org>,
        "H. J. Lu" <hjl.tools@gmail.com>, Rich Felker <dalias@libc.org>,
        x32@buildd.debian.org, Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <CALCETrXoRAibsbWa9nfbDrt0iEuebMnCMhSFg-d9W-J2g8mDjw@mail.gmail.com>
 <6577ac4f-524c-37f4-a4d0-6eb94ec7d9a5@schoebel-theuer.de>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <d6542485-87ba-7d57-29bb-4077bda17809@metux.net>
Date:   Tue, 22 Jan 2019 14:34:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <6577ac4f-524c-37f4-a4d0-6eb94ec7d9a5@schoebel-theuer.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:rD4gPqfDS8uDAaui+3Odm720gyLN5PD9QPuVR7uVbs2xBcn/RIA
 z38WD1/2h2DKIwznN1xBg39nNxdaVFz9aIuGJiyecJ78IdLyKg041lH11JvpUkD2TP6JpfD
 dcfZ3spiK/3AhC4ZE9rGvPhQ7neUepikB3aZewOILruUeHJpmwEHuIJSnOjzbTxfvoO+IWN
 L9jkoT9salGmJh8fvtZQA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Snsp54M2tlI=:IPwgpVKhu/88TxZU/TFwxs
 +oFE0vGQj4YA97ySA8vc1GjCGVM6K6CcrG0EbNKhSlzPm6oyz97QeCPYbJ8/xWVSyKZfsSh+X
 Yd6s3m086yeANynZmnyw0uXTv731mGv418gkY27doO+pmzB4VkXfoBztPqbreriDhUfWf8Ohf
 Sdj7MH/LusNUglj31Z2A/q9NkbIlbRAMswjboWbsh1An9WgR2NJzHaZ/FR69tumaNDZPcZNEf
 dFiSFGILnTexdeLOqDa43ZvszblXuztZc1upcGOrOOnuEZQlRPs+Mi9/k0GlVpSVZ0uvQeBpa
 H9qKkbekhfFjaixs6aaup5cDLEXnhn/7GHJQnMHorG1BpLrW23PPWHMTjvy+Yfsyhs01Pvdme
 lQ6BCPxHDR8Ni6GNU5Gw3JQtrbHCW4GnjC3TA/cj5Qfahmku0XrJlD/tiTqcuv2M2qz8q4mKo
 hr63mrzojEi6YLJrGMuDNoQsXGKxp01+Oons5ZwM9RyW8XTmJRVRWqakT7FfhHrzKe5za03vd
 xF8Z3lL67fyIRwjZpad+T7Hk6/qJQdK1yayKYxcIC4yAcC3CoMmEWHZGZXEvbrPw3+XhnpnnC
 A5gCmflwGiDJ6EkPv7Hoox2dkhXRG6STmHXJJDa9UfC2L5hq1oLdZCuWMecIEOcFwEbyZlDNp
 BkWyCQ6B9HH2Dyd7SAdFpr0/ZqsKDphgOfMx4dBP3n1QEA987yTtkddB56a2YDFVsii/ciUG7
 kiHLrKejeAepA3dILI7qRSbUaA7goSbbKAPjtMu9aoyrBS8AVFMihqkPdwA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.12.18 22:16, Thomas Schöbel-Theuer wrote:

Hi,

> Currently, we have a few thousands of servers relying on 32bit ABIs in> some thousands of VMs and/or containers of various types (LXC,
OpenVZ,> etc).
Similar w/ my clients, but in Industrie/Embedded/i4.0 world. We have
thousands of devices in the field, that need support for at least a
decade.

Right now, I'm working on a new device, that - even having a 64bit cpu -
will still run 32bit userland for various reasons (memory footprint
is one of them).

Even on the data center side, where we have *a lot* of containers
(eg. container-based microservices on minimal distros like alpine
or ptxdist - as well as many different, often highly specialized,
legacy applications), 32bit userland indeed is a major factor.

Dropping it would have huge economic consequences:

* massive costs for re-deployment / migration of thousands of different
  applications
* field roll of thousands of different embedded / industrial devices,
  as a major cpu arch
* huge increase in memory consumption and io load in container-
  based microservice environments
* loosing x86 for a huge portion of the embedded / small devices world

I don't even dare to estimate the economic damage. (not even speaking
about reputation loss of the Linux community)

> Here is my private opinion, not speaking for 1&1: at some point the> future, 32bit userspace support needs to be dropped anyway, somewhen
in> future. This is inevitable in the very long term.

Very, very, long term. Just the devices I'm coping w/ will have
remaining lifetime of at least 10..15 years. That's a really long time
in IT world. Nobody knows whether x86 at all will play a big role then.

> 1) please release / declare a new LTS kernel, with upstream support for
> at least 5 years (as usual). Currently, only 4.4 and 4.9 are marked as
> LTS. Either mark another existing stable kernel as LTS, or a future one.

That might be okay in enterprise world (even though, here I'm regularily
stumbling across much older code in production), but in industrial
world, the product lifetimes are much longer - 20+yrs years
usualstandard.are pretty common.

--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
