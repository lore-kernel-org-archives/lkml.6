Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743E0ECDE43
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 00:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0313F20869
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 00:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sendgrid.net header.i=@sendgrid.net header.b="KjuVwu2C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0313F20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=korte.land
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbeJTI20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 04:28:26 -0400
Received: from o4.31pqt.s2shared.sendgrid.net ([167.89.55.65]:14200 "EHLO
        o4.31pqt.s2shared.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726542AbeJTI20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 04:28:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sendgrid.net;
        h=mime-version:content-type:content-transfer-encoding:from:to:cc:
        subject:in-reply-to:references;
        s=smtpapi; bh=8WAgGBP9FqOYcPWmDG0XiMqulOOY1Z3ZxgRPOo3VLt4=;
        b=KjuVwu2CcZsJD4fHdjGwkbHFOiLWSTOA4NlMVtpNTztuqbJctzSbcHBdgRV36yvAoDPk
        StiQFOF7XWOr62i5Ieyu23O+wNFfts2JtD9MBbint4R7v6by8aJ/3dsstx8To+469HqFJg
        SBaO10zaXQz0CwQbqEI/xZHyIUXfbz/Mg=
Received: by filter0006p2las1.sendgrid.net with SMTP id filter0006p2las1-19557-5BCA74B0-19
        2018-10-20 00:20:00.988234985 +0000 UTC m=+105217.348206259
Received: from korte.land (unknown [146.185.150.169])
        by ismtpd0002p1lon1.sendgrid.net (SG) with ESMTP id YOypaPXITiOI0FfiO3cuZQ
        Sat, 20 Oct 2018 00:20:00.457 +0000 (UTC)
Received: from mail.korte.land (localhost [127.0.0.1])
        by korte.land (Postfix) with ESMTP id 52FA8603F7;
        Sat, 20 Oct 2018 00:19:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Sat, 20 Oct 2018 00:20:01 +0000 (UTC)
From:   Will Korteland <will@korte.land>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        JonathanCorbet <corbet@lwn.net>, Jason Baron <jbaron@akamai.com>,
        linux-doc-owner@vger.kernel.org
Subject: Re: [PATCH] Documentation: dynamic-debug: fix wildcard description
In-Reply-To: <74834e33-3876-9eeb-5139-903bd412059a@infradead.org>
References: <74834e33-3876-9eeb-5139-903bd412059a@infradead.org>
Message-ID: <636555f5a50bed2afa7f79aba41321fc@korte.land>
X-Sender: will@korte.land
X-SG-EID: =?us-ascii?Q?cUnx5NqAuhUbAHG4iZ9Vx1BO6oMeAW3Kqk+xSEzhkR48c1futjyLp2=2Fwp8OUBt?=
 =?us-ascii?Q?=2F5X+h1tdyY33lVKbOQVGXUFee5jXzXSX3DwIyxm?=
 =?us-ascii?Q?3PJkJnr4csFbyGVXRnFtxndcAd2=2F2VMCzpAO8P5?=
 =?us-ascii?Q?2PwQh8=2FR9LuUD=2FiK99STpQlE6du9bvJNakz+Y9D?=
 =?us-ascii?Q?XEsceysEuXJwfj1rwdzkWPfVeE9YROaIoTIttct?=
 =?us-ascii?Q?9kPb3HmxxhHTygp4e2yPEmNDaA4O49iATRAmsz?=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-20 00:16, Randy Dunlap wrote:
> -A another way is to use wildcard. The match rule support ``*`` (matches
> -zero or more characters) and ``?`` (matches exactly one character).For
> +A another way is to use wildcards. The match rule supports ``*`` (matches
> +zero or more characters) and ``?`` (matches exactly one character). For
>  example, you can match all usb drivers::

"A another" -> "Another"?

- Will
