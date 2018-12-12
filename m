Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68392C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B76120849
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:12:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B76120849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbeLLJMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 04:12:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57116 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbeLLJMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 04:12:21 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E9451308220F;
        Wed, 12 Dec 2018 09:12:20 +0000 (UTC)
Received: from krava (unknown [10.43.17.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id EA78E5C26E;
        Wed, 12 Dec 2018 09:12:15 +0000 (UTC)
Date:   Wed, 12 Dec 2018 10:12:14 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        "Herton R. Krzesinski" <herton@redhat.com>
Subject: [PATCHv3 01/10] tools lib traceevent: Use LDFLAGS in the build
 commands
Message-ID: <20181212091214.GC17489@krava>
References: <20181016150614.21260-1-jolsa@kernel.org>
 <20181016150614.21260-2-jolsa@kernel.org>
 <20181016112136.3a72a452@gandalf.local.home>
 <20181016154526.GC6631@krava>
 <20181017102341.53412998@gandalf.local.home>
 <20181116130158.GA30583@krava>
 <20181122093006.GD15953@krava>
 <20181128135641.GD31608@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128135641.GD31608@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 12 Dec 2018 09:12:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 10:56:41AM -0300, Arnaldo Carvalho de Melo wrote:

SNIP

>     LD       /tmp/build/perf/libtraceevent-in.o
>   MKDIR    /tmp/build/perf/util/
>   LINK     /tmp/build/perf/libtraceevent.a
>   CC       /tmp/build/perf/util/block-range.o
>   MKDIR    /tmp/build/perf/arch/
>   CC       /tmp/build/perf/arch/common.o
>   LD       /tmp/build/perf/plugin_mac80211-in.o
>   CC       /tmp/build/perf/plugin_sched_switch.o
>   LD       /tmp/build/perf/plugin_sched_switch-in.o
>   CC       /tmp/build/perf/plugin_function.o
>   LD       /tmp/build/perf/plugin_function-in.o
>   CC       /tmp/build/perf/plugin_xen.o
>   MKDIR    /tmp/build/perf/arch/arm/util/
>   CC       /tmp/build/perf/arch/arm/util/pmu.o
>   LD       /tmp/build/perf/plugin_xen-in.o
>   CC       /tmp/build/perf/plugin_scsi.o
>   CC       /tmp/build/perf/plugin_cfg80211.o
>   LD       /tmp/build/perf/plugin_scsi-in.o
>   LD       /tmp/build/perf/plugin_cfg80211-in.o
>   MKDIR    /tmp/build/perf/arch/arm/util/
>   CC       /tmp/build/perf/arch/arm/util/auxtrace.o
>   CC       /tmp/build/perf/arch/arm/util/cs-etm.o
>   LINK     /tmp/build/perf/plugin_jbd2.so
> /opt/android-ndk-r12b/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/bin/../lib/gcc/arm-linux-androideabi/4.9.x/../../../../arm-linux-androideabi/bin/ld: error: cannot find -lc
> /opt/android-ndk-r12b/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/bin/../lib/gcc/arm-linux-androideabi/4.9.x/../../../../arm-linux-androideabi/bin/ld: error: cannot find -ldl
> collect2: error: ld returned 1 exit status
> Makefile:196: recipe for target '/tmp/build/perf/plugin_jbd2.so' failed
> make[3]: *** [/tmp/build/perf/plugin_jbd2.so] Error 1
> Makefile.perf:669: recipe for target 'libtraceevent_plugins' failed
> make[2]: *** [libtraceevent_plugins] Error 2
> make[2]: *** Waiting for unfinished jobs....
> 
> 

SNIP

>    1    59.08 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0
>    2    68.75 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822
>    3    79.67 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0
>    4    48.69 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0
>    5    46.89 alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0
>    6    46.46 alpine:edge                   : Ok   gcc (Alpine 6.4.0) 6.4.0
>    7    38.46 amazonlinux:1                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-28)
>    8    44.69 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180303 (Red Hat 7.3.1-5)
>    9    41.88 android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
>   10    46.24 android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
>   11    22.22 centos:5                      : Ok   gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
>   12    35.54 centos:6                      : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23)

ok, I shouldn't have taken out the CFLAGS,
some build scripts depends on it already

attaching v2

thanks,
jirka


---
So user could specify outside LDFLAGS values.

Keeping the CFLAGS in there as well, so we don't break
existing script.

Cc: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/traceevent/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/traceevent/Makefile b/tools/lib/traceevent/Makefile
index 67fe5d7ef190..941761d9923d 100644
--- a/tools/lib/traceevent/Makefile
+++ b/tools/lib/traceevent/Makefile
@@ -177,7 +177,7 @@ $(TE_IN): force
 	$(Q)$(MAKE) $(build)=libtraceevent
 
 $(OUTPUT)libtraceevent.so.$(EVENT_PARSE_VERSION): $(TE_IN)
-	$(QUIET_LINK)$(CC) --shared $^ -Wl,-soname,libtraceevent.so.$(EP_VERSION) -o $@
+	$(QUIET_LINK)$(CC) --shared $(LDFLAGS) $^ -Wl,-soname,libtraceevent.so.$(EP_VERSION) -o $@
 	@ln -sf $(@F) $(OUTPUT)libtraceevent.so
 	@ln -sf $(@F) $(OUTPUT)libtraceevent.so.$(EP_VERSION)
 
@@ -196,7 +196,7 @@ $(PLUGINS_IN): force
 	$(Q)$(MAKE) $(build)=$(plugin_obj)
 
 $(OUTPUT)%.so: $(OUTPUT)%-in.o
-	$(QUIET_LINK)$(CC) $(CFLAGS) -shared -nostartfiles -o $@ $^
+	$(QUIET_LINK)$(CC) $(CFLAGS) -shared $(LDFLAGS) -nostartfiles -o $@ $^
 
 define make_version.h
   (echo '/* This file is automatically generated. Do not modify. */';		\
-- 
2.17.2

