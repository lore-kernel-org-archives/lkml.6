Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BBEC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 21:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A017121479
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 21:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZctG/Xcl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbfACVWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 16:22:18 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44801 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727820AbfACVWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 16:22:17 -0500
Received: by mail-pf1-f193.google.com with SMTP id u6so17227544pfh.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 13:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:subject:cc:to:in-reply-to
         :from:user-agent:references:message-id:date;
        bh=2GrbhEjMXkwitqpsbKbAygt68MVpKcPqBE9ZY2HM9LY=;
        b=ZctG/XclDlRJNXLiHD9KvmkWKkyOc0+IBwiqdZBJNhy8A3nUp0rS6EgrU+O8tX+nRt
         AZ55s9LPsEmSs4zjqmj63jF6M9zPWu9yg2W0Xe2g3fns8NLbKpkTW/WB1pvx9r+QD+qX
         mZ+ksmhT3gD50HLYT5avhkcmA8vlMoF0diS0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:subject
         :cc:to:in-reply-to:from:user-agent:references:message-id:date;
        bh=2GrbhEjMXkwitqpsbKbAygt68MVpKcPqBE9ZY2HM9LY=;
        b=l2Dz0N/ENmxokZGSRFEH11nkBhj2QkPzzQBc+xKUuP06Ik2ffRBytVQ5MGtqEQn+JY
         o/A4KYzYThm++TwtVK0MV2OIDzrE8i950BaYM3MrMlGfocMlXLtsi4zQyISICISiK/pw
         E73IHpXeIteKk9iJEidDsWJuFpmxaveGuuL6Ph+BRwO6tT15+hMiv6yw2yK0rFoTbgKW
         doTKQ/OQEEJFo67CDRtm4n9aBSuO+6fszxQFdLXdUnl/7uk29wvRgEmURhc3yErPkO1/
         Hz0PqXh5lSiPId1CRNaHd+PlsziWfxC6uira28iu7OT5oEXK2G1RYW5aL+8oLMA5bRHR
         TrNQ==
X-Gm-Message-State: AJcUukd57+tX2jO/FQQ3ku6gfXOKVHNuUtCWcoDwaV4jmUaXUsJAfSeD
        ExfqEpD+mRG6djDFZzx9Jh/h3A==
X-Google-Smtp-Source: ALg8bN7QFZNUzLTGzuRab3N3Bbpz8ET5nsJzudSq/I/7LHT6EXxOv9zz/bawoPoFj/LrBINFSl1Rmw==
X-Received: by 2002:a63:3c58:: with SMTP id i24mr30043174pgn.284.1546550536786;
        Thu, 03 Jan 2019 13:22:16 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id i184sm78639497pfc.41.2019.01.03.13.22.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 13:22:16 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 4/4] tty: serial: qcom_geni_serial: Use u32 for register variables
Cc:     Evan Green <evgreen@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Ryan Case <ryandcase@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Ryan Case <ryandcase@chromium.org>
In-Reply-To: <20190102213636.40866-5-ryandcase@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8
References: <20190102213636.40866-1-ryandcase@chromium.org> <20190102213636.40866-5-ryandcase@chromium.org>
Message-ID: <154655053537.15366.12329201016969398011@swboyd.mtv.corp.google.com>
Date:   Thu, 03 Jan 2019 13:22:15 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ryan Case (2019-01-02 13:36:36)
> Signed-off-by: Ryan Case <ryandcase@chromium.org>
> ---

It'd be nice to have any sort of commit text here with the motivation
for the change (code clarity is my motivation).

Besides that nitpick

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

