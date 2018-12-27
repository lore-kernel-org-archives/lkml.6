Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DFEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 05:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69752214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 05:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbeL0FZg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 00:25:36 -0500
Received: from ozlabs.org ([203.11.71.1]:56173 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbeL0FZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 00:25:35 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43QJFm4gYTz9s7W;
        Thu, 27 Dec 2018 16:25:32 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        "Masami Hiramatsu" <mhiramat@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [for-next][PATCH 09/24] seq_buf: Make seq_buf_puts() null-terminate the buffer
In-Reply-To: <20181221130532.532c51ea@gandalf.local.home>
References: <20181221175618.968519903@goodmis.org> <20181221175656.827708767@goodmis.org> <20181221130021.6e66484f@gandalf.local.home> <20181221130532.532c51ea@gandalf.local.home>
Date:   Thu, 27 Dec 2018 16:25:38 +1100
Message-ID: <87wonvy20d.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> writes:

> On Fri, 21 Dec 2018 13:00:21 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
>
>> > Can result in:
>> > 
>> >   Message is fooÂªÂªÂªÂªÂªsecret  
>> 
>> Sending this via quilt, and that we have non UTF8 characters causes
>> LKML to blow up.
>> 
>> There's a couple more patches with this issue. I'm going to fix up the
>> change logs and rebase them.
>
> Actually, this change log should have them. Bah, I'll just ignore it.
> The repo that gets pulled is fine.

Thanks, sorry for the bother. It doesn't really matter in this case
what's displayed, it's just an example.

cheers
