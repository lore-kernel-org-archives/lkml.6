Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37308C46470
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 00:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8859208DD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 00:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="E+fmYHlD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8859208DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=networkplumber.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbeHFCZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 22:25:02 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44307 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbeHFCZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 22:25:02 -0400
Received: by mail-pg1-f194.google.com with SMTP id r1-v6so5364267pgp.11
        for <linux-kernel@vger.kernel.org>; Sun, 05 Aug 2018 17:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e4aCRU+cjQNbDUAz+uB9nh3LG71nCEDe/Wu1Bq1OBMU=;
        b=E+fmYHlDaZdufy67V3tt8K2xQDlIQSo98xrDDPdyBYgk3ez/puU384nof1mmmUUEKL
         LliDLgGc4LKd9uVjEK4gcvdSuCqJqwbL4FSf8KvkPJaFObYQTDb5OTJ13EZ3/7sn3vX8
         +wnYJQG55rFaX3PuvMXWKYmmy45wY/ClvbuIS7l/YehRlGdDQVBuxKagUMxSwQ51o1v+
         MBWpzD3Qhh2JHrftw+OKnuQ2JbR3T9usSH9mmvW9uYsYwcktuF+OaojkSIBcLaXQvi+b
         aojHf1HD29Wai52yNYo/wTV84L1VFV9ktHqx2FS3wdkQkMNJUUkxQcr933TmX5xg+WGL
         fzVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e4aCRU+cjQNbDUAz+uB9nh3LG71nCEDe/Wu1Bq1OBMU=;
        b=F/jjEU4r9/aOCDdrDNlFmDpmGKjPbJ8IuAyVm0wT0y0mGZFamLe0VpfMd1DB0Uhps3
         1yjJgQzGLAyr7wBNM+vh+WepYg/BvaTfC6jzZEMgJbt/eRUYyFUPY4FTMI1zfu0LxlLg
         TKHNw8ep/svAj8KIoXEdMA7UL+pnvO6yhsSN69JF0YAcgRUdf4S5WZxTshWbrwpPYJZx
         JtqXO+Zz3O99s3ndRqSf2N4UusdfrpbwLzZH/d4pWCvY7UFHDsrZ9hzqbihHQcRnELl8
         90JYrWvljNKl0HO5L8yR3KuFrgmY4sLBUd48yCpTUnRCHDKE+brHboAVLoZmztSFMCFn
         KpmA==
X-Gm-Message-State: AOUpUlH7NWP7llY3cokT8DQusH5vrrHguoZkLDwHToSZtMjZryL3XKis
        YQuZj7kdHPUZUgP9BJkxXq4k+Q==
X-Google-Smtp-Source: AAOMgpeJBI+bgwBLyimKiBFXx+RTyirGjMOfP8/dsx5LLTv82wVfs5u0JJO23wbxIoOYx4oOeRQupg==
X-Received: by 2002:a62:4a41:: with SMTP id x62-v6mr14795510pfa.45.1533514715331;
        Sun, 05 Aug 2018 17:18:35 -0700 (PDT)
Received: from xeon-e3 (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id i20-v6sm16393530pfj.82.2018.08.05.17.18.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Aug 2018 17:18:34 -0700 (PDT)
Date:   Sun, 5 Aug 2018 17:18:27 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net/bridge/br_multicast: remove redundant variable
 "err"
Message-ID: <20180805171827.2cf9a2c4@xeon-e3>
In-Reply-To: <1533478723-18361-1-git-send-email-zhongjiang@huawei.com>
References: <1533478723-18361-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Aug 2018 22:18:43 +0800
zhong jiang <zhongjiang@huawei.com> wrote:

> The err is not used after initalization, So remove it and make
> it void function.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>

Makes sense to me.

Acked-by: Stephen Hemminger <stephen@networkplumber.org>
