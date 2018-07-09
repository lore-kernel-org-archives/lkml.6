Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEFAC5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 074A5208A2
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="H60d6Nz+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 074A5208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932789AbeGIWZ4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 18:25:56 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34671 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753008AbeGIWZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 18:25:54 -0400
Received: by mail-pl0-f66.google.com with SMTP id z9-v6so6655563plo.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 15:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:organization:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=7WRgaPWGQSxNwPRJYPrf9V4IdDnHcZRwdFwXtrHImuc=;
        b=H60d6Nz+VgW7Wi2fkqDhZ0Qnqy2C/xvp84y08q9cpM5Wj7fx2KMHrPwrwqsdt4SEYB
         CU/eddhk4nfomxV9e08FmBBDnHi7v3mmjz64LzJv/P6EIHDXqnKRS+l1vjF0/Xm6xbUu
         9YnmvgP04+6wWQEpmUn2E9Flhwj1NPlB+kzHCS2IDbHSrqz+IP6bkEB0qiwOOqG+JMF7
         6b2eReUHA4uG8Z5gtpGF6AAv6+6LhICXhvLkyDXFwcPq462heGHgpHdGi+shRWpzCDi4
         fMDyfREqbVKt9Mrz6GuPvbyjcwatN0ukQOjPyse2ybSNiPKFzRiPVseoKusZZcEb6o1X
         HLcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:organization:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=7WRgaPWGQSxNwPRJYPrf9V4IdDnHcZRwdFwXtrHImuc=;
        b=WU4tmCoW56TqKB+q4CKYqgOWqNNMgKflCAeEaLNLg/IafoDZ18MezdV8mNgsjtBqq/
         /r2UXmlS0ijoDcxo4hm9mKe+d9u29AEk35s4Io1eMHO5WBzu2dOJ2Fl72so2AfAiXrKo
         bvNVTQDxQ4OSL0Aazx2OTPCP5lrSURD5JapO0OpCsc6ZJ04CgbNUqwRmJZ/yzdGTyXoj
         Gqt3I/S6dBjB/j/qwKJMFWp3BIgCJqgdDx6/d0A2VCxU1gmHzWjxUHK/HHIpKT81gcDb
         CPsJ2dtieAcYnC8YqobO5Me7lNno2Tby0snyepBzeqltmu7gengi0xaz4TmDhmyJyXfx
         qOSw==
X-Gm-Message-State: APt69E0OYBwtCF6qWWDAnPzBF4ZFwhDEng3emtGrcPGYrWML23Y2yXy6
        HQZ+qz6WuwsA4CSXrWjx9rDkWg==
X-Google-Smtp-Source: AAOMgpd3iHRlP+zVlEzDkspz4hONhd3YKTTyGr1RwYCLoxwymPcEIOLPN8Ayd20MhT1Ggq/2ZsRnlg==
X-Received: by 2002:a17:902:7b94:: with SMTP id w20-v6mr22203207pll.280.1531175153698;
        Mon, 09 Jul 2018 15:25:53 -0700 (PDT)
Received: from localhost ([98.237.141.101])
        by smtp.googlemail.com with ESMTPSA id i6-v6sm24082269pfo.107.2018.07.09.15.25.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 15:25:53 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Carlo Caione <carlo@caione.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM64: dts: meson-axg: add spdif output pins
Organization: BayLibre
References: <20180704170409.25809-1-jbrunet@baylibre.com>
Date:   Mon, 09 Jul 2018 15:25:52 -0700
In-Reply-To: <20180704170409.25809-1-jbrunet@baylibre.com> (Jerome Brunet's
        message of "Wed, 4 Jul 2018 19:04:09 +0200")
Message-ID: <7hwou4m4gf.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> Add the different pin configurations for the spdif output
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Applied to v4.19/dt64,

Kevin
