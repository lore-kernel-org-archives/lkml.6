Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823CEC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F707217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545219928;
	bh=8zFXM09tZLBwyAYs5qcYhrwvfA+HvhZRy9W3wKwswt8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=y485yImgfEJ+mHV6kVFLBcbg1ivaThFZT4PFy9XFUn54vyrGzP2MNKWD5wtdGgnJc
	 8oKpx5tmQ9aBFUonTPdfma1Ki9X9FRhjI7Fq6eifFBMaCvzRUbnmPOV42FGwYVpUnr
	 pWZkFpnDCZIuBSSmYm8L47jwGAW8d8uQO560vkIw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbeLSLp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 06:45:27 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38592 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728588AbeLSLp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 06:45:26 -0500
Received: by mail-pf1-f195.google.com with SMTP id q1so9711710pfi.5;
        Wed, 19 Dec 2018 03:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yA6u9F3WOgaaI02cgKYXIT3vT5R8Y/Itf3hapCWM3f8=;
        b=RyDeYfq/0lcXtJaPQOEW0gwUIE3gy6Co88Gg+oBiMPVl1qDGbO0WTb6dLxveyLs8Uf
         Ecw6yu8X4c1AZmSvOriJssb1Nyq+yMJyNdPrjIVccUQ0Sq0jvdyyFauRTYKFFXMYaW92
         w2YYvr/svLpwQwqPWX65QCQ5YZ4DLRBf977vSVcODKMLx8zhUVIUrJRpuQw79kB+VIpM
         aIQUfFdZDQ4elITpi01xXSTFajbijPPEPHBiX+SELB61UDHXJgi5GNc590OT9yOi5xaw
         EQFIc4Q+JNcrzEl5OKtRmLZz+qEvpPo65TXNDUM78zMwl7RIqH+z3kdcT4g3EqL3e+R3
         ZMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=yA6u9F3WOgaaI02cgKYXIT3vT5R8Y/Itf3hapCWM3f8=;
        b=gJ4fv67goI2KxrzqM8tHy3Nq2X5vp7jiIO2rsvCE4M4H/Ks+aZZ60zu+K4ydJJ1I8b
         +ujiVl4eJ1t9/Q4WqBqGx7PjfiM6HYGibGg3N4tAWpA+P2lZAUYhmGH0Q7i+gd0iK+I+
         qzJ4oYOAWRlik1O/YeDKMBn9uAru4JFIMtooPtP92k3KpIjml35dsvOsSoPhGmNA2/1H
         +BuskoNturZDaPn8WjbOeio+56Qsocyub1cbt/vkwqNn/ChFd8U5uI390+gXx1gcQ7r5
         u8+5bvHCNUci8/sndsHEOb/mrN3etA4/dBr76kww8KWTL9rQBbBeRNUprS3Br77bCWQT
         bXRg==
X-Gm-Message-State: AA+aEWbTWUgOpxo5ZpX7SbH8zKvjqKAarw9rz5urX40+7qpXAN79XjjM
        6NIXyX2Og1VyAs2f5LdAw2Y=
X-Google-Smtp-Source: AFSGD/U0Mh7CAlo22++hrRPUTpX15pYo1UCR3u4BxAZXkE1fIoqtGwsOTG3K+KJJHLkV9GUrwJbdOw==
X-Received: by 2002:a62:9719:: with SMTP id n25mr6460771pfe.240.1545219925580;
        Wed, 19 Dec 2018 03:45:25 -0800 (PST)
Received: from danjae.aot.lge.com ([182.210.106.196])
        by smtp.gmail.com with ESMTPSA id b7sm37185090pga.39.2018.12.19.03.45.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 03:45:24 -0800 (PST)
Date:   Wed, 19 Dec 2018 20:45:17 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, kernel-team@lge.com
Subject: Re: [PATCH 0/7] tracing: Hist trigger var-ref cleanup and comments
Message-ID: <20181219114517.GA19177@danjae.aot.lge.com>
References: <cover.1545161087.git.tom.zanussi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1545161087.git.tom.zanussi@linux.intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

On Tue, Dec 18, 2018 at 02:33:19PM -0600, Tom Zanussi wrote:
> From: Tom Zanussi <tom.zanussi@linux.intel.com>
> 
> Hi,
> 
> This patchset is a standalone series broken out of the v8 version of
> the 'tracing: Hist trigger snapshot and onchange additions' patchset.
> 
> It's a series of changes resulting from some suggestions from Namhyung
> for making the variable-reference handling code more understandable
> through some refactoring and comments.
> 
> It also added a new patch changing all strlen() to sizeof() for string
> constants, in trace_events_hist.c
> 
> Also, in the 'tracing: Remove open-coding of hist trigger var_ref
> management' patch, in create_var_ref(), moved the saving of ref_field
> and update of ref_field->var_ref_idx into the 'if' as pointed out by
> Dan Carpenter/smatch 0-day robot.
> 
> It doesn't introduce any functional changes and can be applied
> independently of the other patchset.

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> 
> The following changes since commit 5d6ddf6acce68d1290112cb08b12fd78b201e7d5:
> 
>   arm64: Use ftrace_graph_get_ret_stack() instead of curr_ret_stack (2018-12-08 22:21:31 -0500)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/hist-var-ref-cleanup-v1
> 
> Tom Zanussi (7):
>   tracing: Remove unnecessary hist trigger struct field
>   tracing: Change strlen to sizeof for hist trigger static strings
>   tracing: Use var_refs[] for hist trigger reference checking
>   tracing: Remove open-coding of hist trigger var_ref management
>   tracing: Use hist trigger's var_ref array to destroy var_refs
>   tracing: Remove hist trigger synth_var_refs
>   tracing: Add hist trigger comments for variable-related fields
> 
>  kernel/trace/trace_events_hist.c | 267 +++++++++++++++++++++++----------------
>  1 file changed, 156 insertions(+), 111 deletions(-)
> 
> -- 
> 2.14.1
> 
