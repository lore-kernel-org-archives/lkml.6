Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D678CC64EB4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 973A520867
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="Qt5wF0dW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 973A520867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbeLALLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 06:11:23 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38478 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbeLALLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 06:11:22 -0500
Received: by mail-lj1-f196.google.com with SMTP id c19-v6so6483507lja.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 16:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HYWqfGstftOSKIavnOY/u8y/miyTPH18CXsr4jDdYoY=;
        b=Qt5wF0dWBulsPK/91GI1i2UrQ53Cfejbi7KFFfxw4l4II2Lr37CfC70GkuXkvGz55M
         sMGknyQCn21Rrw0wGWMkjnznHxK4prCv8CyVW9Je/LW/QAkbL5l1Bu76syeByhotVfbr
         zBR0AIGgC4oz13w0lF5VUsN0fFlKi6P8WdMuA1S10z7sLOXBNXVK9QUz2dzpRwYrzbWn
         FSPJCVfADPZyxSyl2lv3jhuaq7udL8L9ILpSyuVZMEheJg/8f9G+ibcXKgfbJf1Dgwv6
         dOQOPGm6vbLbjQLyvhjvt3Z5BB044r/dvnUBMFD/vQbTUrlaV1ZQPzEgVWBHSEcq3ewj
         CEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HYWqfGstftOSKIavnOY/u8y/miyTPH18CXsr4jDdYoY=;
        b=B+s5M6JKMxKOzRA6/K2hFgZLwwCMye6SbHKOQb+Fr+lXbWXtSUcAaGhIZluFMMk1hG
         TwjDjiP+W14n6RQmx3EHuBhc5d4WkkXM9qnJW0zppvM3jbM3+mqDNDpC1aylIlKgFHbT
         uRjH7uDi8XWIz12dckY0R7hl2CAm2UkvBIwZWY847XdgfXPRCdEzUOiDgXf+7595aAkA
         nPgrvrdEo+oPB4RBTuUqdR/eyT9A9tdvX3Q2tyqdNi2qhY5PGmex1SP/Q4LmBF1oCgXk
         A7MoZW4P23hc0fe+yV35bk0uhlAMVRbMdO9c869/8XmF1Br7FnQ6Ckn813h6x68CiNae
         h7zg==
X-Gm-Message-State: AA+aEWZ3csWmv1ieASRH57WT/VeRrWJVu3/6F7IstjlmRUDPqcumHUky
        c6k68NGcmD5ZvlTTuI2lnGXkFA==
X-Google-Smtp-Source: AFSGD/V+H247VtLkfMkogq7O7AOuGT3/06ejzp1Wed0sqGEzgaAEP9OqNUVIgr0eFwij7GB8iweClw==
X-Received: by 2002:a2e:8156:: with SMTP id t22-v6mr271391ljg.32.1543622417432;
        Fri, 30 Nov 2018 16:00:17 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id z9sm1021898lfj.79.2018.11.30.16.00.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 16:00:16 -0800 (PST)
Date:   Fri, 30 Nov 2018 15:59:28 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     arm@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Pavel Machek <pavel@ucw.cz>, James Cameron <quozl@laptop.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 15/20] ARM: mmp2: initialize clocks before the timer
Message-ID: <20181130235928.vqknywa54pta35am@localhost>
References: <20181128175324.163202-1-lkundrak@v3.sk>
 <20181128175324.163202-16-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128175324.163202-16-lkundrak@v3.sk>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 06:53:19PM +0100, Lubomir Rintel wrote:
> The timer shall enable its clock.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> ---

Applied to next/soc, thanks.


-Olof
