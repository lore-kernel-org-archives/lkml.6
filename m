Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2315BC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE4D520870
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:15:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE4D520870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbeJ3DEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 23:04:52 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36205 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728723AbeJ3DEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 23:04:52 -0400
Received: by mail-pf1-f196.google.com with SMTP id j22-v6so623008pfh.3;
        Mon, 29 Oct 2018 11:15:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nJC0NNPKN/Uv1V6q9cs49qJxbI0zyIuZrqxHAYI0mSU=;
        b=QxiYQIV63br1mR2LUr0c6D/Q+RwpTn0VBOHn0bBMpq9SqQ4AsVJy7iW+ZNmZQ0yD5V
         UZcgEVMAgPril46EscwqDcO/2gNzseufF70jR6qlkTxHyt7ND2XEZyIrsFhz2+RBImA6
         ynE0IpJS08M50EWR1YspbjMFbbRmf4p7PL4oiOIbT6Kfm8LwJL7RhFAp9CdAt7lAmlii
         sqi9+jiF7lOXzwlrvEcNOgQTTcpY6UjERNa7SFmCmktsgmL24GoxBReuOdeKmPOFN5cl
         pgbXmC5YpNufpZSqzD36IE2pOLB4pFg18kzMsp/TO27mIaoLR3Suv9GS83/MIqRBJEQd
         3dwg==
X-Gm-Message-State: AGRZ1gJkI7ljrF5U6BeyyFTOX4yg5C9t/MVDVW8rKMDL4S4mIuVrSkDq
        +Mdj7Zn8Sy0ODqiv69uSC8VUrrUe
X-Google-Smtp-Source: AJdET5fsSxnu8hqTdf6qGA7XgvvcBm5uD3Hb6tJHDViyPpxLp9Yj0iBGzq6gwPqMe4qz7MIEVqqzsA==
X-Received: by 2002:a63:bd51:: with SMTP id d17mr4132675pgp.443.1540836906129;
        Mon, 29 Oct 2018 11:15:06 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id o9-v6sm28511626pgn.30.2018.10.29.11.15.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 11:15:04 -0700 (PDT)
Message-ID: <1540836903.196084.70.camel@acm.org>
Subject: Re: [PATCH 07/14] blk-mq: support multiple hctx maps
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 29 Oct 2018 11:15:03 -0700
In-Reply-To: <20181029163738.10172-8-axboe@kernel.dk>
References: <20181029163738.10172-1-axboe@kernel.dk>
         <20181029163738.10172-8-axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-10-29 at 10:37 -0600, Jens Axboe wrote:
+AD4 -static inline struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo-blk+AF8-mq+AF8-map+AF8-queue(struct request+AF8-queue +ACo-q,
+AD4 -						     unsigned int flags,
+AD4 -						     int cpu)
+AD4 +-static inline struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo-blk+AF8-mq+AF8-map+AF8-queue+AF8-type(struct request+AF8-queue +ACo-q,
+AD4 +-							  int type, int cpu)
+AD4  +AHs
+AD4  	struct blk+AF8-mq+AF8-tag+AF8-set +ACo-set +AD0 q-+AD4-tag+AF8-set+ADs
+AD4  
+AD4 -	return q-+AD4-queue+AF8-hw+AF8-ctx+AFs-set-+AD4-map+AFs-0+AF0.mq+AF8-map+AFs-cpu+AF0AXQA7
+AD4 +-	return q-+AD4-queue+AF8-hw+AF8-ctx+AFs-set-+AD4-map+AFs-type+AF0.mq+AF8-map+AFs-cpu+AF0AXQA7
+AD4  +AH0
+AD4  
+AD4 -static inline struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo-blk+AF8-mq+AF8-map+AF8-queue+AF8-type(struct request+AF8-queue +ACo-q,
+AD4 -							  int type, int cpu)
+AD4 +-static inline struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo-blk+AF8-mq+AF8-map+AF8-queue(struct request+AF8-queue +ACo-q,
+AD4 +-						     unsigned int flags,
+AD4 +-						     int cpu)
+AD4  +AHs
+AD4 -	return blk+AF8-mq+AF8-map+AF8-queue(q, type, cpu)+ADs
+AD4 +-	int type +AD0 0+ADs
+AD4 +-
+AD4 +-	if (q-+AD4-mq+AF8-ops-+AD4-flags+AF8-to+AF8-type)
+AD4 +-		type +AD0 q-+AD4-mq+AF8-ops-+AD4-flags+AF8-to+AF8-type(q, flags)+ADs
+AD4 +-
+AD4 +-	return blk+AF8-mq+AF8-map+AF8-queue+AF8-type(q, type, cpu)+ADs
+AD4  +AH0

How about adding a comment above both these functions that explains their
purpose? Since blk+AF8-mq+AF8-map+AF8-queue() maps rq-+AD4-cmd+AF8-flags and the cpu index to
a hardware context, how about renaming blk+AF8-mq+AF8-map+AF8-queue() into
blk+AF8-mq+AF8-map+AF8-cmd+AF8-flags()?

+AD4  /+ACo
+AD4 diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
+AD4 index f9e19962a22f..837087cf07cc 100644
+AD4 --- a/include/linux/blk-mq.h
+AD4 +-+-+- b/include/linux/blk-mq.h
+AD4 +AEAAQA -86,6 +-86,7 +AEAAQA enum +AHs
+AD4  
+AD4  struct blk+AF8-mq+AF8-tag+AF8-set +AHs
+AD4  	struct blk+AF8-mq+AF8-queue+AF8-map	map+AFs-HCTX+AF8-MAX+AF8-TYPES+AF0AOw
+AD4 +-	unsigned int		nr+AF8-maps+ADs
+AD4  	const struct blk+AF8-mq+AF8-ops	+ACo-ops+ADs
+AD4  	unsigned int		nr+AF8-hw+AF8-queues+ADs
+AD4  	unsigned int		queue+AF8-depth+ADs	/+ACo max hw supported +ACo-/
+AD4 +AEAAQA -109,6 +-110,7 +AEAAQA struct blk+AF8-mq+AF8-queue+AF8-data +AHs
+AD4  
+AD4  typedef blk+AF8-status+AF8-t (queue+AF8-rq+AF8-fn)(struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo,
+AD4  		const struct blk+AF8-mq+AF8-queue+AF8-data +ACo)+ADs
+AD4 +-typedef int (flags+AF8-to+AF8-type+AF8-fn)(struct request+AF8-queue +ACo, unsigned int)+ADs

How about adding a comment that the format of the second argument of
flags+AF8-to+AF8-type+AF8-fn is the same as that of rq-+AD4-cmd+AF8-flags?

Thanks,

Bart.
