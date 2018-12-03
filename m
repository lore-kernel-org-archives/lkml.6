Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E846C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D33E22087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:14:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D33E22087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbeLCUOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 15:14:43 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39454 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbeLCUOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 15:14:42 -0500
Received: by mail-pf1-f194.google.com with SMTP id c72so6934989pfc.6;
        Mon, 03 Dec 2018 12:14:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mUB6IfPhg5STJyATuJQzvX9GxAvgS+HuZhS3KXmQ9DA=;
        b=rTv2rYaGpFYoDAZWej/xak4eafZ/SmKfalT5nnZcM+Yiq17HaUk+sb8uaCjr8jXyo4
         2Vt2Xgw58QNlvUYGmilM4HbVXVWoUFIWyjiLpBvfG9Wf65Wybn+Tsrb3i6VaRQShgUTA
         4QRFhpWO9vrg889blicQ/5RbMbb12RlLM5x2b+EAF/FQZaLFjMRoRD6tpfK2MKYuXrzR
         Hh2j4oLazdWEAcksBc+i9ny2WfvyHq09EK9HXU/EA2ltCvGowXvq1uf6qep2B8NCBAHd
         5W1jGYif10NPNKZQD2yjt2CVV1ePQuKNG06ygrvnaSJ4jlXYj7vsHs6Zm0GAKmk0YkBO
         c2rQ==
X-Gm-Message-State: AA+aEWZfh7o785fAqPSDDH70P9P/MWF3GnNtwaRgOqSHswKsP4vdnD9A
        9DlTW9zxD/+i8lZeM1l0SpM=
X-Google-Smtp-Source: AFSGD/UVtXCTsTdciTf4BrtTMmUQ1XrtGXeM5H6i0mdteiBEaFMbTNamprLLHw25TgGp5d+W7TGm5g==
X-Received: by 2002:a63:ce08:: with SMTP id y8mr14326892pgf.388.1543868080001;
        Mon, 03 Dec 2018 12:14:40 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id v89sm22850036pfk.12.2018.12.03.12.14.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 12:14:38 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Mon, 03 Dec 2018 12:14:36 -0800
Date:   Mon, 3 Dec 2018 12:14:36 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     cheng.lin130@zte.com.cn, keescook@chromium.org,
        akpm@linux-foundation.org, ebiederm@xmission.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        zhong.weidong@zte.com.cn, wang.yi59@zte.com.cn
Subject: Re: Re: [PATCH] proc/sysctl: fix return error for
 proc_doulongvec_minmax
Message-ID: <20181203201436.GO28501@garbanzo.do-not-panic.com>
References: <20181130191456.GX18410@garbanzo.do-not-panic.com>
 <201812031312398404610@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201812031312398404610@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 01:12:39PM +0800, cheng.lin130@zte.com.cn wrote:
> >Cheng, thanks for the patch!
> >
> >On Fri, Nov 30, 2018 at 02:35:17PM +0800, Cheng Lin wrote:
> >> If the number of input parameters is less than the total
> >> parameters, an INVAL error will be returned.
> >
> >Do you mean EINVAL?
> >
> Yes, it's EINVAL.

Please adjust the commit log.

> >> This patch ensure no error returned in this condition, just
> >> like other interfaces do.
> >
> >Have an actual example to reproduce?
> >
> >Luis
> >
> We use proc_doulongvec_minmax to pass up to two parameters with kern_table.
> e.g. 
>         {
>                 .procname       = "monitor_signals",
>                 .data           = &monitor_sigs,
>                 .maxlen         = 2*sizeof(unsigned long),
>                 .mode           = 0644,
>                 .proc_handler   = proc_doulongvec_minmax,
>         },
> 
> Reproduce:
> When passing two parameters, it's work normal. But passing only one parameter, an error "Invalid argument"(EINVAL) is returned.
> [root@cl150 ~]# echo 1 2 > /proc/sys/kernel/monitor_signals
> [root@cl150 ~]# cat /proc/sys/kernel/monitor_signals
> 1       2
> [root@cl150 ~]# echo 3 > /proc/sys/kernel/monitor_signals
> -bash: echo: write error: Invalid argument
> [root@cl150 ~]# echo $?
> 1
> [root@cl150 ~]# cat /proc/sys/kernel/monitor_signals
> 3       2
> [root@cl150 ~]#
> 
> The following is the result after apply this patch. No error is returned when the number of input parameters is less than the total parameters.
> [root@cl150 ~]# echo 1 2 > /proc/sys/kernel/monitor_signals
> [root@cl150 ~]# cat /proc/sys/kernel/monitor_signals
> 1       2
> [root@cl150 ~]# echo 3 > /proc/sys/kernel/monitor_signals
> [root@cl150 ~]# echo $?
> 0
> [root@cl150 ~]# cat /proc/sys/kernel/monitor_signals
> 3       2
> [root@cl150 ~]#

This would be good to have in the commit log as well. But your patch
only addresses one of the proc users, there are a few other checks like
this that would also need to be expanded for this. So please expand
your patch to cover the other cases as well.

Since this worked before I do agree that we need to keep it working now,
and I can't think of an issue with returning 0 now. Since this is about
semantics though I'd like a bit more review from at last one more
person.

Kees, Eric, Andrew?

  Luis

> Cheng
> 
> >> Signed-off-by: Cheng Lin <cheng.lin130@zte.com.cn>
> >> ---
> >>  kernel/sysctl.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> >> index 5fc724e..9ee261f 100644
> >> --- a/kernel/sysctl.c
> >> +++ b/kernel/sysctl.c
> >> @@ -2779,6 +2779,8 @@ static int __do_proc_doulongvec_minmax(void *data, struct ctl_table *table, int
> >>              bool neg;
> >>
> >>              left -= proc_skip_spaces(&p);
> >> +            if (!left)
> >> +                break;
> >>
> >>              err = proc_get_long(&p, &left, &val, &neg,
> >>                           proc_wspace_sep,
> >> --
> >> 1.8.3.1
> >>

