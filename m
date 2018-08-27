Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB9BC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 13:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDB2F208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 13:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ABZc6jVc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDB2F208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbeH0QyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 12:54:25 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51558 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbeH0QyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 12:54:25 -0400
Received: by mail-wm0-f67.google.com with SMTP id y2-v6so8039908wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 06:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v5W4yPzOnHExLZmGFwxFuEst3xBu3y9SIYVlzHYk0GA=;
        b=ABZc6jVcEvogCyOCHxDEyInSnlBgKp6QeIffd8OOo0XL9OtJKl5Og4H25bQ5N3DPcu
         2XzCMoEZn1/QecjmClHzBFG96Dm3pWdprjlZrRMbUllgeAo5RSiynutNmoFLhxC9p/63
         HINF5LzI+td59eNn/I25BQk4gIstn3+K3Y9BiQyp8yiKs6s9O2lTyMqaW06ApR3/F3M9
         PUNgiHoajBWPSLcjMGb915/XHn8C/DXWpEo3CJz+knMQMwOM3m1SWRh5QPPOL3HiMp0S
         Pe1Gvl0jkRbBIUmGcutzsKefV2xZ9n46v1DJjDJK/2YS1Y2Pa+UoQUfRnK9eDCOZ5RMB
         DwgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v5W4yPzOnHExLZmGFwxFuEst3xBu3y9SIYVlzHYk0GA=;
        b=hRgS0YJHU46/jHG3Cwaf7/lMX/XDZ1T/GZHeWNScxxIyVq/L+OpssfI6ld3dp7qQvk
         rDQM3uGEq74XAwNkU4aTxqYW4koHg8T3UYqWQlk0lbn2nwXu/8pwmsMIouOyh/eCDcRY
         gqYJN5Tfx3tUgGrLiLbBIrfn3CYImNh8DuytUCoSGiK/9P0L3/a37+ohXIc0mLVoiWir
         0ob7BkYQIGvUMVwONZTpN9OiPmY+qW+VknrFPaEtVjw2hRFIzTI4R3yUALxvBIqoFVFS
         5yx/h7eVY+Odo5I7E6Gi7ZHQyFArI7iIS/E8sp35IsEqq8PFHCn9prXhvaZD03UPKr66
         QuZg==
X-Gm-Message-State: APzg51A4Mmg9UlOvwdJ8H7xyHfy4Pu75aeFW8HvviHhb1GmRPVifTbgL
        fbxsHDoKs5I23Y1FnvqQjt8JlQ==
X-Google-Smtp-Source: ANB0VdbNT/NCiRTgjrd0Zac+NVuCnoXUzpICouCpX3JwQ2p/dAfDltzKpqmVZmmAYbi13LgU5BLZUg==
X-Received: by 2002:a1c:32c4:: with SMTP id y187-v6mr5386473wmy.31.1535375268177;
        Mon, 27 Aug 2018 06:07:48 -0700 (PDT)
Received: from boomer ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id v5-v6sm13379267wru.60.2018.08.27.06.07.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Aug 2018 06:07:47 -0700 (PDT)
Message-ID: <89b058a7bba26058fab95dea01155221dbb642ce.camel@baylibre.com>
Subject: Re: [PATCH 2/2] clk: meson-g12a: Add AO Clock controller driver
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Jian Hu <jian.hu@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Rob Herring <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Date:   Mon, 27 Aug 2018 15:07:46 +0200
In-Reply-To: <fff1f982-c9f3-8aa4-b108-6c0998827e79@amlogic.com>
References: <1533894868-85815-1-git-send-email-jian.hu@amlogic.com>
         <1533894868-85815-3-git-send-email-jian.hu@amlogic.com>
         <6c855dc62fe6ed1a01216bd708d401a280f8762c.camel@baylibre.com>
         <fff1f982-c9f3-8aa4-b108-6c0998827e79@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-08-24 at 21:34 +0800, Jian Hu wrote:
> > 
> 
> I am confued about aoclk81's parent clocks.
> 
> I can not get the example of axg audio clock driver, Could you provide 
> the link? Had it merged into clk-meson.git?

Yes and mainline as well : drivers/clk/meson/axg-audio.c

Basically this driver is creating bypass input clocks (audio_pclk, mst_in[0-9],
etc...) .

This allows to collect input clocks from DT (like any consumer should) will
keeping constant in the controller clock tree.

From what I've seen of your controller drivers, the EE controller should have
one input, the AO should have 3.



