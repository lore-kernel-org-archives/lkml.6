Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FC2C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E3262086B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LpSOnnZR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E3262086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbeIJOGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 10:06:52 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:45559 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbeIJOGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 10:06:52 -0400
Received: by mail-io0-f193.google.com with SMTP id e12-v6so25776iok.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 02:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bKwLsGkvnyzYF+jIdXeK91qBWk7wtIOS4afg/iF9Fb0=;
        b=LpSOnnZR66xGj+ikztCUeMi0WiSBFLsNRdTC5l2cVAxdmF51KJiCBHHvMQ8qlHONsi
         gITXst3ePXL8BT6UbKx7XwWCSFB5FSNGzn5Vp+pTqzhXlC9NrvajVKNBd5p5Rt1U7VdF
         bodp/csTE3V9YrZBnXEdSCafnUVZfvrPmfoZRRkji37exUCJUg30E+7mzrHKGloILzGp
         O+4KUDHd1jWHS33BkcDOp5p5WRs98Bs8I02NrR3MBtrLYMllA/HwwkMVfpEWY0/FeQU+
         rF2yUfeDGBGC/LcfqDL0C5hP684YDqpeD/EkdB2NIk+C7t4EFd67J9bwLcxr1dig6GEt
         apEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bKwLsGkvnyzYF+jIdXeK91qBWk7wtIOS4afg/iF9Fb0=;
        b=oI4tVFwm82473JqGsJ7VQ1bSv/PIIsoxbSv1e0qpP0YWxievcupw+2rD4Ip6xd/Ld6
         MHmeDcSwFPyAaKUiCr0vIa91vH3uNRVKk3cr3sQYYYPXw0ty912kOENQGigvJXbmmVeG
         CeykchfJEaBS0ZQ7TdH7/IFJwMfzqisWMeUA/LRl76f46lsoJIP16m8sb/qS5INYgevB
         BhMxBxsVpzHGfelW8pwP7QztjPhE1b5b+cmsjAUMHk4iRP+A56kiTAT1ZADaRk1TRBgn
         9F4pA3c1xcotBQSgEz+X5qO3Qj6JZU9iLkb2SM+iojqcgG/pKmhwY96a19MjihHlVbGW
         aOag==
X-Gm-Message-State: APzg51B7tCq1PbSkkzy1jjPhQd/dQo8FS7PnY8n3T3KRy1/V5epsIN2b
        VRtUmkF11tw/gKm49o0PmQwtn6KB30brMVoFEaTAGwh7dDY=
X-Google-Smtp-Source: ANB0Vdag8QSLYW4JY4NSiGVI4f7jHPk0sDQ+v5CAu0M9gZbp0JLZVV1bexDuEbFJXOFiaUa8MFP/aIqul5knPJUwkZA=
X-Received: by 2002:a6b:18c5:: with SMTP id 188-v6mr15388663ioy.211.1536570827585;
 Mon, 10 Sep 2018 02:13:47 -0700 (PDT)
MIME-Version: 1.0
References: <20180718160956.19864-1-enric.balletbo@collabora.com>
 <20180718160956.19864-3-enric.balletbo@collabora.com> <20180907075438.GB95655@rodete-laptop-imager.corp.google.com>
 <20180910091208.GH28860@dell>
In-Reply-To: <20180910091208.GH28860@dell>
From:   Benson Leung <bleung@google.com>
Date:   Mon, 10 Sep 2018 17:13:34 +0800
Message-ID: <CANLzEkvuNYS4q_bATF1kz205dzfrjzEkRZ0MaT71-Cd46-D0fA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mfd: cros_ec: Fix and improve kerneldoc comments.
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 5:12 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Fri, 07 Sep 2018, Benson Leung wrote:
>
> > Hi Enric,
> >
> > On Wed, Jul 18, 2018 at 06:09:56PM +0200, Enric Balletbo i Serra wrote:
> > > cros-ec includes inside the MFD subsystem, specially the file
> > > cros_ec_commands.h, has been modified several times and it has grown a
> > > lot, unfortunately, we didn't have care too much about the documentation.
> > > This patch tries to improve the documentation and also fixes all the
> > > issues reported by kerneldoc script.
> > >
> > > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> >
> > Applied, thanks.
>
> If applying patches from other subsystems, you need to wait for an
> appropriate Ack before applying.  Please send me a succinct
> pull-request for this patch, so that we might avoid potential conflict
> at merge time.
>

Ok Lee, sorry about that.  Actually this hasn't landed in my for-next
branch yet so no conflict has happened yet. I  will send you a PR
shortly.



-- 
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org
