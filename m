Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212A8C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3A14208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3nLEPVs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3A14208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729580AbeJEXYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:24:07 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36790 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729459AbeJEXOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:14:18 -0400
Received: by mail-wm1-f65.google.com with SMTP id a8-v6so2436048wmf.1;
        Fri, 05 Oct 2018 09:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KsOXf+04nO1i9Fx25nBAdv1HqIVCeXklXULnIBURjDc=;
        b=A3nLEPVspuqH/lNpAXDWSReVi3ylY83PHg1ZrZor1Mcmcr1e6unO8BuOHUWqCIM4oO
         vmGtTH1Q46ScgCEwpi7pJYedcazbXEQaJPvdKkZV5F0+MZpeV0ngi7A72lyCWZB8SCHm
         qY8XiOiTmSTGk6XGswoFRImOxoz9xKk41tmZW6D2IcGdaTH4vEcobuIAqU7lU5/0KByJ
         WEzFjSAWlFX5GFUl5wdwtR5NoEtikv71EplGp1qjrGSxcg5QzDVQ0A2aq2ZUv6C0zwya
         01XkWT7cwjGFU6Zs8LBKLsK3yO5PtuWXrj8p92WfWmKvoOdLnWgCkC0QOYLTAeoEz5PC
         J4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KsOXf+04nO1i9Fx25nBAdv1HqIVCeXklXULnIBURjDc=;
        b=MOG47iXlFGyWGE2KiNUQxRDx987U8WcRoydzG1ufl669ShScNWQUXaxQ2AFhXbEXii
         PLT3XrCXYffYOOFKJ/jVEJp9XR+AWZ9ATKVx19uQKb7HXvl6MwyHXXCP2Ikqq2JskUCD
         NL/plXonOQjAXsbjI8KleiMQY+8cLGHidNGCRBBH+JYyswGp0ahHZZUPWxv3453X2V39
         xMavDooPiqAokI7uKcfsdP24M+BOcmloNG3H9rYE3EhBvYham4aA1F9NE8Or0wjZgJee
         qYwuuIa8HPEikmZ1iHPz8kaO2zDvmUmh3QHcg9yumBpp5l72b51Pz7RFs1I+jfVIhxUV
         /BNA==
X-Gm-Message-State: ABuFfojTrd6BBpz2OfwJ5wBFuXNEd+8kgSKH86gJHxQ1cmhgJeaFMZUF
        7ext/LNJnOqm2Q3njTAe4Xc=
X-Google-Smtp-Source: ACcGV62pIxWj5DU4Ny8CV4AYV/Eq30vpA3Xuq/GabYIY8IO8f0J9xPXtbQNKCsnlMETskSh5qxQz2A==
X-Received: by 2002:a1c:6655:: with SMTP id a82-v6mr4906931wmc.10.1538756093620;
        Fri, 05 Oct 2018 09:14:53 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id g186-v6sm2726696wmf.19.2018.10.05.09.14.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 09:14:53 -0700 (PDT)
Date:   Fri, 5 Oct 2018 18:14:50 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Milian Wolff <milian.wolff@kdab.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Sandipan Das <sandipan@linux.ibm.com>, stable@vger.kernel.org,
        Thiago Macieira <thiago.macieira@intel.com>,
        Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 0/5] perf/urgent fixes
Message-ID: <20181005161450.GA73272@gmail.com>
References: <20181005161012.18475-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005161012.18475-1-acme@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 5d05dfd13f20b01a3cd5d293058baa7d5c1583b6:
> 
>   Merge tag 'perf-urgent-for-mingo-4.19-20180918' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2018-09-19 13:25:35 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-4.19-20181005
> 
> for you to fetch changes up to 7a8a8fcf7b860e4b2d4edc787c844d41cad9dfcf:
> 
>   perf record: Use unmapped IP for inline callchain cursors (2018-10-05 11:18:09 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> - Fix the build on Clear Linux, coping with redundant declarations of
>   function prototypes in python3 header files by adding
>   -Wno-redundant-decls to build with PYTHON=python3 (Arnaldo Carvalho de Melo)
> 
> - Fixes for processing inline frames in backtraces using DWARF based
>   unwinding (Milian Wolff)
> 
> - Cope with bad DWARF info for function names for inline frames,not
>   trying to demangle this symbol. Problem reported with rust but
>   reproduced as well with C++. Problem reported to the libbpf
>   maintainers (Milian Wolff)
> 
> - Fix python export to postgresql and sqlite code (Adrian Hunter)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Adrian Hunter (2):
>       perf script python: Fix export-to-postgresql.py occasional failure
>       perf script python: Fix export-to-sqlite.py sample columns
> 
> Arnaldo Carvalho de Melo (1):
>       perf python: Use -Wno-redundant-decls to build with PYTHON=python3
> 
> Milian Wolff (2):
>       perf report: Don't try to map ip to invalid map
>       perf record: Use unmapped IP for inline callchain cursors
> 
>  tools/perf/scripts/python/export-to-postgresql.py | 9 +++++++++
>  tools/perf/scripts/python/export-to-sqlite.py     | 6 +++++-
>  tools/perf/util/machine.c                         | 8 +++++---
>  tools/perf/util/setup.py                          | 2 +-
>  4 files changed, 20 insertions(+), 5 deletions(-)

Pulled into tip:perf/urgent, thanks a lot Arnaldo!

	Ingo
