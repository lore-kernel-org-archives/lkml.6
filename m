Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ldGtLHZ+HFudNwAAmS7hNA
	; Sun, 10 Jun 2018 01:45:56 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B9A7E608BA; Sun, 10 Jun 2018 01:45:55 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZm6Zjbb"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4AB92605A2;
	Sun, 10 Jun 2018 01:45:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4AB92605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753586AbeFJBpv (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 21:45:51 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46309 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753555AbeFJBpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 21:45:50 -0400
Received: by mail-wr0-f195.google.com with SMTP id v13-v6so16847486wrp.13
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jun 2018 18:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rPFopr9rq8jmvhQ5G1wBDhE89b7GcS3rHk55gW/1L6M=;
        b=hZm6ZjbbwkeqC/VxszShEL1Uaj4BWG3eQjMeuQ0RF9NPtK4aN5yk/HIwwktuk/EZqp
         mDW6KXKqwmrLs4VGDi1Xva1iHQ7lf9JJscRpoUQSZR4OyaWQNk6D1jhIMRwzR1HbH33Q
         +ksO4ojIsTm1WqIonsDRYi/rI/nWtTWfcB7uxONSIk9kCuNlCf078F8CbqzgmyutwXhW
         jygeBQxKIwkQNHF3WroS0wVUqrYUmu9PjNczMAtUe8di702Tvi0ZtCjfZXy24OOs89xN
         PeRAsiQUwhQ36/SFLjVcrU5BNx+/KtM5x6AWWA+JOV7ObJa3pgR+EthhyuOznxP0I+Df
         UfRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rPFopr9rq8jmvhQ5G1wBDhE89b7GcS3rHk55gW/1L6M=;
        b=UVD7SKqFHghoSTqlvTSfGzPjVVXNvTVyLU8NZ94q8T6rHmVzPczjTc/nPiVnHs1zdK
         3gSBxujZEDphgBzatYRnOlCOAPT/zhEmlJu90nFjB80iMWCCVtRIOm5YCzwG/KNSA130
         fJb2JW+U/j+eKr1i6sdJMkzfhhH/Fbhy4FLAxmO+vuFTZ2X6kUT/GQV+oegD792z2pZm
         sC1auv8xzTaSLyFY9h+q0cu1V7712NHMhEtp+lW7miPl7VfgeFJVahKBPpLUdm8IsmC8
         ed57hGnsFaSVLOUMZuDEBw1vTo1aUCWYZR3rpcbGkmPo1P8ZAbnzbLYY4O/vsBDzgYWJ
         ENCA==
X-Gm-Message-State: APt69E2pIyQsZH0Bf5hUhRJDvq4oasDlF6BObrd030WPHs+zB5fus29Y
        zQBE1+o4ga/whjEQ86ECM37hAKvz49IOTP6S4Sw=
X-Google-Smtp-Source: ADUXVKKk3mK4vlC4fbEwHli5bPqyAA58Jj32HDXp2r5oAiq/theBkSYBPAJE4/3eAXcAEGtaFKAfbWskno6GoPwbJ28=
X-Received: by 2002:adf:9b86:: with SMTP id d6-v6mr9705554wrc.240.1528595149047;
 Sat, 09 Jun 2018 18:45:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:97de:0:0:0:0:0 with HTTP; Sat, 9 Jun 2018 18:45:48 -0700 (PDT)
In-Reply-To: <20180609000819.13883-1-logang@deltatee.com>
References: <20180609000819.13883-1-logang@deltatee.com>
From: Allen Hubbe <allenbh@gmail.com>
Date: Sat, 9 Jun 2018 21:45:48 -0400
Message-ID: <CAJ80satPXHNXbZ5OYqzDNknxp7gug4ukg19Fuksvgrm0Y4AsZg@mail.gmail.com>
Subject: Re: [PATCH 0/8] Fix breakage caused by the NTB multi-port patchset
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 8, 2018 at 8:08 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
> Hey,
>
> Here are all the fixes required to get ntb_test on switchtec working
> again after the multi-port test patches were merged.
>
> I'd appreciate it if future changes can be a) more careful about
> not breaking things, b) communicated more clearly so that better
> review can be done, and c) not merged until sufficient review actually
> is done.
>
> Note, I sent the first patch in this series earlier; please disregard
> the earlier one.
>
> Thanks,
>
> Logan
>
> Logan Gunthorpe (8):
>   NTB: ntb_tool: reading the link file should not end in a NULL byte
>   NTB: Setup the DMA mask globally for all drivers
>   NTB: Fix the default port and peer numbers for legacy drivers
>   NTB: ntb_pingpong: Choose doorbells based on port number
>   NTB: perf: Don't require one more memory window than number of peers
>   NTB: perf: Fix support for hardware that doesn't have port numbers
>   NTB: perf: Fix race condition when run with ntb_test
>   NTB: ntb_test: Fix bug when counting remote files

Thanks Logan.

Series:
Acked-by: Allen Hubbe <allenbh@gmail.com>

>
>  drivers/ntb/hw/amd/ntb_hw_amd.c         |  4 ----
>  drivers/ntb/hw/idt/ntb_hw_idt.c         |  6 ------
>  drivers/ntb/hw/intel/ntb_hw_intel.c     |  4 ----
>  drivers/ntb/ntb.c                       | 22 ++++++++++++++--------
>  drivers/ntb/test/ntb_perf.c             | 22 +++++++++++++++++++---
>  drivers/ntb/test/ntb_pingpong.c         | 14 ++++++--------
>  drivers/ntb/test/ntb_tool.c             |  3 +--
>  tools/testing/selftests/ntb/ntb_test.sh |  2 +-
>  8 files changed, 41 insertions(+), 36 deletions(-)
>
> --
> 2.11.0
