Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65227C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2925E2084C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s2o5yhbc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730185AbfBANpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 08:45:00 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33654 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726737AbfBANpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 08:45:00 -0500
Received: by mail-pg1-f193.google.com with SMTP id z11so2986890pgu.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 05:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xHfh3FDPNBOhulLTCdEMpftI/AyFp8P7FwKbx/0Dy+w=;
        b=s2o5yhbcy1Qem5uSJk0i5F5wwidgkO+za708iSH45pdTw5qqdo2PjB1StdNH2CGnxd
         gdFpzvsnoXnW9hKujtb8xWXWaNVoEYUV5rjDbHJVQFL5HUhYKJWtd9qrj+mvJRQI6Li/
         ez4yV49SG56fPdNvw4yGE9FqzabB05pv3vzmyvoFXbidHZgotdgV/UQy+nJx59VuuwZ2
         Pi3P42Tx7Crr3fop8JAMqwAN8iDwOG7qwQZQ+Pg1ncmw/e97StWT81dOLTNG4qNFcqWK
         8zPgeCmieRGn8CChcu/0Jsy29T8WJIlIrd0W3K48ELW0eJMEnwsakXsQEJnTjQU07UBu
         3A6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xHfh3FDPNBOhulLTCdEMpftI/AyFp8P7FwKbx/0Dy+w=;
        b=sdgrxMAmEW8p8iDggW1LUHyRWqDi+lX2J3IkH1LkiBZElF/2lFnLHPxKM4Rg59PW1L
         QoI+y7qF/lhBsgGoYGfY7fnXy/NTiDukmC8y4us5ZuGlD9sqDeoSPRpKrF9e83Rj9RFp
         t9cFVgAaMck0WgM1ts2tgc9I3SHyCtdvb0CkGbCeoBdd0Nx1FSCN1m4FE5uOld3II6mV
         1XvB8OVGjZa8nBrgI+ik3KyC97coh6uxpQTRefmtK1XJFyEmgkT3VvC66FRUFJQPmMDD
         1eduw19clKhdpukBTYqUKGwlB4/q4LF0U0QFxcKtwivNtx1atO3ntBhwmJvTjHUjAakv
         IgGQ==
X-Gm-Message-State: AHQUAuZDt5XhzwmNjoDm9JP/GdOhdP7qbCTszYynLpZa2KpjnnXP0mmt
        s8M9skhJuUoUD9WCGgbjsmFtTOrl
X-Google-Smtp-Source: AHgI3IZFQEfwVUkaBE2hLvzz99EvFQS6zrZPetW6DzY0bwxe5wusIAKArrRtJ9c3qRDlzttPwUnD0w==
X-Received: by 2002:a63:2e88:: with SMTP id u130mr2394692pgu.9.1549028698790;
        Fri, 01 Feb 2019 05:44:58 -0800 (PST)
Received: from mail.google.com ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id h185sm13100146pfg.143.2019.02.01.05.44.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 05:44:58 -0800 (PST)
Date:   Fri, 1 Feb 2019 21:44:52 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Wang Nan <wangnan0@huawei.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf record: Add doc for bpf event selection
Message-ID: <20190201134451.64dxa2k3q7fdw5yq@mail.google.com>
References: <20190201030641.4046-1-changbin.du@gmail.com>
 <20190201081050.GA8839@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201081050.GA8839@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sure, please check them in v2. Thanks!

On Fri, Feb 01, 2019 at 09:10:50AM +0100, Arnaldo Carvalho de Melo wrote:
> Em Fri, Feb 01, 2019 at 03:06:41AM +0000, Changbin Du escreveu:
> > Add document for how to pass bpf program with perf.
> 
> That is a good start, see some comments below.
>  
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  tools/perf/Documentation/perf-record.txt | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> > index d232b13ea713..0925d987cad0 100644
> > --- a/tools/perf/Documentation/perf-record.txt
> > +++ b/tools/perf/Documentation/perf-record.txt
> > @@ -88,6 +88,19 @@ OPTIONS
> >            If you want to profile write accesses in [0x1000~1008), just set
> >            'mem:0x1000/8:w'.
> >  
> > +        - a bpf source file or object file to select events by a bpf program.
> 
>              A source file (ending in .c) or a precompiled object file (ending in .o)
> 	     selects one or more BPF events.
> 
> > +          The bpf program can attach to variant perf events based on section
>              The BPFa                      various
> > +          names.
> > +
> > +          When passing '.c', perf searches installed LLVM to compile it into
>                                              a
> > +          object file first. Optional clang options can be pased by option
>            an
> > +          '--clang-opt'.
> > +
> > +          perf record --clang-opt "-DLINUX_VERSION_CODE=0x50000" \
> > +                      -e ./tests/bpf-script-example.c
> > +
> > +          Note: '--clang-opt' must place before '--event'.
> 
> Please mention ~/.perfconfig, that needs a section in the
> tools/perf/Documentation/perf-config.txt, for instance I have right now:
> 
> [root@quaco ~]# cat ~/.perfconfig
> [llvm]
> 	dump-obj = true
> 	clang-opt = -g
> 
> The 'clang-opt' is the same as the command line arg you documented
> above, dump object may be used to update a .o file, like:
> 
> [root@quaco ~]# vim /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.c 
>  
>  # Do some changes, save
> 
> [root@quaco ~]# perf record -e /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.c sleep 1
> LLVM: dumping /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.023 MB perf.data ]
> [root@quaco ~]# 
> 
> And if you are up to documenting the remaining features, which I'd
> encourage you, please take a look at:
> 
> tools/perf/util/llvm-utils.c
> 
> In the perf_llvm_config function. there are more things that needs
> documenting, and doing a:
> 
>   git blame tools/perf/util/llvm-utils.c
> 
> Helps in getting the needed explanations, for instance, the original
> patch adding the .perfconfig section was this:
> 
> git show aa61fd05ca796
> 
> And it has, for instance, among others:
> 
>             # kbuild directory. If not set, use /lib/modules/`uname -r`/build.
>             # If set to "" deliberately, skip kernel header auto-detector.
>             kbuild-dir = "/path/to/kernel/build"
> 
>             # Options passed to 'make' when detecting kernel header options.
>             kbuild-opts = "ARCH=x86_64"
> 
> Thanks for working on documenting these features!
> 
> - Arnaldo
> 
> 
> > +
> >  	- a group of events surrounded by a pair of brace ("{event1,event2,...}").
> >  	  Each event is separated by commas and the group should be quoted to
> >  	  prevent the shell interpretation.  You also need to use --group on
> > -- 
> > 2.17.1
> 
> -- 
> 
> - Arnaldo

-- 
Cheers,
Changbin Du
