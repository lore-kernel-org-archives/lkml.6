Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46092C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E6FE20879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548156616;
	bh=m/QXAVnR25KJ1zfUq6jZvk1QP+E6uEFKraR4Xyo8JzI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JeWktwv7pXZ4e3jTkBoSZtYUJJX3/L5OIEC53w/fiKPY9dcCjTf6iR2lGLbkXedcX
	 W140sAq6jpNa7AtSNjA6Tu1toNFcbnGRx2j9c7TU1/Y+DK5WFgDVqq0ZkL2UGFBLpg
	 cfMwHKDC6Cilylc69yqu75emaSPaJuOS8SJVy4ts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbfAVLaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 06:30:14 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43242 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728010AbfAVLaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 06:30:13 -0500
Received: by mail-wr1-f67.google.com with SMTP id r10so26864801wrs.10;
        Tue, 22 Jan 2019 03:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Nn8HUsuI9boXN7FDkNevTAb1/0gK0SqebCujRHKLLkg=;
        b=IJAqF+NHRJX5RTbEIK6VWFeTta6u+SQcRJ64hL3U7T/gel6gTl/8nTaWiyIyWFBJtH
         +DkTBj++aniaK0lcoicx8builGDv1zbswZrkr8nDWQTvY2H7e1a7VfXC36AcYRAYoTkx
         JC7FMNiJ2ZoCjIULCJeCABH9LNmy8eXu2nMedNPbfqJYJri3gkG80XQcVVP/oXptrplJ
         1/Ccf6D8+ekAddnedmgeLmp0ZhXMQrv/ms+PEprTLN8ZH9zlnqCVdRa5f+CxubNxJ/w2
         G5M5CgkH+QeWuPpTGHgTGm4BWlj2OAJlCrW0w0Wl81rDaSumqo6mfDAFFSVc4Jn8w4ok
         P8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Nn8HUsuI9boXN7FDkNevTAb1/0gK0SqebCujRHKLLkg=;
        b=N8R1VD5HfKL80xC8GyiTo/Cp6tQgehGQVWtuzwosrQx50D2vvZ1hOeZeErr1ihiC0l
         FyV+2tXBWUUO9SC9oto74i8cWNLS+yWQN0ULoguxp6ihTs8eA29KcZyt6LwTz/l4cWDB
         ma/vVGz/PDjgrPhNPKDQP4qS8u2J5Nkv7TJBdJXmMZKoofr8zMNrquhc8rXobHj8bxFn
         hHZbRw/TnXcPLj5H/clf8n/p9L08nlbKPnMmgj2wUWUvkS55OM6Jjl6DHhlRMI2q2Yzc
         CRb6swsl62maIoN1sQ0JfnfP+UI6AQmhZ++OTK0UE1FXV0qa5WBguEIdohuEclY+5goI
         fOKQ==
X-Gm-Message-State: AJcUukcxHrMIIbbvSx8a6E38x/wcKwusU3eVqPerujIr/k0NJCosrWSq
        V0sDj5E62cxubmvaSz8o3Bw=
X-Google-Smtp-Source: ALg8bN4KAtOjdW63/ErIWYiQXYcWI/XYsBW90RzwkmNqZdfIaLlFRcggFg27oxLf96/Q/Vc15IHPSQ==
X-Received: by 2002:adf:e383:: with SMTP id e3mr31985245wrm.31.1548156611711;
        Tue, 22 Jan 2019 03:30:11 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id f10sm21477212wmb.35.2019.01.22.03.30.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 03:30:10 -0800 (PST)
Date:   Tue, 22 Jan 2019 12:30:08 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        He Kuang <hekuang@huawei.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Song Liu <liu.song.a23@gmail.com>,
        Stephane Eranian <eranian@google.com>,
        Tony Jones <tonyj@suse.de>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 0/7] perf/urgent fixes
Message-ID: <20190122113008.GB113758@gmail.com>
References: <20190121183507.23490-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121183507.23490-1-acme@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling,
> 
> Regards,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 4e72ee8872279a70ebe973172133b98e8acbf54e:
> 
>   Merge tag 'perf-core-for-mingo-5.0-20190110' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2019-01-11 08:12:09 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-5.0-20190121
> 
> for you to fetch changes up to 8bf8c6da53c2265aea365a1de6038f118f522113:
> 
>   perf script: Fix crash when processing recorded stat data (2019-01-21 11:29:07 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> Kernel:
> 
>   Stephane Eranian:
> 
>   - Fix perf_proc_update_handler() bug.
> 
> perf script:
> 
>   Andi Kleen:
> 
>   - Fix crash with printing mixed trace point and other events.
> 
>   Tony Jones:
> 
>   - Fix crash when processing recorded stat data.
> 
> perf top:
> 
>   He Kuang:
> 
>   - Fix wrong hottest instruction highlighted.
> 
> perf python:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Remove -fstack-clash-protection when building with some clang versions.
> 
> perf ordered_events:
> 
>   Jiri Olsa:
> 
>   - Fix out of buffers crash in ordered_events__free().
> 
> perf cpu_map:
> 
>   Stephane Eranian:
> 
>   - Handle TOPOLOGY headers with no CPU.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Andi Kleen (1):
>       perf script: Fix crash with printing mixed trace point and other events
> 
> Arnaldo Carvalho de Melo (1):
>       perf python: Remove -fstack-clash-protection when building with some clang versions
> 
> He Kuang (1):
>       perf top: Fix wrong hottest instruction highlighted
> 
> Jiri Olsa (1):
>       perf ordered_events: Fix crash in ordered_events__free
> 
> Stephane Eranian (2):
>       perf core: Fix perf_proc_update_handler() bug
>       perf tools: Handle TOPOLOGY headers with no CPU
> 
> Tony Jones (1):
>       perf script: Fix crash when processing recorded stat data
> 
>  kernel/events/core.c              | 14 +++++++-------
>  tools/perf/builtin-script.c       |  9 +++------
>  tools/perf/ui/browsers/annotate.c | 16 ++++++++++------
>  tools/perf/util/cpumap.c          | 11 +++++++++--
>  tools/perf/util/ordered-events.c  |  6 ++++--
>  tools/perf/util/setup.py          |  2 ++
>  6 files changed, 35 insertions(+), 23 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
