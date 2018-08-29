Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CDCC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2706D204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:59:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2706D204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbeH2R4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 13:56:35 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:43539 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727651AbeH2R4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 13:56:33 -0400
Received: by mail-qk0-f195.google.com with SMTP id 130-v6so3381095qkd.10;
        Wed, 29 Aug 2018 06:59:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P/XzgYAnGguIrGM1ZuYRfmBN4J+hS1a8wGU6EB4Hehk=;
        b=psqx3jUEE48WJbCVR5w/vfkzcPo7aR7TlWYrT9gR2zj+r53Jt88m+RGGriDXHY4+cn
         MOeQRFz7CN5R9nMKlMb/ia4aMZ+FHMBmOwpvnYMZvDXNMlwoosaf+l8a6qJpQC9EPA35
         zbf7xOOnH/+/o4Ta6jAJ/nmd1Wp5abZRlXWzVc4cwfh9V2nnY2u9W/lMG41DIHNB+CPK
         jbigJgy6FLo7pcYqwFiL7XJu1NCE7ZykZvL2zszfdVbUcPhKih6exMunmf7j7X89tXZX
         xtnqHCb8qPrFDw1LOTFXBkafXoLkx2dq3PbpY88veji6E8lOniHN+s+425vfQopFelso
         J62A==
X-Gm-Message-State: APzg51DbLwZgQw4XoKMl+ytWOgO+wZb1GK7Red8GmkpEFdWxHz7n2raa
        WZjB0yaAZaEhT13ER0yqCe7ZD2oLODqgHi2cJTY=
X-Google-Smtp-Source: ANB0VdYNCTWep/vRvh8AARErlKbE2uHctt2pHBx/2M0dhB5Ce3mrSiEqpHtZBXeYK+n5glhFdQG68R8wLwu3jKx1PoM=
X-Received: by 2002:a37:132a:: with SMTP id d42-v6mr6180150qkh.343.1535551167612;
 Wed, 29 Aug 2018 06:59:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180827194531.3796559-1-arnd@arndb.de>
In-Reply-To: <20180827194531.3796559-1-arnd@arndb.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 29 Aug 2018 15:59:11 +0200
Message-ID: <CAK8P3a2vuDRnPzLQU1TeGfdPRjdZ9R2EkbDVerogJ7tJOoy8zg@mail.gmail.com>
Subject: Re: [PATCH 00/14] y2038 syscall changes for 4.20
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Linux API <linux-api@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 9:45 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Hi Thomas,
>
> I've rebased the syscall changes on top of 4.19-rc1, and the old_time32
> rename. This is the first set of those patches, the ones that I hope
> are all uncontroversial and obvious now. I'm still in the process of
> reorganizing and testing the next set batch top, and plan to send them
> after you've merged these.
>
> The first three patches are new here, the other ones have been posted
> before a few times.

Update: I've added the patch from the kbuild test robot, and pushed
the series to

git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git y2038

from where it should get picked up into linux-next. If there are
no concerns about the rest of the content, please pull from there.

      Arnd
