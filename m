Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752812AbeDRPFh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 11:05:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:43644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751836AbeDRPFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 11:05:36 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD13A2178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Wed, 18 Apr 2018 12:05:16 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        systemtap@sourceware.org, Mark Wielaard <mark@klomp.org>
Subject: Re: perf probe line numbers + CONFIG_DEBUG_INFO_SPLIT=y
Message-ID: <20180418150516.GB10084@kernel.org>
References: <20180417174701.GD3625@kernel.org>
 <20180418122343.67575c580c0dc5cf11b6ddeb@kernel.org>
 <20180418230301.fd26676ece5b2dc16d98b266@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180418230301.fd26676ece5b2dc16d98b266@kernel.org>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 18, 2018 at 11:03:01PM +0900, Masami Hiramatsu escreveu:
> And I found below description in systemtap document(man/error::dwarf.7stap).
> ===
> debuginfo configuration
> Some tools may generate debuginfo that is unsupported by systemtap, such
> as the linux kernel CONFIG_DEBUG_INFO_SPLIT (\f2.dwo\f1 files) option.
> Stick with plain ELF/DWARF (optinally split, Fedora-style), if possible.
> ===
 
> So, it seems that elfutils may not support this split debuginfo yet.

Ok, what about detecting that this is the case: .dwo is being used, as
detected by the presence of those .debug_*.dwo ELF sections and then
warning the user that this mode of operation is not supported yet?

- Arnaldo
