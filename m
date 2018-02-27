Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751903AbeB0Uzk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 15:55:40 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:32905 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751628AbeB0Uzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 15:55:38 -0500
X-Google-Smtp-Source: AG47ELuOU2Bnhf2qBuIvmYcCKK/t0ItC9D5Q052JQFhkjv4sYN1k9zX3hgVx+CxX8JKnb27/4dHPQw==
Date: Tue, 27 Feb 2018 21:55:23 +0100
From: Robin Jarry <robin.jarry@6wind.com>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2 3/3] objtool: use global host flags for compilation
Message-ID: <20180227205523.cvzium5loc4km4qh@6wind.com>
References: <cover.1519393674.git.robin.jarry@6wind.com>
 <cover.1519668832.git.robin.jarry@6wind.com>
 <2fa138b613417581eca23afd8741aaf75fbf966a.1519668832.git.robin.jarry@6wind.com>
 <20180227174932.e4pbucnwhducv7xr@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180227174932.e4pbucnwhducv7xr@treble>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-27, Josh Poimboeuf:
> On Mon, Feb 26, 2018 at 07:41:48PM +0100, Robin Jarry wrote:
[snip]
> >  ifdef CONFIG_STACK_VALIDATION
> >    has_libelf := $(call try-run,\
> > -		echo "int main() {}" | $(HOSTCC) -xc -o /dev/null -lelf -,1,0)
> > +	echo "int main() {}" | $(HOSTCC) $(HOSTLDFLAGS) -xc -o /dev/null -lelf -,1,0)
> 
> This should probably also have HOSTCFLAGS, since the objtool makefile
> uses it as well.

I had intentionally omitted HOSTCFLAGS since the compiled code does not
contain any #include statements (only -lelf). But adding them cannot
hurt.

-- 
Robin
