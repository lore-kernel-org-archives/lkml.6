Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5755BC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 06:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0057723D93
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 06:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l1IN+bQT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0057723D93
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932135AbeF0GKB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 02:10:01 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35534 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751901AbeF0GKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 02:10:00 -0400
Received: by mail-oi0-f68.google.com with SMTP id e8-v6so797380oii.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 23:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AqOWllTxKfSX+imZ60cQVNm+iZIL00wVmtqfZ5jpCzk=;
        b=l1IN+bQTwbGtTtFqGto5d1OkRL2z1gFGXdvriPt4dtZ63K+WXUH0535yP+u/hm7XAO
         eQzAojlh83pU1kimdqxlxbPiPq6QqajJTrLg+JWIgwiLyDR1feFBdzEerhHgOZekoA7W
         VLUkH0YHCrVYrzpBbv5tsNVOfNUjt7XodfO8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AqOWllTxKfSX+imZ60cQVNm+iZIL00wVmtqfZ5jpCzk=;
        b=ChXyrqV4W5j5Qska7KfcHsbYStwldJihmiiyjrLad6IUpKrflBjxCGMT4tl/YMqEbc
         V574S5QEqNYP4QiuoGihQvIxHwI8FIUK9v6nDg2ZYKKiLbnoR0Yv/XVY0Ch5Y150yrMD
         NAJLCpjEFIAs1mN8Ys2nbl+efV4iYyxJtjfF04dFoT4l68EHbYopYhZekJrTz0HMQbyh
         PCVvbL86Jm58P4Y8XgcKa8pGV+jhEmoiCP5ARi4230/aScBN7XS1WQCPSDINe892H09S
         ixo2GbhSFpboRDs8Z62mdHFp6lFTzoTOX/DiYPqw5XP21xXgyfeuyz+nY7owk5foQTK8
         NRBw==
X-Gm-Message-State: APt69E3NKAec6W1EKHsozTn22xcflK/EcQiTzWMXy6qn1rPPAdMLAIn0
        RzAse3h0RwjpTHy/cEywIzsxQnOxW6JUTwV8t1hsLw==
X-Google-Smtp-Source: AAOMgpfegIr554KG8jGOBFV5H2QE3d4Wal+s0QCWWrSESb2uZ8XH3yaHP2/ATolQ0RY7Hycn/2sLJBYyMCOEkFWoP/g=
X-Received: by 2002:aca:c692:: with SMTP id w140-v6mr2397418oif.284.1530079799719;
 Tue, 26 Jun 2018 23:09:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:79c:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 23:09:59 -0700 (PDT)
In-Reply-To: <CAKNRAJW-7BUCRwiUneW+pDU4k4jXY6S5XNxAJCmQnE9AkP2ooA@mail.gmail.com>
References: <20180608071146.110567-1-louiscollard@chromium.org>
 <20180618180943.GD20697@linux.intel.com> <CAKNRAJW-7BUCRwiUneW+pDU4k4jXY6S5XNxAJCmQnE9AkP2ooA@mail.gmail.com>
From:   Louis Collard <louiscollard@chromium.org>
Date:   Wed, 27 Jun 2018 14:09:59 +0800
Message-ID: <CAKNRAJU98YMzATxHR9grC7sdXxmv-cscrSZJOqKk+Laf1nV=Mg@mail.gmail.com>
Subject: Re: [PATCH] tpm: Allow tpm_tis drivers to set hwrng quality.
To:     linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi sorry I'm not sure I understand; I based the change on linux-next
master, let me know if I should be using something else. The change is
not dependent on https://patchwork.kernel.org/patch/10453893/

On Wed, Jun 27, 2018 at 1:28 PM, Louis Collard
<louiscollard@chromium.org> wrote:
> Hi sorry I'm not sure I understand; I based the change on linux-next master,
> let me know if I should be using something else. The change is not dependent
> on https://patchwork.kernel.org/patch/10453893/
>
> On Tue, Jun 19, 2018 at 2:09 AM, Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
>>
>> On Fri, Jun 08, 2018 at 03:11:46PM +0800, Louis Collard wrote:
>> > Adds plumbing required for drivers based on tpm_tis to set hwrng
>> > quality.
>> >
>> > Signed-off-by: Louis Collard <louiscollard@chromium.org>
>>
>> NAK because this not connected to the current GIT tree (should probably
>> make a patch set?).
>>
>> /Jarkko
>
>
