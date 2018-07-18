Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2ADCECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 953D42084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:33:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 953D42084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730999AbeGRVNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 17:13:07 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:43034 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbeGRVNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 17:13:07 -0400
Received: from localhost (179-64-212-66.spl.org [66.212.64.179])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6A9591479C5F2;
        Wed, 18 Jul 2018 13:33:33 -0700 (PDT)
Date:   Thu, 19 Jul 2018 05:33:33 +0900 (KST)
Message-Id: <20180719.053333.396851874410198344.davem@davemloft.net>
To:     keescook@chromium.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        s.mesoraca16@gmail.com, f.fainelli@gmail.com, andrew@lunn.ch,
        David.Laight@aculab.com
Subject: Re: [PATCH v2] net: dsa: Remove VLA usage
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180717041034.GA37382@beast>
References: <20180717041034.GA37382@beast>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 18 Jul 2018 13:33:33 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>
Date: Mon, 16 Jul 2018 21:10:34 -0700

> From: Salvatore Mesoraca <s.mesoraca16@gmail.com>
> 
> We avoid 2 VLAs by using a pre-allocated field in dsa_switch. We also
> try to avoid dynamic allocation whenever possible (when using fewer than
> bits-per-long ports, which is the common case).
> 
> Link: http://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
> Link: http://lkml.kernel.org/r/20180505185145.GB32630@lunn.ch
> Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>
> [kees: tweak commit subject and message slightly]
> Signed-off-by: Kees Cook <keescook@chromium.org>

Florian and Andrew, please review.
