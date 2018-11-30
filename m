Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 559C1C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19E732147D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="f+Evjle/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19E732147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbeLALIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 06:08:24 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39680 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbeLALIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 06:08:21 -0500
Received: by mail-lj1-f196.google.com with SMTP id t9-v6so6470931ljh.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 15:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3q7hEzfX4yp16DPPqiDQPlBHy9EvBQV70eHnJM8kSmM=;
        b=f+Evjle/kmFCGqrFBwVafVCuNAb8kfi8b8yr3ejwRIXXoFaNhHmYuLh+32CW9mEnz8
         t/JJf6DU47CCCyYZybmgjGesiGVUotlEbrWqHAPKKMu51wVJfLEdDhjG8fyCYdamooD+
         XT5vR6vfC+na/jlJvqun1T/A8EXXd+z8nKJWPyJoQC2WaOcXrlQgaVRLgdFiujdkR+Ue
         ZZHbdIBodSjJxnJHhKLhjRdp4IHsbsui8BIP2A99YafdX5b8tqiSNHUwMZVrwFXoVMr9
         bzsi1Tj56fW1KI735fw6uzZBj4/FjUBgdWgicPJFhGOY1Mo3DwQfr5y3v17Gop9S3MW1
         V99g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3q7hEzfX4yp16DPPqiDQPlBHy9EvBQV70eHnJM8kSmM=;
        b=agafV12l+imWqN10Trw2bEqtRv2c3i1Fv+980nPWqoR7k7FYKZ8q+yfDr3NhT0uD+5
         w86MiVMvNhGcdmsG5uHgfPAOI+B74v6YYkTFhxs3exjo1SQi+O0tS1pLkQcuZpBnPyCK
         GlwqP5uiZGl+VMp161ZJSPbK6HgY8j0+aK/zLRNRLQYUTNXg3C3k4AabT+3Pp2zJrOO/
         cUvZ3OLsQbfsfgALKgXVblmMcH6Y2FAHz7wsyY+I3V6O4REB98476gu/IUCskdsfWnAV
         hhmBaAJKLWKCaGTpRTFqw8Sv0l5kk4i78jhcXUEeDI4TAKu1q3Qrma+lcvjSqbmPKS9p
         WD2g==
X-Gm-Message-State: AA+aEWakrFo1a53xotVjiICGf6WL4kfCraeC310LMYyaDI4l8ad00mSM
        Bm7h1/Dt3wzjBhxGSemwB5WNlw==
X-Google-Smtp-Source: AFSGD/W5iqHC1pjIenhW59r8XYbhtadF4/81VNadn53WuCOKLRitQNinSOEvtYpKfSEkI5ExPbredQ==
X-Received: by 2002:a2e:841:: with SMTP id g1-v6mr5409472ljd.21.1543622237523;
        Fri, 30 Nov 2018 15:57:17 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id o14-v6sm1034761lji.70.2018.11.30.15.57.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 15:57:16 -0800 (PST)
Date:   Fri, 30 Nov 2018 15:42:39 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     arm@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Pavel Machek <pavel@ucw.cz>, James Cameron <quozl@laptop.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 20/20] USB: gadget: mv-udc: use phy-pxa-usb
Message-ID: <20181130234239.5hdqd4bulyoq4phc@localhost>
References: <20181128175324.163202-1-lkundrak@v3.sk>
 <20181128175324.163202-21-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128175324.163202-21-lkundrak@v3.sk>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 06:53:24PM +0100, Lubomir Rintel wrote:
> Use a proper PHY driver, instead of hooks to a board support package.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Same here, please get Felipe to ack them if you can. Thanks!


-Olof
