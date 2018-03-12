Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932277AbeCLWcj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 18:32:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52356 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751282AbeCLWci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 18:32:38 -0400
Date: Mon, 12 Mar 2018 23:32:34 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Daniel Borkmann <daniel@iogearbox.net>, Wangnan <wangnan0@huawei.com>
Subject: Re: [PATCH 11/13] perf bpf: Add helper header files
Message-ID: <20180312223234.GB14525@krava>
References: <20180312094313.18738-1-jolsa@kernel.org>
 <20180312094313.18738-12-jolsa@kernel.org>
 <20180312184455.bs2rk6qr3qrz7vmy@ast-mbp>
 <20180312192020.GA14525@krava>
 <20180312192551.GC10004@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312192551.GC10004@kernel.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 04:25:51PM -0300, Arnaldo Carvalho de Melo wrote:

SNIP

> > 
> > right, I kept this way, because it was already there for kernel,
> > so it was fast to write ;-)
> > 
> > but it's true we could leave it symbol based and have some sort of
> > dynamic loader behaviour.. but we'd need to sort out passing the
> > arguments in some generic form.. I'll check on that
> 
> Does this answer it or am I missing something?
> 
> Documentation/bpf/bpf_design_QA.txt
> 
> Q: Is BPF a generic virtual machine ?
> A: NO.
> 
> BPF is generic instruction set _with_ C calling convention.
> 
> Q: Why C calling convention was chosen?
> A: Because BPF programs are designed to run in the linux kernel
>    which is written in C, hence BPF defines instruction set compatible
>    with two most used architectures x64 and arm64 (and takes into
>    consideration important quirks of other architectures) and
>    defines calling convention that is compatible with C calling
>    convention of the linux kernel on those architectures.

hm right, but still we interpret the calls.. so we have to call
the function at the end

jirka
