Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35D2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7178D2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfBTUdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:33:13 -0500
Received: from tartarus.angband.pl ([54.37.238.230]:34382 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbfBTUdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 15:33:13 -0500
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.89)
        (envelope-from <kilobyte@angband.pl>)
        id 1gwYYH-0004FW-2L; Wed, 20 Feb 2019 21:33:09 +0100
Date:   Wed, 20 Feb 2019 21:33:09 +0100
From:   Adam Borowski <kilobyte@angband.pl>
To:     Juerg Haefliger <juerg.haefliger@canonical.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        mingo@redhat.com, Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <shuahkhan@gmail.com>
Subject: Re: [PATCH] selftests/ftrace: Make the coloring POSIX compliant
Message-ID: <20190220203309.fdxhriqd6r5tacyt@angband.pl>
References: <20190220161333.28109-1-juergh@canonical.com>
 <20190220144934.22c52092@gandalf.local.home>
 <20190220211922.051fd2fc@smeagol>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190220211922.051fd2fc@smeagol>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 09:20:20PM +0100, Juerg Haefliger wrote:
> On Wed, 20 Feb 2019 14:49:34 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Wed, 20 Feb 2019 17:13:33 +0100
> > Juerg Haefliger <juerg.haefliger@canonical.com> wrote:
> > 
> > > echo -e and \e are not POSIX. Depending on what /bin/sh is, we can get
> > > incorrect output like:  
> > 
> > I'm curious to which shell this is.
> 
> Quite frankly I don't know but that's the output we get when we run it in
> Jenkins. I'll try to find out.

The only shell that did not support \e was dash -- I fixed it myself on
2017-01-24; thus I expect any Ubuntus prior to Zesty to require \033.  This
means your Jenkins likely runs Xenial.

\e has been supported since ages in at least: bash zsh mksh sash posh ksh
busybox:sh; also in perl python ruby lua php, gcc clang tcc -- MSVC being
the only other exception I know about.

Indeed POSIX doesn't specify \e, but as it pretends there are charsets other
than ASCII and EBCDIC, it can't.  There's no escape in its "portable
character set".


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀
⣾⠁⢠⠒⠀⣿⡁
⢿⡄⠘⠷⠚⠋⠀ Have you accepted Khorne as your lord and saviour?
⠈⠳⣄⠀⠀⠀⠀
