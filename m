Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A9CC28CF8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8817120870
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pd2rnbQM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8817120870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbeKUBxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 20:53:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:34930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726108AbeKUBxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 20:53:02 -0500
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 323E121104
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 15:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542727403;
        bh=0m8fh6LaecV4l9BymYlr9ywM/vB2zKc3lKgXEagCnzw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Pd2rnbQMTBRniufEDI/QymIySVDt8zGGCouBQVgS58HB6s0QdxJxIeUu8C2OzSYr+
         EicSxX4ylLFgBcdFWyKSXzKYt73/sUEwgb7QhuHaYGkVAOQ6FBvrkscO/QnBIto0rX
         tZIVRczeWU5hXzYSzeR6KrJ89Wno7c7ZB2LS6WPY=
Received: by mail-wm1-f50.google.com with SMTP id r63-v6so2512548wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 07:23:23 -0800 (PST)
X-Gm-Message-State: AA+aEWbFWTehPZflnDzjSZEsa6pNP3g9Uq3y6KG+Zaq4Dq/EvZbo+fBv
        Hw+SileL/R6Zd9wfWaVnRSMHWoFqlOxHE1DNsLBOwA==
X-Google-Smtp-Source: AFSGD/WfyccRIttMMi0ijAYsuVqSuHd2ERTiPj+2MJZEsxk5RZHFZFbWV+hs6xyw5UZZccOl9z4ZC17RClXnnJG0pW0=
X-Received: by 2002:a1c:110b:: with SMTP id 11mr2484611wmr.83.1542727401599;
 Tue, 20 Nov 2018 07:23:21 -0800 (PST)
MIME-Version: 1.0
References: <CALCETrVPcgKarpTOsdTfODkNA76W04WvW+tNWoOx6+Em0KS04A@mail.gmail.com>
 <87efbggly5.fsf@oldenburg.str.redhat.com>
In-Reply-To: <87efbggly5.fsf@oldenburg.str.redhat.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 20 Nov 2018 07:23:09 -0800
X-Gmail-Original-Message-ID: <CALCETrVJO-GSbQCGNJS_F1ZswG15aWOdX7onWFYgTVhh97WbWg@mail.gmail.com>
Message-ID: <CALCETrVJO-GSbQCGNJS_F1ZswG15aWOdX7onWFYgTVhh97WbWg@mail.gmail.com>
Subject: Re: Cleaning up numbering for new x86 syscalls?
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Andrew Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Tycho Andersen <tycho@tycho.ws>,
        Daniel Colascione <dancol@google.com>,
        "Carlos O'Donell" <carlos@redhat.com>,
        Rich Felker <dalias@libc.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 1:03 AM Florian Weimer <fweimer@redhat.com> wrote:
>
> * Andy Lutomirski:
>
> > 5. Adjust the scripts so that we only have to wire up new syscalls
> > once.  They'll have a nr above 1024, and they'll have the same nr on
> > all x86 variants.
>
> Is there a sufficiently sized gap on all other architectures as well?
> The restriction to the x86 variants seems arbitrary to me.
>

Fair point.  We have this shiny "generic" syscall list.  Maybe we can
get x86 synced up with it for new syscalls.
