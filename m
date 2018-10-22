Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48895C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 14:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA65020645
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 14:50:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA65020645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbeJVXJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 19:09:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52072 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727218AbeJVXJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 19:09:05 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 999F33001A49;
        Mon, 22 Oct 2018 14:50:13 +0000 (UTC)
Received: from krava (unknown [10.43.17.150])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0043561B82;
        Mon, 22 Oct 2018 14:50:07 +0000 (UTC)
Date:   Mon, 22 Oct 2018 16:50:07 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Len Brown <len.brown@intel.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Renninger <trenn@suse.com>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "Herton R. Krzesinski" <herton@redhat.com>
Subject: [PATCH 10/10] tools gpio: Override CFLAGS assignments
Message-ID: <20181022145007.GD2945@krava>
References: <20181016150614.21260-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016150614.21260-1-jolsa@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Mon, 22 Oct 2018 14:50:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 05:06:05PM +0200, Jiri Olsa wrote:
> hi,
> while hardening some of the tools rpm, we noticed we
> can't pass build flags to some of them. 
> 
> Sending separate tools fixes for what we found. It's
> mostly override for CFLAGS and adding LDFLAGS to the
> build commands.
> 
> thanks,
> jirka
> 
> 
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Markus Mayer <mmayer@broadcom.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Signed-off-by: Len Brown <len.brown@intel.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Thomas Renninger <trenn@suse.com>
> Cc: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> ---
> Jiri Olsa (10):
>       tools lib traceevent: Use LDFLAGS in the build commands
>       tools perf: Pass build flags to traceevent build
>       tools cpupower debug: Allow to use outside build flags
>       tools cpupower: Override CFLAGS assignments
>       tools power x86_energy_perf_policy: Override CFLAGS assignments and add LDFLAGS to build command
>       tools thermal tmon: Override CFLAGS assignments
>       tools thermal tmon: Use -O3 instead of -O1 if available
>       tools power turbostat: Override CFLAGS assignments and add LDFLAGS to build command
>       tools iio: Override CFLAGS assignments
>       tools gpio: Override CFLAGS assignments

the last one did not get post for some reason,
attaching it now

jirka


---
So user could specify outside CFLAGS values.

Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/gpio/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/gpio/Makefile b/tools/gpio/Makefile
index 240eda014b37..6ecdd1067826 100644
--- a/tools/gpio/Makefile
+++ b/tools/gpio/Makefile
@@ -12,7 +12,7 @@ endif
 # (this improves performance and avoids hard-to-debug behaviour);
 MAKEFLAGS += -r
 
-CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
+override CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
 
 ALL_TARGETS := lsgpio gpio-hammer gpio-event-mon
 ALL_PROGRAMS := $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))
-- 
2.17.2

