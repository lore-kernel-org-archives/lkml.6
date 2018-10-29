Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B4EC46475
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 07:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C04CA20851
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 07:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFM98eQT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C04CA20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbeJ2Qh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 12:37:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:45068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729090AbeJ2Qh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 12:37:26 -0400
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A23B220851;
        Mon, 29 Oct 2018 07:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540799397;
        bh=VBIB3j/I8Wz+6iVanr0oduPk5nh0olzBHsMdqasuKoY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oFM98eQTTdSP6xfcrqiN0T2e4a6x9Z4iaZ4OSdQmtBL4RHmwt0RNmrzFPBUZb81X1
         DjHmwN1WlSohmgXE/2AOpwFpvJgYAjdS8Ka1DFc4eekSYx5sbebEWXB0eT6baiu8HK
         l5gXplZQlv27jEnuoaN51ppMeaQIkM+SJ6MAILIs=
Received: by mail-lj1-f172.google.com with SMTP id x85-v6so2593438ljb.2;
        Mon, 29 Oct 2018 00:49:56 -0700 (PDT)
X-Gm-Message-State: AGRZ1gKWJZQovLwug5Pyt7jK1Oz4k21KBM7hUcm93iuLNYKLTHaCjR/b
        RoV8s/hyPmvGq0qWXTsI2KB+th9cCf5962z1okk=
X-Google-Smtp-Source: AJdET5dw1UJTz9IZH8g1rMLNw4ofWbW0ztaASjaOy1/pLg2B941Py6+IBd4BHBP94gdEjtSUDfETWCcbghQNIFlA8q4=
X-Received: by 2002:a2e:6503:: with SMTP id z3-v6mr7348162ljb.153.1540799394752;
 Mon, 29 Oct 2018 00:49:54 -0700 (PDT)
MIME-Version: 1.0
References: <1540619262-22681-1-git-send-email-Julia.Lawall@lip6.fr> <1540619262-22681-2-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1540619262-22681-2-git-send-email-Julia.Lawall@lip6.fr>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 29 Oct 2018 08:49:43 +0100
X-Gmail-Original-Message-ID: <CAJKOXPceTN=idoipU_X+jZQQorRVh3cBaepw72q5O-vn49OGzw@mail.gmail.com>
Message-ID: <CAJKOXPceTN=idoipU_X+jZQQorRVh3cBaepw72q5O-vn49OGzw@mail.gmail.com>
Subject: Re: [PATCH 1/8] clk: max77686: constify clk_ops structure
To:     Julia.Lawall@lip6.fr
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        kernel-janitors@vger.kernel.org,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, mturquette@baylibre.com,
        sboyd@kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Oct 2018 at 08:23, Julia Lawall <Julia.Lawall@lip6.fr> wrote:
>
> The clk_ops structure is only stored in the ops field of a
> clk_init_data structure.  This field is const, so the clk_ops
> structure can be const as well.
>
> Identified and transformed using Coccinelle.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>
> ---
>  drivers/clk/clk-max77686.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
