Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D19C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC2AD2080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544822684;
	bh=ekvsmSSSd58A4N1M0AKk5aYGsJQVH6wJr8GJVQFeMfI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KMfOnk0rwuwXHQft6yH/BLjeAO5/7U/iotsQnIV/7hYy7wa2tJJ8txNTvH3C/bZ8w
	 XMX7RT7Yh7JaStDpY/eTfuOzqRRpex2p5A7vMAgMqS4DoTutBOHOd64nHRutxuSUL6
	 /riZQdsrEduPqCLxjugOK4hdrFvVD3Fw0rXRzj7c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731014AbeLNVYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 16:24:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:34896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730734AbeLNVYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 16:24:42 -0500
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 443E52080F
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 21:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544822682;
        bh=ekvsmSSSd58A4N1M0AKk5aYGsJQVH6wJr8GJVQFeMfI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YsP1y1fktr0nPP9Kp7LSnZKrCYPdZGXBWlQSzc4nooCMikLxLt1ARmTEZtlsBgcLz
         X/E+fJFrMMT51xZRdxf48o/RuNQx4qNXUQKgwjgw53nVMaTfYen6wDuyJCvWkIGQxa
         7F+UXye2Ra28qLtfauOoTL1TBX9QQVfTQONH5xrk=
Received: by mail-wr1-f54.google.com with SMTP id x10so6743252wrs.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 13:24:41 -0800 (PST)
X-Gm-Message-State: AA+aEWYE9lI79lo89iH/zmOQwIMm29EONl4ci4PySOXDulVTvBBNfQMK
        bMvMn7aabisDetvFCjFR8KNmx7Z7gwPigOmNy4CtqQ==
X-Google-Smtp-Source: AFSGD/Xr0oPcx5hyOUr643I8wO/XQqjTcMu3x4coYOpBUe2M+R1QHLjnmSlx5QQGKr4/uZ9TAEF0fapeJuFcR6SM07A=
X-Received: by 2002:adf:ea81:: with SMTP id s1mr3737192wrm.309.1544822680404;
 Fri, 14 Dec 2018 13:24:40 -0800 (PST)
MIME-Version: 1.0
References: <CALCETrXoRAibsbWa9nfbDrt0iEuebMnCMhSFg-d9W-J2g8mDjw@mail.gmail.com>
 <6577ac4f-524c-37f4-a4d0-6eb94ec7d9a5@schoebel-theuer.de>
In-Reply-To: <6577ac4f-524c-37f4-a4d0-6eb94ec7d9a5@schoebel-theuer.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 14 Dec 2018 13:24:28 -0800
X-Gmail-Original-Message-ID: <CALCETrV0fVLZKG6JrOvzvOzP06UxhZW=LbHpPXbonoeFdPJB1A@mail.gmail.com>
Message-ID: <CALCETrV0fVLZKG6JrOvzvOzP06UxhZW=LbHpPXbonoeFdPJB1A@mail.gmail.com>
Subject: Re: Can we drop upstream Linux x32 support?
To:     thomas@schoebel-theuer.de
Cc:     Andrew Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 1:22 PM Thomas Sch=C3=B6bel-Theuer
<thomas@schoebel-theuer.de> wrote:
>
> On 12/11/18 02:23, Andy Lutomirski wrote:
> > I'm seriously considering sending a patch to remove x32 support from
> > upstream Linux.
>
> I am downstream maintainer of several self-patched kernels at 1&1 Ionos.
> The kernels are rolled out to several tenthousands of production servers
> running in several datacenters and in multiple continents.
>
> Currently, we have a few thousands of servers relying on 32bit ABIs in
> some thousands of VMs and/or containers of various types (LXC, OpenVZ, et=
c).

I should clarify again: I am not suggesting that we drop 32-bit
support in the forseeable future.  (Well, I might eventually suggest
that we drop support for 32-bit *hardware* at some point, but not for
32-bit compat software.)  Linux's compat code is quite robust and is
even fairly maintainable.

I'm talking about x32, which is a different beast.
