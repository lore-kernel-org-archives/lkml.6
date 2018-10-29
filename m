Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98642C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F9B32082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:34:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F9B32082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbeJ3CYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 22:24:13 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:32810 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbeJ3CYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 22:24:12 -0400
Received: by mail-pg1-f195.google.com with SMTP id q5-v6so552544pgv.0;
        Mon, 29 Oct 2018 10:34:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y/TBf0+WwC/yzZJvJR7rStju0y0oUn049SUOTOVoQv8=;
        b=WWn6sTErfoaUSKfqz+t0goPlSrrq0c8hzQCkKc6ANsct/Fg98LlZaG2FPo05q7Irv9
         2b3qGFpI0CS1eyWfGKJDwG0D2II1HRdVR9zItRpO3yv1EIFp7qJ/wuiktRTAkx0PBCho
         iRuyUxU9sd/At2aUYct/PAYN36b46LzOPKhCtqQkf/gLLbnUY3q//vfqUDgewTfLP7/8
         0VXCWqlSlG+LWbK6hgIJdPXSYjUDaw1vkg8+YgTrav+mbyaChTYTBQpmY9cAn5j4X4Lc
         3wlzA9vDT2s3ISGP5RsshmXjduncHubz3wkM2e5Gz/TfnquIi52gRzUS01m6Pehcn1L4
         phzA==
X-Gm-Message-State: AGRZ1gKD6BYw02DEc7BB9cZaeuTF0H+wumPvx5LNTkYOtvLEhj7iQVF1
        lv/0oMsrVZMI/GfhmHVcKSlc83br
X-Google-Smtp-Source: AJdET5c/Bcm1veHdlDuhXvsVC+H8rBJkbu1DEX91JGP+b4OcnXl/DkILJt0rcxG8SDtE+YuY79TvnA==
X-Received: by 2002:a63:7c13:: with SMTP id x19mr14517804pgc.45.1540834476955;
        Mon, 29 Oct 2018 10:34:36 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id i19-v6sm2418396pfi.87.2018.10.29.10.34.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 10:34:35 -0700 (PDT)
Message-ID: <1540834474.196084.64.camel@acm.org>
Subject: Re: [PATCH 05/14] blk-mq: allow software queue to map to multiple
 hardware queues
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 29 Oct 2018 10:34:34 -0700
In-Reply-To: <20181029163738.10172-6-axboe@kernel.dk>
References: <20181029163738.10172-1-axboe@kernel.dk>
         <20181029163738.10172-6-axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-10-29 at 10:37 -0600, Jens Axboe wrote:
+AD4 The mapping used to be dependent on just the CPU location, but
+AD4 now it's a tuple of +AHs type, cpu+AH0 instead. This is a prep patch
+AD4 for allowing a single software queue to map to multiple hardware
+AD4 queues. No functional changes in this patch.

A nitpick: mathematicians usually use the +AHs +AH0 notation for sets and () for
tuples. See also https://en.wikipedia.org/wiki/Tuple.

+AD4 +-		/+ACo wrap +ACo-/
+AD4 +-		BUG+AF8-ON(+ACE-hctx-+AD4-nr+AF8-ctx)+ADs

Another nitpick: how about changing the +ACI-wrap+ACI comment into +ACI-detect integer
overflow+ACI or so to make the purpose of the BUG+AF8-ON() statement more clear?

Thanks,

Bart.
