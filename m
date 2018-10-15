Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81213C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 10:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ABB320881
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 10:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqOlZsGh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ABB320881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbeJOSEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 14:04:34 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42731 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbeJOSEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 14:04:34 -0400
Received: by mail-io1-f65.google.com with SMTP id n18-v6so13824759ioa.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 03:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mi3C+KuSj5f477ub1b5sS7wleOfjYxeL5Yey+r/4aHM=;
        b=YqOlZsGhEjQF8YJq98DTACUVliRX6lNoLhCh+e2QOCmrcprhhfv8+/ciRjxGtE6V5C
         PxZDjD1sKeKDag/wTQ9t0C0vG4QV1nGJ/NKfJrOw5rI/g2eGE/RD5+hoqu2L3E5k3K5T
         X/ft1VKWZtnKgSZBvEIcXABTFWMPM9TWH2sapLJN3+seivHKF7KF7zsIvjwgpLMMfvuC
         FlHZpZx04epYllYiFMHmVviGAUUP0DBZwxSI/25o5wt1h2l8mdiGQPepj3Y0Ig+qJUKM
         OSIAOLlbFTEH+tz744f/GdRERkPRddqVbVwOdwgA3RWHvIdhripqM1xQ7LFyHTaZ+Q6n
         GBvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mi3C+KuSj5f477ub1b5sS7wleOfjYxeL5Yey+r/4aHM=;
        b=VR303A8oLPXK0bFJY4lfFm23mIYa+I+UbDw3bXUOk7ZcH/zLTR/Pcn98kNTtnmM4tw
         Cjj9+Rcshv7Mx3ClYQ0sG/ewpS0mLizXNX+XNQ+WUEl8gXHQjpZ3XEZ6OZCDIDRpqgrd
         vY5UjTxSvrI7ccgzu2o9C1E+oZbwI8/k9+C/5qyxn68bcHD2ax2o083FxcB7XXU2j/Ln
         1m72FL5xM671UaErbp85CLoyQnBAxvSyIZblfJf8V3Kp+9MN/n+PRu2U0MJxJkfkJ57T
         7l74gUodKky4a53+4G1I7VX4F5bdXG+OqgKF+y0b9ley98ZjJTXj86OBLl+K8CwRvkK8
         dgKw==
X-Gm-Message-State: ABuFfojoJzHWi4B5Dqsn4wJ4XiJ/4JoxNr77IaCuPVoo7iqdrGmxUdbb
        ZTM4tguo4eA900GZFURXpxgN53oAEIUFoPylrK8=
X-Google-Smtp-Source: ACcGV60pqcu1i4kBYrIi2dTwUZATq/+JjBRvYLYUiGg+6arWaU4VczwQE5Nb+MFctW92Io1eBf5TrI1HiETR0yV+tJ0=
X-Received: by 2002:a6b:f408:: with SMTP id i8-v6mr11106429iog.278.1539598797203;
 Mon, 15 Oct 2018 03:19:57 -0700 (PDT)
MIME-Version: 1.0
References: <20181015045927.156790-1-toddpoynor@gmail.com> <20181015073318.GB14476@kroah.com>
In-Reply-To: <20181015073318.GB14476@kroah.com>
From:   Todd Poynor <toddpoynor@gmail.com>
Date:   Mon, 15 Oct 2018 03:19:45 -0700
Message-ID: <CAO3upoYRgCxaF7_NG7J+p+PgLn+yBfnWPkM87TK75DauJOodBw@mail.gmail.com>
Subject: Re: [PATCH 00/11] staging: gasket: fixes
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Springer <rspringer@google.com>,
        Ben Chan <benchan@chromium.org>, devel@driverdev.osuosl.org,
        lkml <linux-kernel@vger.kernel.org>,
        Todd Poynor <toddpoynor@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 12:33 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sun, Oct 14, 2018 at 09:59:16PM -0700, Todd Poynor wrote:
> > From: Todd Poynor <toddpoynor@google.com>
> >
> > Various fixes for gasket/apex drivers.
>
> For some reason you seem to have ignored/missed this patch:
>         Subject: [PATCH v3] staging: gasket: Fix sparse "incorrect type in assignment" warnings.
> that was sent last week.
>
> Any specific reason?

Coming off a 2 week vacation, I'm behind on everything.  I saw you had
commented already, but I'll take a look as well, sure.

>
> thanks,
>
> greg k-h



-- 
Todd
