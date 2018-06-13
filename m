Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D6B92C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B138208B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="E30cSz5J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B138208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935581AbeFMNfc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 09:35:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:58386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934508AbeFMNfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 09:35:31 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 252CF208AF;
        Wed, 13 Jun 2018 13:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528896930;
        bh=rFCPXgBOkZXr6wka1AGKo7pR6hgs0Qq09OM/htyz+NA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E30cSz5JPulnryzqoLoPom/sbe1b6puQ0d+MReFPtFik/wDw6qBq634x5OJ/4wM+R
         GJS0wKjHqLRrzl2VCpgSp6ui7tkpPIw0EpOJtj2x9s1SexGnf8nLGyLkNzum5/vdjS
         H3nSesDi18ZwN6aLamaMMcb0IN7lIkDp/j1XuIeo=
Date:   Wed, 13 Jun 2018 15:35:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jean Delvare <jdelvare@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas =?iso-8859-1?Q?Gr=FCnbacher?= 
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
Message-ID: <20180613133508.GA3291@kroah.com>
References: <20180612083449.100099222@infradead.org>
 <CA+55aFzLNFO1za9-Lb=jxO_F9NS0jZyti+we=ycr5NTpgzdEbw@mail.gmail.com>
 <CAHpGcMJSb4pqWF7X3K7yrk+N=FwcSrbjWm9xvprpaLRGgdE24A@mail.gmail.com>
 <CA+55aFx81igOjFZcvO03mvDFd3=pxsq2QuNrWrPW+4pvJy780A@mail.gmail.com>
 <20180613150025.62cf94ca@endymion>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180613150025.62cf94ca@endymion>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Jun 13, 2018 at 03:00:25PM +0200, Jean Delvare wrote:
> On Tue, 12 Jun 2018 12:23:26 -0700, Linus Torvalds wrote:
> > On Tue, Jun 12, 2018 at 11:52 AM Andreas Grünbacher
> > <andreas.gruenbacher@gmail.com> wrote:
> > >
> > > Quilt uses those Content-Disposition headers to preserve the patch
> > > filenames;  
> > 
> > That' what I was assuming, but does anybody really care?
> 
> Long ago (probably a decade by now, literally) I wrote a shell script
> named "rename-patch" for Greg KH which suggests a file name for a patch
> received by e-mail. The script first looks for a "filename" attribute
> in the Content-Disposition header, and only if not found, falls back to
> a heuristic which attempts to generate a good-looking file name based
> on the e-mail's subject.
> 
> The script used to be published on my kernel.org personal web space,
> but went away when kernel.org got hacked, and I never bothered
> publishing my few scripts again, sorry about that.
> 
> I'm still using that script myself, to name patches generated with "git
> show --pretty=email", however there is no Content-Disposition header
> there, so the subject heuristic is always used. I don't know if Greg is
> still using rename-patch in combination with quilt. Greg?

Yes I am, I also use it for other things, it's quite useful to me.  It's
attached below if anyone else wants it.

But I don't really use the Content-Disposition portion of the logic in
that script much, if any, anymore as I handle most of my normal kernel
work using git.  I only use quilt these days for local work before using
git, and for all of my stable kernel work.

So if that logic goes away in quilt, I'm not going to miss it :)

thanks,

greg k-h

--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=rename-patch

#!/bin/bash

# Rename patch files according to the Content-Disposition header line
# if they do have one, or Subject if they don't.
#
# Copyright (C) 2005, 2006, 2008  Jean Delvare <khali@linux-fr.org>
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details:
# http://www.gnu.org/copyleft/gpl.html
#
# The latest official version of this script can be found at:
# ftp://ftp.kernel.org/pub/linux/kernel/people/jdelvare/scripts/rename-patch

# Avoid nasty locale effects
export LC_ALL=C

findname()
{
	local file="$1" pattern;

	# Try Content-Disposition first
	pattern='^Content-Disposition:[[:space:]]*inline[[:space:]]*;[[:space:]]*filename[[:space:]]*=';
	if grep -q $pattern "$file"
	then
		sed -ne "/$pattern/{s/$pattern[[:space:]]*//p;q}" "$file"
		return
	fi

	# Fallback to Subject
	pattern='^Subject:';
	if grep -q $pattern "$file"
	then
		sed -ne "/$pattern/{
			s/$pattern[[:space:]]*//;
			s/\[[^]]*\]//g;
			s/[^a-z0-9._-]/-/ig;
			s/--*/-/g;
			s/^-//;
			s/^re-//i;
			s/[.-]*$/.patch/;
			p;q}" "$file" | \
		tr A-Z a-z
		return
	fi
}

if [ $# -eq 0 ]
then
	echo "Usage: rename-patch file [file...]" >&2
	exit 1
fi

for file in "$@"
do
	name=$(findname "$file")
	if echo "$file" | grep -q '/'
	then
		path=$(echo "$file" | sed -e 's/\/[^/]*$/\//')
	else
		path=''
	fi

	if [ -z "$name" ]
	then
		echo "No name found for $file" >&2
		continue
	fi

	if [ "$path$name" == "$file" ]
	then
		# It's already OK
		continue
	fi

	if [ -e "$path$name" ]
	then
		echo "Can't rename $file to $path$name which already exists" >&2
		continue
	fi

	mv -f "$file" "$path$name"
#	echo "$file renamed to $path$name"
	echo "$path$name"
done

--PEIAKu/WMn1b1Hv9--
