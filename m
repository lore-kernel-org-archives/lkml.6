Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2C6C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA85020874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pespcEvr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA85020874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754065AbeFTPPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 11:15:53 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:42093 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753202AbeFTPPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 11:15:51 -0400
Received: by mail-lf0-f68.google.com with SMTP id z207-v6so5532313lff.9;
        Wed, 20 Jun 2018 08:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=3ApDaRhbM88FtRyogWLcbd0JpEWX0aQ/J49LvKrYlnc=;
        b=pespcEvrFwhglqgwLP+wBJMHablpz7ES/VVc385BWQ4G+519n5oMCZBpJiR3DiJFY1
         Lq+sEVWkFSW57r+75z++z2BfJOdNXCM64I5o/n0kFQ050Ae6Mp8/lkMHFgkGEAOyiQ//
         HeDT6FcTyiAWzaKyxsUqGTtEdzdCM2pYyebCLhaSs0XiedIbDGBXAQoQV5OSAkulP1/O
         JHWx74/Lw8YP32AW3vD8QU2HzObVl16a8w5mGgQpo3ln8J86Fk0EDzduwYTwq4eRVK3e
         7L2yVJyDpNxGY/23ZWyd36UtlmPUawYEcO911vIinqOiejR5Y51GXbgOoGeLIumES/qv
         Pv/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to;
        bh=3ApDaRhbM88FtRyogWLcbd0JpEWX0aQ/J49LvKrYlnc=;
        b=s07wqVkRBvObgAQ2UEcqWxUnTNbvh6MzScPI5pBIbnfSczZSVVuiGXjo37a8GRtdCw
         tGEGnCb2LWJrh1PR669mAqywj8vIuMaYi286D8/6Ng8dpApt6a89IGCrZpCZ5Wt70XFm
         eG+f0u5TeQHhwr7lemyrb79Nm7+4zCskGCHy1MEYG93N7lWkHS6yvJZmid+Uwezxuo9J
         lgkwt64YtTs9JXtUL3lTCex8/aGpFZGFkKw/gvQGZkypkSSKgjtJUG1lGT7f9i1RUdsb
         UpwwB0hHZppCZPppeW73e3FD6sbU8NJAwV+fXrg22/WO7MJy/fLuSlO6QNqZKWVUvvcQ
         k3cg==
X-Gm-Message-State: APt69E3H6U1smh6SNRZMAtR3zoQ89azIXUXkmcgptKNCK5H9YHa1L+LQ
        r2t3doeztOSNlE/Y2DrPeAw7C2VMGid0uGcM4RHNnA==
X-Google-Smtp-Source: ADUXVKIbGKTRRa3VV0xDXpYhKE58ekLcArSpaqgLM5Xt7eWvTiHy7KEXfgLS2mArpx8OsLjfkMk7xNb1HcRrNirN8UQ=
X-Received: by 2002:a19:f03:: with SMTP id e3-v6mr10797241lfi.83.1529507749937;
 Wed, 20 Jun 2018 08:15:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:56c8:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 08:15:49
 -0700 (PDT)
In-Reply-To: <20180620143655.GD24375@twin.jikos.cz>
References: <20180620143448.44388-1-arnd@arndb.de> <20180620143448.44388-2-arnd@arndb.de>
 <20180620143655.GD24375@twin.jikos.cz>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 20 Jun 2018 17:15:49 +0200
X-Google-Sender-Auth: bhWS4211t3BcSLq4ABvmVuHlHUs
Message-ID: <CAK8P3a3=Obi3MS0bdrLRPJ2FE2igmzNkOM47mqtco0UwyW60sw@mail.gmail.com>
Subject: Re: [PATCH 2/3] btrfs: use 64-bit timestamps for struct btrfs_dev_replace_item
To:     David Sterba <dsterba@suse.cz>, Arnd Bergmann <arnd@arndb.de>,
        Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        David Sterba <dsterba@suse.com>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Anand Jain <anand.jain@oracle.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Allen Pais <allen.lkml@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 4:36 PM, David Sterba <dsterba@suse.cz> wrote:
> On Wed, Jun 20, 2018 at 04:34:33PM +0200, Arnd Bergmann wrote:
>> The structure already has 64-bit fields for the timestamps, but
>> calling get_seconds() may truncate and risk overflow on 32-bit
>> architectures.
>>
>> This changes the dev-replace code to use ktime_get_real_seconds()
>> instead, which always returns 64-bit timestamps.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Thanks but there's a patch already fixng that, sent a few days ago
>
> https://patchwork.kernel.org/patch/10473195/
>
> and added to patch queue for the next dev cycle as it does not appear to
> urgent for 4.18.

Ok, sounds good.
I had missed that Allen has independently sent out some of the
same patches that I created in the last weeks.

Allen, do you have more patches pending? I have sent out most of what
I did (around 80 patches I think), with just ext4, ceph, nfs and xfs pending
at the moment. It seems we also sent identical patches for procfs and
I have something pending for ceph that duplicates another patch you did.

      Arnd
