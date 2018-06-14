Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 95CD2C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CB25208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhDxfsll"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CB25208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754655AbeFNGWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 02:22:17 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:41524 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754589AbeFNGWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 02:22:15 -0400
Received: by mail-pg0-f65.google.com with SMTP id l65-v6so2422946pgl.8;
        Wed, 13 Jun 2018 23:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tYt0hLy8aODO6/YIZjmAbP6vPxlCD8U9B2KnHOIHIYM=;
        b=KhDxfsllJvcwIO6Hjuf3xSw3m3QEfowhM55lpz+9VntWHSShfCSpXZiiXfEubqOHHI
         CgQSYrw8DFm+pUmI6NVYeuGFRTeWUzHDrNbH3bfsdEGevHqmY9HENJKcr4VHNa+Ch78d
         SVq9qq4MCj6Yk1A1kG25Ap+ww3NwkUuu+VCItjKe3EiixxwPGqCo61BuwxF+PKOyZjk4
         3+hg3BLttQvp9ZehzYjsWddaUETtLoRfQR/KHINyHoGNCWW5e0Njmi6VprGAVe0B+7vo
         YAAb00LtfphDqhwn5T7IlX9KAsUCP1fNjn96EW26KU3jzEUjHAY3sejtFdj4QPv1Xggt
         f+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tYt0hLy8aODO6/YIZjmAbP6vPxlCD8U9B2KnHOIHIYM=;
        b=sc613UM2TItc/Br53+DHgYJ4scnJNdFom5LoXmFmYXdq3uCIvAFnJMMrGY/LrAfAUg
         roWFPmzoaWVFrqIHHvlYR4QAoITUobEVfJImCx5WYzSCLXn+FdKnmxUHQ4DtvMEwHKUw
         b5S2G4rIPpGS6DSlNmb01m9NV0KSikXZrmIIdvT/V08nNeQo5bYv2ab2tDK/B/fPjaPB
         YZYRXs7uwLQCoz1o5PUE+TCFVW+30XCjBBC9PZUUFEIGnJe/tYiwHddoFMsMXw9V4WNZ
         /HkV1HA0ebbR7ruEBrsOo878yZZJqPlp6+2PxetmYLRyX6/nWfcD9xySOl3dHqtF16wp
         fWaQ==
X-Gm-Message-State: APt69E2XeN+ZKGTm7MalzIqlR/02Ct+tORZy7AxXh31vFtVOIjjHcPji
        9Re3Lt+9H0U3lfO25CphEoJnuGNr2lemVepq+xs=
X-Google-Smtp-Source: ADUXVKIs78E44GHa24Yr7cysMxq2ntC+Ao7gpSG9HfcteW4WlqlUc5LZe4+TiP8wv3TVkKk/eKl+E7taD7gpXbkbvIk=
X-Received: by 2002:a65:42c2:: with SMTP id l2-v6mr1113416pgp.237.1528957335038;
 Wed, 13 Jun 2018 23:22:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:284f:0:0:0:0 with HTTP; Wed, 13 Jun 2018 23:21:54
 -0700 (PDT)
In-Reply-To: <20180614053446.GB18426@mtr-leonro.mtl.com>
References: <20180613234947.15767-1-xiyou.wangcong@gmail.com> <20180614053446.GB18426@mtr-leonro.mtl.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Wed, 13 Jun 2018 23:21:54 -0700
Message-ID: <CAM_iQpXxHk+yFqqK-Hezsc83_mKfbUXr4=jjNnik5DwGscRKUA@mail.gmail.com>
Subject: Re: [PATCH] infiniband: fix a subtle race condition
To:     Leon Romanovsky <leon@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 10:34 PM, Leon Romanovsky <leon@kernel.org> wrote:
>
> Hi Cong,
>
> If the compiler optimizes the first line (mutex_lock) as you wrote,
> it will reuse "f" for the second line (mutex_unlock) too.

Nope, check the assembly if you don't trust me, at least
my compiler always fetches ctx->file without this patch.

I can show you the assembly code tomorrow (too late to
access my dev machine now).


>
> You need to ensure that ucma_modify_id() doesn't run in parallel to
> anything that uses "ctx->file" directly and indirectly.
>

Talk is easy, show me the code. :) I knew there is probably
some other race with this code even after my patch, possibly with
->close() for example, but for this specific unlock warning, this patch
is sufficient. I can't solve all the races in one patch.
