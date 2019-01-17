Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C52FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F36620868
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ukgrokuh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728586AbfAQVRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 16:17:04 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:34950 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728286AbfAQVRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 16:17:04 -0500
Received: by mail-yb1-f193.google.com with SMTP id h81so3264754ybg.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 13:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L8+pWFbjCXuZb0yF6AHOy187X+FZaQYqjUOMZpie9bQ=;
        b=UkgrokuhmHu5BHG9ibxHHWYsSKQA3yFgbi4+RJoVYS4roItRbCA+YtWxsQ3IbIDK5e
         pDvM+E6OCfoYyABAXjNnhy/jgIkT29DAdAIg/ZFVFfydlbfpF0A8+udmJ3KQVH/OGaTO
         vvtCH0aH7OLaI74+5J3X087dmFrWAnpfUMDkCkXU0CExTZrM6srsrUS7NrpjCJrAe7G/
         XunrDnB5IDTQCVFGiK+3QED+lKX1ms3JGwriAmXv3Wm4VeFIaktUpi9h5AlESJQ2dTc5
         Zday/2myvmMO5cZu6rGcDT/6oVsiTJVGQvOafg0pBDZXEYuYh4AFKFunlkL1tnb+oZ8h
         SNYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L8+pWFbjCXuZb0yF6AHOy187X+FZaQYqjUOMZpie9bQ=;
        b=ZwrBXzVCQGvLuZdTdLHWGR6QJVviSe0yv5q/WD7veug6sGXYlFTR5/JMu2tATNCRow
         B+1phwrEVe7O9iFgSiBIhJmvR0BnZSAXuuxa3wT5Kk4q5uBHnJ/JEd7vZX8YWS1Hcf1f
         uro/HNJRu3pUpRLsfxJSm7fOJq4yP3bzJhqRC3++ne5BW2nZe1XTMLvhMmavVcRF98EH
         pGgsAW6XjZ0bNeeFgpi4XxN920TBmZk44HDiR6KfjeghJ5mnjsl6l4gVG0uvM3Bv+tAn
         QsR+lQOd0A4qBOGI6qglE5MmFAuMJOltuBDetF8/yPjCofWEKIEqL+FBIsvyT8ClkWgW
         yiRQ==
X-Gm-Message-State: AJcUukdG7xLr6BBEj+LpnX3i68VD9SipXMuLQSRrOC3yXmJGzowirPRK
        jV3WzShbbSkHZpmugjdXQfQSwFBPOMf2tUuDps8gzQ==
X-Google-Smtp-Source: ALg8bN5L/+ZMMprFQ2JLwBhESmh/RacXyg5Z5w5UMTcZ6sNZUnbODdvqnV98JCzG9xUJjtbbSo2TxGh09Tfuc+xYG/M=
X-Received: by 2002:a25:7ec5:: with SMTP id z188mr3790812ybc.282.1547759822737;
 Thu, 17 Jan 2019 13:17:02 -0800 (PST)
MIME-Version: 1.0
References: <20190117151942.6092-1-saiprakash.ranjan@codeaurora.org>
 <154775022743.169631.1716489383315213219@swboyd.mtv.corp.google.com>
 <CABXOdTfE+_q8DrRfPE1V+3pU7x5rLoOy7k5LYMrwd+xojsBWvw@mail.gmail.com> <20190117211410.GA30749@anatevka>
In-Reply-To: <20190117211410.GA30749@anatevka>
From:   Guenter Roeck <groeck@google.com>
Date:   Thu, 17 Jan 2019 13:16:51 -0800
Message-ID: <CABXOdTefAMjNypoa9uB2nMgAwi_e1pRMRxiDbXGfGT8_v7Ho-Q@mail.gmail.com>
Subject: Re: [PATCHv2] watchdog: qcom: Add suspend/resume support
To:     Jerry.Hoemann@hpe.com
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 1:14 PM Jerry Hoemann <jerry.hoemann@hpe.com> wrote:
>
> On Thu, Jan 17, 2019 at 11:09:31AM -0800, Guenter Roeck wrote:
> > On Thu, Jan 17, 2019 at 10:37 AM Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > > Quoting Sai Prakash Ranjan (2019-01-17 07:19:42)
> > > > diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
> > > > index 780971318810..5dfd604477a4 100644
> > > > --- a/drivers/watchdog/qcom-wdt.c
> > > > +++ b/drivers/watchdog/qcom-wdt.c
> > > > @@ -245,6 +245,28 @@ static int qcom_wdt_remove(struct platform_device *pdev)
> > > >         return 0;
> > > >  }
> > > >
> > > > +static int __maybe_unused qcom_wdt_suspend(struct device *dev)
> > > > +{
> > > > +       struct qcom_wdt *wdt = dev_get_drvdata(dev);
> > > > +
> > > > +       if (watchdog_active(&wdt->wdd))
> > > > +               qcom_wdt_stop(&wdt->wdd);
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +static int __maybe_unused qcom_wdt_resume(struct device *dev)
> > > > +{
> > > > +       struct qcom_wdt *wdt = dev_get_drvdata(dev);
> > > > +
> > > > +       if (watchdog_active(&wdt->wdd))
> > > > +               qcom_wdt_start(&wdt->wdd);
> > > > +
> > > > +       return 0;
> > > > +}
> > >
> > > This looks fairly generic. For example, the Mediatek driver also stops
> > > and starts (but also pings after starting). Grepping for 'active' in
> > > drivers/watchdog/ finds more examples. Could there be some functions in
> > > watchdog core that do the common things like watchdog_stop() and
> > > watchdog_start() and watchdog_start_and_ping()? Or maybe a bit can be
> > > set during registration so that the 'struct class watchdog_class' can
> > > get PM ops to stop and start on suspend/resume of the watchdog character
> > > device?
> > >
> > > Nothing is wrong with the patch, I'm just bemoaning the amount of code
> > > duplication here.
> > >
> >
> > Patch(es) to add the functionality to the watchdog core are welcome;
> > it should be possible to move the functionality into the core (maybe
> > to be enabled with a new watchdog API call). Doing it using the class
> > device sounds like an excellent idea. This should be straightforward
> > to implement, though the question of "should we ping on resume or not"
> > might be an endless source for bike shedding fun.
> >
> > Guenter
>
> It could be controlled by a currently unused bit in the
> watchdog_info.options.  Then people can agree to disagree.
>
I thought about that, but that would result in inconsistent behavior
across drivers. Of course we could be all fancy and make it runtime
configurable via ioctl.

Guenter
