Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932163AbeENNbL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 09:31:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:46828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752366AbeENNbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 09:31:10 -0400
Date: Mon, 14 May 2018 22:31:07 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Holger Freyther <automatic+kernel@freyther.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org,
        Holger Hans Peter Freyther <holgar+kernel@google.com>
Subject: Re: [RFC 0/6] perf probe: Attempt to improve C++ probing
Message-Id: <20180514223107.3ff9d8249ef41b8dd2957591@kernel.org>
In-Reply-To: <20180514041940.96126-1-automatic+kernel@freyther.de>
References: <20180514041940.96126-1-automatic+kernel@freyther.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 May 2018 12:19:34 +0800
Holger Freyther <automatic+kernel@freyther.de> wrote:

> From: Holger Hans Peter Freyther <holgar+kernel@google.com>
> 
> Currently perf probe -x app --funcs will list and demangle C++ functions
> but the other probe actions can't work with them. When asking probe to not
> demangle it will not list any of the application symbols creating the
> impression that there are no symbols at all.
> 
> Make --funcs --no-demangle list all C++ functions and modify the handling
> for listing code, variables and adding the uprobe work with the demangled
> C++ function name.
> 
> I tried to keep this as minimal as possible but having to keep the dso in
> the debuginfo and passing it everywhere to be able to demangle the linkage
> name isn't pretty (and for C++ demangling the struct dso is not of much
> use. Maybe having a static "empty" dso could avoid a lot of the changes).
> 
> Maybe the easiest first patch is to default to --no-demangle and change
> the DEFAULT_FUNC_FILTER to not include mangled C++ symbols. The remaining
> tooling would work then.
> 
> This has seen very little testing outside the following commands.
> 
> My test set includes:
> 
>  ./perf probe -x . -L "std::vector<int, std::allocator<int> >::at"
>  ./perf probe -x . -L "std::vector<int, std::allocator<int> >::at:2-3"
> 
>  ./perf probe -x . -V "std::vector<int, std::allocator<int> >::at"
>  ./perf probe -x . -V "std::vector<int, std::allocator<int> >::at:2"
>  ./perf probe -x . -V "std::vector<int, std::allocator<int> >::size%return"

OK, this series looks good to me :)

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
for this series.

Arnaldo, could you pull this series?

Thank you!


-- 
Masami Hiramatsu <mhiramat@kernel.org>
