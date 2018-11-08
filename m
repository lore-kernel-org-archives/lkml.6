Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A9EECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAC1B20840
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvVRi1by"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAC1B20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbeKID4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 22:56:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:51468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbeKID4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 22:56:13 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3438720825;
        Thu,  8 Nov 2018 18:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541701170;
        bh=hyuGyPWsjoFKYyWOu9UL+k0JbgP06pF32daBf9nnD20=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=hvVRi1byTfQYvkp8D+ScGxNZwK0svBIhfeqlMRyshXbg7YsnajjCXTmx8BBDFkd83
         TnO+96v/Q2rMEr5f4ge3YfBnmcU5d1Pkn65I1kmepxrdCQnBv9pJkx3EMf5Y+XnXej
         G1/FNbE1Y9u10H02vZf+EvtMZCXrzndWvFhjOmTI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Yi Wang <wang.yi59@zte.com.cn>, paul.burton@mips.com
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1540971702-3133-2-git-send-email-wang.yi59@zte.com.cn>
Cc:     mturquette@baylibre.com, linux-mips@linux-mips.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhong.weidong@zte.com.cn, Yi Wang <wang.yi59@zte.com.cn>
References: <1540971702-3133-1-git-send-email-wang.yi59@zte.com.cn>
 <1540971702-3133-2-git-send-email-wang.yi59@zte.com.cn>
Message-ID: <154170116960.88331.164103375264551287@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 1/2] clk: boston: fix possible memory leak in
 clk_boston_setup()
Date:   Thu, 08 Nov 2018 10:19:29 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Yi Wang (2018-10-31 00:41:41)
> Smatch report warnings:
> drivers/clk/imgtec/clk-boston.c:76 clk_boston_setup() warn: possible memo=
ry leak of 'onecell'
> drivers/clk/imgtec/clk-boston.c:83 clk_boston_setup() warn: possible memo=
ry leak of 'onecell'
> drivers/clk/imgtec/clk-boston.c:90 clk_boston_setup() warn: possible memo=
ry leak of 'onecell'
> =

> 'onecell' is malloced in clk_boston_setup(), but not be freed
> before leaving from the error handling cases.
> =

> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
> ---

Applied to clk-next

