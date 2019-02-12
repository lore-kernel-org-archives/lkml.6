Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E808EC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7C892190B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZtgH2eM1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731958AbfBLTcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 14:32:32 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33372 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730468AbfBLTcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 14:32:31 -0500
Received: by mail-pl1-f195.google.com with SMTP id y10so1794510plp.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 11:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=RrDOZhX2BdUSOXPg+ko/Cm/nI74vx5xQFnZe9rt+GjI=;
        b=ZtgH2eM1vDUbEK9ucmivh+CxaDLrhdck+0OKloXUPKVGVbUUq5BbvR1Rsww0HkaSYZ
         dBTpz5W9WPKRBWZqDORkgajY/trZt6VS80j4cL8vxdps97OqOb9mJWbRkVzXUNrtzo+5
         E56E1HJaUwj0VAgsoKyS8ZgytRVn7G11UfJ58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=RrDOZhX2BdUSOXPg+ko/Cm/nI74vx5xQFnZe9rt+GjI=;
        b=NZb8SA9xCfrn5JUetZDT5JzWim8hHE6a9OfFCbPV6DDp1syy9khxac9w8pdlNt26Nb
         DxDtcpcvAcrQ9oVYTnIChmGdPDncQRkiGFMwoYRBmcFRlLrx5NEI8+0ZGeHvkpWWRwqm
         lrSykN6twHimSOuJS+87EzRiwP97W/HlQrfSPLs6tof5uSzBLQap9Kcdoetfz7Sk1HjW
         utvAI4DtPoGMXAXJXwHktAPsTq2T5UUrlrLGOPrCTsuWPxWYK+TwjTbwOVnxs8RiFxKR
         6FpHgHOyYYbLVbDnwMkQX6D+n4sEEBgSfWW+IEc7/TcgC6QYYqWPvWfi758Q8TgBV5pQ
         ZSRA==
X-Gm-Message-State: AHQUAuaoC5/CZp79bLduDJfhuI5NwGM5kz2fssAO1Wr93gfIKSkZOvVp
        P0BfQXN3PoDFFMn0TpFr3+XpMA==
X-Google-Smtp-Source: AHgI3Ib5nrnpCm9IAAwoPV44MT1+il+H2fbPLj6dgHmhuNShkbbWJcykhpjyWV5Fz+4rClxobV5zdQ==
X-Received: by 2002:a17:902:988b:: with SMTP id s11mr5584224plp.162.1549999951107;
        Tue, 12 Feb 2019 11:32:31 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id g14sm28211232pfg.27.2019.02.12.11.32.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 11:32:30 -0800 (PST)
Date:   Tue, 12 Feb 2019 11:32:29 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Lukasz Luba <l.luba@partner.samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, joel@joelfernandes.org,
        chris.diamand@arm.com, Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 0/2] drivers: devfreq: fix and optimize workqueue
 mechanism
Message-ID: <20190212193229.GT117604@google.com>
References: <CGME20190211153030eucas1p19bd9a7eca565ca066ab00dc2243cfb46@eucas1p1.samsung.com>
 <1549899005-7760-1-git-send-email-l.luba@partner.samsung.com>
 <26e38213-630f-94bc-ff80-1cad708c7f83@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <26e38213-630f-94bc-ff80-1cad708c7f83@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Feb 12, 2019 at 02:46:24PM +0900, Chanwoo Choi wrote:
> Hi Lukasz,
> 
> On 19. 2. 12. 오전 12:30, Lukasz Luba wrote:
> > This patch set changes workqueue related features in devfreq framework.
> > First patch switches to delayed work instead of deferred.
> > The second switches to regular system work and deletes custom 'devfreq'.
> > 
> > Using deferred work in this context might harm the system performance.
> > When the CPU enters idle, deferred work is not fired. The devfreq device's
> > utilization does not have to be connected with a particular CPU.
> > The drivers for GPUs, Network on Chip, cache L3 rely on devfreq governor.
> > They all are missing opportunity to check the HW state and react when
> > the deferred work is not fired.
> > A corner test case, when Dynamic Memory Controller is utilized by CPUs running
> > on full speed, might show x5 worse performance if the crucial CPU is in idle.
> 
> The devfreq framework keeps the balancing between performance
> and power-consumption. It is wrong to focus on only either
> performance or power.
> 
> This cover-letter focus on the only performance without any power-consumption
> disadvantages. It is easy to raise the performance with short sampling rate
> with polling modes. To get the performance, it is good as short as possible
> of period.
> 
> Sometimes, when cpu is idle, the device might require the busy state.
> It is very difficult to catch the always right timing between them.
> 
> Also, this patch cannot prevent the unneeded wakeup from idle state.
> Apparently, it only focuses on performance without considering
> the power-consumption disadvantage. In the embedded device,
> the power-consumption is very important point. We can not ignore
> the side effect.
> 
> Always, I hope to improve the devfreq framwork more that older.
> But, frankly, it is difficult to agree because it only consider
> the performance without considering the side-effect.
> 
> The power management framework always have to consider
> the power-consumption issue. This point is always true.

I missed the impact of forcing a CPU out of an idle state and/or not
allowing it to enter a more power efficient state. I agree that this
should be avoided.

I wonder if using a power-efficient workqueue could help here:

  Instead of running work on the local CPU, the workqueue core asks the
  scheduler to provide the target CPU for the work queued on unbound
  workqueues (which includes those marked as power-efficient). So they
  will not get pinned on a single CPU as can happen with regular
  workqueues.

  https://lwn.net/Articles/731052/


Since this series also changes from a custom to system workqueue it
seems worth to mention that there are power-efficient system workqueues:

system_power_efficient_wq
system_freezable_power_efficient_wq


In case a power-efficient workqueue is suitable in principle there
would still be a problem though: the feature is currently disabled by
default, hence devfreq couldn't really rely on it. It is enabled in
the arm64 defconfig though, so at least devices on this architecture
would benefit from it. Also power-efficient workqueues might be
enabled by default in the future as the scheduler becomes more energy
aware.

Cheers

Matthias
