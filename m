Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ma00D+1WGVsadAAAmS7hNA
	; Thu, 07 Jun 2018 16:01:49 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 782116090E; Thu,  7 Jun 2018 16:01:48 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BI0M9bFG"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id BFE9F60590;
	Thu,  7 Jun 2018 16:01:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BFE9F60590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934187AbeFGQBo (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:01:44 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:41004 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932912AbeFGQBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 12:01:32 -0400
Received: by mail-wr0-f196.google.com with SMTP id h10-v6so10399311wrq.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 09:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GzoDECv4OvkI9xX9WzUiTmYqSn3LavsRzoEt3FCoFNI=;
        b=BI0M9bFGcMuixuYOFkCfnF6MllMwseNI1WAo21DYJFzgRKjdRp8lQVbJKm1h4qFGIg
         0A7oUWZaG0qFeVJd6BcCfb6f8VTOXGfNoHJ9YIhk4KMa2jZndzlsg3OnaQZRKdwtrRXN
         y1vd19A2jxLSt5hHEO1dSkiK3v7dwxmEFavfdOeaHquQiyGXd7+FRdPPcXnl//rFsURu
         44iP0POD5+eyUwiJLTAR1Yr0g8cG1I9gvyBb+tJCJkyGfs1F3XTIK3kojif/kn+PlJXE
         d1y/SpZ5jTtcs7t6UI2aMwTlwsUGpOZzPgGtRgm/5dGk3kFBo7gNM6Nx5iazrWEHGxgZ
         xOVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GzoDECv4OvkI9xX9WzUiTmYqSn3LavsRzoEt3FCoFNI=;
        b=SI2Jzye1XgR0ADqxeA+z7KajBJw5rTp19FMOmXDq1RyLleFUndAmsNV7fGEv3xaBEV
         Of3yscmyb2BYgmblwt14mm1AR51OPUvPSoRv94nOYYCSDq9yPlAMjanswxyzBoqNB/ov
         yjaPPSyA1GeZW2KT/FWoJQ9Fyi93qYa6M7P8cxjYgjk3gJ1e9DpF9PVhDeX/hUD8E237
         X5XwvxIuxxEQjq2/5d/s5Y+9dSW3Qb1Dy3k317SuYauUIe6en/z4bLVccCAdvhiEZyk0
         lGIRWivA/49nR7O/U9oHRuYZkYLkQnl+ueJ/GDm/TDqQFuli1DkOuH7PLVVchsvTWhK3
         dtog==
X-Gm-Message-State: APt69E25q3zLIKrlVlVURpOzHjfd3t4nyJwmJoCHCny35wqTrtHA30WW
        zPp0X8Eun6Exg5mdlcTqe1qDlyNmxru6fR295Q749A==
X-Google-Smtp-Source: ADUXVKLA7JymL97kNx5B1VfssJZL/2t5pQ98LULpLj5rv5WEX4RpmtBwsuAYZBp9dbxQOVy+grSYwFsFmMCVj8IDHE8=
X-Received: by 2002:adf:b839:: with SMTP id h54-v6mr2313882wrf.36.1528387291581;
 Thu, 07 Jun 2018 09:01:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180606221513.11302-1-jolsa@kernel.org> <20180606221513.11302-10-jolsa@kernel.org>
 <20180607154522.hyjmxn3q6zgcvsnx@two.firstfloor.org>
In-Reply-To: <20180607154522.hyjmxn3q6zgcvsnx@two.firstfloor.org>
From: Stephane Eranian <eranian@google.com>
Date: Thu, 7 Jun 2018 09:01:30 -0700
Message-ID: <CABPqkBR88VBZB1mLttUx0UxnFgWTJ=ggb66PsMti--svJU70UQ@mail.gmail.com>
Subject: Re: [PATCH 09/10] perf/cputime: Don't stop idle tick if there's live
 cputime event
To: Andi Kleen <andi@firstfloor.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Milian Wolff <milian.wolff@kdab.com>, frederic@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Thu, Jun 7, 2018 at 8:45 AM Andi Kleen <andi@firstfloor.org> wrote:
>
> On Thu, Jun 07, 2018 at 12:15:12AM +0200, Jiri Olsa wrote:
> > Disable stopping of the idle tick when having live cputime
> > event. When the tick is disabled, the idle counts are out
> > of date until next tick/update and perf cputime PMU provides
> > misleading counts.
>
> I really don't like this. This can totally change performance
> (e.g. less Turbo due to less idle) and performance tools shouldn't
> change the performance profile drastically.
>
You do not want to change the behavior of the kernel just because you
are monitoring.
This may introduce side effects on other events which may not otherwise exist.
