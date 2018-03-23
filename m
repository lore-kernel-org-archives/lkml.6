Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751962AbeCWJJb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 05:09:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36588 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751790AbeCWJJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 05:09:30 -0400
Date: Fri, 23 Mar 2018 10:09:27 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Quentin Monnet <quentin.monnet@netronome.com>,
        Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] bpf: Remove struct bpf_verifier_env argument from
 print_bpf_insn
Message-ID: <20180323090927.GA4096@krava>
References: <20180321150212.5586-1-jolsa@kernel.org>
 <d28f0a7f-3721-88f3-f4e9-97a73a8833e5@netronome.com>
 <20180321183749.GF2707@krava>
 <e30c5b79-c2a9-d0ed-e626-bf81a0705805@iogearbox.net>
 <20180322133222.GB3206@krava>
 <efa1cd74-12f4-2ac6-cc9a-50669b4b69de@netronome.com>
 <20180322155723.GD3206@krava>
 <96093da6-9e0f-5d6b-59a4-91a744ad64cb@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96093da6-9e0f-5d6b-59a4-91a744ad64cb@iogearbox.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2018 at 05:07:48PM +0100, Daniel Borkmann wrote:

SNIP

> >>> +	va_end(args);
> >>> +}
> >>>  EXPORT_SYMBOL_GPL(bpf_verifier_log_write);
> >>> +
> >>> +__printf(2, 3) static void print_ins(void *private_data,
> >>> +				     const char *fmt, ...)
> >>
> >> Unless I am mistaken, you could just call this one "verbose()" and
> >> simply remove the function alias?
> > 
> > right you are ;-) I haven't realized that struct bpf_verifier_env *env
> > will cleanly cast to void * 
> > 
> > new version attached.. I'll make some tests and send full patch
> 
> When you do so, please make sure to send a full fresh series with the two
> patches and also cover letter included, otherwise it's more fragile wrt
> potentially applying the wrong patch from one of the replies. :-)

will do, thanks

jirka
