Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FBDC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 596A320989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="fqwFjq9S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730749AbfA3MzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 07:55:24 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:38161 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbfA3MzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 07:55:23 -0500
Received: by mail-it1-f194.google.com with SMTP id z20so10296322itc.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 04:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zCtGeCpE1sxK4WmA7T+PvQTfrahghy4qlktyCsa5Yt4=;
        b=fqwFjq9SOMhYINWEIZY1e1CIdEaIT24AYg2hLKl5hxqkJbJx50YuUGueszHuSyIwdW
         LCjFQtwBe8Z1JJzZGvnYm7usPk7UR+qczBEjhwv3PqOppKKksSfpeJeMC+s8sulzbont
         5GhKcs3VxZI3rE72/tWrZ86maYbmoWe20xPv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zCtGeCpE1sxK4WmA7T+PvQTfrahghy4qlktyCsa5Yt4=;
        b=CuzNYcxxuADCsNAoIgTkLk82uWBz/R9VE6UAeX4to4Q5nDmxDjKp8dggQtMNftCmoI
         JoJdl3gUtGvn0lK6aPicoPiZNDBg0zOlotJm2iNGeRDmMBFKWfFj+7qN0pwAiQgjmTPn
         /HH9vVh/LRqnvAbdFJTfQWxsBfF0aM0Yb4L8DsKpetYD0wn4Ov8eCcni4JO9wjpE/feY
         ljPjYoB0+UsqqZZJ9vQeAeMpMp5X4JityIeYsNVy1uLeybxRnjPz/XtccEgFT9QzNj4D
         UdW6Bq68QaKIZgsN31SCOx7icxQ0jkZpcXc+OxxLIbt6Mv/CXiteDI9O6FKywE3hrhjd
         N0qw==
X-Gm-Message-State: AJcUukdJVB2SpSZeW/Eom4tXv6AAwnNY86oGej8MGEwFFMdey0F7fDip
        NrJuGJ4sq5wYZ9HY67S64RIucxcUrlhq27nJowekmQ==
X-Google-Smtp-Source: ALg8bN5ehJ0wTRd3T04vZqoLy387FYwsYOEgRKFWgD2TJtUKtMRXdH5Nz6RKl/hZ2HyxZiOyEC9Bb7encFrr7y5TN8w=
X-Received: by 2002:a24:4f07:: with SMTP id c7mr15993125itb.107.1548852922704;
 Wed, 30 Jan 2019 04:55:22 -0800 (PST)
MIME-Version: 1.0
References: <20190125192233.10019-1-jagan@amarulasolutions.com>
 <20190125192233.10019-2-jagan@amarulasolutions.com> <20190125195205.GA31938@ravnborg.org>
 <CAMty3ZAB9vceDu0g-mRhBr2poZHZdNq3D1_-Fp7uYxhGg3GrCg@mail.gmail.com>
 <CAMty3ZCejdo+ztipg0F0SSpSRZwxKxTbhbXA93YqM2GFozxFqg@mail.gmail.com> <20190129151916.GA12635@ravnborg.org>
In-Reply-To: <20190129151916.GA12635@ravnborg.org>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 30 Jan 2019 18:25:11 +0530
Message-ID: <CAMty3ZATzXmLX8GpiW-Qcysvz6nEcu44P7Ba_4pZWBZ_ijyiOw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] drm/panel: Add Feiyang FY07024DI26A30-D MIPI-DSI
 LCD panel
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-amarula@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 8:49 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Jagan.
>
> > >
> > > I see DRM_MODE_ARG as mode argument, that print all mode timings but
> > > here we need only 3 timings out of it. do we really need? if yes
> > > please suggest an example.
> >
> > fyi: sent v6 for this except this change. Let me know if you have any
> > comments on this.
>
> Drivers looks fine, the above was just a quick suggestion to use some
> exising plumbing.
>
> You have done a nice job following up on all the feedback.

Thanks, hope v6 will be apply soon.
