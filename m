Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C75C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69D4C20848
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pOXOa4Fe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69D4C20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbeJZAnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 20:43:11 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:39079 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbeJZAnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 20:43:11 -0400
Received: by mail-ua1-f67.google.com with SMTP id j38so3446895uae.6;
        Thu, 25 Oct 2018 09:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=dLBbTJBV+h5vBXBOj+To2iHALkFqlJs321afRJTg7uM=;
        b=pOXOa4FeReLasbGgdNdCiX97nP7dirnxpOK2X6ZU6Ew75IEhFeWvMC0W1ST6fpNKRm
         PmpNyUaupH44ocjcRwNAPfv/2EVnYeZVzbjzPvJbzbLua4JLIkDwnyzkd0XgxNlFoXhH
         +F8wrsQlGr/4aznEaHjdWSMvl2vzoqufXfbig+lq7vJjEAEb1o+u/O5LGo07VqRVSihz
         m2ZV3U0w6ol4h1DunN+T3Dr6lrg5zzYf3RmxtZu3SClz8KJqOhDhI5BrqfDz6RdWyrbZ
         +praj4Fpmp7afOKOm3PaFym/ttdJMngJaZ/1dJ732+UMbP6ga2bC6L5l2VGmrUAbW92F
         q49w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=dLBbTJBV+h5vBXBOj+To2iHALkFqlJs321afRJTg7uM=;
        b=s1LMjZLigHV0UjSKnoDnMMpjSx3HFhRxf1y+8f7TQKf3AOAwyIjvg7asi0YJgj+vFz
         oINGBv1NoKE4zGmjS0twCLYzQ8o8xCzgTle/ZcYOMRqImKqQDYeqLGOmH2IDy63yFZ00
         uzqRW0wMjvDSE67ttqrg7GuBJ8PVj18eFv6xfmEoYupBHrWRA3lwoOfSjttS9gdeQmBG
         U9kOowyHieNQydtGjGCnLNWOkWRn8Pv4mZ4XR7VKURM+oWE79izSQvCwWRhWhG6lL2vh
         oWU6JWGl0p8NzaBnNmtKsWyYkdxmrylHKH+4SmvEwY/prBOk+dabRA+ctTh9GGzdXf67
         ZCBQ==
X-Gm-Message-State: AGRZ1gLTee+DInlkPUeJm/cd7utP+vsZgSCX8zmIt198dKo9uIs4juRE
        yQauWANzL/EtG71bIX4fitGQuLBxw5AmV3JFKrHULr/e+w==
X-Google-Smtp-Source: AJdET5cZ/vV4w9U99H0mu0mc8dt6I0fZ0zSoEvXPbJIya4bOqh7/sRaMs2dfWQG1TU2D/lbutRHGAyLglyfF83FKjzE=
X-Received: by 2002:ab0:5bcf:: with SMTP id z15mr1049841uae.8.1540483784306;
 Thu, 25 Oct 2018 09:09:44 -0700 (PDT)
MIME-Version: 1.0
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Thu, 25 Oct 2018 17:09:32 +0100
Message-ID: <CALjTZvapU2xc84D7Nqjk+vrF35cAOPzDTd6dRaXpuO=Lcap5Sg@mail.gmail.com>
Subject: Bug: swap discard issue with zram caused by "block: don't deal with
 discard limit in blkdev_issue_discard()"
To:     ming.lei@redhat.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

After commit 744889b7cbb56a64f957e65ade7cb65fe3f35714, I started
getting this (-EIO, it seems) on my dmesg:

swapon: discard_swap(00000000c275f02d): -5

This is an 8 GB zram swap device. It's configured like this:

modprobe zram
echo zstd > /sys/block/zram0/comp_algorithm
echo 8297508864 > /sys/block/zram0/disksize
mkswap /dev/zram0
swapon -d -p 100 /dev/zram0

I should note that if I use --discard=pages instead of -d (both
policies) at swapon, I don't get this error.
Reverting the commit from v4.19 final fixes the error for me, but
surely breaks something else. :)
Let me know if you need any additional information.

Thanks,

Rui
