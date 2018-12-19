Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235FEC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 07:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91DBE204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 07:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cock.li header.i=@cock.li header.b="J7TGJdRy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbeLSHzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 02:55:05 -0500
Received: from cock.li ([185.100.85.212]:40742 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726631AbeLSHzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 02:55:05 -0500
Date:   Wed, 19 Dec 2018 10:55:01 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cock.li; s=mail;
        t=1545206102; bh=g7AsA7yE6zZqdUOAMFj7aACbVqwIf68pRQFvqpNLvDM=;
        h=Date:From:To:Subject:From;
        b=J7TGJdRyWfADO9ROcz2GR2G5gQ4qwq8KbziJr5Vj2OGExmzEfo3f3C54j3K0i/0FB
         hxQU8kSTWTTC7okHOtZDhUC5Mn8UPh2sYDa+Sfe67xR6glllym4kPvzPJu1jonVBBX
         lJGZ4irA8SWGxTca1s7n60A/XoKPKYx58vHqd5m3jf66yc1HkkgSmYlQr5vuNICDVr
         jEmF0HPBxJUDknk0znRgtAYvAELNpodZsxE/Jt5DjISAHEF2olYc8+vjcwMbKz6IEo
         YZo/VvUZflsU0KXRG5/Le7+ox5tVUUT7VweE5EUS8K/9UEAQj5D8IHTYgsMbZHTMk4
         vbXNBLPDuJaMw==
From:   L29Ah <l29ah@cock.li>
To:     linux-kernel@vger.kernel.org
Subject: Mysterious delays on power-related events in userspace
Message-ID: <20181219075500.mhdx2j5dy75kwgk7@l29ah-x201>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716-999-57adec
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

When i connect various USB devices or get different ACPI(?) events like opening/closing the lid (as seen by acpid) on my Thinkpad X230 with Linux-4.19.5, i get random delays (usually ~10s, but may also be ~20s and ~30s). USB-related messages show up in dmesg instantly as they should tho. This was occuring to me for a few years already. What can be wrong with my system?
eudev bug report: https://github.com/gentoo/eudev/issues/153

CC me please.

-- 
()  ascii ribbon campaign - against html mail
/\  http://arc.pasp.de/   - against proprietary attachments
