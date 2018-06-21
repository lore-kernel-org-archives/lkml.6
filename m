Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E17C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 15:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CBD4208B0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 15:11:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CBD4208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933310AbeFUPLf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 11:11:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54260 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933178AbeFUPLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 11:11:33 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 18E0B3082141;
        Thu, 21 Jun 2018 15:11:33 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 065F0200824F;
        Thu, 21 Jun 2018 15:11:33 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id DEEFB1800531;
        Thu, 21 Jun 2018 15:11:32 +0000 (UTC)
Date:   Thu, 21 Jun 2018 11:11:32 -0400 (EDT)
From:   Bob Peterson <rpeterso@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>, y2038@lists.linaro.org,
        Abhi Das <adas@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Message-ID: <1526735430.44722790.1529593892692.JavaMail.zimbra@redhat.com>
In-Reply-To: <20180620142857.33297-1-arnd@arndb.de>
References: <20180620142857.33297-1-arnd@arndb.de>
Subject: Re: [PATCH] gfs2: call ktime_get_coarse_real_ts64() directly
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.3.116.54, 10.4.195.26]
Thread-Topic: gfs2: call ktime_get_coarse_real_ts64() directly
Thread-Index: WHwBhQ6GTCt8Mf0nGXPw/a7k2HKDxg==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.25
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 21 Jun 2018 15:11:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
> current_kernel_time64() is now just a deprecated wrapper around
> ktime_get_coarse_real_ts64(), so let's just call that directly.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
Hi,

Thanks. This is now pushed to the for-next branch of the linux-gfs2 tree:
https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git/commit/fs/gfs2?h=for-next&id=ee9c7f9ae3d4fb9fb5c9cacbe3880d5dd66feb16

Regards,

Bob Peterson
Red Hat File Systems
