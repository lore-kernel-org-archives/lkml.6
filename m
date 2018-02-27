Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751847AbeB0Vlp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 16:41:45 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45468 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751568AbeB0Vln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 16:41:43 -0500
Date: Tue, 27 Feb 2018 15:41:42 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Robin Jarry <robin.jarry@6wind.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2 3/3] objtool: use global host flags for compilation
Message-ID: <20180227214142.4nrt22uita5qrm35@treble>
References: <cover.1519393674.git.robin.jarry@6wind.com>
 <cover.1519668832.git.robin.jarry@6wind.com>
 <2fa138b613417581eca23afd8741aaf75fbf966a.1519668832.git.robin.jarry@6wind.com>
 <20180227174932.e4pbucnwhducv7xr@treble>
 <20180227205523.cvzium5loc4km4qh@6wind.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180227205523.cvzium5loc4km4qh@6wind.com>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 09:55:23PM +0100, Robin Jarry wrote:
> 2018-02-27, Josh Poimboeuf:
> > On Mon, Feb 26, 2018 at 07:41:48PM +0100, Robin Jarry wrote:
> [snip]
> > >  ifdef CONFIG_STACK_VALIDATION
> > >    has_libelf := $(call try-run,\
> > > -		echo "int main() {}" | $(HOSTCC) -xc -o /dev/null -lelf -,1,0)
> > > +	echo "int main() {}" | $(HOSTCC) $(HOSTLDFLAGS) -xc -o /dev/null -lelf -,1,0)
> > 
> > This should probably also have HOSTCFLAGS, since the objtool makefile
> > uses it as well.
> 
> I had intentionally omitted HOSTCFLAGS since the compiled code does not
> contain any #include statements (only -lelf). But adding them cannot
> hurt.

Ah, right.  The point of this check is to see if it can find libelf, so
I guess using HOSTCFLAGS wouldn't have a point here.  So it's fine the
way it is.

-- 
Josh
