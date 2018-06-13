Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8FEB9C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 06:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46CC72086A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 06:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfVCnjza"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46CC72086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754572AbeFMGgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 02:36:44 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35498 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754530AbeFMGgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 02:36:11 -0400
Received: by mail-lf0-f67.google.com with SMTP id i15-v6so2132909lfc.2;
        Tue, 12 Jun 2018 23:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jp7lbYeqgzIXVyF4ygVXt6FsKAHdtkzKeyQD1np/joY=;
        b=nfVCnjza2m0sWSrwQPX65pyn+dt8qBiayPl+cAnf0EJgCTlDIRT5i1ltbQXwfBcxUu
         hpc2LjAy5k/N43mGCwI3apBurqG1Y1FeVxhhb55JHv6V3Up9fI3dvCDwYBaGW6Qq85hD
         W0in0DjMFRCDKXUCCyyfVDZm5ZcfwWoXp94KPoIK92hGZHUM7iegVFQpPYm4m7JGKTFt
         rWflKCBWEvaVhkH5sxHpo5DpXJhyONF/3AEKGYY9UJ++KJ6oTlBIejVv3KT1ic51Qr23
         wvY8XRVumLTqn6+8QR0JvXX5ZZNfBUR0dyVglmUrkeSR/O7BBRqYvd+tPcKD9pJMp/hQ
         LOBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jp7lbYeqgzIXVyF4ygVXt6FsKAHdtkzKeyQD1np/joY=;
        b=AUGqVgKANIdVXt2CTz/bZx/dXzKHSQ4V19tgOLh6rnXeDKkHffKm4sD18L+JFr7tXu
         1GpS/Dln4ESg3XLVcDVYGkZKpfhzeaEtL+2kthW2vvttSBOnOU9TT9bKWNjtpDlYmOWW
         zPkIoD1t6DTuf+kGa2DlJn46nRCHkl7zoqVWSubzE9aLEYIwf+7IL2V9HRQtkp1AhO9z
         zGXN6hBIT2vBO2HlJjhr45WOWtjb/VavbP3VvVC1f0SfqaZWzh9PzL+edHtQgVq/WmMa
         2Lk+eWh1PFs74RfiO5IgZp7YCB565L/Ff7OL5+0ubQ/te/ZIQx4Vic/E0E+faFcRXlbO
         OXog==
X-Gm-Message-State: APt69E2kAGFUGJvvZfJPBWOhX3n9RuGABmbapMhV/WHuApoR5h762y0T
        bPlmrM8G4oky6I53a5nqW7Bm3yaDrDWTGPBWtt4=
X-Google-Smtp-Source: ADUXVKId6MhDX1pb62Gc81KK+ThKJmT5KmnPPpi4BQua0NbJS6OZf02/gDQSm1018jQ2nYZN9V8UUe2xZTdh5y8A3NI=
X-Received: by 2002:a19:b203:: with SMTP id b3-v6mr1976660lff.84.1528871770261;
 Tue, 12 Jun 2018 23:36:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
 <20180611115240.32606-19-ricardo.ribalda@gmail.com> <CAL_JsqLhRSbhmpaiqgG_TRRXQEsRKG5UK0HWw0tu9Eymn8cNcA@mail.gmail.com>
In-Reply-To: <CAL_JsqLhRSbhmpaiqgG_TRRXQEsRKG5UK0HWw0tu9Eymn8cNcA@mail.gmail.com>
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date:   Wed, 13 Jun 2018 08:35:53 +0200
Message-ID: <CAPybu_1rgnAGa813pdNyhem5q3t_gGwAVtCO933bb24KB+sghQ@mail.gmail.com>
Subject: Re: [PATCH v2 18/24] serdev: ttydev: Serdev driver that creates an
 standard TTY port
To:     Rob Herring <robh@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,
On Wed, Jun 13, 2018 at 3:20 AM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Jun 11, 2018 at 5:52 AM, Ricardo Ribalda Delgado
> <ricardo.ribalda@gmail.com> wrote:
> > Standard TTY port that can be loaded/unloaded via serdev sysfs. This
> > serdev driver can only be used by serdev controllers that are compatible
> > with ttyport.
>
> I'm hesitant to expose a tty device on top of serdev to userspace that
> we then have to support forever unless that's the only way tty devices
> (for serial ports) are created.

My concern is that, with the current implementation, serdev does have
a tiny collection of usecases:

-It cannot be used for board bring up
-It cannot be used as a replacement of hciattach and friends

It can only be used on embedded devices or platforms where the
developer has control of the ACPI table.

This hack, allows its use in almost any scenario and I have been
happily using it for two weeks with no issue.
It is also a very simple solution that does not have the issues of
cdev/serdev coexistence that you mention.

I am not very convinced about all the ttydev being serdevs. Adding 1K
lines of code to people that do not plan to use serdev seems like a
high expense. If in the future we can get rid of all the hciattach
programs then we can redesign the port probing.

>
> I did a similar patch which just registered both serdev and a tty
> allowing them to coexist. It suffered from warnings about open counts
> though and felt hacky.
>
> Rob



-- 
Ricardo Ribalda
