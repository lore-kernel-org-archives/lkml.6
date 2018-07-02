Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB35C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E8CB25C20
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="T8EjT0bg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E8CB25C20
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965391AbeGBKPL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 06:15:11 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38304 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965308AbeGBKPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 06:15:06 -0400
Received: by mail-wr0-f193.google.com with SMTP id j33-v6so2060737wrj.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 03:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YLgP1HcIL0SmKjsYu8ZTEg56EDjd76CAZDk2EKgwlKY=;
        b=T8EjT0bgdhpMQLjWqx1mML5WBphcqd8Va4V6MpMx68GgWD+HnefXXMAN7k8svJs9RY
         AQv6bK83s1mKce9Dxtd+pxzJCBvZmdrxbdyMNppyDI3wa8e82VVpsiJC0mEpiCVWWbih
         C20QRBHC1G4oEOWpnm1eSa1torsmDWWu2b4E1os88UZXmrTzPvwpWcj6q6mk57DtqyeB
         IQXAbawo/RJKhocq2IFNe1buNXWK9HUVNqPAL42DtpeyULi43JykBSZsYco/ZiQKAtfT
         TD06B240fREGXpMvPsqLVWbJQG1KYc+A6mRp6Q20U97SOQsY9+Dr/VSXgpWnnVGEQ5fX
         u8PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YLgP1HcIL0SmKjsYu8ZTEg56EDjd76CAZDk2EKgwlKY=;
        b=VSkdnlnTHihWOkihxJlGC35cQa6ijGPL7CRpsfQscZBpkMwPhXv4gldopOwW08KGPd
         0IDUR5Tuw2XIoGRAeWxAaHGpUoedpxo0TXgwngPEBZEkUaBMVzZUmp0AjBUTOHOwyzGF
         +udapCR+cb0YlioASr8EyGIM8VOaGENz9U5bdDaeW/cJ5NqPqFAMpO3tafE+Iw6Et7io
         7I1551jG4iPgvvA5iH3P1IYJVyvU19qv9Vyj+FumGbSvwoF2vtVNKGr76YfcRp/HRWoX
         BkZwS5aSErxQKqailLVbbFPS49JTAKnoOcQ9MMUwtDWWscRhHjLw01mbajNbSIrwR23n
         O4Gg==
X-Gm-Message-State: APt69E1NF0gN5pHIW+DZdlqediDRo75iRZTIM+fHTPR1BtXT9Ki4BrWv
        s9omY2OaU2O/3XTgo9mqDFOzaqDkngY=
X-Google-Smtp-Source: AAOMgpesKLhAQi2wB+E2CRVkyifWsnw3FAdsQNyHUY8HHv97fFd7OmF03M4TCQ5T0dLbyCFmgRywhw==
X-Received: by 2002:adf:8e89:: with SMTP id q9-v6mr17435399wrb.261.1530526504933;
        Mon, 02 Jul 2018 03:15:04 -0700 (PDT)
Received: from boomer ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id p8-v6sm8047018wre.84.2018.07.02.03.15.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 03:15:04 -0700 (PDT)
Message-ID: <1530526503.2900.144.camel@baylibre.com>
Subject: Re: [PATCH v2 2/2] ASoC: es7241: add es7241 codec support
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 02 Jul 2018 12:15:03 +0200
In-Reply-To: <20180702101222.GF18211@sirena.org.uk>
References: <20180630172241.10806-1-jbrunet@baylibre.com>
         <20180630172241.10806-3-jbrunet@baylibre.com>
         <20180702101222.GF18211@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-02 at 11:12 +0100, Mark Brown wrote:
> On Sat, Jun 30, 2018 at 07:22:41PM +0200, Jerome Brunet wrote:
> 
> > +	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> > +	case SND_SOC_DAIFMT_I2S:
> > +	case SND_SOC_DAIFMT_LEFT_J:
> > +		break;
> 
> These two modes are not the same so either there should be some
> different handling to select between them or one shouldn't be supported.
> 
> Otherwise this looks good.

Actually, the difference is provided with some pull-up/pull-down resistor.
There no way to set this up in SW, AFAIK.
So the driver shall accept both and trust we are not doing anything crazy

