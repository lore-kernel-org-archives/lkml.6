Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0DDC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F94C21736
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548668193;
	bh=HnmiZDDnIoodoZisvzDrAioD+D+NSzvDFN8n4IKpNPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:List-ID:From;
	b=nBOIhuEhxFBeIgJjggcyF3BqmAoBScJzR5+W8YkLIFGfHqyjLjb0k3M2k0bMdxVN8
	 Tqk7mr7tz2n8Ine2ECPiV2R8Q30+eAsx6Q1FiYYwemtOSIEKpcocRGwhq01ahX9MNh
	 mkhmU9FY8c1uCmnSLzimjL6O4orrJe9EB3sg22QU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfA1Jgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 04:36:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:35128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726668AbfA1Jgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 04:36:31 -0500
Received: from localhost.localdomain (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EAE320880;
        Mon, 28 Jan 2019 09:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548668191;
        bh=HnmiZDDnIoodoZisvzDrAioD+D+NSzvDFN8n4IKpNPI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=HyoB5MvasufV7olTUeFE9b+9WeMQpOY5yW2UzPeHzi7OhAL3i+b8yxIRVbv3q6k4Z
         +uCKXwOC2XVlag+xXeQ7jgah5B29r0yuLePzshYPacmf6aZZYk5S56nk7tOtQKERYV
         dA1MGvUoo0ECS25WXZy37Sg+RVYHBUGyo+hXND/E=
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>, robert.jarzmik@free.fr,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        bbrezillon@kernel.org, marek.vasut@gmail.com, richard@nod.at
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [v4,-next] mtd: docg3: fix a possible memory leak of mtd->name
Date:   Mon, 28 Jan 2019 10:36:22 +0100
Message-Id: <20190128093622.18620-1-bbrezillon@kernel.org>
X-Mailer: git-send-email 2.17.1
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: decbd9e173cadf348b86038356d1aad8ef69e4f5
In-Reply-To: <20190125021242.17268-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-01-25 at 02:12:42 UTC, YueHaibing wrote:
> In case DOC_CHIPID_G3, mtd->name is not freed in err handling path,
> which is alloced by kasprintf(). Fix this by using devm_kasprintf().
> 
> Fixes: ae9d4934b2d7 ("mtd: docg3: add multiple floor support")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied to http://git.infradead.org/linux-mtd.git mtd/next, thanks.

Boris
