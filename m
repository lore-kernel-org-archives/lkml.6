Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F085C04EBC
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 12:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE91E208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 12:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qRKuYzeu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE91E208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729532AbeK0Xdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 18:33:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:34046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726407AbeK0Xdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 18:33:45 -0500
Received: from quaco.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EF0920989;
        Tue, 27 Nov 2018 12:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543322156;
        bh=M+Joe5G5+y/CIjEN648gk1/V8EBD7KYTyecF4Sj6yJg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qRKuYzeuguXFtRfcNHIb1fr3K8OrltwI9bccsXANrEqmsQaTOqpeTflAjrRtXJrVO
         vG1Aq2JnN4dNrCUnk1vPyj/+5p8BewKzUJeaT2MG60xUUCi3w7sgfDRrK0duFr0+O8
         WxpQ8K5nmEw6hWW+qkrEuIYa1ZMYdEV4IpPcasOQ=
Received: by quaco.infradead.org (Postfix, from userid 1000)
        id 4226841114; Mon, 26 Nov 2018 17:04:54 -0300 (-03)
Date:   Mon, 26 Nov 2018 17:04:54 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools lib traceevent: Fix compile warnings in
 tools/lib/traceevent/event-parse.c
Message-ID: <20181126200454.GG18491@kernel.org>
References: <20181122112937.10582-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181122112937.10582-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 22, 2018 at 01:29:37PM +0200, Adrian Hunter escreveu:
> Fix following warnings:

Steven, any problem if I apply these? I think I've hit these warnings on
Clear Linux too.

- Arnaldo
 
> event-parse.c: In function ‘tep_find_event_by_name’:
> event-parse.c:3521:21: warning: ‘event’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>   pevent->last_event = event;
>   ~~~~~~~~~~~~~~~~~~~^~~~~~~
>   CC       ui/gtk/hists.o
>   LINK     plugin_mac80211.so
>   CC       nlattr.o
> event-parse.c: In function ‘tep_data_lat_fmt’:
> event-parse.c:5200:4: warning: ‘migrate_disable’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>     trace_seq_printf(s, "%d", migrate_disable);
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> event-parse.c:5207:4: warning: ‘lock_depth’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>     trace_seq_printf(s, "%d", lock_depth);
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   LINK     plugin_sched_switch.so
>   LINK     plugin_function.so
>   LINK     plugin_xen.so
> event-parse.c: In function ‘tep_event_info’:
> event-parse.c:5047:7: warning: ‘len_arg’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>        trace_seq_printf(s, format, len_arg, (char)val);
>        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> event-parse.c:4884:6: note: ‘len_arg’ was declared here
>   int len_arg;
>       ^~~~~~~
> event-parse.c:4338:11: warning: ‘vsize’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>      val = tep_read_number(pevent, bptr, vsize);
>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> event-parse.c:4224:6: note: ‘vsize’ was declared here
>   int vsize;
>       ^~~~~
> 
> $ gcc --version
>   gcc (Clear Linux OS for Intel Architecture) 8.2.1 20180502
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/lib/traceevent/event-parse.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
> index 3692f29fee46..fbd6d6813fab 100644
> --- a/tools/lib/traceevent/event-parse.c
> +++ b/tools/lib/traceevent/event-parse.c
> @@ -3498,7 +3498,7 @@ struct tep_event_format *
>  tep_find_event_by_name(struct tep_handle *pevent,
>  		       const char *sys, const char *name)
>  {
> -	struct tep_event_format *event;
> +	struct tep_event_format *event = NULL;
>  	int i;
>  
>  	if (pevent->last_event &&
> @@ -4221,7 +4221,7 @@ static struct tep_print_arg *make_bprint_args(char *fmt, void *data, int size, s
>  	unsigned long long ip, val;
>  	char *ptr;
>  	void *bptr;
> -	int vsize;
> +	int vsize = 0;
>  
>  	field = pevent->bprint_buf_field;
>  	ip_field = pevent->bprint_ip_field;
> @@ -4881,7 +4881,7 @@ static void pretty_print(struct trace_seq *s, void *data, int size, struct tep_e
>  	char format[32];
>  	int show_func;
>  	int len_as_arg;
> -	int len_arg;
> +	int len_arg = 0;
>  	int len;
>  	int ls;
>  
> @@ -5146,8 +5146,8 @@ void tep_data_lat_fmt(struct tep_handle *pevent,
>  	static int migrate_disable_exists;
>  	unsigned int lat_flags;
>  	unsigned int pc;
> -	int lock_depth;
> -	int migrate_disable;
> +	int lock_depth = 0;
> +	int migrate_disable = 0;
>  	int hardirq;
>  	int softirq;
>  	void *data = record->data;
> -- 
> 2.17.1

-- 

- Arnaldo
