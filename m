Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24246C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0C0020878
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="R5CIKaXY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0C0020878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732446AbeGLPxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 11:53:18 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:62709 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbeGLPxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 11:53:18 -0400
Received: from mail-vk0-f41.google.com (mail-vk0-f41.google.com [209.85.213.41]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id w6CFh9eo031714;
        Fri, 13 Jul 2018 00:43:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w6CFh9eo031714
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1531410190;
        bh=vuZvCl4bHLyz/pmSk+Hi8DvmA+NHdtowAQSAR0oIK50=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=R5CIKaXYv2ENUUBZiooof4LzpWqSm1V2ViWsE5WHnlt5rfB0IzsX/FSHa5YvEzGGS
         PVKSS2sVHFof6OaFty9ZjEYghKqU6ROROxMmTW4JBzOyjFQz2FzTfTB8FLB0rKJ99O
         i/Eg2Ii638U0z9UInHnN/k0uCkNiP9YteIMn0lNysyzY+J1AmzX1vxD0209PanVpyA
         ZRRJeB+lWtnoqPVlz2EewuBElOqYDE9Ivy0+Qs/pq7zdeaN1O/OYSBJK32VbDaBayA
         xeuQTTHBJZJvI1/1JYznCejFO2YGaT7qWUc1RPjUcsVmbQwvrSkqWBIHACeSh7hbkl
         s8Ft4oQ+1ubVw==
X-Nifty-SrcIP: [209.85.213.41]
Received: by mail-vk0-f41.google.com with SMTP id b77-v6so16583507vkb.5;
        Thu, 12 Jul 2018 08:43:09 -0700 (PDT)
X-Gm-Message-State: AOUpUlF87ZK4GgJzbddRHNV5og3XH6j5GGRQfmrPAkmRgzWE+zK9j9lg
        lbQYPmqrb/spCPSrWWGKkLL4M4049U682VbWLEw=
X-Google-Smtp-Source: AAOMgpe1kZXlTeCcJAy3LreOaMgCRNzjWNWSsbmsGFbAdqFv/rrbBV3lF2HQfAkKeO61JGeGA3ahVRWo9STQ5G7Jnqo=
X-Received: by 2002:a1f:2348:: with SMTP id j69-v6mr1531265vkj.160.1531410188622;
 Thu, 12 Jul 2018 08:43:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 08:42:28
 -0700 (PDT)
In-Reply-To: <20180710073833.GA7671@krava>
References: <20180710004602.21599-1-labbott@redhat.com> <20180710004602.21599-2-labbott@redhat.com>
 <20180710073833.GA7671@krava>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 13 Jul 2018 00:42:28 +0900
X-Gmail-Original-Message-ID: <CAK7LNARtugBJb5GEmqTD2PybznaRPX7Ho42P1OwKoCSaNfhNCA@mail.gmail.com>
Message-ID: <CAK7LNARtugBJb5GEmqTD2PybznaRPX7Ho42P1OwKoCSaNfhNCA@mail.gmail.com>
Subject: Re: [PATCHv2 1/7] tools: build: Fixup host c flags
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Laura Abbott <labbott@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Robin Jarry <robin.jarry@6wind.com>,
        Andi Kleen <andi@firstfloor.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-10 16:38 GMT+09:00 Jiri Olsa <jolsa@redhat.com>:
> On Mon, Jul 09, 2018 at 05:45:56PM -0700, Laura Abbott wrote:
>> Commit 0c3b7e42616f ("tools build: Add support for host programs format")
>> introduced host_c_flags which referenced CHOSTFLAGS. The actual name of the
>> variable is HOSTCFLAGS. Fix this up.
>>
>> Fixes: 0c3b7e42616f ("tools build: Add support for host programs format")
>> Signed-off-by: Laura Abbott <labbott@redhat.com>
>> ---
>> v2: Also fixed another instance in perf pmu-events.
>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
>
> cc-ing more folks, that were in initial patch for heads up
>
> thanks,
> jirka
>

Applied to linux-kbuild/fixes. Thanks!


>
>> ---
>>  tools/build/Build.include   | 2 +-
>>  tools/perf/pmu-events/Build | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/build/Build.include b/tools/build/Build.include
>> index a4bbb984941d..b5c679cd441c 100644
>> --- a/tools/build/Build.include
>> +++ b/tools/build/Build.include
>> @@ -98,4 +98,4 @@ cxx_flags = -Wp,-MD,$(depfile) -Wp,-MT,$@ $(CXXFLAGS) -D"BUILD_STR(s)=\#s" $(CXX
>>  ###
>>  ## HOSTCC C flags
>>
>> -host_c_flags = -Wp,-MD,$(depfile) -Wp,-MT,$@ $(CHOSTFLAGS) -D"BUILD_STR(s)=\#s" $(CHOSTFLAGS_$(basetarget).o) $(CHOSTFLAGS_$(obj))
>> +host_c_flags = -Wp,-MD,$(depfile) -Wp,-MT,$@ $(HOSTCFLAGS) -D"BUILD_STR(s)=\#s" $(HOSTCFLAGS_$(basetarget).o) $(HOSTCFLAGS_$(obj))
>> diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
>> index 17783913d330..215ba30b8534 100644
>> --- a/tools/perf/pmu-events/Build
>> +++ b/tools/perf/pmu-events/Build
>> @@ -1,7 +1,7 @@
>>  hostprogs := jevents
>>
>>  jevents-y    += json.o jsmn.o jevents.o
>> -CHOSTFLAGS_jevents.o = -I$(srctree)/tools/include
>> +HOSTCFLAGS_jevents.o = -I$(srctree)/tools/include
>>  pmu-events-y += pmu-events.o
>>  JDIR         =  pmu-events/arch/$(SRCARCH)
>>  JSON         =  $(shell [ -d $(JDIR) ] &&                            \
>> --
>> 2.17.1
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
