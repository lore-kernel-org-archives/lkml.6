Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0080EC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE1FA2175B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qy/QX56c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729741AbfBFNCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 08:02:39 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:46843 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727644AbfBFNCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 08:02:39 -0500
Received: by mail-ua1-f65.google.com with SMTP id v24so2196004uap.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 05:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a6/1hWE3LIM2fJXOQZ2WMd+RZy3RSXMlCl61vcVVSPU=;
        b=qy/QX56cfGFCUD710ej++PJrJY/PpjMCeB8zN43WjiiNoTtWm+uWeH36WoN39x2MN4
         xalrgBWnyqPdFYvGxdj7YS64WOaISMRMCNqAcb/n3CdRjmH4SegMzUusBBs5mLcBAV1z
         ypDyVamjHqFRUwKJWJxnotovtssblR0Wx4hr3gHcKUk/pbvWJiIDXjUnO2C9nJ+ahltA
         KOqN1jx2cW9X+4rmYk/Trk8UqxgXwuOh9epoq1R3MvHE7qRK4UhqnBjfFeQA1QPv0nW6
         nYt+c40l9AqiyDw8Gp3V18R4Er4xQMkzEqVqGKhfYw5/2zmRzxSzyaQkffmbS3R9000+
         t8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a6/1hWE3LIM2fJXOQZ2WMd+RZy3RSXMlCl61vcVVSPU=;
        b=Z6occRcvMT4Xg52D1frXcAbypEMDYEmCGy3koNF9V+7hwaQNumRlspKmIN+H/37YzE
         8vtkl9FgFRYeNo9eKUgGzgvs4QBoLVoS3/eLADCsyIe4PXtavqC7AuoZjVcxjaZrNbTu
         LoOvsZFHL5m+XfrUJCU6lp6m2AzhMoFrPeJxlTpZVTt5dWUUKR2dcjwlnHv3uZOP2w3p
         1viNig1GesVo8Nrwswwi2rEFh3/IW/kZhdoiO/2u049dzfCAUG2LE2LbHJVIbImXavI3
         Lg7lYtQL+fDaEHtOJKw9LocOUQtFZKkJy9uYiIHI9QcWcb+XjD8UUlXp6KT1mBQLrPrc
         snHQ==
X-Gm-Message-State: AHQUAuacyrSCA6nJuGP/Y+Q2V9eyggnKEKsQQwFwUkqDXnskl7OEneI3
        NN2QXE7zKgN110Dap8CFObD3R6RyNKeC7VNJEhAPog==
X-Google-Smtp-Source: AHgI3IbLpLtk5frS78bFye2MgzDu8Osx3cAjvRkT301d1d1zj4JyO9tNIL94LhQVzbxVd5q+bEp1qPROlmmYQP/Qvcc=
X-Received: by 2002:ab0:b83:: with SMTP id c3mr1983520uak.77.1549458157468;
 Wed, 06 Feb 2019 05:02:37 -0800 (PST)
MIME-Version: 1.0
References: <1952449.TVsm6CJCTy@aspire.rjw.lan> <CAJZ5v0jOVLZDoW5BAy9obp7AptTYzKikFo7Qd15kNt5Y9=vXRQ@mail.gmail.com>
 <CAPDyKFrq-r-rFDDB3yU=W4mOF2-A4xGGomqFqUba6MVWZugHmQ@mail.gmail.com>
 <24600564.pMaimVIQbW@aspire.rjw.lan> <CAJZ5v0gBYyoumVkLTuEcHsFE8QKEXdYuhDRGwmvoKPhx7gPvgQ@mail.gmail.com>
 <CAPDyKFoUfM8kopWfkorDhVKfk35wVaKVPzJeZ55RPRdc2Y1MYw@mail.gmail.com> <CAJZ5v0hnXyqdrq3cXLuwZ-imda2=EEUEq8rx=en7=DwdgB5N9A@mail.gmail.com>
In-Reply-To: <CAJZ5v0hnXyqdrq3cXLuwZ-imda2=EEUEq8rx=en7=DwdgB5N9A@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 6 Feb 2019 14:02:00 +0100
Message-ID: <CAPDyKFoQWTANLTdO1Ci_Vvtsq+QhWMxo=MZ811MoE6LSDWb7ng@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] driver core: Fix some device links issues and add
 "consumer autoprobe" flag
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lukas Wunner <lukas@wunner.de>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Lucas Stach <l.stach@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Feb 2019 at 13:10, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Feb 6, 2019 at 12:24 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Wed, 6 Feb 2019 at 10:56, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Tue, Feb 5, 2019 at 12:27 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > >
> > > > On Tuesday, February 5, 2019 9:15:49 AM CET Ulf Hansson wrote:
> > > > > On Mon, 4 Feb 2019 at 12:45, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > > >
> > > > > > On Mon, Feb 4, 2019 at 12:40 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > > > >
> > > > > > > On Fri, Feb 1, 2019 at 4:18 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > [cut]
> > >
> > > > > >
> > > > > > For example, if the consumer device is suspended after the
> > > > > > device_link_add() that incremented the supplier's PM-runtime count and
> > > > > > then resumed again, the rpm_active refcount will be greater than one
> > > > > > because of the last resume and not because of the initial link
> > > > > > creation.  In that case, dropping the supplier's PM-runtime count on
> > > > > > link deletion may not work as expected.
> > > > >
> > > > > I see what your are saying and I must admit, by looking at the code,
> > > > > that it has turned into being rather complicated. Assuming of good
> > > > > reasons, of course.
> > > > >
> > > > > Anyway, I will play a little bit more with my tests to see what I can find out.
> > > > >
> > > > > >
> > > > > > > Arguably, device_link_del() could be made automatically drop the
> > > > > > > supplier's PM-runtime count by one if the link's rpm_active refcount
> > > > > > > is not one, but there will be failing scenarios in that case too
> > > > > > > AFAICS.
> > > > >
> > > > > Let's see.
> > > >
> > > > So for the record, below is the (untested) patch I'm thinking about.
> > > >
> > > > Having considered this for some time, I think that it would be better to
> > > > try to drop the supplier's PM-runtime usage counter on link removal even if
> > > > the link doesn't go away then.  That would be more consistent at least IMO.
> > >
> > > So I can't convince myself that this is the case.
> > >
> > > Either way, if there are two callers of device_link_add() for one
> > > consumer-supplier pair trying to add a stateless link between them and
> > > one of these callers passes DL_FLAG_RPM_ACTIVE set in the flags to it,
> > > there may be issues regardless of what device_link_del() and
> > > device_link_remove() do.  However, if they decrement the link's
> > > rpm_active refcount (and possibly the supplier's PM-runtime usage
> > > counter too), the supplier may be suspended prematurely, whereas in
> > > the other case (no decrementation of rpm_active, which how the code
> > > works after this series) it may just be prevented from suspending.  To
> > > me, the former is worse than the latter.
> >
> > Well, I would say it sucks in both cases. :-)
> >
> > >
> > > Moreover, there is a workaround for the latter issue that seems to be
> > > easy enough: it is sufficient to let the consumer runtime suspend
> > > after calling device_link_add() to create the link (with
> > > DL_FLAG_RPM_ACTIVE set) and before trying to remove it.
> >
> > I get your point, but unfortunate I don't think it's that simple.
> >
> > For example, someone (like a child) may prevent runtime suspend for
> > the consumer. Hence, also the supplier is prevented from being runtime
> > suspended.
>
> Well, in that case the supplier should not be suspended until the
> consumer can be suspended too.
>
> IOW, if you call device_link_del() in that case, it would be a bug if
> it allowed the supplier suspend.

Well, maybe the "child" was a bad example. The point is, the driver
doesn't control the RPM child count and nor the RPM usage count for
its consumer device - solely by itself.

Someone, like the driver/PM core can at some point decide to increase
the runtime PM usage count for example for the consumer device. For
whatever good reason.

>
> > So, if you want to push this responsibility to the driver, then I
> > think we need make __pm_runtime_set_status() to respect device links,
> > similar to how it already deals with child/parents.
> >
> > In that way, the driver could call pm_runtime_set_suspended(), before
> > dropping the device link in ->probe(), which would allow the supplier
> > to also become runtime suspended.
>
> I guess you mean that runtime PM would be disabled for the consumer at
> that point?

Yes.

Calling pm_runtime_set_suspended() should be a part of the error path
in the driver, which includes disabling runtime PM as well (if it
enabled it in the first place of course).

>
> > I did a quick research of users of device links, unless I am mistaken,
> > this seems like an okay approach.
> >
> > What do you think?
>
> Well, I think I need to know the exact use case you have in mind. :-)

The use case is simply a generic driver that fails to probe by
returning -EPROBE_DEFER. So it's hypothetical, but I often tests
common sequences by using my RPM testdriver, to make sure it all works
as expected.
The below sequence is common, so then I have added the use of device
links, to see how this plays. And it doesn't.

->probe()
  ...

  pm_runtime_get_noresume()
  pm_runtime_set_active()
  pm_runtime_enable()

  ...

  device_link_add(con, supp, DL_FLAG_STATELESS |DL_FLAG_PM_RUNTIME |
DL_FLAG_RPM_ACTIVE);

we got some errors...
  goto err:

  ...

err:
  pm_runtime_put_noidle()
  pm_runtime_disable()
  pm_runtime_set_suspended()

  device_link_remove()

  return err;

Kind regards
Uffe
