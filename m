Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6473EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B9F42146D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="GvD1q8bt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B9F42146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388410AbeKPF62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 00:58:28 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46939 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbeKPF62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 00:58:28 -0500
Received: by mail-pf1-f196.google.com with SMTP id s9-v6so10171847pfm.13
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 11:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=Ya7zR+5h3Xy8UKYRf5rz1pgPkpCymYtlyNpnLZi4JEI=;
        b=GvD1q8btp54izCLzKQGXIp34t6d65S3EEuHcMpcik4xKdfm1W73qYTeCWX9gFEnLdc
         6PWQ6T+HzsApnpUaJQekPYqaQTsLz1ak0DTQjiRqcc0ZJC6knHzXRiEHLgA0l4KGeDj8
         OLuiMTDUfPggpQpq60ScNe/QVm+w5AnHoXvt6xTQ1L51/YeBV5hwnPnvryaIlhkau/P2
         Ugo6cZmfAqEqVb82GkzoF+iZWrRKN/G3xdi+WUCKwktSAN27S6IYL0vVJPdSbv7Vny3k
         6O6GBhznAkIJPiSlohTKu/LdcOPJ7MA/+0TkiVaTqwxaZLHN/KJSR6psXOybAn9PgDiK
         nl4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Ya7zR+5h3Xy8UKYRf5rz1pgPkpCymYtlyNpnLZi4JEI=;
        b=Ax1M9dzB01s75VCBl77zgGh53jfgIFlHVkzpcjbSHCgd4oU77ULkiaMMGfs56BuFkX
         REyhqlsiZqXqZrCdUGR9fYl5kfZuvVM21nrQoTRXBfF+Ebah8RAT1rlAyWOcb3Gx+yl5
         vgq/3e5Ks59XDv/mrbTfup86eR7IunW8sVIZhUfJT78BogWrSlMTsLeao7d/UkTMO9Uw
         iDx/1adNp6TYDVdQFy47VjfqjreCgAjLWBLHazjX1o7AicL7tpmvgenQhUH0kTPOZ7BK
         1gi7qlTgxU2yUg6TI+NxKl0hn5Lx4CgeiOaTOxlaWGKR/l0h+Q3WDIyNpzOcxDxXO7st
         5Pdw==
X-Gm-Message-State: AGRZ1gKcN703daIyYUojPciBVmghWpO7YeMnW6+/0ibD54u8Lprw5F0f
        qR8gMDpnWiqs74ObcqXFlmgXeQ==
X-Google-Smtp-Source: AJdET5elRE7qwS60icZNM2MlurA9gkkd+U8A2siam7YA+CQ6yShGQotuLbTOFairB9Gnxy+OqcJWJA==
X-Received: by 2002:a62:cc4:: with SMTP id 65-v6mr7805011pfm.127.1542311356611;
        Thu, 15 Nov 2018 11:49:16 -0800 (PST)
Received: from localhost ([107.181.189.87])
        by smtp.googlemail.com with ESMTPSA id g136sm5924836pfb.154.2018.11.15.11.49.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 11:49:15 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH RESEND] arm64: dts: meson-axg: fix dtc warning about unit address
In-Reply-To: <20181108095156.26810-1-jbrunet@baylibre.com>
References: <20181030150614.19461-1-jbrunet@baylibre.com> <20181108095156.26810-1-jbrunet@baylibre.com>
Date:   Thu, 15 Nov 2018 11:49:14 -0800
Message-ID: <7hzhuadsud.fsf@eze.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> section 2.2.1 of the DT specs says: " If the node has no reg property,
> the @unit-address must be omitted and the node-name alone differentiates
> the node from other nodes at the same level in the tree"
>
> Simply replace the '@' with a '-' to fix this warning.
>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>
> Hi Kevin,
>
> I'm resending this change because I noticed the previous patch I sent had
> references to spdif input which has not been merged yet. This would have
> triggered a conflict in your tree.
>
> Hopefully, this new version will apply correctly

Thanks for the resend, this version applies (and builds) cleanly.

Queued for v4.21 with Neil's tag (branch: v4.21/dt64)

Kevin
