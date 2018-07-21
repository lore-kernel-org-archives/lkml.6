Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF62FECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 20:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A1CD20856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 20:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="P3U7EyM4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A1CD20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbeGUVm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 17:42:56 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45640 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728241AbeGUVm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 17:42:56 -0400
Received: by mail-wr1-f65.google.com with SMTP id t13-v6so4824479wrv.12
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 13:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LqdlhjKct4bJcWkR2A1JXXlgIFYjMYw/VCweiS0reuo=;
        b=P3U7EyM4av3qbhI8aboSv1dQVOuUVa3lvIJd1fxXpS+4VP142ghgVKhjpJNbZ6cgrt
         jqSLYlsQ3IyAdxK6+vXGL41RpgJ3GGuzOJ81zbJZutNTlTb459cykGXPIjg+2NKJMZok
         IxWNdGp/5HFYu5LXc8fB61I0mjx+nak1OkaK+bhVBX4LvwRCzeYiA0V6lOsCr1xijXrl
         k71HXe+fFKG958OccchNXh0gzxMjj9dfCN9sx0NcvtkllzeflIHvPJFHRTQjZjYrcJC+
         vu491E/NKuu6k8/HIqyqxnwqTXACyBXqoyM39T+IT96lhfJ5vd23tz96I1uQul29lCpf
         YCjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LqdlhjKct4bJcWkR2A1JXXlgIFYjMYw/VCweiS0reuo=;
        b=ZWLbg0+zWoSTeLReSFzmUYpZ5xWUAfi1sVRjflN7FgYDqoO3JT07Jt9Ef4LP512o0B
         y6FSKxx1otPVueB+uDydrgpUt5XXY2vTynzXqj60X3Kkn8T3DjPdv3hMRi6SaYnfEnET
         Fu/zc0VhKqMWQSVnBuUqNKfd1tDwooKdQPd2Mxr72xd8GmR+/J+vB/yTZ4B8AN86VJas
         JBYt+fP59XbWHlQi3gHYuFKoNoGShCc72DJmkznlgSZ/BvXTA5npj4awTKBOLLoPrYEq
         9KBKwEvD5ErCI9q53ymmZQU7k6aGspRW98T9zzAaqY/evDKw5qQi1niFodUac0l4AM3P
         Q9Tw==
X-Gm-Message-State: AOUpUlGX9avqeZnzbDwKBkxlTGSpkDOa+ge7K9sxTC2NKLl06S0J7TGi
        JMIsQ8VZ4A57YFbz+N7VvB0T0Q==
X-Google-Smtp-Source: AAOMgperuM+Jzipelrld1I5CQMNk3PH35P1uLJEkM42nJlUmB9NE/0LflECJPuCuvss/9qpAxcqeAQ==
X-Received: by 2002:adf:a963:: with SMTP id u90-v6mr4974825wrc.248.1532206132370;
        Sat, 21 Jul 2018 13:48:52 -0700 (PDT)
Received: from boomer (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id d7-v6sm3573399wro.92.2018.07.21.13.48.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 21 Jul 2018 13:48:51 -0700 (PDT)
Message-ID: <1532206130.26720.86.camel@baylibre.com>
Subject: Re: [PATCH 0/3] clk: meson: clk-pll driver update
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com
Date:   Sat, 21 Jul 2018 22:48:50 +0200
In-Reply-To: <CAFBinCC4CO_C_f9LLTnLmzVJ6-C-w8J0JQ0e6F9Jh_h61bGEKQ@mail.gmail.com>
References: <20180717095617.12240-1-jbrunet@baylibre.com>
         <CAFBinCC4CO_C_f9LLTnLmzVJ6-C-w8J0JQ0e6F9Jh_h61bGEKQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-07-21 at 22:17 +0200, Martin Blumenstingl wrote:
> > This series has been tested on the gxl libretech cc and axg s400.
> > I did not test it on meson8b yet.
> 
> I had some comments on patch #2
> once that is fixed I can help testing on Meson8b (if you give me a few days...)

I don't intend to make another PR to clk in this cycle, unless something
critical comes up. No rush.
