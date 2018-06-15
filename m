Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7DBCC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8185C20896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eGNINlcD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8185C20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756249AbeFOQyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 12:54:39 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37703 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752703AbeFOQyi (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 12:54:38 -0400
Received: by mail-wm0-f66.google.com with SMTP id r125-v6so5005188wmg.2
        for <Linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 09:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ja3999jF5iQXwv7wt/N13Hgg7KOi5Ldzx9DUYdpdmrs=;
        b=eGNINlcDzGLD0Xn3vJLHaFV4MDLoo8x2wrPzf9iwmYX+EB6xYcsf3h7vf4w8YM7b6N
         N1o+I1goOIxLP7640RbXNZrnrT+xM9gx8NwF5LmH/SzyUwgqx1VIlunGY0li6DLwlSeT
         Ibg2LXY8btXMv2AS1NgyUD7lRF+vZqeL0xht5yL068v/0G7bLILEDISFNzGnezrrfGJd
         y8qT02lX4B1l9wj5xH9rxmBueFQmJmAqySx14uFhePTjOpUv1gHMpGrGX4L6YTxFHkcx
         npDJNFlyZSVo0f1CGKOfYZm6c9M+mLNxdjLp/VTkFm2t0zEJfT0/FPGg9pkicMpLI0lV
         Q1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ja3999jF5iQXwv7wt/N13Hgg7KOi5Ldzx9DUYdpdmrs=;
        b=W2oyQqzLOa/VimzivKsEwxZzhwuiEfLN47IzPA8T2e8gZ2Nl8TfPLZDWpOouAc8sFG
         kgph2ylUbNIkGLyfH6c6jcxihmOc922YtG7vjUACdZnc3g0RJ9riSrHVYWkz0Uvu/xDl
         mBknUol+4JPmM9L1fankUPIJHwDtKv/+iDHfPtox8tObAgyNDET8aO20tl4hiE8EM9H6
         jXtPgBvc1TdiMmCXBg07w54N5MRk7L+yHkozmm9i+Wry3SlynhpgM8EJVSO6A2iFf3vy
         BrWXyj2/xGaZdffUx+550O21fyzxV0MhX+1POmzZjz7fOG5tu2IQepP6dFiR7dQ9KZds
         QALg==
X-Gm-Message-State: APt69E1e4x4AuaqK5mJf9eVfpGVqdYxVCA7JHgJwSWJ54AtOipMe4z9n
        t65vK/ORWevoavPDOleV3s1esFCS0p7rN1uU30YJZg==
X-Google-Smtp-Source: ADUXVKLRIZf2BMQJgdc9PQKY1V9Xj3C78MG79SUhiqgD7WmdHO3T6adlxoA3fMAV0r0AD+XmyC/TwTIXslTr2xE+zKQ=
X-Received: by 2002:a1c:afc3:: with SMTP id y186-v6mr1732789wme.87.1529081676963;
 Fri, 15 Jun 2018 09:54:36 -0700 (PDT)
MIME-Version: 1.0
References: <1529057003-2212-1-git-send-email-yao.jin@linux.intel.com>
 <20180615074504.GA2458@hirez.programming.kicks-ass.net> <11958be5-dc05-611b-6839-f1f6903c7ca8@linux.intel.com>
 <20180615081223.GB2458@hirez.programming.kicks-ass.net>
In-Reply-To: <20180615081223.GB2458@hirez.programming.kicks-ass.net>
From:   Stephane Eranian <eranian@google.com>
Date:   Fri, 15 Jun 2018 09:54:44 -0700
Message-ID: <CABPqkBRgDSVCyg_qF3dYLpE+9cO0Woria+Jk+BdOA_6_VCYQfw@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] perf: Drop leaked kernel samples
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     yao.jin@linux.intel.com,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        me@kylehuey.com, LKML <Linux-kernel@vger.kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Will Deacon <will.deacon@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        "Liang, Kan" <kan.liang@intel.com>, "Jin, Yao" <yao.jin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Fri, Jun 15, 2018 at 1:12 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Jun 15, 2018 at 04:01:45PM +0800, Jin, Yao wrote:
>
> > Bring more overhead to kernel if we zero the bits considering the number of
> > leaked samples may be not too small?
>
> Keeping the samples at least allows you to know how many samples
> happened and such things.
>
Yes, important point. You cannot just drop a sample. It may break some
calculations
done like num_samples x fixed_periods = total number of events observed. Some
tools do this.


> > And the skid information may be interesting (see example of hitting on
> > page_fault in previous mail). If we zero it, we will not know.
>
> If you throw them out the window you also don't know, do you?
