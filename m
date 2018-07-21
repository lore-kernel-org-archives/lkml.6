Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD009ECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 19:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AD7620858
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 19:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="e9DTxxXa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AD7620858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbeGUUbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 16:31:52 -0400
Received: from vern.gendns.com ([206.190.152.46]:52759 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727838AbeGUUbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 16:31:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=EKoe83X3vbh5nGxdLk5UEJXL4rQZNUZvR1vixnAB8F4=; b=e9DTxxXafSE6e60zdf2wWalz6E
        uH25ou50zX3gUNzTr4cZXAqkkHHKZQj77cB0ALx7m1hK1wt2t4HSLmtnsAoizGLdF6PxvkzINc6Cl
        osOOc0feL8U6odOSvnmUpKx4Z+yagp/wY+9eKrBKFxxpqUDgF09s5MH61Z463yTRKXsOLWGrU6t0M
        /7Rh+aW4BJaWntO7TViju2EgbJ0f5yp3+tl56SVwUSjmPOtb5EiBlUrzJp6QquiAhgJbabXIDjxIs
        odpwR0Fxo5FbYnxl++6HPBDAafszfwvXwDhvlWvYNqZe6S5MPI2fyf6fJfkgOa/dbzjfIuHUKZQFA
        oTETjqsw==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:35490 helo=freyr.lechnology.com)
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1fgxhW-009bOk-QP; Sat, 21 Jul 2018 15:37:59 -0400
From:   David Lechner <david@lechnology.com>
To:     linux-iio@vger.kernel.org
Cc:     David Lechner <david@lechnology.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] iio: adc: ti-ads7950: allow simultaneous use of buffer and direct mode
Date:   Sat, 21 Jul 2018 14:37:32 -0500
Message-Id: <20180721193734.6427-1-david@lechnology.com>
X-Mailer: git-send-email 2.17.1
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2 changes:
- add new patch to use SPDX-License-Identifier (since we are touching this file
  anyway)
- don't add struct iio_device *indio_dev as field to private data
- fix indent on return statement

David Lechner (2):
  iio: adc: ti-ads7950: use SPDX-License-Identifier
  iio: adc: ti-ads7950: allow simultaneous use of buffer and direct mode

 drivers/iio/adc/ti-ads7950.c | 42 ++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

-- 
2.17.1

