Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B2FECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 22:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C26002089F
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 22:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="G0g+ZT49"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C26002089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731697AbeGNWjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 18:39:15 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39697 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731182AbeGNWjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 18:39:15 -0400
Received: by mail-lj1-f195.google.com with SMTP id l15-v6so6916905lji.6
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jul 2018 15:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cPQJ59mNWmUMn/ZvOX3oBgi1ja02rf38XBs9ILcQUMw=;
        b=G0g+ZT496kpw47pWOmV5IpBKhOP7XvwmrVXbzwL2OUNJntMx+afzRMlFpKxyavL1lH
         d63uN80sdV/u92FZUJ+PvyjjHQ/IBAbdM9JySmxSRmToN/qtwp4Z/E0mwnuXna+56RV0
         kkegZxR7VI6zZMRlVFaz5CwK5o0cCl6Q2nseVJBBRJCJOjc0GW0aMUkDpNFpUBrEO7VQ
         SihitqZc5Ay8a0+bARaboS4HzEw1wXBG/Sf1I5m0DEU+u8Gwwftc1+mO8ObYwGnXp49/
         o344qSJKUArOIHx8YBfCHLhcwFVqazMJZX/8QGttp2HwAZ/SC3Dx1X+bfkT+40hhWYw8
         IBsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cPQJ59mNWmUMn/ZvOX3oBgi1ja02rf38XBs9ILcQUMw=;
        b=a8B634O8OonRz7f0iJVkoFKlECcuiqB3mEZcP9IfZRXqILwnzLQTGxFSaLv4QtAiEz
         EU8JzLrX6kOMvTMEA+44iep7TYZTJ/oEAUteyGNrKpW8vLIJMmQ7FVFiEYWeGrWdaOeO
         SdZZTRQQFPZXa4JcIjCctF4U26y1BLNp8a4mvqikINVzh+tieD8mCOcoGM2LpnIBwAyQ
         q81xVHbrAGqQJvKdeLazcyp9Qnux/7RljLxoC4DllMtA3ZKdQoqATZ4Bx0YurG9qflWo
         7F8akcizsvF4GifKZyaWJDlY98W0xbRKQl/G97geAry89p3gWNlycacutvZ2iMC7CrHX
         NP/A==
X-Gm-Message-State: AOUpUlHQQTTU+Sj4yofi0SLsjKGk+TS0XuFoe0Q5ozfSyrCPEiRsaS9Q
        zRRPFVyV9MNmhSaXEoAbnIrttA==
X-Google-Smtp-Source: AAOMgpdDlMY0XnDO45zfBm07FK2gfhFappNp7rkTcbZAQiVkVhyaDSGqstY4WJh4nyggDSS0uP9bbg==
X-Received: by 2002:a2e:800e:: with SMTP id j14-v6mr6255141ljg.114.1531606722951;
        Sat, 14 Jul 2018 15:18:42 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.se.alltele.net. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id u24-v6sm4134400lji.4.2018.07.14.15.18.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Jul 2018 15:18:41 -0700 (PDT)
Date:   Sat, 14 Jul 2018 14:23:03 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, arm@kernel.org,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 1/3] ARM: dts: exynos: Pull for v4.19
Message-ID: <20180714212303.nddjnfhis4vwn4zc@localhost>
References: <20180712164641.19925-1-krzk@kernel.org>
 <20180712164641.19925-3-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712164641.19925-3-krzk@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 06:46:40PM +0200, Krzysztof Kozlowski wrote:
> Hi,
> 
> Rebased on v4.18-rc2.
> 
> Best regards,
> Krzysztof
> 
> 
> The following changes since commit 7daf201d7fe8334e2d2364d4e8ed3394ec9af819:
> 
>   Linux 4.18-rc2 (2018-06-24 20:54:29 +0800)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-4.19
> 
> for you to fetch changes up to 57f4e8bc1c3ebbd06a278107edeb6af95b53e5bf:
> 
>   dt-bindings: samsung: Document bindings for SGH-T959P board (2018-07-07 12:28:07 +0200)

Merged, thanks!


-Olof
