Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1119AC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 03:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8542C214AB
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 03:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="pyZftw/3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8542C214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbeIZJxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 05:53:16 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36590 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbeIZJxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 05:53:14 -0400
Received: by mail-lj1-f193.google.com with SMTP id p89-v6so7619118ljb.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 20:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kC5HAoyCvqNlWb4AC5jZ15KRGPlpnZlDg52DHhBI+TY=;
        b=pyZftw/3fguNjiEIV1Mp0sX9fAWLtHiUb6mZoEHyscYE7kbcUbVuFb3abtjtsmS8od
         os7Z4ycgbDhvVlht7agDqGEUudWjerBP78dCfR+je47cFgsm5nGJsFCKL26FQPE9CzLX
         cPw38wl9EuoN53HeQsFERjL+2uOS0P8UCq9IZaR8T3IQ+NIE8c6kRjFbAtdK71qR02Xj
         Pdj4gw9Wyol1wcPK9OJXlMtJ4zRTs+VQhpaiQyfXs0FUVzWEA4OwhYAvICY+d15oDf4A
         gZpUzVCyGOlranUObCsJasbIbAlAet9pTzaBWTJu6IztP5Uf+dMe5DyHIsNZusUjQEoI
         k58g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kC5HAoyCvqNlWb4AC5jZ15KRGPlpnZlDg52DHhBI+TY=;
        b=iYyQ78WGiDJcNnPNMXwsedya8PtxmfPtmFf0zNxZbm9aLfXHvkkGW6tVNTI7orkBL7
         zWZ7yteH5UiU4mygB6FXCUFijnND8HGcdHo6p2kSh0lQ7opP4vy0G5uwpJY9uRZRKDUX
         YXRzF/Rf4ARYPDcYZpd9VL88v6gO1vy+LY+qSo6AtzDr1Pf7Wm90BRYSEQSctJ+xSieW
         4JNMKFmWhxo6GTlA8rHwbN7rwD71Dl22fQ99ArcDmyjJMMYCmKOOPrbsxl7/HRO4L6fa
         dXTu8cTZDrEovCVlQsA8QV4Xn6ZEG/P4Apay2Gkx2Ji+XjQt/Ewd8Ksyj0+JC9uc/vBY
         Bc2g==
X-Gm-Message-State: ABuFfoi4x2jdX9qQNrcklXEsqdhvRSx1o0aHoymnU2Gi8xHzKajOGvU1
        Z/rLIrBX7MX/FlkbaXDaoYWsBA==
X-Google-Smtp-Source: ACcGV60NlL58TtRibxNEZHYtUGX9HNKASLrS8OE5DU0xXKMVUQ1tkkvBkdvmxpRo08GePzU5NIlhKg==
X-Received: by 2002:a2e:8513:: with SMTP id j19-v6mr2841251lji.10.1537933344170;
        Tue, 25 Sep 2018 20:42:24 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.se.alltele.net. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id t200-v6sm740152lff.77.2018.09.25.20.42.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 20:42:22 -0700 (PDT)
Date:   Tue, 25 Sep 2018 13:40:14 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, arm@kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] ARM: at91: DT for 4.20
Message-ID: <20180925204014.ys7gpxssghmrq3wx@localhost>
References: <20180925104226.GA32034@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925104226.GA32034@piout.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 12:42:26PM +0200, Alexandre Belloni wrote:
> Arnd, Olof,
> 
> Here are the DT changes for 4.20. Mostly cleanups and small additions.
> 
> The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
> 
>   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux tags/at91-4.20-dt
> 
> for you to fetch changes up to 97181516b0785dd032700ae4899842389c6bea78:
> 
>   arm: dts: sama5d2: Update coresight bindings for hardware ports (2018-09-19 19:12:25 +0200)
> 
> ----------------------------------------------------------------
> AT91 DT for 4.20
> 
>  - warning fiwes from Rob
>  - many updates for the axentia boards
>  - ADC, I2S and touch screen support for sama5d2

Merged, thanks!

Tiny nit:

> Suzuki K Poulose (1):
>       arm: dts: sama5d2: Update coresight bindings for hardware ports

s/arm/ARM/


-Olof
