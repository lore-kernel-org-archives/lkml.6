Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6D0C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 19:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75844208E2
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 19:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fxESJaeB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75844208E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754684AbeGITVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 15:21:17 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34360 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754528AbeGITVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 15:21:15 -0400
Received: by mail-ed1-f67.google.com with SMTP id d3-v6so14798995edi.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 12:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hu+1XnR5AKjsg4VLD/jfOLUZVPMHoAoGZ4UKKXjEbXo=;
        b=fxESJaeBs+Hm7Qhsr0y1wgwDudDkBVnNKwFCnJdHq156hqxnLI78tEjMdv3X70+BXm
         xA3KFOA8k55Cn5J2jRmGA0GIhBdM7nPtDLxYx0zH2ufaQkuIIZeFEHfI8fJleBXQL2E+
         R3uidoVzFiuPvB7DFSgT2IC5JxGTaWVDVXd2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hu+1XnR5AKjsg4VLD/jfOLUZVPMHoAoGZ4UKKXjEbXo=;
        b=udNI48cf9pdq4Ze0CvV6KhzTjBn8sG41TSEcbRJqeKHFjX+ZcWQNXBbIGJUcKyB142
         2PsOTix9NhI6+ZSlNipqf17cc5c9R2a958gFvigpD+TT0DfWmb4yaxOk6PxVEK9F4ZWi
         alGU+1SB8wVnZN/qzuIKXGjm+fgZYv1bzOFMflB9WaGFZ7BiFBjSqQhPgONpuYIZHlxS
         oPeB9TjpCCcVde357F+/ipM2MsVyrZEkBWFOlg52lZdE1i+kixNZIA7JUKKFPHUUsXSM
         5retz4oP+u+R1AXinByB0vfi0+G5ttOLi2QkRqe9S8Tl1dv1wKFkOcs6um5PHO+yeY30
         wo/Q==
X-Gm-Message-State: APt69E2Rrgm4nSDtCtDAN6fhnAVXZqAUonyNn6F50T4YgCq0DTOvDN7D
        w04/VUq1cM//1oNCL1NpbNrQu2DbxCp0mi9louWZRA==
X-Google-Smtp-Source: AAOMgpcFANAzZbtsuTE1dQnabh/akMXriWBZLsJEeSSfUBmmou2G3UHq9zNWxf/v2KXuvSYt/W1CdTnWnBCf6Nuyqd0=
X-Received: by 2002:a50:b505:: with SMTP id y5-v6mr23130467edd.195.1531164074391;
 Mon, 09 Jul 2018 12:21:14 -0700 (PDT)
MIME-Version: 1.0
References: <1530828827-11604-1-git-send-email-mathieu.poirier@linaro.org> <20180706183844.9de52f1d45e1775b51790e8e@arm.com>
In-Reply-To: <20180706183844.9de52f1d45e1775b51790e8e@arm.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Mon, 9 Jul 2018 13:21:03 -0600
Message-ID: <CANLsYkxJHhZE8VpS_S7ep2KnTNY725DPLKbZFfC_ZDdzaVkoZQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] perf: Add ioctl for PMU driver configuration
To:     Kim Phillips <kim.phillips@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>, ast@kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-s390@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jul 2018 at 17:38, Kim Phillips <kim.phillips@arm.com> wrote:
>
> On Thu,  5 Jul 2018 16:13:40 -0600
> Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
>
> > This set adds the capability to communiate event specific configuration
> > to the PMU kernel driver using an ioctl().  The functionatlity is made
> > generic enough for anyone to use but is targeted at the identification
> > of CoreSight sinks when operating in CPU-wide trace scenarios.
>
> With this series, a --per-thread -less invocation looks like it
> succeeds (instead of giving a "failed to mmap with 12 (Cannot allocate
> memory)" error):
>
> # perf record -e /cs_etm/@20010000.etf/ sleep 1
> [ perf record: Woken up 3 times to write data ]
> Warning:
> AUX data lost 2 times out of 3!
>
> [ perf record: Captured and wrote 0.182 MB perf.data ]
> #
>
> but now perf report - built with libopencsd - is unable to process the
> perf.data file:
>
> # perf report --stdio
> 0x3a0 [0x60]: failed to process type: 1
> Error:
> failed to process sample
> # To display the perf.data header info, please use --header/--header-only options.
> #

Right, that's expected since the perf tools patches for CPU-wide trace
scenarios haven't been merged yet.  The real problem is, as you
pointed above, that this patchset should still report an error as full
functionality isn't merged yet.  I will fix that.

>
> Also, a "record -a" invocation also acts like it's working, but Juno
> has a hardware limitation where it can't record all cpus concurrently,
> right?  So, shouldn't record commands that exceed the h/w's
> capabilities error out instead?

To be clear there is no hardware limitation preventing "record -a" to
work properly, just SW.  This patchset is the first step in addressing
the situation.

Thanks,
Mathieu

>
> Thanks,
>
> Kim
