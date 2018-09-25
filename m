Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D850DC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8720121480
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="Vv1GNedp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8720121480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbeIZCZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 22:25:18 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40410 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeIZCZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 22:25:17 -0400
Received: by mail-lj1-f195.google.com with SMTP id r83-v6so4990289ljr.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 13:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pjXJgDoCeT3ar/rj6kybtCz71ML4MQSb1n7PBQozGTc=;
        b=Vv1GNedpkc3tHQoUm0/+zdcz3V7Tax8I4WtLDPcS3fucy2OnWTO8rdmqmdv+U7lShy
         WUSxP67I2ltRyaWRu6ZN0gzthKLTNwhYLlQWScPXqYlmQgLUt1SbegWPwiW8Z4XxoNqI
         G6jaJ3y7xu8YMlgBx2v+oQsbaiVBjXYMhuaa6Xqf45HaamGglk+QuedHDeUcX74o1KaX
         z/JS3PU/CdKiQkUaaG3SgtkaFqwbhTECqw3nIOplToLWJhsQPRTfFlpbqV3Yb6nZO56v
         I3DC/eVN0uqToqevJttyqfIYgaID8jKCdyjH3bSsK2+Rdlq8rRygpp/HAJU6LxEGvlZK
         skdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pjXJgDoCeT3ar/rj6kybtCz71ML4MQSb1n7PBQozGTc=;
        b=e1P2pb0XSHJRB50hKBM00ZhX+UXkSDMRm6q8lhjkjPqZaLnUFr4RsnJY3u3jaQW401
         vqe4+HZwmACsJwkZKGsiLBpgnWaKo7RUNZRoFFk7UeUVbGSD1Aef0tPJcN1oJFrqO+dd
         JQsYEL3EuBbeoJIf/+Sris+MXUixRfPSSRhYO7R4crCX7CcaXqO80YyrFdIB/T0slLp3
         wcnp5d26PandU3FFTGP2DobBGOTAsI69rx1HZgWlESvqar0fky+TXp6cjmT90cJaX9n/
         pj09RhigmgfHqfBZlPQ9gDX+SQaiRjHNYy73OdEiw+g6eqKQdGqgmpM5y9N1BYkwnFmj
         Sl6w==
X-Gm-Message-State: ABuFfohI8puQeKIvO3oh3PtHbvfjCyy0cT7Fgjsen+K40eXU6hNgra3j
        TUx6joOYcpH9Ex6XBFj8hPty0w==
X-Google-Smtp-Source: ACcGV61vSPK4OadGf6xvGaQPUq1MjA+MSS1S2Hj28A/BCsaPd1CJWzF1aaAZhhXR8BvwSygg3A9pRQ==
X-Received: by 2002:a2e:44d:: with SMTP id 74-v6mr2173612lje.146.1537906561203;
        Tue, 25 Sep 2018 13:16:01 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.se.alltele.net. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id g14-v6sm145455lja.96.2018.09.25.13.15.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 13:15:58 -0700 (PDT)
Date:   Tue, 25 Sep 2018 12:31:12 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, arm@kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] ARM: at91: fixes for 4.19
Message-ID: <20180925193112.uu2lncxsbmzenxl4@localhost>
References: <20180924200941.GA11498@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180924200941.GA11498@piout.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 10:09:41PM +0200, Alexandre Belloni wrote:
> Arnd, Olof,
> 
> Here is a small fix for an issue seen on the sama5d2 PTC EK.
> 
> The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
> 
>   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux tags/at91-4.19-fixes
> 
> for you to fetch changes up to 379e36d3f591cb62e781907edafea17d75e8c1fa:
> 
>   ARM: dts: at91: sama5d2_ptc_ek: fix nand pinctrl (2018-09-12 12:38:04 +0200)
> 
> ----------------------------------------------------------------
> AT91 fixes for 4.19:
> 
>  - fix a NAND issue on sama5d2_ptc_ek

Merged, thanks (with slight elaboration on merge description from tag).


-Olof
