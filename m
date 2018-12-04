Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B56AC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 07:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8EBD214D9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 07:32:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8EBD214D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbeLDHch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 02:32:37 -0500
Received: from lgeamrelo11.lge.com ([156.147.23.51]:36300 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbeLDHch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 02:32:37 -0500
Received: from unknown (HELO lgeamrelo04.lge.com) (156.147.1.127)
        by 156.147.23.51 with ESMTP; 4 Dec 2018 16:32:35 +0900
X-Original-SENDERIP: 156.147.1.127
X-Original-MAILFROM: namhyung@kernel.org
Received: from unknown (HELO sejong) (10.177.227.17)
        by 156.147.1.127 with ESMTP; 4 Dec 2018 16:32:35 +0900
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date:   Tue, 4 Dec 2018 16:32:35 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>, kernel-team@lge.com
Subject: Re: [PATCH 2/9] tools/lib/traceevent: Added support for pkg-config
Message-ID: <20181204073235.GB16733@sejong>
References: <20181130154403.150474900@goodmis.org>
 <20181130154647.022471992@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181130154647.022471992@goodmis.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Fri, Nov 30, 2018 at 10:44:05AM -0500, Steven Rostedt wrote:
> From: Tzvetomir Stoyanov <tstoyanov@vmware.com>
> 
> This patch implements integration with pkg-config framework.
> pkg-config can be used by the library users to determine
> required CFLAGS and LDFLAGS in order to use the library
> 
> Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---

[SNIP]
> diff --git a/tools/lib/traceevent/libtraceevent.pc.template b/tools/lib/traceevent/libtraceevent.pc.template
> new file mode 100644
> index 000000000000..42e4d6cb6b9e
> --- /dev/null
> +++ b/tools/lib/traceevent/libtraceevent.pc.template
> @@ -0,0 +1,10 @@
> +prefix=INSTALL_PREFIX
> +libdir=${prefix}/lib64

Don't we care 32-bit systems anymore? :)

Thanks,
Namhyung


> +includedir=${prefix}/include/traceevent
> +
> +Name: libtraceevent
> +URL: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> +Description: Linux kernel trace event library
> +Version: LIB_VERSION
> +Cflags: -I${includedir}
> +Libs: -L${libdir} -ltraceevent
> -- 
> 2.19.1
> 
> 
