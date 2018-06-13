Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0E6D1C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C25D8208B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:00:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C25D8208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935646AbeFMNAb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 09:00:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:40548 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935346AbeFMNA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 09:00:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4EEDFAD4B;
        Wed, 13 Jun 2018 13:00:28 +0000 (UTC)
Date:   Wed, 13 Jun 2018 15:00:25 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Andreas =?UTF-8?B?R3LDvG5iYWNoZXI=?= 
        <andreas.gruenbacher@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        quilt-dev@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [Quilt-dev] Quilt vs gmail
Message-ID: <20180613150025.62cf94ca@endymion>
In-Reply-To: <CA+55aFx81igOjFZcvO03mvDFd3=pxsq2QuNrWrPW+4pvJy780A@mail.gmail.com>
References: <20180612083449.100099222@infradead.org>
        <CA+55aFzLNFO1za9-Lb=jxO_F9NS0jZyti+we=ycr5NTpgzdEbw@mail.gmail.com>
        <CAHpGcMJSb4pqWF7X3K7yrk+N=FwcSrbjWm9xvprpaLRGgdE24A@mail.gmail.com>
        <CA+55aFx81igOjFZcvO03mvDFd3=pxsq2QuNrWrPW+4pvJy780A@mail.gmail.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jun 2018 12:23:26 -0700, Linus Torvalds wrote:
> On Tue, Jun 12, 2018 at 11:52 AM Andreas Grünbacher
> <andreas.gruenbacher@gmail.com> wrote:
> >
> > Quilt uses those Content-Disposition headers to preserve the patch
> > filenames;  
> 
> That' what I was assuming, but does anybody really care?

Long ago (probably a decade by now, literally) I wrote a shell script
named "rename-patch" for Greg KH which suggests a file name for a patch
received by e-mail. The script first looks for a "filename" attribute
in the Content-Disposition header, and only if not found, falls back to
a heuristic which attempts to generate a good-looking file name based
on the e-mail's subject.

The script used to be published on my kernel.org personal web space,
but went away when kernel.org got hacked, and I never bothered
publishing my few scripts again, sorry about that.

I'm still using that script myself, to name patches generated with "git
show --pretty=email", however there is no Content-Disposition header
there, so the subject heuristic is always used. I don't know if Greg is
still using rename-patch in combination with quilt. Greg?

> If you do things one patch at a time, maybe it's convenient, but then
> it doesn't sound like a huge win either.
> 
> And if you do a patch-series, then it won't work anyway, and you'd be
> saving to an mbox or something. Unless people save patch-series things
> one by one, but at that point "convenient" is no longer an issue.

I'm not sure why it wouldn't work with a series. The name information
is available in each patch of the series, and I know that some kernel
developers have all sorts of shortcuts and macros implemented on top of
their MUA to automate queuing of patches for various testing or
publishing purposes.

-- 
Jean Delvare
SUSE L3 Support
