Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57394C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10C522086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="GlERiY6g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10C522086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbeIDUXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:23:31 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:37924 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbeIDUXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:23:31 -0400
Received: by mail-oi0-f65.google.com with SMTP id x197-v6so7677805oix.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 08:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ScxoHZVTJxRH7GZpd10ouJ/6i13Ji0hmQbUFgIZXPrQ=;
        b=GlERiY6gOee5tDgJuucJ2ciOiDmaS8ZI4pr+1jyGtDgXjP6nvhJ1M3a1PKr7J3fBT6
         NQs3kk7EWkImIV26ey44m/ktO0NDTDXRy8eN7WEEkynT9cA6ZRnxlTRCQfP03LU7JtfR
         MLRY6j1oM1wEBzlgbYIhwBpHPGYrSK5cHYhlS+LHHfg7TaGJjvKxDkKWs3l1UztO6cKI
         kI3UKbed2aBGKF+TcAiWnPbwuPSqn1RLJlnrEoc2aTE92ekCBpInNMMfXMFZ4KxX7QWv
         oU7G2vLwljv/iK+1ga6qHtPpaSRly1A1cdCo8jYPAlN58BT79Dj3VqtgzQoeOjPG8evk
         oMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ScxoHZVTJxRH7GZpd10ouJ/6i13Ji0hmQbUFgIZXPrQ=;
        b=afZeVB0hmy1P2zjMtmNDhrKgS4AmsqvjcC3ihbN2mNfSkR5S/deEUnXS4NgFSfz6Ix
         l7JdDDdoQ/pFmqvqjKMFz9JZFNnYOaIln396h8oRr78Ir2PNxdl5qrhWLWTNLLDrJndW
         yV+5/Dv2t3vXoDH7Fh8gkv+D28DKrrInYDTAMUyjRf4cRQQfsym9dY/yW5ssQBqpilgO
         Fy8cY7sUUfkfAPqHTGDNhrkK99D6fRdSAdt/16mp0aV3pWMxCpWgYFu3KckstJOfCxJM
         uMZ9NwXnkv4dpVZt2iFf/B+UiA+My3cVtclpQqRRT8jc8zpQ7r6Z4i/VSa0EvtkAVj7E
         EDEA==
X-Gm-Message-State: APzg51CyvTtspON4g7RsIYzLh+uB9Rrv7c9YlrRT2/phuZMEllWlObnh
        uEcbBMjvzXHaRwxP+DdG+13aOlw3Ok8Hnc9O8hZ/jQ==
X-Google-Smtp-Source: ANB0VdZH42Ron+mrGs6HjYeERJQaCKImFfgZDV6jJ2gxdEGDj2eLuA817qotWPkd6MnVycf0LwpVBicgUonLS70cbe4=
X-Received: by 2002:aca:adc6:: with SMTP id w189-v6mr17052742oie.174.1536076667452;
 Tue, 04 Sep 2018 08:57:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:8346:0:0:0:0:0 with HTTP; Tue, 4 Sep 2018 08:57:47 -0700 (PDT)
In-Reply-To: <1536058062-18894-1-git-send-email-oceanhehy@gmail.com>
References: <1536058062-18894-1-git-send-email-oceanhehy@gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 4 Sep 2018 08:57:47 -0700
Message-ID: <CAPcyv4iVYjbs_ds9tL4rceH5cSck=D-AkkejFh+rHXdY25nGfw@mail.gmail.com>
Subject: Re: [PATCH v2] libnvdimm, region_devs: stop NDD_ALIASING bit test if
 one test pass
To:     Ocean He <oceanhehy@gmail.com>
Cc:     Ross Zwisler <ross.zwisler@linux.intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ocean He <hehy1@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 4, 2018 at 3:47 AM, Ocean He <oceanhehy@gmail.com> wrote:
> From: Ocean He <hehy1@lenovo.com>
>
> There is no need to finish entire loop to execute NDD_ALIASING bit test
> against every nvdimm->flags.

Of course there is. I see nothing stopping someone mixing an NVDIMM
that supports labels with one that doesn't. If anything I think we
need fixes to make sure this operates correctly to force disable
BLK-mode capactiy when the PMEM capacity is interleaved with a
label-less NVDIMM.
