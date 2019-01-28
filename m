Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFE2C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 094ED20880
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548668211;
	bh=da/vrBQ8VMJmjnf5OTI1PAGzFWvvYe0W1XicVmqsA1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:List-ID:From;
	b=L15rTE423iQ5YBDzN1U8iJkQUnPDOacC5ZbeQ5GLqXyX+8VNB2itm5ummBfbi0cLj
	 7URfHhMls+9YubMk3Q2EavVzACwzZrR/rIq5y8h+8j9fKNgKMfBqc1QZ4bT9mYB9+L
	 9PyrkrT4vTGikdV+9MZCclnvhoxOLMBQIQwROBSU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfA1Jgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 04:36:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:35262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726668AbfA1Jgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 04:36:49 -0500
Received: from localhost.localdomain (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF9CC217D6;
        Mon, 28 Jan 2019 09:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548668208;
        bh=da/vrBQ8VMJmjnf5OTI1PAGzFWvvYe0W1XicVmqsA1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=XRSvPOMBWclX5tLlZ5TmpaXMcNb4X4aiKeE2gc8IfTYN5TKdnkLJNNLOkwpl56Bhr
         LbduZH7TM3IPMcev5yoNZY6FxSfZWGo6mC5zR4Q+oHU67RvvLeh0tdr1ly7foGEf8n
         bJUFy6WEi7VcbUzpGDLkVGeFuHLOLs72IihLR1SQ=
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>, robert.jarzmik@free.fr,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        bbrezillon@kernel.org, marek.vasut@gmail.com, richard@nod.at
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [-next] mtd: docg3: Fix passing zero to 'PTR_ERR' warning in doc_probe_device
Date:   Mon, 28 Jan 2019 10:36:43 +0100
Message-Id: <20190128093643.18929-1-bbrezillon@kernel.org>
X-Mailer: git-send-email 2.17.1
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 05f93739cdfccb4c3d30f821b09d418dfc659997
In-Reply-To: <20190123065827.16748-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-01-23 at 06:58:27 UTC, YueHaibing wrote:
> Fix a static code checker warning:
> drivers/mtd/devices/docg3.c:1875
>  doc_probe_device() warn: passing zero to 'ERR_PTR'
> 
> Fixes: ae9d4934b2d7 ("mtd: docg3: add multiple floor support")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Applied to http://git.infradead.org/linux-mtd.git mtd/next, thanks.

Boris
