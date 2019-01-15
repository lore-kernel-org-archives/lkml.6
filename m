Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA05C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 05:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19A8520656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 05:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JUd0nvd3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbfAOFmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 00:42:45 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:44035 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbfAOFmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 00:42:45 -0500
Received: by mail-yb1-f195.google.com with SMTP id e1so590493ybn.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 21:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PXDiDbCWSojGdBQHy8QvvSwkVb8vcMJGGTZ3hLVJa2A=;
        b=JUd0nvd3wkt/6LG6T/IJx11IwhmrWtm5Y7xgOXGJmAUHHGKQpKlufxx371cdTMgZf/
         ZXqhP/BV2TKqFC4jAD2MEZJfQAJrOQ+Avj2D3n4c7Gbw5qdAZnQfBAV1W+9Stxr7wJp6
         sEUDzBNErQeMh0UmAh9Q0SnpdWeGMpEWIgyEDsoEazidy0JZU3FhK2oczf5MQn5UoSaB
         jI4gO4DVSneg+glXU6+bcCYsFNBetY0mljwlFWE5Ct7tjLqemB4S7i8kzFAciAok2cwO
         mfhMX0ekAzFut31VZawG+UIj7GwwVu4Uyue6LQacW3FfdzXPqArdL4ilZClmF09E3//V
         UBiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PXDiDbCWSojGdBQHy8QvvSwkVb8vcMJGGTZ3hLVJa2A=;
        b=WzkHrJHWkaxQB4TehB9AOUAOPDOZNMsbKOnw427uZBtrWp9Cgp5WEHUFXloCO78Cx6
         M9InFBByBg5KER7KOfMvgmJ1R5q7D9rRINXmbE42/VRZjSR+xQOSVl741EdYe8g50gmP
         xRHtJ4sEzt9rj7B4VzPtVYmob0wFTvbUoJhsKazkYS0/Q7yODLKbMYpQZDoazsehRUXS
         wy0326LS4KSx5XVje9yDi+xCGW/60DhvGFJh1YUWPJbZU01lzO2pMl9NcP6ACYAZpXTT
         KUuwSyxfWnPtknX5V1Bb81KTYXARoIyCwkD6GczyUFtxoj/gdMXQBGW3Kw1Ht9YwJbsC
         JGsQ==
X-Gm-Message-State: AJcUukdYl6Yu5W+HciId4IDd7aw6dVnw66/zR9BVHvIoIl76RZRduPOd
        NPptSolJJQawWXKFYez1z0fOX4cw5oOZZgdCfVM+sg==
X-Google-Smtp-Source: ALg8bN6KV2E2O7byvH4O7YT0Bi3NL9LMuGsMU9chgiXsQaYeG2x20Q06h9F0vRm2eAQBFbgjqhhrDBgZboSVHM7JfWg=
X-Received: by 2002:a25:c184:: with SMTP id r126mr1485509ybf.441.1547530963538;
 Mon, 14 Jan 2019 21:42:43 -0800 (PST)
MIME-Version: 1.0
References: <20181129195548.204153-1-egranata@chromium.org>
 <20181207222223.GA240898@google.com> <CAMHSBOU0qNrCfg5=N-4KXBS_0fTBRbHGY2V9R7Q9E9ZY7R-1Mg@mail.gmail.com>
 <CA+ASDXPt5fws82r71xjuVucB=gZCYVSjx5dMaGdbW6qFOuG0vA@mail.gmail.com>
In-Reply-To: <CA+ASDXPt5fws82r71xjuVucB=gZCYVSjx5dMaGdbW6qFOuG0vA@mail.gmail.com>
From:   Gwendal Grignou <gwendal@google.com>
Date:   Mon, 14 Jan 2019 21:42:30 -0800
Message-ID: <CAMHSBOVy+n+nf+Y_mu21QkNd9U7=Tq4=R6dQFLB_xy=Uh4AHkQ@mail.gmail.com>
Subject: Re: [PATCH] mfd: cros_ec: Add support for MKBP more event flags
To:     Brian Norris <briannorris@chromium.org>
Cc:     Enrico Granata <egranata@google.com>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Enrico Granata <egranata@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 6:04 PM Brian Norris <briannorris@chromium.org> wrote:
>
> Hi Gwendal,
>
> On Mon, Jan 14, 2019 at 3:50 PM Gwendal Grignou <gwendal@google.com> wrote:
> > On Fri, Dec 7, 2018 at 2:22 PM Brian Norris <briannorris@chromium.org> wrote:
> > > On Thu, Nov 29, 2018 at 11:55:48AM -0800, egranata@google.com wrote:
> > > > --- a/drivers/platform/chrome/cros_ec_proto.c
> > > > +++ b/drivers/platform/chrome/cros_ec_proto.c
> > > > @@ -420,10 +420,14 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
> > > >       ret = cros_ec_get_host_command_version_mask(ec_dev,
> > > >                                                   EC_CMD_GET_NEXT_EVENT,
> > > >                                                   &ver_mask);
> > >
> > > It's not exactly new here (although you're using 'ver_mask' in new
> > > ways), but cros_ec_get_host_command_version_mask() doesn't look 100%
> > > right. It doesn't look at msg->result, and instead just assumes that if
> > > we got some data back (send_command() > 0), then it must have been a
> > > success. I don't think that's really guaranteed in general, although it
> > > might be for the specific case of EC_CMD_GET_CMD_VERSIONS.
>
> > It is guaranteed: if msg->result is not EC_RES_SUCCESS, then ret can
> > not be greater than 0. At best it will be 0, or a negative number if
> > we can already qualify the error in the errno space (see
> > T() for instance).
>
> Sorry, where do you guarantee that? The only enforcements I see in
> those xfer implementation are:
> (1) if result == EC_RES_IN_PROGRESS, we convert that to an errno
> (2) if the expected length or checksum are bad, we turn that to an errno
>
> So technically, the EC *could* be sending a valid, checksummed
> response of the expected length, while still setting the ->result
> field to something besides EC_RES_SUCCESS or EC_RES_IN_PROGRESS. And
> we would treat that as a valid 'ver_mask'.
You're right, I misread cros_ec_pkt_xfer_i2c().
> Albeit, that seems unlikely, given understanding of how the EC is
> supposed to behave, but our code is not properly defensive AIUI. This
> is basically why cros_ec_cmd_xfer_status() exists -- so that
> sub-drivers don't get lazy and use cros_ec_cmd_xfer() without handling
> the ->result field properly.
send_command is called for a very small subset of command where the
ec_dev mutex is already held. We indeed need to be careful when
calling it directly.

Gwendal.
>
> Brian
