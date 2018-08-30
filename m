Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C7E6C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEFCC20837
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tbJgB2Q7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEFCC20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbeHaCY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 22:24:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:41344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727229AbeHaCY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 22:24:26 -0400
Received: from localhost (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C98F20834;
        Thu, 30 Aug 2018 22:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535667605;
        bh=KRWOj8HN0H6okb/CU0oGXbJezJ9IHRdBTnSFJYF8fhU=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=tbJgB2Q7KaWiKEwFryBmahIPu6QUq7zYjFP9jkgHrdwi6VY+hmMBa/3miY28LiWiW
         9J0q5lxGRInDsGagZL5ummYbNKzMkErAWubU6An8LyGjAlA+vNwNPkb6ab/nSzDiGw
         ybgzghbwHKYkeC7wc+mVRtRVVu5ZDk8Ck7PZCVQw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Michael Turquette <mturquette@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1534885532-26558-1-git-send-email-khoroshilov@ispras.ru>
Cc:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
References: <1534885532-26558-1-git-send-email-khoroshilov@ispras.ru>
Message-ID: <153566760504.93865.7380493717123451991@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: cdce925: release child device nodes
Date:   Thu, 30 Aug 2018 15:20:05 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alexey Khoroshilov (2018-08-21 14:05:32)
> of_get_child_by_name() returns device node with refcount incremented,
> but there is no decrement in cdce925_probe(). The patch adds one.
> =

> Found by Linux Driver Verification project (linuxtesting.org).
> =

> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> ---

Applied to clk-next

