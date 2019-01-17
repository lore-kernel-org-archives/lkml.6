Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 658B4C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22EB020851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="l/3H2+Y0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbfAQU6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 15:58:08 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37784 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729311AbfAQU6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 15:58:07 -0500
Received: by mail-pl1-f194.google.com with SMTP id b5so5295154plr.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 12:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=FONDXt4AJS71zhG3kJTYtIF5wWChTZfEXF4/HXKEofg=;
        b=l/3H2+Y0/pOomsSjtHpSWzSHnVn90wsHBtZ6YGQMUu5OFV7ckMTMIGrdgZZOPMJ+Qa
         Xt5awjqXnrlSUtp9Tso8sIDjaFssG8Ffi5Srzqnade72ebse41WHYHFjS3EKdIes1Ukc
         JafNA2Rnh0GOfD7X0eQ1aA7Eqrx2unJHE/y7+lPOFxPFRH4IKabvEogjgRWldbxxoWSl
         Fxt1RpzwtU95c5e+HuN87kBmu8EjFmEjZGtOj1ci9uLpmxnD79FMzhugJU15VAN5GXuP
         HGAeRU/cgaVv0WBsXODnOproX3/ee9AYkamUy7ZDWRdRJlee5J4WkAfQGFGwfBG5ftFU
         1IwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=FONDXt4AJS71zhG3kJTYtIF5wWChTZfEXF4/HXKEofg=;
        b=fNT0vHTtyOhZaFYWlzili+gfkgOnygQwxHaNMBt6EaozHIlm/ZDF3rEvsQIs0FtBFQ
         2TEbTFtHBK4DeA51BgiMB8VZ8xEutUb/5Dj/0Wx7uJ5rMZxieYQImSfk9gJMbUStgdyf
         GQQNMjcOv914A3S82kvBf6Luci9pAdVMrlexk45g8RYT08lxUCU1EjHdDMPt3AfeV3AS
         vV7SZPruM8BSH23FX0IpVVCwNC+W37/9u3T5RJm+A07r0WcKQUlnBkA+IjOPpH4/F0CW
         2/8bUyRDq9GGolyaVl44FjwJWPoww7a6x/hZkHI6TBNdo1JQUDbgT/if+E9EM72eqkBC
         4FFg==
X-Gm-Message-State: AJcUukdN8RQRHYJOdBXwGdQjAAEZCvLhOMxAXVxA+Bny+UO5sMvnwwv+
        xrsemhJ69OD63W+0OfaFCTj6iw==
X-Google-Smtp-Source: ALg8bN5aJPz/0qz25QK1e0Bf+RKkhytaFVzqGtNKMEpBqgbfHLnDVHH4Opvkd9clxBs5N8COF5GkmQ==
X-Received: by 2002:a17:902:c85:: with SMTP id 5mr16744477plt.339.1547758685505;
        Thu, 17 Jan 2019 12:58:05 -0800 (PST)
Received: from localhost ([2601:602:9200:a1a5:e076:9fe9:59e2:1e0b])
        by smtp.googlemail.com with ESMTPSA id h128sm4172909pgc.15.2019.01.17.12.58.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 12:58:04 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Maxime Jourdan <mjourdan@baylibre.com>, devicetree@vger.kernel.org
Cc:     Maxime Jourdan <mjourdan@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v3 0/2] arm64: dts: meson: add simple-framebuffer nodes
In-Reply-To: <20190116124030.16882-1-mjourdan@baylibre.com>
References: <20190116124030.16882-1-mjourdan@baylibre.com>
Date:   Thu, 17 Jan 2019 12:58:04 -0800
Message-ID: <7hfttratnn.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxime Jourdan <mjourdan@baylibre.com> writes:

> This patch series adds support for simplefb for the GXBB and GXL chips.
>
> simple-framebuffer allows sharing a framebuffer already setup by the
> firmware to the kernel for a seamless boot transition.
>
> It goes along with a u-boot patch series adding display support to
> GXBB & GXL [3].
>

Queued for v5.1 (branch: v5.1/dt64)

Kevin
