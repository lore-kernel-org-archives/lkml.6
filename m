Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91E9ECDE46
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 02:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D49720843
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 02:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="ufTZDwng"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D49720843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbeJ0Kj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 06:39:56 -0400
Received: from mail-qt1-f179.google.com ([209.85.160.179]:46736 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbeJ0Kjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 06:39:55 -0400
Received: by mail-qt1-f179.google.com with SMTP id c16-v6so3381656qtj.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 19:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=BYO8gJ0DL9t4HFysoPzX3BkJADnAtRGENw1K+KI3Mew=;
        b=ufTZDwng1mOiEmFuenTqSU3wlgkyJbP/dMgk9BuIPZlUQ8ZnmKlZHZFN2DppCeZhGJ
         0sq2lr3cyVHs5EkoVEmSppLa31+wWW6Hjnhl93d3I8AIWOMLfY39yz4lxJX9cfE3cx5y
         OlPvQ7lc7QVPSNAk2DY8QHd3pL4IaIxeINGl389BXmPLvCJlUc7BLShhqGmVSYkZzQCc
         2/gOBBbbUh/VWjCqBAJxjMjCw9mIatrwG8yIh6ukDnhuqc8x1JXKNB17svDDTS8eXc8H
         uAznZPtqMgxN6EHLKrTWGP61z4HOEA/AMORIaFNLppiKjaFry5WQqAp2Mkg8dmRk9o0U
         DQ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BYO8gJ0DL9t4HFysoPzX3BkJADnAtRGENw1K+KI3Mew=;
        b=TM2T1xc9yuaOT63qM1lQfQ3pX9sCoV53f4V6ainPYUnDsh8vLhQ6Uc9MJTupPr2jdz
         QJbZS23wYeTsMm+oOqa1tcYfpdSkfvvdDjQCRJlt11a5I3cob+2J32dMz9BmxJV2kc3P
         J0meMdFbUJgh9qEO39fho6Xl5BQRF4/NxE8zuDX0IL1A0CLQK+4+z6UNC1sxIiLahp3w
         pGp6SgfiR+tAUtq0kzr1XXrODVu8XuDnMHpDhxHedssL1ZrdGV3kvsYxYw44DQlbX09V
         Mu4QyRtutU92E7em8aMeBUsHd+DYxowhPQ0xxqWBu03UV4JgY/KYYLCeTUZMQBVinXgX
         Nd9Q==
X-Gm-Message-State: AGRZ1gIQmkyGzQP1BTE/lARibvR+zuP3cyXCYeqDp3kvLXLNvkpZ7P10
        nRItKifTRdz9sILHwPq1yV65/A==
X-Google-Smtp-Source: AJdET5cL1GUilrbyh0cqKiYeyasx+obYBNtkwtqCLwSU52bpMfo+DhLYwXKlFdrp/HbWNIPeHM9nEw==
X-Received: by 2002:ac8:1701:: with SMTP id w1-v6mr5312112qtj.76.1540605634971;
        Fri, 26 Oct 2018 19:00:34 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id h67-v6sm8499777qkf.32.2018.10.26.19.00.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 19:00:34 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH v2 0/6] staging:iio:ad2s90: Add scale info and improve error handling
Date:   Fri, 26 Oct 2018 22:59:59 -0300
Message-Id: <20181027020005.3140-1-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds scale info to ad2s90's single channel, improve
error handling in it's functions and fix a possible race condition
issue.

The goal with this patch set is to address the points discussed in the
mailing list in an effort to move ad2s90.c out of staging.

Changes in v2:
 - Added my S-o-B in patch 5.

Matheus Tavares (5):
  staging:iio:ad2s90: Make read_raw return spi_read's error code
  staging:iio:ad2s90: Make probe handle spi_setup failure
  staging:iio:ad2s90: Remove always overwritten assignment
  staging:iio:ad2s90: Move device registration to the end of probe
  staging:iio:ad2s90: Check channel type at read_raw

Victor Colombo (1):
  staging:iio:ad2s90: Add IIO_CHAN_INFO_SCALE to channel spec and
    read_raw

 drivers/staging/iio/resolver/ad2s90.c | 55 ++++++++++++++++++---------
 1 file changed, 37 insertions(+), 18 deletions(-)

-- 
2.18.0

