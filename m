Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E037C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 07:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B8BB2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 07:47:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B8BB2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726041AbeLDHrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 02:47:46 -0500
Received: from lgeamrelo13.lge.com ([156.147.23.53]:52968 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725996AbeLDHrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 02:47:46 -0500
Received: from unknown (HELO lgemrelse6q.lge.com) (156.147.1.121)
        by 156.147.23.53 with ESMTP; 4 Dec 2018 16:47:44 +0900
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: namhyung@kernel.org
Received: from unknown (HELO sejong) (10.177.227.17)
        by 156.147.1.121 with ESMTP; 4 Dec 2018 16:47:44 +0900
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date:   Tue, 4 Dec 2018 16:47:39 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>, kernel-team@lge.com
Subject: Re: [PATCH 3/9] tools/lib/traceevent: Install trace-seq.h API header
 file
Message-ID: <20181204074739.GC16733@sejong>
References: <20181130154403.150474900@goodmis.org>
 <20181130154647.176265533@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181130154647.176265533@goodmis.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 10:44:06AM -0500, Steven Rostedt wrote:
> From: Tzvetomir Stoyanov <tstoyanov@vmware.com>
> 
> This patch installs trace-seq.h header file on "make install".
> 
> Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  tools/lib/traceevent/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/lib/traceevent/Makefile b/tools/lib/traceevent/Makefile
> index adb16f845ab3..67fe5d7ef190 100644
> --- a/tools/lib/traceevent/Makefile
> +++ b/tools/lib/traceevent/Makefile
> @@ -285,7 +285,7 @@ define do_install_pkgconfig_file
>  	fi
>  endef
>  
> -install_lib: all_cmd install_plugins install_pkgconfig
> +install_lib: all_cmd install_plugins install_headers install_pkgconfig
>  	$(call QUIET_INSTALL, $(LIB_TARGET)) \
>  		$(call do_install_mkdir,$(libdir_SQ)); \
>  		cp -fpR $(LIB_INSTALL) $(DESTDIR)$(libdir_SQ)
> @@ -302,6 +302,7 @@ install_headers:
>  	$(call QUIET_INSTALL, headers) \
>  		$(call do_install,event-parse.h,$(prefix)/include/traceevent,644); \
>  		$(call do_install,event-utils.h,$(prefix)/include/traceevent,644); \
> +		$(call do_install,trace-seq.h,$(prefix)/include/traceevent,644); \
>  		$(call do_install,kbuffer.h,$(prefix)/include/traceevent,644)

Do you still wanna have 'traceevent' directory prefix?  I just
sometimes feel a bit annoying to type it. ;-)

Or you can rename it something like 'tep' or 'libtep' - and hopefully
having only single header file to include..

Thanks,
Namhyung


>  
>  install: install_lib
> -- 
> 2.19.1
> 
> 
