Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B491FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BC6D21B1A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="miNHtWej"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440068AbfBNUqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 15:46:21 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42036 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440019AbfBNUqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 15:46:20 -0500
Received: by mail-lj1-f194.google.com with SMTP id l7-v6so6452302ljg.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 12:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gl6I2b7fxkRiwKicMaJHRX0YMriswtzvuilI6IduaU0=;
        b=miNHtWej1ev6gufg8ZGzqKodvnBr7o4HnVKfZt84L29zL3xZE6+/GmdCXaEMUO8Pa1
         lFsiFZ6Wd+WsNtqniDFKwOe8hDmJgdCdG0GvlI6d+uH66VrGhsXKL5J7LC0zFOtFOziY
         pwdo67UM8NrsTkJ+kUadbN18hDr6VMdW9Gkf81Wyx/MEGNZuwqd5sZzOJQlM58gb73qj
         D2+apfOy+a2vqpMY4j0R1OAiAyH3x/o8NkUasHt7jnojt1kJkUgM++S9OVsTjrf55eNG
         4PNUY/ELH953uB7bhvbP7F9gt4/z1JQg7/NGxslYG84wVCvW70fwozXegEbj6Io79thq
         065g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gl6I2b7fxkRiwKicMaJHRX0YMriswtzvuilI6IduaU0=;
        b=VXV5JpEZ7g6GTnSqmn2TAuy66sBJZxEZKZ0JDgi0MhbEOLvOuFlIENJC2WLq7qzTgv
         4mlsp3mTwJY0XnK+lq+18O8saUzL2RkapIerJU/68QztIGeV+pbQ93/Vf3IoHnTnYq1s
         YoB16dDYSWRa7IVGQbnTn+pzcqbuFueCHk2KJ25Bsbfs+Vf2KSyMoLp60iK2+PzlMlSg
         TBJVVH20kPV6qa/kffGOLAsm4jRh1MjZETrrwPOuBhOEWx7qrP400zF+skZSTWnNqZ2k
         Dhnno0wg+PRQCOMh7QGTP+2uFCVv0jmJZKgTVTd9nGAr5GJhl4mrIW5mOvn7gZHviAM3
         VX7Q==
X-Gm-Message-State: AHQUAub88GZBn9S5MLEZqx3QQq7sZkTlxqgSluBbPzbwkpe8Xym61tiQ
        mkKQ8KRJJFs4NtFxjJwzJTdniGbKGG7+uubj7h9TeA==
X-Google-Smtp-Source: AHgI3IZvInj9x4eP9ZLqWUlqSugOKcrx1mCUQSKdbPJz3GYLxCQqz1aXKcIagvGylbfNZhC/Xj3YaMDveoYfPieQxnU=
X-Received: by 2002:a2e:6109:: with SMTP id v9-v6mr3559557ljb.126.1550177178324;
 Thu, 14 Feb 2019 12:46:18 -0800 (PST)
MIME-Version: 1.0
References: <CAE=gft4_WiL87FtZnVmZok+oXPjK=GUb5tDUPGQFijddrB0Pbg@mail.gmail.com>
 <1550172827.93548.5.camel@acm.org>
In-Reply-To: <1550172827.93548.5.camel@acm.org>
From:   Evan Green <evgreen@google.com>
Date:   Thu, 14 Feb 2019 12:45:41 -0800
Message-ID: <CAE=gft5GR1xEM1gNQjMyo_wfhs_JUAc2AUHHk5qr36EjaWv1hg@mail.gmail.com>
Subject: Re: KASAN warning in bt_for_each
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 11:33 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On Thu, 2019-02-14 at 10:04 -0800, Evan Green wrote:
> > Greetings, block experts!
> >
> > I'm trying to track down a KASAN warning I'm seeing in our downstream
> > 4.19 kernel, and I could use a little help. The warning looks like
> > this:
> >
> > [  224.564894] BUG: KASAN: use-after-free in bt_for_each+0x1ac/0x28c
> > [  224.571195] Read of size 8 at addr ffffffc17c621340 by task fio/3851
> > [  224.577745]
> > [  224.579320] CPU: 2 PID: 3851 Comm: fio Tainted: G W 4.19.16 #398
>
> Please have a look at this e-mail thread:
> https://lore.kernel.org/linux-block/1545261885.185366.488.camel@acm.org/

Oh, yep, that's totally it. Did that patch make it in anywhere?
-Evan
