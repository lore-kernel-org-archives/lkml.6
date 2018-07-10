Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3C3C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 07:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24B0320877
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 07:38:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24B0320877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751267AbeGJHii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 03:38:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53680 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751047AbeGJHig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 03:38:36 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AAD6B401CC41;
        Tue, 10 Jul 2018 07:38:35 +0000 (UTC)
Received: from krava (unknown [10.43.17.196])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9DFCD111DD15;
        Tue, 10 Jul 2018 07:38:33 +0000 (UTC)
Date:   Tue, 10 Jul 2018 09:38:33 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Laura Abbott <labbott@redhat.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robin Jarry <robin.jarry@6wind.com>,
        Andi Kleen <andi@firstfloor.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCHv2 1/7] tools: build: Fixup host c flags
Message-ID: <20180710073833.GA7671@krava>
References: <20180710004602.21599-1-labbott@redhat.com>
 <20180710004602.21599-2-labbott@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710004602.21599-2-labbott@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 10 Jul 2018 07:38:35 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 10 Jul 2018 07:38:35 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 05:45:56PM -0700, Laura Abbott wrote:
> Commit 0c3b7e42616f ("tools build: Add support for host programs format")
> introduced host_c_flags which referenced CHOSTFLAGS. The actual name of the
> variable is HOSTCFLAGS. Fix this up.
> 
> Fixes: 0c3b7e42616f ("tools build: Add support for host programs format")
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
> v2: Also fixed another instance in perf pmu-events.

Acked-by: Jiri Olsa <jolsa@kernel.org>

cc-ing more folks, that were in initial patch for heads up

thanks,
jirka


> ---
>  tools/build/Build.include   | 2 +-
>  tools/perf/pmu-events/Build | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/build/Build.include b/tools/build/Build.include
> index a4bbb984941d..b5c679cd441c 100644
> --- a/tools/build/Build.include
> +++ b/tools/build/Build.include
> @@ -98,4 +98,4 @@ cxx_flags = -Wp,-MD,$(depfile) -Wp,-MT,$@ $(CXXFLAGS) -D"BUILD_STR(s)=\#s" $(CXX
>  ###
>  ## HOSTCC C flags
>  
> -host_c_flags = -Wp,-MD,$(depfile) -Wp,-MT,$@ $(CHOSTFLAGS) -D"BUILD_STR(s)=\#s" $(CHOSTFLAGS_$(basetarget).o) $(CHOSTFLAGS_$(obj))
> +host_c_flags = -Wp,-MD,$(depfile) -Wp,-MT,$@ $(HOSTCFLAGS) -D"BUILD_STR(s)=\#s" $(HOSTCFLAGS_$(basetarget).o) $(HOSTCFLAGS_$(obj))
> diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
> index 17783913d330..215ba30b8534 100644
> --- a/tools/perf/pmu-events/Build
> +++ b/tools/perf/pmu-events/Build
> @@ -1,7 +1,7 @@
>  hostprogs := jevents
>  
>  jevents-y	+= json.o jsmn.o jevents.o
> -CHOSTFLAGS_jevents.o	= -I$(srctree)/tools/include
> +HOSTCFLAGS_jevents.o	= -I$(srctree)/tools/include
>  pmu-events-y	+= pmu-events.o
>  JDIR		=  pmu-events/arch/$(SRCARCH)
>  JSON		=  $(shell [ -d $(JDIR) ] &&				\
> -- 
> 2.17.1
> 
