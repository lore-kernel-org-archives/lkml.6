Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CE5C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98050206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ErKD6PQz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbfAGOFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 09:05:21 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39634 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728076AbfAGOFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 09:05:21 -0500
Received: by mail-ed1-f65.google.com with SMTP id b14so982414edt.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 06:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=W/2RBvXjOJQ952z/CyP4hTtFtFtTcbe06r2ruHrpECU=;
        b=ErKD6PQzmDOuMMgrMYYAyad8DrMFH6BJXeK9KQJzAcRiMc3fu4CWfdKgKytETlkK+c
         puMOTrf4qIWSjHqElJEdYkuUeixb+JC5tzmMLUdRwLIzRaCwHXwx6uvWwAuKTNdZadMr
         ifcZ2aAKAw0vdjlXqT5XY4MC2p0cbZSHPu5GSisEvYuVwbCKZS+Jicu+BG5UfwCzzECf
         PeYGDAs0NLeXCn6CGO9JANyupBE4+CevxjbqCAm7XoMXIGsQOVtpkqVmUA1Dj9yLZSy1
         xdItU8y8VUyB49qpFWXDgbVIbqqy3tYEr7p4YS5m/tJTAbv09gOyN9yUjATz0sBfqZoJ
         yTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=W/2RBvXjOJQ952z/CyP4hTtFtFtTcbe06r2ruHrpECU=;
        b=dVnt9bfQJfgwKhiF0veF5u0lOkZJqduvpfPWQpnAkoNNGoenchqezrOxRyIDfW78hD
         /IpFaWEL4cmgzMTbna1AhoBJCYHz1ZaRuAngSc/e/yp8A+O3UqFVqaHV3spiSSOs7+SA
         nOOLA2Iab9FBy4Pan4A8XAYgRQBqIEcQFRz0q4r9TnuQdAAYeGV32W0L2ao7tRFoESTW
         lNMEx56BG+AqFuw6Ov39nq1YC9XhZ9qW3/t1CU4sXqQuuMnYy7gjFxRG8XldfazMR0Uy
         8p1LCjbyo1yAcxhfXgKfl2B/MU91ybZoXuJDuEWmGsDs7jjDZQbOKQzfcfHL3YCvlT3v
         lRYA==
X-Gm-Message-State: AJcUukc7EOZMlv3l8ulAX1dt8vpjpwPmXckHhdVddv3sIXpaqlFAIS+y
        pW3PShIoUN0WdTMWq8BxxaCRshYp8F8=
X-Google-Smtp-Source: ALg8bN5z1IL+BHXTtVhNiCTkWGW8dsqCGok3DpycWh3r1VE1WmepCdiThSjEeTkTu0iH5CkWiUgpEw==
X-Received: by 2002:a50:8ad9:: with SMTP id k25mr11054301edk.189.1546869919451;
        Mon, 07 Jan 2019 06:05:19 -0800 (PST)
Received: from boomer.baylibre.com (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a38sm35436997edd.44.2019.01.07.06.05.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 06:05:18 -0800 (PST)
Message-ID: <6770759de6ed04ecabaa163eb550769d43dfc901.camel@baylibre.com>
Subject: Re: [PATCH] arm64: defconfig: enable modules for amlogic s400 sound
 card
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Date:   Mon, 07 Jan 2019 15:05:17 +0100
In-Reply-To: <7hmusmvw6z.fsf@baylibre.com>
References: <20180828122735.28919-1-jbrunet@baylibre.com>
         <7hmusmvw6z.fsf@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.3 (3.30.3-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-09-12 at 21:49 -0700, Kevin Hilman wrote:
> Jerome Brunet <jbrunet@baylibre.com> writes:
> 
> > Compile the necessary drivers as modules, including codecs, for the
> > s400 sound card.
> > 
> > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> 
> Applied to v4.20/defconfig.

Hi Kevin,

This patch was supposed to be merged for v4.20 but I'm still not seing it in
the 5.0-rc1

Could you tell me if there is a problem with it ?

Cheers
Jerome

> 
> Thanks,
> 
> Kevin


