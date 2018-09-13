Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C68C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 03:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEA6B2133F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 03:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ovqgi7Jp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEA6B2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbeIMJHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 05:07:17 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45386 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbeIMJHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 05:07:17 -0400
Received: by mail-pf1-f195.google.com with SMTP id i26-v6so2018702pfo.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 20:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:organization:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=FlLb4ujcmBnp6HTDrIY0VBmiTgs8i1J/zlYeTsAUdoU=;
        b=ovqgi7JpyCsGuO+YP3TXlv3DpuZToRMwOeCTroDs+DnY/OkxFj6T8GY4OYscnXoFxn
         LFx6gTB08P/Rm55kW9hILEcVtivDoGZAev9Og61qZceOvSpHhe8CwfVqKknlMywDIh5C
         nx6Ji19ah/RKqoDuquVUMiKMxYroy+SOy4jRo52vmfEPB4azw3zTIxLA1QU+3YlvVaQw
         kKst9NfIAxofbvFJXn3yFad4A2jkryiVzrN2DEfj9w9eOku3isHq7/DbcH5oQTxKcNWN
         vEe3ynLzBza08DXdkok4HE/5IcGC3dvKfO0H0hhm8+Rzu84KtiVCCspqqhUL/2OtNpfr
         0HcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:organization:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=FlLb4ujcmBnp6HTDrIY0VBmiTgs8i1J/zlYeTsAUdoU=;
        b=N6TJLWhnrVHOrY+n5fcDeXaAZTdadKBX0utZZGonbyGHYR3ziHWh+xL3ER9LmosXHS
         cNkV8BHV9TC09NcFGiTHhwDPVRGqh1rXrJHD82CRnJnbLWAir5qQ4SFTB0hwQEiyPzs3
         hM2IHcv5h9BZpiIQxo8vWxi/b5l/a71Dy9PkIh+Tc2AGXYS5VzQskGU/0sPkDu2QQAMc
         DbPCBFkhSyf0I/+AKSj/FxZ9D/uvEd4ywoUzYImHBuWoGk3crXyVo3WLteiE+YBrdfuM
         m7/aaC2CXUE0MMMkjwTSwyNc5qFwTvu4eIwm4IuNRV7jbVeY9THsicwQ0Bt98jBzi/3N
         qfwg==
X-Gm-Message-State: APzg51BhNY8c78PSNajA8xkU/fgR/JuDoX0xIU4zPIwclAqnllhksO1K
        lIkvjm/ptGQQl7OfhBw/hvTZqw==
X-Google-Smtp-Source: ANB0VdZn8sv6wg2EWjVYH3UUxUYlXSnXcwLKjTHqpNfNVKTgR8wLqymlGY1SboMLd+HzX0xV0CYn0A==
X-Received: by 2002:a62:d113:: with SMTP id z19-v6mr5358036pfg.98.1536811178692;
        Wed, 12 Sep 2018 20:59:38 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id 193-v6sm9139499pgh.47.2018.09.12.20.59.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 20:59:38 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: meson: Switch simple-mfd and syscon order
Organization: BayLibre
References: <1532614438-7207-1-git-send-email-narmstrong@baylibre.com>
Date:   Wed, 12 Sep 2018 20:59:37 -0700
In-Reply-To: <1532614438-7207-1-git-send-email-narmstrong@baylibre.com> (Neil
        Armstrong's message of "Thu, 26 Jul 2018 16:13:58 +0200")
Message-ID: <7hh8iuxd1y.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> The order between "syscon" and "simple-mfd" is important because in these
> particular cases, the node needs to be first a "simple-mfd" to expose
> it's sub-nodes, and later on a "syscon" to permit other nodes to access
> this register space through the "syscon" mechanism.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Applied to v4.20/dt64,

Kevin
