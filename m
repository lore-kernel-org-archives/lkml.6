Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AA2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE36321934
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bi/zA0Di"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730114AbfBOATu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 19:19:50 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44240 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfBOATt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 19:19:49 -0500
Received: by mail-pg1-f193.google.com with SMTP id y1so3900250pgk.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 16:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/1zJlt70pEOWMDY89z1Jrc2U17E1dixZLwzhSqJa9Sw=;
        b=bi/zA0Di8mxoLwo6LmEwMiDYyU1uxg9BM/DXP3U+d6+pk9EJxX90SU07prTOcuqQXE
         pb1NpemfQVYvmlvnpVQGXZMnFhPbkdGMwTSzH5jnLmSDyOU6Z5R5BCvYU8nr7VVCcBjS
         j1+wdNp/N9hL7TZYgkTAN/84yWgKbjeeJQ3Aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/1zJlt70pEOWMDY89z1Jrc2U17E1dixZLwzhSqJa9Sw=;
        b=tfUySojPXVIXBneiKteNOes4sKDyKyaVY67JL38bkpGMTmIKhJIzS7nqDgxIolvWtV
         OSYQpV50fY8smVnEt7MtPOA969qobdAxXvx5ri6YxSQTDC2jqOjeoRE1r06hqgLQ6icj
         EyeP63g/krUex9RScTO+uNXiYetSdrHVsRPFUxqbBjUf5hB+e4nrXXMIscz/alyM8Ydk
         z40Wan3Hjjmtn+SUv6u+JE3mVAFEFw4DZt9Nll/ULmnqN6nZq32HkejzkU0yMTU8p1hy
         KylCqVmh7W7xzqmF7fIvXNAgEhKVSCVqYG1a06h9QsRDAU85oMiYg7kCa7a6v72eVd+u
         E/TA==
X-Gm-Message-State: AHQUAuas1FJadMgBn0sQSTXfrFwTGp1NvYqMn4nCBZKh3DdbXkCx8faZ
        uSu2tS0MUpQNPlqEHan0YWVgSw==
X-Google-Smtp-Source: AHgI3IafKF/a8Cd43B/3Cqt0UKavoPu6uLLpXMdRRhstGi7T9f7A3ZY9HHAz1+xWIUbkEJQVw4TMdQ==
X-Received: by 2002:a65:4101:: with SMTP id w1mr2609218pgp.257.1550189988494;
        Thu, 14 Feb 2019 16:19:48 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id 62sm4122568pgc.61.2019.02.14.16.19.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 16:19:47 -0800 (PST)
Date:   Thu, 14 Feb 2019 16:19:47 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Chanwoo Choi <cwchoi00@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: Re: [PATCH 4/4] PM / devfreq: Handle monitor start/stop in the
 devfreq core
Message-ID: <20190215001947.GF117604@google.com>
References: <20190214013042.254790-1-mka@chromium.org>
 <20190214013042.254790-5-mka@chromium.org>
 <CAGTfZH118diXgKHetWwiNMXHALxXqt=MSh9oVv+nt4-SJkzN2Q@mail.gmail.com>
 <CGME20190214192933epcas5p204c34010accb5e63480abd3ca34991eb@epcas5p2.samsung.com>
 <20190214192855.GD117604@google.com>
 <b28e763d-c3c9-0673-6216-f67561112b60@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b28e763d-c3c9-0673-6216-f67561112b60@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,

On Fri, Feb 15, 2019 at 08:42:30AM +0900, Chanwoo Choi wrote:
> Hi Matthias,
> 
> On 19. 2. 15. 오전 4:28, Matthias Kaehlcke wrote:
> > Hi Chanwoo,
> > 
> > On Thu, Feb 14, 2019 at 11:17:36PM +0900, Chanwoo Choi wrote:
> >> Hi Matthias,
> >>
> >> As I commented on the first patch, it is not possible to call some codes
> >> according to the intention of each governor between 'devfreq_moniotr_*()'
> >> and some codes which are executed before or after 'devfreq_moniotr_*()'
> >>
> >> For example, if some governor requires the following sequence,
> >> after this patch, it is not possible.
> >>
> >> case DEVFREQ_GOV_xxx:
> >>         /* execute some code before devfreq_monitor_xxx() */
> >>         devfreq_monitor_xxx()
> >>         /* execute some code after devfreq_monitor_xxx() */
> > 
> > As for the suspend/resume case I agree that the patch introduces this
> > limitation, but I'm not convinced that this is an actual problem.
> > 
> > For governor_start(): why can't the governor execute the code
> > before polling started, does it make any difference to the governor
> > that a work is scheduled?
> 
> The some governors might want to do something before starting
> the work and do something after work started. I think that
> the existing style is more flexible.

Could you provide a practical example that answers my question above:

"why can't the governor execute the code before polling started, does
it make any difference to the governor that a work is scheduled?"

> And,
> It has one more problem when changing the governor on the fly
> from simple_ondemand to other governors like performance,
> powersave and so on.
> 
> Even if other governors don't need to monitor the utilization,
> the work timer will be executed continually because the devfreq
> device has the polling_ms value. It is not necessary
> of the other governors such as performance, powersave.
> 
> It means that only specific governor like simple_ondemand
> have to call the devfreq_monitor_start() by itself
> instead of calling it on devfreq core.

yes, I noticed that too, it can be easily fixed with a flag in the
governor.

> > For governor_stop(): why would the governor require polling to be
> > active during stop? If it needs update_devfreq() to run (called by
> > devfreq_monitor()) it can call it directly, instead of waiting for the
> > monitor to run at some later time.
> 
> As I knew, if the current governors are performance/powersave/
> userspace, the monitoring is already stopped and not used.
> Because they don't need to handle the codes related to the work
> like queue_delayed_work(), cancel_delayed_work_sync().
>
> And,
> In case of the existing style for calling devfreq_monitor_*(),
> other governors like performance/powersave/userspace/passice
> don't need to call the devfreq_monitor_stop() because they
> didn't use the work timer.

As per above, the governor could have a flag indicating that it
doesn't need load monitoring.

I think it should be avoided to expect the governors to do the right
thing if certain actions are mandatory and common for all governors
(unless the feature in question is not used). It should be handled in
the core code, unless there are good reasons not to do this.

With thispatch set the amount of code remains essentially the same,
and no new code needs to be added for governors that don't do anything
special in start/stop/suspend/resume.

TBH I think probably the entire event handler multiplexing should go
away and be changed to a struct devfreq_ops with optional callbacks
for start, stop, suspend, resume and update interval. As far as I can
tell the multiplexing isn't needed and separate ops would result in
cleaner code, in both the devfreq core and the governors.

Cheers

Matthias
