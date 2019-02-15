Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E35C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 598FF21B18
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ettus-com.20150623.gappssmtp.com header.i=@ettus-com.20150623.gappssmtp.com header.b="mzveJjO+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389388AbfBOP3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 10:29:43 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35889 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730213AbfBOP3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 10:29:43 -0500
Received: by mail-ed1-f65.google.com with SMTP id o59so8286134edb.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 07:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ettus-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+qQVLOm+tc6witGNoTG9gdfSDZengbsbLuRNCQL5ryo=;
        b=mzveJjO+4aNOs1o6nVRjMlC6boIT0oM6N0eJWQHCDX/CwBMyt0vGJJs0G5RW7nPToK
         PBWAAGkqRsYICdw+NAgWwbPxtenmagWpOE6i2KEfSJfAxPrjBXTcxE05W6iiSEnPz8B8
         Wcw64qfslCSHVfwCD5Xn6SVMl0iPf9CDSlbnU9xYXBQyl4dEw3w8yb+vPNizXonIKhhX
         YUwecHkV49EbXpJFyTAaLx9Q0mNlg4ZiTl06VGMp9dWQzUQlopDfpz/bFbu7AvVe4Qaw
         JIBlrELn6xm0XLFY8/59DQCSuLQf/FBjF4nDNHzramoQGPygGnC+pf188J043T3P7yVb
         Ad7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+qQVLOm+tc6witGNoTG9gdfSDZengbsbLuRNCQL5ryo=;
        b=J25tSrBcN2eHp//sz2GLxx25A0CDYqBq1gJALq2hveVvfjXaRWYb4J9jK99sc9f2mT
         sqpqj7S9xrqY7YB1DzRuCyBuUawJEQtuT+a5+ciHIwuYsXGcLSSYfWsBiYRo59rWCAmz
         sIH4w/xCHD3d4l6spHbzDKfHMPILkIkmtmWzxQ3M5c5rCBvV+nrK3FZELpWF0O43kM6H
         RvP101tDjDOw72BadNOdL3g9ZYbAUDO4v/p5XgzTyTmmMdqttrANAo8zVbBDAC2o+LTF
         g4GMdbaHMneT7R0bqLJjB7sdAtC7IBr4aj4BPmrFs4B6tiT90SJWTf2+w4i8x/AiwMgw
         1ILw==
X-Gm-Message-State: AHQUAuaje0lA/tWGdfRuB4MVCHxvC2Xllgoa+fDSpvS4nvNZpjRh/YWV
        AvTNDkqpZQlsXmykSfVrsOAS+4Mknjks7JUQwoMvHw==
X-Google-Smtp-Source: AHgI3IbhNdX2Bg74RLwEkcrRhm1vApGLVElMs+TzLvz6uAt2lN8weU+z+0CEEofHxBAMRg2aie/EVF7GCI6DKXSyJXs=
X-Received: by 2002:a17:906:651:: with SMTP id t17mr7169879ejb.144.1550244581539;
 Fri, 15 Feb 2019 07:29:41 -0800 (PST)
MIME-Version: 1.0
References: <20190131213957.11568-1-alex.williams@ettus.com> <CAKfKVtFM1zPb-MjBwY8WREy4xoHW60JrjZ-LnSzBvJ1Yv_zgsw@mail.gmail.com>
In-Reply-To: <CAKfKVtFM1zPb-MjBwY8WREy4xoHW60JrjZ-LnSzBvJ1Yv_zgsw@mail.gmail.com>
From:   Alex Williams <alex.williams@ettus.com>
Date:   Fri, 15 Feb 2019 07:29:30 -0800
Message-ID: <CAJZzcDiv8BGDa8pj-2gP+BWiu=CfrsDi15xHr=UUFwCwE-E4zg@mail.gmail.com>
Subject: Re: [PATCH] i2c: cadence: Handle transfer_size rollover
To:     Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Cc:     mical.simek@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alex Williams <alex.williams@ni.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 2:53 AM Shubhrajyoti Datta
<shubhrajyoti.datta@gmail.com> wrote:
>
> HI Alex,
>
> Thanks for the patch.
>
> On Fri, Feb 1, 2019 at 4:22 AM <alex.williams@ettus.com> wrote:
> >
> > From: Alex Williams <alex.williams@ni.com>
> >
> > Under certain conditions, Cadence's I2C controller's transfer_size
>
> Any help in reproducing the conditions would be appreciated
>
>
> > register will roll over and generate invalid read transactions. Before
> > this change, the ISR relied solely on the RXDV bit to determine when to
> > write more data to the user's buffer. The invalid read data would cause
> > overruns, smashing stacks and worse.
> >
> > This change stops the buffer writes to the requested boundary and
> > reports the error. The controller will be reset so normal transactions
> > may resume.
> >
> > Signed-off-by: Alex Williams <alex.williams@ni.com>


One possible related errata is here:
https://www.xilinx.com/support/answers/61664.html

In our case, we only needed to hammer on i2c to reproduce in a few
minutes, with a script like this:
while true
    do date
    cat /sys/class/gpio/gpio882/direction > /dev/null
    cat /sys/class/gpio/gpio883/direction > /dev/null
    cat /sys/class/gpio/gpio884/direction > /dev/null
    cat /sys/class/gpio/gpio885/direction > /dev/null
    cat /sys/class/gpio/gpio886/direction > /dev/null
    cat /sys/class/gpio/gpio887/direction > /dev/null
    cat /sys/class/gpio/gpio888/direction > /dev/null
    cat /sys/class/gpio/gpio889/direction > /dev/null
    cat /sys/class/gpio/gpio890/direction > /dev/null
    cat /sys/class/gpio/gpio891/direction > /dev/null
    cat /sys/class/gpio/gpio892/direction > /dev/null

    cat /sys/class/gpio/gpio894/direction > /dev/null
    cat /sys/class/gpio/gpio895/direction > /dev/null
    cat /sys/class/gpio/gpio896/direction > /dev/null
    cat /sys/class/gpio/gpio897/direction > /dev/null
    cat /sys/class/gpio/gpio898/direction > /dev/null
    cat /sys/class/gpio/gpio899/direction > /dev/null
    cat /sys/class/gpio/gpio900/direction > /dev/null
    cat /sys/class/gpio/gpio901/direction > /dev/null
    cat /sys/class/gpio/gpio902/direction > /dev/null
    cat /sys/class/gpio/gpio903/direction > /dev/null
    cat /sys/class/gpio/gpio904/direction > /dev/null
    cat /sys/class/gpio/gpio905/direction > /dev/null
done

In normal usage, we have code that sets up a number of i2c GPIO
expanders and pokes them for values as it initializes devices.
Occasionally, the transfer size register will roll over, and the ISR
will cause memory corruption, since it doesn't stop writing at the
requested boundary.
