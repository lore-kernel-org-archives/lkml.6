Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47126C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBBB12469A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="M/n9AWFW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBBB12469A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934063AbeFVRXB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 13:23:01 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:39857 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933900AbeFVRW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 13:22:59 -0400
Received: by mail-io0-f195.google.com with SMTP id f1-v6so6778890ioh.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 10:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bLZ/C+TDzFUhdbTGPBgjOhbhfY+e+uFDfMgn3YsknH8=;
        b=M/n9AWFWhNzdjvUOEHgISafZ4yv9cagXyHgYTie7C5jYZoJEXpigAZPPQZZMcZyHe+
         axo3aOF/iTtqnnKK+JxZ51ttZuHpxr7NUO1bxnH0OYaatSp1fq26tsi6pvSS3dt2RaC1
         VlLZzuNiDKyZV7r0xxmt48HwErvF4kJFKrDPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bLZ/C+TDzFUhdbTGPBgjOhbhfY+e+uFDfMgn3YsknH8=;
        b=CW0NiVYYeTDjYPhXhhwUxmNH+CHOwyJfsjOVSz4CcIwWpLYMRqlHTbWH11++SVSD6H
         INM6x2SgBwtN+oUD1Z1RZ2S9fhVaZAwWN+VQDPalLDg8Ve2Se1w/CSZmb6MqYhR9Q6Ip
         eDVOVqrookT4GIw2I8jZflr/vJqt8CwYLhdcavrx5xnoSgVi9rSfcxlyai/AKhHClsSF
         iMao0tjG56mNtNyp++dxh9ef9ZkWuSsHgYnCzLl9rFVGMr2+P9mknR659j8IaVwb3Qbj
         YpaKhK+vk6n8H54WgceBgzwHiorbyILcju/9mXSLCxBMCuZ7wU9H7/M63TOb/vTDvlIl
         t6Ow==
X-Gm-Message-State: APt69E35LvcejMhzK6KlWb7Xc7iUkZe2QrInt/3ZCqC3sStZ0SWq7yF8
        gSDUb76Lb4J9WJ6OTm9Wf9v5SiUgIZuvCmAcHF1GUC4q
X-Google-Smtp-Source: AAOMgpcg53dUbgMX9XbxBVx0TJDlmbgRgTw452T2522CPs/G/I8Yuzp44XSFYOzXmM/W7a2c+jdB7+OeJ39qfmfRdmg=
X-Received: by 2002:a6b:1884:: with SMTP id 126-v6mr1948597ioy.183.1529688179269;
 Fri, 22 Jun 2018 10:22:59 -0700 (PDT)
MIME-Version: 1.0
References: <1528459794-13066-1-git-send-email-vincent.guittot@linaro.org>
 <1528459794-13066-7-git-send-email-vincent.guittot@linaro.org> <20180622152428.GS2476@hirez.programming.kicks-ass.net>
In-Reply-To: <20180622152428.GS2476@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 22 Jun 2018 19:22:48 +0200
Message-ID: <CAKfTPtAMqCF_J2gOwPtixsOUjPYg1krKP5u7PcJ3dDbuNJv1mw@mail.gmail.com>
Subject: Re: [PATCH v6 06/11] cpufreq/schedutil: use dl utilization tracking
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Quentin Perret <quentin.perret@arm.com>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jun 2018 at 17:24, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Jun 08, 2018 at 02:09:49PM +0200, Vincent Guittot wrote:
> > -      * Ideally we would like to set util_dl as min/guaranteed freq and
> > -      * util_cfs + util_dl as requested freq. However, cpufreq is not yet
> > -      * ready for such an interface. So, we only do the latter for now.
>
> Please don't delete that comment. It is not less relevant.

ok i will keep it in next version

>
> > -static inline unsigned long cpu_util_dl(struct rq *rq)
> > +static inline unsigned long cpu_bw_dl(struct rq *rq)
>
> I think you forgot to fix-up ignore_dl_rate_limit().

yes you're right
