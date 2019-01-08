Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BEDC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6511220850
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546954543;
	bh=EAikm38jmsnPfSQcMEDLbQ4kuJlqFvcIxVPbcEgpEso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ER1vFSU6P2d4UOLA+cJq0XYBZrPapw+FQlfQOEA7AdCpOZWvHr0Q8fb5tR6oUqeIc
	 KUbp/EWq/trtFcXxbAfdUHZ7DquRspqBWaernxbinmstx/qWQ/mrZesDxuEFpfydGM
	 K0DdZJ6Tsm0Myald4T9fR1eDnC54r2MtDqdtEhpk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbfAHNfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 08:35:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:37332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728594AbfAHNfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 08:35:40 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E1F320827;
        Tue,  8 Jan 2019 13:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546954539;
        bh=EAikm38jmsnPfSQcMEDLbQ4kuJlqFvcIxVPbcEgpEso=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J/U/qDmvFkP2YDgTTNrVoUcmTqQO4t+jNJW2nGccfdU8r15Xnrf9+WhYK8BaQmWDF
         fOEDijYjfnAgO07C8hfWpgYTWpHXc7UFkT/52F2UzaC83ysgA50OCALAzM/m32wUDV
         4wDibNXOc/+BOZavX8SdQxOltzGiWLql+Hk6RmF4=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 35EED40355; Tue,  8 Jan 2019 10:35:36 -0300 (-03)
Date:   Tue, 8 Jan 2019 10:35:36 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>
Subject: Re: [PATCH 8/9] tools/lib/traceevent: Introduce new libtracevent
 API: tep_override_comm()
Message-ID: <20190108133536.GD28965@kernel.org>
References: <20181130154403.150474900@goodmis.org>
 <20181130154648.038915912@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130154648.038915912@goodmis.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Nov 30, 2018 at 10:44:11AM -0500, Steven Rostedt escreveu:
> From: Tzvetomir Stoyanov <tstoyanov@vmware.com>
> 
> This patch adds a new API of tracevent library: tep_override_comm()
> It registers a pid / command mapping. If a mapping with the same
> pid already exists, the entry is updated with the new command.

This one had fell thru the cracks, noticed that while processing the
following patchkit, now its in and I'm processing the last one.

- Arnaldo
 
> Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  tools/lib/traceevent/event-parse.c | 69 +++++++++++++++++++++++-------
>  tools/lib/traceevent/event-parse.h |  1 +
>  2 files changed, 55 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
> index 8863de9f8869..892cf032a096 100644
> --- a/tools/lib/traceevent/event-parse.c
> +++ b/tools/lib/traceevent/event-parse.c
> @@ -232,11 +232,13 @@ int tep_pid_is_registered(struct tep_handle *pevent, int pid)
>   * we must add this pid. This is much slower than when cmdlines
>   * are added before the array is initialized.
>   */
> -static int add_new_comm(struct tep_handle *pevent, const char *comm, int pid)
> +static int add_new_comm(struct tep_handle *pevent,
> +			const char *comm, int pid, bool override)
>  {
>  	struct cmdline *cmdlines = pevent->cmdlines;
> -	const struct cmdline *cmdline;
> +	struct cmdline *cmdline;
>  	struct cmdline key;
> +	char *new_comm;
>  
>  	if (!pid)
>  		return 0;
> @@ -247,8 +249,19 @@ static int add_new_comm(struct tep_handle *pevent, const char *comm, int pid)
>  	cmdline = bsearch(&key, pevent->cmdlines, pevent->cmdline_count,
>  		       sizeof(*pevent->cmdlines), cmdline_cmp);
>  	if (cmdline) {
> -		errno = EEXIST;
> -		return -1;
> +		if (!override) {
> +			errno = EEXIST;
> +			return -1;
> +		}
> +		new_comm = strdup(comm);
> +		if (!new_comm) {
> +			errno = ENOMEM;
> +			return -1;
> +		}
> +		free(cmdline->comm);
> +		cmdline->comm = new_comm;
> +
> +		return 0;
>  	}
>  
>  	cmdlines = realloc(cmdlines, sizeof(*cmdlines) * (pevent->cmdline_count + 1));
> @@ -275,21 +288,13 @@ static int add_new_comm(struct tep_handle *pevent, const char *comm, int pid)
>  	return 0;
>  }
>  
> -/**
> - * tep_register_comm - register a pid / comm mapping
> - * @pevent: handle for the pevent
> - * @comm: the command line to register
> - * @pid: the pid to map the command line to
> - *
> - * This adds a mapping to search for command line names with
> - * a given pid. The comm is duplicated.
> - */
> -int tep_register_comm(struct tep_handle *pevent, const char *comm, int pid)
> +static int _tep_register_comm(struct tep_handle *pevent,
> +			      const char *comm, int pid, bool override)
>  {
>  	struct cmdline_list *item;
>  
>  	if (pevent->cmdlines)
> -		return add_new_comm(pevent, comm, pid);
> +		return add_new_comm(pevent, comm, pid, override);
>  
>  	item = malloc(sizeof(*item));
>  	if (!item)
> @@ -312,6 +317,40 @@ int tep_register_comm(struct tep_handle *pevent, const char *comm, int pid)
>  	return 0;
>  }
>  
> +/**
> + * tep_register_comm - register a pid / comm mapping
> + * @pevent: handle for the pevent
> + * @comm: the command line to register
> + * @pid: the pid to map the command line to
> + *
> + * This adds a mapping to search for command line names with
> + * a given pid. The comm is duplicated. If a command with the same pid
> + * already exist, -1 is returned and errno is set to EEXIST
> + */
> +int tep_register_comm(struct tep_handle *pevent, const char *comm, int pid)
> +{
> +	return _tep_register_comm(pevent, comm, pid, false);
> +}
> +
> +/**
> + * tep_override_comm - register a pid / comm mapping
> + * @pevent: handle for the pevent
> + * @comm: the command line to register
> + * @pid: the pid to map the command line to
> + *
> + * This adds a mapping to search for command line names with
> + * a given pid. The comm is duplicated. If a command with the same pid
> + * already exist, the command string is udapted with the new one
> + */
> +int tep_override_comm(struct tep_handle *pevent, const char *comm, int pid)
> +{
> +	if (!pevent->cmdlines && cmdline_init(pevent)) {
> +		errno = ENOMEM;
> +		return -1;
> +	}
> +	return _tep_register_comm(pevent, comm, pid, true);
> +}
> +
>  int tep_register_trace_clock(struct tep_handle *pevent, const char *trace_clock)
>  {
>  	pevent->trace_clock = strdup(trace_clock);
> diff --git a/tools/lib/traceevent/event-parse.h b/tools/lib/traceevent/event-parse.h
> index 35d37087d3c5..e6f4249910e6 100644
> --- a/tools/lib/traceevent/event-parse.h
> +++ b/tools/lib/traceevent/event-parse.h
> @@ -432,6 +432,7 @@ int tep_set_function_resolver(struct tep_handle *pevent,
>  			      tep_func_resolver_t *func, void *priv);
>  void tep_reset_function_resolver(struct tep_handle *pevent);
>  int tep_register_comm(struct tep_handle *pevent, const char *comm, int pid);
> +int tep_override_comm(struct tep_handle *pevent, const char *comm, int pid);
>  int tep_register_trace_clock(struct tep_handle *pevent, const char *trace_clock);
>  int tep_register_function(struct tep_handle *pevent, char *name,
>  			  unsigned long long addr, char *mod);
> -- 
> 2.19.1
> 

-- 

- Arnaldo
