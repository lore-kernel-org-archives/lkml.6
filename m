Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C9AC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 23:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77BA8217FA
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 23:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbeLWXBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 18:01:54 -0500
Received: from smtprelay0102.hostedemail.com ([216.40.44.102]:60671 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725895AbeLWXBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 18:01:54 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 71024182251B3;
        Sun, 23 Dec 2018 23:01:52 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: part92_10193fe49464d
X-Filterd-Recvd-Size: 2353
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Sun, 23 Dec 2018 23:01:50 +0000 (UTC)
Message-ID: <01c2fe1b83a56e958d1cd329741eaea5be82f47b.camel@perches.com>
Subject: Re: [for-next][PATCH 23/24] string.h: Add strncmp_prefix() helper
 macro
From:   Joe Perches <joe@perches.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andreas Schwab <schwab@linux-m68k.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Sun, 23 Dec 2018 15:01:49 -0800
In-Reply-To: <098d7abf-5b62-6a01-a370-97d96bece299@rasmusvillemoes.dk>
References: <20181221175618.968519903@goodmis.org>
         <20181221175659.208858193@goodmis.org>
         <CAHk-=wg_sR-UEC1ggmkZpypOUYanL5CMX4R7ceuaV4QMf5jBtg@mail.gmail.com>
         <20181221144054.20bdeb33@gandalf.local.home>
         <CAHk-=wgSvRhj6KNRdn9gbK9RJVAswdtKSNjAxdf9O9vn04T5XQ@mail.gmail.com>
         <20181221153526.5e6055ca@gandalf.local.home>
         <077eeb8b09baebe78822819b5f15d671b738a2b2.camel@perches.com>
         <20181221155435.38a9a221@gandalf.local.home> <871s6ad2br.fsf@igel.home>
         <20181221160826.34c544e6@gandalf.local.home>
         <84199633fd49db573c9ba71f1992936422e907d4.camel@perches.com>
         <098d7abf-5b62-6a01-a370-97d96bece299@rasmusvillemoes.dk>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-12-23 at 23:01 +0100, Rasmus Villemoes wrote:
> On 21/12/2018 23.20, Joe Perches wrote:
[]
> > static inline bool str_has_prefix(const char *str, const char prefix[])
[]
> We already have exactly that function, it's called strstarts().

Heh.  Thanks Rasmus.  I didn't remember that one.

I think the 'int str_has_prefix' naming and returning the prefix
length may be a bit better use than 'bool strstarts' and perhaps a
treewide conversion of the existing strstarts to str_has_prefix
would be OK as there aren't that many.

$ git grep -w strstarts | wc -l
91

