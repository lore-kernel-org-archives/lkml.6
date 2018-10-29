Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E714CC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D7C12080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:41:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D7C12080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729732AbeJ3Fb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 01:31:57 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38343 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729648AbeJ3Fb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 01:31:56 -0400
Received: by mail-pl1-f195.google.com with SMTP id p7-v6so4386522plk.5;
        Mon, 29 Oct 2018 13:41:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LfsuftipXfE2AZoMshGR26rwgHEQpDPpqFfxyTz+ZcI=;
        b=lZ3sNvEDd51pPtlLz615mu0oeG2GIabriqXWQgJrINm6I8WBIIVtzeSZQ+gEvc2W8C
         5xx2GbVmO3X6NXe5zGst3bDSHSq0CZlvNXsPcIwBRR1eeEhGuM9afeh0gnkq1hpT+GfC
         XW9jEUA9w9KdEZP5TluxBHhB14RzaO2xN+3YSRvBedB06WmBM+viXlfbrFIcOvxS2x9f
         AnRzGcA61ydj5Rl9YzUpk2hY2pK/12XQkQ1QQ+cKj0E+UmMSXGv6Y9mtdycKm3YtQPr7
         e3L+COy9CZhvzo8VaPTjYV9ay/H5guspXHc9uNFhCFT3LebKbF6Fv4y7tg3wj6Ss2R/U
         ot8w==
X-Gm-Message-State: AGRZ1gJvSmy2e5xL8MGBtK0N7KvfJt6yyuEH19hWJStW3pBV8isUMXBx
        a7ROi3Cmxd66aV8Kv8nlVeeI8/Yv
X-Google-Smtp-Source: AJdET5dPuZpikkZ/5u0yIBKZpvNm1FNOKi6R0XOZ2HvKyp/f6l9SJNORtW9QusJ+GmpWx2LiutV/AA==
X-Received: by 2002:a17:902:8342:: with SMTP id z2-v6mr15607122pln.147.1540845696331;
        Mon, 29 Oct 2018 13:41:36 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id b139-v6sm22301312pfb.3.2018.10.29.13.41.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 13:41:35 -0700 (PDT)
Message-ID: <1540845693.196084.96.camel@acm.org>
Subject: Re: [PATCH 1/2] fs: remove exofs
From:   Bart Van Assche <bvanassche@acm.org>
To:     Christoph Hellwig <hch@lst.de>, ooo@electrozaur.com,
        martin.petersen@oracle.com
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        osd-dev@open-osd.org, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 29 Oct 2018 13:41:33 -0700
In-Reply-To: <20181027082019.20838-2-hch@lst.de>
References: <20181027082019.20838-1-hch@lst.de>
         <20181027082019.20838-2-hch@lst.de>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-10-27 at 10:20 +-0200, Christoph Hellwig wrote:
+AD4 This was an example for using the SCSI OSD protocol, which we're trying
+AD4 to remove.

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4-
