Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id h/mnD+oBHFvoagAAmS7hNA
	; Sat, 09 Jun 2018 16:49:34 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id AB4D4608BA; Sat,  9 Jun 2018 16:49:34 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="N8Q5hEa5"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 979C5605A2;
	Sat,  9 Jun 2018 16:49:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 979C5605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753439AbeFIQtb (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 12:49:31 -0400
Received: from imap.thunk.org ([74.207.234.97]:52944 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753188AbeFIQt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 12:49:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=HdjQ7sMz1uc7uUnYAzRVD7EL+tk9AD5nsOdKZewhQlY=; b=N8Q5hEa5gi2yosG6S29/igGJG0
        7MrkQtWcjNpdqvJMAq1QHk0+dAK54Odtp65yv8x6JcLOhxznHMW0YEg3OiQFbL1szvufuI8vHRDVa
        UuXxcNl2u2iuzsjT4vgjcuxsYdEqwgThTg9Yq2B1iytTrv56pJMV7VHePYM/eaZu/SRg=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fRh3K-0008Dn-Mt; Sat, 09 Jun 2018 16:49:22 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 0E81E7A4474; Sat,  9 Jun 2018 12:49:22 -0400 (EDT)
Date: Sat, 9 Jun 2018 12:49:21 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Kubecek <mkubecek@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Backlund <tmb@mageia.org>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: building in 32bit chroot on x86_64 host broken
Message-ID: <20180609164921.GA5020@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Kubecek <mkubecek@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Backlund <tmb@mageia.org>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <daf0fbba-6357-1748-d583-bcb5edf067ec@mageia.org>
 <CA+55aFwiyuA4fKztofM-fdDSc+ZH9aAR1xksL8ZWRDE-pdXruw@mail.gmail.com>
 <CAK7LNAS=PvYVrLczeJT0utq3UHNL5YtSE_w=RjJYJ3SD9ALrYA@mail.gmail.com>
 <CA+55aFzNCQZHEz9P2a4ZSyWB0RxZcTkh5TVfwTmup-Y-6b8qjw@mail.gmail.com>
 <CA+55aFwAwoDdZRP6n9xXDPkeCUm35mmGH3fXv=r1HOZq1bpiGw@mail.gmail.com>
 <CAK7LNAS4Xb_CQ31t_cqt3q0zRFZ-O2n3+qkxXfxZB_jmqvFmWQ@mail.gmail.com>
 <f1f35cdf-bd03-54bb-7196-c13131f7d0fc@mageia.org>
 <CA+55aFxe+LooLzpvBLwW9Ehwomp45zdJ3a-P71ipHJzdMmtDkQ@mail.gmail.com>
 <20180608091227.jbigan3vplns2oxk@unicorn.suse.cz>
 <CAK7LNAQrhBukG14-ggBWPBauB1shAiuZvESo70KrFxuOwhRJjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQrhBukG14-ggBWPBauB1shAiuZvESo70KrFxuOwhRJjg@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 09, 2018 at 09:23:55PM +0900, Masahiro Yamada wrote:
> Just a note.
> 
> In case of cross-compiling, not only ARCH but also CROSS_COMPILE
> must be passed when you do "make *config".

Sure, what was being discussed was people who build 32-bit x86 kernels
on a 64-bit platform.  I do this occasionally to check and make sure
that 32-compat ioctl handling is working correctly, etc.  I suspect
there are more developers setting just ARCH= and not CROSS_COMPILE
because they are building 32-bit x86 kernels (which can then be
trivially tested using qemu) than there are building cross-compiled
kernels for a completely different architecture.

I saw this thread and decided I didn't care because I use a standard
"kbuild32" script (I also have a "kbuild" script for building normal
64-bit kernels), and it always passes ARCH=i386.

					- Ted

#!/bin/bash

N=$(getconf _NPROCESSORS_ONLN)

if test -f .git/kbuild/config ; then
    . .git/kbuild/config
else
    echo "Missing kbuild configuration file!"
    exit 1
fi

if test ! -d "$BLD_DIR_32" ; then
    mkdir -p "$BLD_DIR_32"
    if test -f .git/kbuild/kernel-config ; then
	cp .git/kbuild/kernel-config-32 "$BLD_DIR_32/.config"
    fi
    for i in x509.genkey signing_key.pem signing_key.x509
    do
	if test -f ".git/kbuild/$i" ; then
	    mkdir -p "$BLD_DIR_32/certs"
	    cp ".git/kbuild/$i" "$BLD_DIR_32/certs"
	fi
    done
fi

time nice make O="$BLD_DIR_32" ARCH=i386 -j$N $*

cp "$BLD_DIR_32/.config" .git/kbuild/kernel-config-32
