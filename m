Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A225EC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF09224C6
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:45:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EF09224C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933921AbeGFRpX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:45:23 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:40634 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933197AbeGFRpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:45:21 -0400
Received: by mail-qk0-f196.google.com with SMTP id b129-v6so6733003qke.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 10:45:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lZJ2JXMAAk2+iiRBvHxzA5WSTw49byCnNQvnMw2zD6w=;
        b=MvGz7YwEA2k3kW9zX6Kli9JmhC2G3oPzN7UgDmvnhXcUus6Iy3416L/sYQKLh0Sr2P
         V8tysJNdjq2ymcentF0/sZiqIhymPm7jKtLhcHHbUlGWoeqRoa1P8RqD2qGgGdto0Qu6
         PoRkT+bLNN/58tTNRM6tLAPb5BGHOMNkHEcLt9p6ooG768Joa8RhxhnbEvt6p3uI6xh2
         ZlYx9IFOSj0Zv2J8oHJerPFtqmvFj5Cdjz9Uq/BO4Rx4jcdrFCx4FmCGCOfS2+cuhiCA
         TaPdbPRt1z+NwbWLWJykRWGDjnh77JGoF2Kd07E2lsXumAuWg28W79RhMxaJOL3xRPKC
         kHwQ==
X-Gm-Message-State: APt69E3S9l2N50qXELA9GlF+vQ6F8T2HC5aSAmctjVrQ1a77jB6/PxOU
        FISKBRehLSiChVlqi/vE1VAQpw==
X-Google-Smtp-Source: AAOMgpc3hb/oU0pzT6rlVPJDHgcRLXtEkW7kOTFsPlUcaHwQMaXkw0dPUmlQtksOKzf26LOIIN8DdQ==
X-Received: by 2002:a37:9f4c:: with SMTP id i73-v6mr9496332qke.136.1530899120444;
        Fri, 06 Jul 2018 10:45:20 -0700 (PDT)
Received: from loberhel74 (174-083-000-020.dhcp.chtrptr.net. [174.83.0.20])
        by smtp.gmail.com with ESMTPSA id r13-v6sm1324254qke.21.2018.07.06.10.45.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 10:45:19 -0700 (PDT)
Message-ID: <1530899118.31977.1.camel@redhat.com>
Subject: Re: [PATCH 0/2] null_blk: zone support
From:   Laurence Oberman <loberman@redhat.com>
To:     Matias =?ISO-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>, axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bart.vanassche@wdc.com, damien.lemoal@wdc.com
Date:   Fri, 06 Jul 2018 13:45:18 -0400
In-Reply-To: <20180706173839.28355-1-mb@lightnvm.io>
References: <20180706173839.28355-1-mb@lightnvm.io>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-07-06 at 19:38 +0200, Matias Bjørling wrote:
> This series adds support for exposing a zone block device using the
> null_blk device driver.
> 
> The first patch moves core null_blk data structures to a shared
> header
> file. The second implements the actual zone support. The patchset
> adds
> two new options. One to enable the zone interface, and another to
> define the size of the zones to expose.
> 
> Thanks,
> Matias
> 
> Matias Bjørling (2):
>   null_blk: move shared definitions to header file
>   null_blk: add zone support
> 
>  Documentation/block/null_blk.txt |   7 ++
>  drivers/block/Makefile           |   5 +-
>  drivers/block/null_blk.c         | 124 ++++++++++++-----------------
> ---
>  drivers/block/null_blk.h         | 108 ++++++++++++++++++++++++++++
>  drivers/block/null_blk_zoned.c   | 149
> +++++++++++++++++++++++++++++++++++++++
>  5 files changed, 315 insertions(+), 78 deletions(-)
>  create mode 100644 drivers/block/null_blk.h
>  create mode 100644 drivers/block/null_blk_zoned.c
> 

Thank you for this will be very useful.
I will test it to add value.
I dont know the code well enough to review it
Regards
Laurence
