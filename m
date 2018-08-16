Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B92C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 04:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E1821480
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 04:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbZbvzsZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70E1821480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731176AbeHPHqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 03:46:14 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40276 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbeHPHqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 03:46:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id h15-v6so2894821wrs.7;
        Wed, 15 Aug 2018 21:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pQ/Z/MuwrkKCNz9q93ZamWHUPOLAStzv64ttRQOV0IU=;
        b=GbZbvzsZLK+yPvwhTE2n6wkvtnI6+SqRYSyY8uC0W4ukixwmMyx3bKKb6NM/oKr5dZ
         CbDO+QUBZefA7P/DQAj4ttxOPtOxgREtwFWYuUnzmWowLjZkXWs4/F1f4R3w5w7+y86T
         f+19rEIzjywZQM7sEgHb5am1prpGsEPh6X6s0SvXofrm/NXJeXtFXGGBPHlMQfj47gxp
         HrEY34WB7/P0G0S8GP+p6GFjBJUZHsw6/jdLqKH9FEpb2CGS93k0UjvkHf5dGOvVadO0
         zBdxv4AmbphQ6uLpVV4wm0yIYDBPQa1gtPmkNvRUtcUdNyjj6se8ZKkOV8cfL/WWj+KW
         cwcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pQ/Z/MuwrkKCNz9q93ZamWHUPOLAStzv64ttRQOV0IU=;
        b=r9V+ejQHHw5+dtll9uRdmANBtTy/NA20svBiJgT/E2Ny1Lk2QiOiWH93HbpNbODzcr
         X5/5LbV4amGRaew9/GPUP97eY52YdkZ2EzQyBxmDI+kdtlHYapHslZ273G9OmGz8b52l
         OPtMwTVHPNiS4NWqbSWbwUhd15J6OVsLnTyEa+08i1ExdAdTW6kqN91RofIAUH2GQH9K
         zbo5fTUjRnpVvJX9A0zBh83IKpaXjjQNVDEltmbV+4K7+AmRSkYwUXyKYTNZpJE9buvf
         7i/cPp5ptJgd8QICRgrUMPwtTWPP818NJ65EN0NyNp+1a410GvBVKenaTvRriDoCbL0f
         V//A==
X-Gm-Message-State: AOUpUlFb06QerAtroXX2PrhAbbN6p8na7JQ5QBAKsh3v8e+GL2LzqiEr
        1cA8R6zz400Qw59ac1PsM1dqTysbNZIGl0clkUmDpxil
X-Google-Smtp-Source: AA+uWPySl6DJ2fbEhkbrGtQWIdBPZrMlx0LRfil7DP2c7aArqmdyB05a0IPTV+KJKP76IevDEsMUJBcyG9b7AtKzrOM=
X-Received: by 2002:adf:e841:: with SMTP id d1-v6mr12328177wrn.269.1534395031995;
 Wed, 15 Aug 2018 21:50:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:32c1:0:0:0:0:0 with HTTP; Wed, 15 Aug 2018 21:50:31
 -0700 (PDT)
In-Reply-To: <1534317915-5041-3-git-send-email-jianchao.w.wang@oracle.com>
References: <1534317915-5041-1-git-send-email-jianchao.w.wang@oracle.com> <1534317915-5041-3-git-send-email-jianchao.w.wang@oracle.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Thu, 16 Aug 2018 12:50:31 +0800
Message-ID: <CACVXFVO+g2ACx9XYx4XtwRkpSC9bCYeSFEj07Z==6r7nT-HxkQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] blk-mq: sync the update nr_hw_queues with part_in_flight
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Keith Busch <keith.busch@linux.intel.com>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 3:25 PM, Jianchao Wang
<jianchao.w.wang@oracle.com> wrote:
> For blk-mq, part_in_flight/rw will invoke blk_mq_in_flight/rw to
> account the inflight requests. It will access the queue_hw_ctx and
> nr_hw_queues w/o any protection. When updating nr_hw_queues and
> blk_mq_in_flight/rw occur concurrently, panic comes up.

When updating nr_hw_queues, all queues are frozen, and there shouldn't
be any inflight requests, so there shouldn't be such issue.


Thanks,
Ming Lei
