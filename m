Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02232C2BC61
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 21:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A37BD20664
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 21:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="d3aZX9jM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A37BD20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbeJ2F5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 01:57:40 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38256 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727741AbeJ2F5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 01:57:40 -0400
Received: by mail-lf1-f66.google.com with SMTP id p86so2329771lfg.5
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 14:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CbuGby1AYMPd0qinsAnm72Zu8BFDE7HFMGpcBy3MonE=;
        b=d3aZX9jMK/D09OPLzQDziXfJrVottVg3+kpxxhQRiCkJZDpisI4PaVOoHIBD78c7Yr
         JcNrJLf2ppxmxCPxlQILM0jB/oy8N/Yfam/6rpasLHS1zn3WDC8VHM6F3U4raqiWEzjI
         73JBjqNlr3LbpEKoq1oW5ixWzjOkIKwMsgfU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CbuGby1AYMPd0qinsAnm72Zu8BFDE7HFMGpcBy3MonE=;
        b=dJKAkfUF2ed1YURKkapS21BVEnXOf7Q5RNjo9DpzYGbfRTpsZrE2etN+MCUi81l570
         F8kn4HwEZaRYEv1nB2F2S3WIpyyp9JZ3Wc7nkoHlE+P74vfFb8JYsbDnP7rUGqYCAz2P
         OEgAtRoLKWkP477FfbL4nw3vcmEGUzBmp+BOyImzRBbVxcjUiU0g9vdMDn0ZqGTVOq2x
         FkSDOJIIFMlfiQUEClMjarzL6trPWuuKhcW6BT4gLVyGApaWPdfYFrkAP7mntY+ziD0f
         Slp3kkK1PTjAZJQ8P6wYCb94OOM6EqzlHen3zS4E1twHh8H1v+XlN8/h8JhFuTuYZYJn
         MSsw==
X-Gm-Message-State: AGRZ1gJkrgvS5uMH1A3EDHvrNX4I1Prm+DtkRg4Z32uau6L03eKt7LIE
        G9osku5Ka3z16AvsBTpRHh4+G+Zl1W+rPA==
X-Google-Smtp-Source: AJdET5dIavJECqz1QhGjjqqw82GfmQsM2P8TLWJ7gkbqqarnmWCQXBTfTC88LhTUQlk2wBiwIAF11A==
X-Received: by 2002:a19:cd8e:: with SMTP id d136mr6646812lfg.3.1540761108276;
        Sun, 28 Oct 2018 14:11:48 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id s126-v6sm817769lja.4.2018.10.28.14.11.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Oct 2018 14:11:47 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id d7-v6so4546219lfi.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 14:11:46 -0700 (PDT)
X-Received: by 2002:a19:4948:: with SMTP id l8-v6mr6255789lfj.16.1540761106466;
 Sun, 28 Oct 2018 14:11:46 -0700 (PDT)
MIME-Version: 1.0
References: <1540613318-23877-1-git-send-email-ren_guo@c-sky.com>
In-Reply-To: <1540613318-23877-1-git-send-email-ren_guo@c-sky.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 28 Oct 2018 14:11:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=whHhzsdgbVwRFB8oGVwnfN551HPQjtvuodf+W5dNHtjuA@mail.gmail.com>
Message-ID: <CAHk-=whHhzsdgbVwRFB8oGVwnfN551HPQjtvuodf+W5dNHtjuA@mail.gmail.com>
Subject: Re: [GIT PULL] C-SKY(csky) Port for Linux 4.20
To:     ren_guo@c-sky.com
Cc:     Arnd Bergmann <arnd@arndb.de>, marc.zyngier@arm.com,
        Peter Zijlstra <peterz@infradead.org>, robh@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org, c-sky_gcc_upstream@c-sky.com,
        guoren1983@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd,
 I was kind of hoping/expecting to get an explicit ack for this from
you, since it's a new architecture.

Good to merge?

              Linus

On Fri, Oct 26, 2018 at 9:08 PM Guo Ren <ren_guo@c-sky.com> wrote:
>
> This tag contains the Linux port for C-SKY(csky) based on linux-4.19
> Release, which has been through 10 rounds of review on mailing list.
>
> We almost got the Acked-by/Reviewed-by of all patches except "Process
> management and Signal", but all've been tested.
