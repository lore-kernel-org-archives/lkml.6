Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6A7C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 507E62098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gGZzHJqk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 507E62098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbeJDPSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 11:18:03 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38782 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727325AbeJDPSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 11:18:03 -0400
Received: by mail-io1-f65.google.com with SMTP id e2-v6so5532651ioh.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 01:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4mjjJU8n40vSZZvAZqSV5idSHC7+L4DCzd8oCuPu6Cs=;
        b=gGZzHJqkghBmRSrfFCCu8DRBk9wYUsEJifqd0oakuzHDmpacZM1PwzDfgNeQF2Hq2Z
         4uBnNkf0KzFPUu2pJwetw8wqHlde7fmWuR5dbSs2ACxDyhpnnSgK3vzbv2iVK1NozXdc
         8jozlmVESC89QhYNxLLtujvT/t3mrQbBHp/8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4mjjJU8n40vSZZvAZqSV5idSHC7+L4DCzd8oCuPu6Cs=;
        b=JdyYDMbD7eS6Fht2o7YQfcjNLEovE8nG+Duru4nKwbKqOSs8OdzmAVuDkPB5/J7NAr
         tTItfbo71mZieVNmK6nUtczJbk0bhKVFCwv7LIW8A/5abDsyYUtEXW7xM2nlTu+5pxf3
         niuMl6C7pQdp1nlNcM5R/dYR4ue5S40ptN9N/Oc2O7Vcv0YvTh4Ek1ZRo9JITBhozmL/
         zHuszmoPrslG7jEoPPqBgGLBaWXIlcEoh0EIATyPHZp0JNeEl0jIuO54Qqr6JmmGq0IB
         M6fxNGmEFRhMF3DVorlAJFBx4g9gFBHHMMiHNYm4xtJDrwTSNBSKO4i/hFFaDFs0q0FU
         5o0A==
X-Gm-Message-State: ABuFfogo89avm6zXwfTjq/SOu/1S+o+f9UzuzH5QMUVKN9UzMalris0X
        XUpKq/SC8FchgsMi+wtAetflLid6yDSYVDj9YLwQUw==
X-Google-Smtp-Source: ACcGV62jKEK7P/B9TH+D+aqHNbgNnXo9jTCBYpod20OrgAB5Oq+bWFpiu7GDS9nBrhQMBVVP/umcEitvm67qty1Imnc=
X-Received: by 2002:a6b:4006:: with SMTP id k6-v6mr3373931ioa.277.1538641556569;
 Thu, 04 Oct 2018 01:25:56 -0700 (PDT)
MIME-Version: 1.0
References: <20181002124329.21248-1-linus.walleij@linaro.org>
 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk> <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
 <1eca41df95ff660eb247a3de666adeb4@natalenko.name>
In-Reply-To: <1eca41df95ff660eb247a3de666adeb4@natalenko.name>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 4 Oct 2018 10:25:43 +0200
Message-ID: <CACRpkdb1YSw3WWpGSqwxORaMSAeemiaP4i6cWJcY5VtADfzorQ@mail.gmail.com>
Subject: Re: [PATCH] block: BFQ default for single queue devices
To:     oleksandr@natalenko.name
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-mtd@lists.infradead.org, Pavel Machek <pavel@ucw.cz>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jan Kara <jack@suse.cz>, aherrmann@suse.com, mgorman@suse.com,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        bfq-iosched@googlegroups.com, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 3, 2018 at 1:49 PM Oleksandr Natalenko
<oleksandr@natalenko.name> wrote:

> On another hand, the users of embedded devices, mentioned by Linus,
> should already know what scheduler to choose because dealing with
> embedded world assumes the person can decide this on their own, or with
> the help of abovementioned udev scripts and/or Documentation/ as a
> reference point.
>
> So I see no obstacles here, and the choice to rely on udev by default
> sounds reasonable.

I am sorry but I do not agree with this.

There are several historical precedents where we have
concluded that just "have the kernel do the right thing
by default" is the way to go.

Example 1: pluggable CPU schedulers.
The reasoning was that users or distros have no clue what
scheduler they want, only scheduler developers do. We
drove it to the point where we have one and one
scheduler only, not different flavors. (Special
usecases have special scheduling classes inside the
one scheduler instead.)

Example 2: Automatic process group scheduling
The reasoning was that daemons such as systemd would
be better at placing processes/tasks into the right
control groups to manage their resources, so this would
be a userspace policy handled by the udev/systemd
complex. We did not do that. Instead the kernel does
autogrouping per-session, indeed it is a Kconfig option
but even e.g. Fedora has this enabled by default.
(commit 5091faa449ee)

As pointed out elsewhere: these defaults make it
easy for custom builds not using udev+systemd to
get a system up and running with sensible defaults.

Simple embedded systems use Busybox' mdev (I wouldn't
trust it do do any complex decisions). OpenWRT
has ubox+ubus+uci, also extremely lightweight,
Android has its own init system that I don't
manage to keep track of anymore. Instead of running
all over the map and fixing these userspaces to
do the right thing, it makes sense to make the
right thing the default.

And these are millions and millions of deployed
systems not using udev+systemd we are talking about,
they are not fringe hobby projects. It's not that I
personally dislike udev or anything, I kind of like
it, but these tailored distros simply don't use it
and they are huge in numbers. They need help to do
the right thing. Fixing a udev rule doesn't solve
even half the world's problems I'm afraid.

Yours,
Linus Walleij
