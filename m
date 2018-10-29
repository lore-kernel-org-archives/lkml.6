Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093A3C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1C832084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:34:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1C832084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbeJ3DXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 23:23:53 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37293 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729567AbeJ3DXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 23:23:53 -0400
Received: by mail-pf1-f193.google.com with SMTP id j23-v6so4469501pfi.4;
        Mon, 29 Oct 2018 11:34:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q6Ch81bOKQbe+tWZbblbd4wz1tPiXK3Kf20l9RfX0xk=;
        b=pRVA1gf/rPhC5qYmreven0dlclBz79Q9cBfg6Syxm/Gjuuf2Sy7uRtudpQR/qE4Ddw
         6zzQxBDJesTIuBgwPZ93hYtBaD3Os7u3fXx/OfvamHXusP5a3fJ4xATrl/7Ij35f8zR/
         aZDtgFIWSdRBaX6SgcrO1zzq/U3wgjMxCqgMcIl9/JgOVWNWrFzJW1jwGT5Xa39Z9fOE
         RZEJUAyY6F6lgI8wxvWXXsYD4gbx5DBAtsNGl/Q1S4DL1euTFL9s4AYEThjUNYNIq4Nn
         8e1UXZCwDHqdLarT8xO57KXTTzkdm2yd1z+WbpgXqTT6BknKfv7iaIyX8IEPLBfQT7+V
         7azA==
X-Gm-Message-State: AGRZ1gJiaCJe8mshu4c5le2x/76GXQWNhjfmnAkx7uuv8Y/BWwK3+l1G
        HfqFfpKE1nQAxqXvdBMQTcw=
X-Google-Smtp-Source: AJdET5ckeOUtWPIoQB78bXdhJpqHFXqVGhAAusN/7n9lf0skfWhHuxr1O6OamXM186GCP1hEu+iYaQ==
X-Received: by 2002:aa7:8546:: with SMTP id y6-v6mr8957325pfn.83.1540838041227;
        Mon, 29 Oct 2018 11:34:01 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id p13-v6sm10574957pgg.94.2018.10.29.11.34.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 11:34:00 -0700 (PDT)
Message-ID: <1540838039.196084.78.camel@acm.org>
Subject: Re: [PATCH 02/14] blk-mq: abstract out queue map
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 29 Oct 2018 11:33:59 -0700
In-Reply-To: <20181029163738.10172-3-axboe@kernel.dk>
References: <20181029163738.10172-1-axboe@kernel.dk>
         <20181029163738.10172-3-axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-10-29 at 10:37 -0600, Jens Axboe wrote:
+AD4 struct blk+AF8-mq+AF8-tag+AF8-set +AHs
+AD4 -	unsigned int		+ACo-mq+AF8-map+ADs
+AD4 +-	struct blk+AF8-mq+AF8-queue+AF8-map	map+AFs-HCTX+AF8-MAX+AF8-TYPES+AF0AOw
+AD4  	const struct blk+AF8-mq+AF8-ops	+ACo-ops+ADs
+AD4  	unsigned int		nr+AF8-hw+AF8-queues+ADs
+AD4  	unsigned int		queue+AF8-depth+ADs	/+ACo max hw supported +ACo-/

How about documenting that nr+AF8-hw+AF8-queues is the number of hardware queues across
all hardware queue types instead of e.g. the number of hardware queues for a
single hardware queue type? This is something that only became clear to me after
having reviewed a later patch in this series. Anyway:

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4

