Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F52C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD37520864
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="EXwiTU3k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD37520864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbeLCUs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 15:48:28 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40074 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeLCUsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 15:48:25 -0500
Received: by mail-lj1-f193.google.com with SMTP id n18-v6so12743351lji.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 12:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AK3c+9ETBl4j3tbkVWiiBjg5BzTdGwZucP5nJN6qZJA=;
        b=EXwiTU3kZVEQ2NP84OUHcTGGaWu6rktMYGJH5C3xpflIxrdH2YDO4gvQo3gQi+c7/D
         V1Jjpsj6eqBWufRZnDGyBJIWv/atF+NyaoFpZNB6J4Mn0+2cU+xO0k7Bdg676m2Zp39U
         1eaRdTz72UGt0Pru2PLcY8BkGOlNg7ERxml4pUDa4w81Rzv7SdbCsaDdMDbOYJsYKPPD
         Wgn7DPuAMfWC9+1BKS0WxBorj6SkeSMfbLFoKBVlXnEu+/efq9SELj8NCSEj96vXukB8
         jGuLR80hFh7Xob3dw1XnH1w5vBeWPqdiWVBXpAtNBiQ5LlL42ZpoRjHOMlA14wMgBBwN
         4WIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AK3c+9ETBl4j3tbkVWiiBjg5BzTdGwZucP5nJN6qZJA=;
        b=C9rfUMo83r0ZMleo+PKp9+1jpeW7hFVHh7enmg42A3ob6CZvybkGdN02FhbpCBbUq8
         PS0tqFj9XKRvOBlxiAQRWoCHWJbSMkrVhzA0FJ7vsUDZol6IGfdEr2jk9DuO2ipXz+20
         2JXhkXeNsDcMBmpSMBg4fSPL7HKyimfgUeG5oHX0pPhks0LqfVPOEhyRErP0/QBBF3rH
         oSXQwb4bkJguG5gAbtR378QRKkr1kK1E8XrfU86bcG4tyY8DuVZJW5R5XD+ZG773Q2AU
         9mJpm4Nqh4UIqyLv7rjUY7nSaZKsOCKFdkmP/YmIAz0OqJOT5YIjE1Z8Q2siAMPpQUjv
         v20A==
X-Gm-Message-State: AA+aEWa/DUIPliLsJspIzQvddms345Z/woiSm9ZiVL4z71bEJ+4M+xFm
        nVfqkvZ1QnnGUveERvRO9jmpmg==
X-Google-Smtp-Source: AFSGD/WtBrTiPeQW99fWQPH7nw+r2XgfGDn+wgc7MdzMOsx+P/WRmHhePnTn/AIiucR2GuPlIw/w1A==
X-Received: by 2002:a2e:9849:: with SMTP id e9-v6mr10994200ljj.9.1543870103035;
        Mon, 03 Dec 2018 12:48:23 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id j12-v6sm2716078ljh.66.2018.12.03.12.48.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 12:48:21 -0800 (PST)
Date:   Mon, 3 Dec 2018 12:40:05 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     arm-soc <arm@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, James Cameron <quozl@laptop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: update entry for MMP platform
Message-ID: <20181203204005.wuy6kkuutfwg5d2m@localhost>
References: <20181202111428.1543-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181202111428.1543-1-lkundrak@v3.sk>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 02, 2018 at 12:14:28PM +0100, Lubomir Rintel wrote:
> Move Eric Miao and Haojian Zhuang over to CREDITS, since they're AWOL
> for some time already. The git trees have gone away too.
> 
> I'm adding myself as a reviewer. I'd like to be Cc'd on patches and will
> be able to test them, but I don't possess a data sheet thus there might
> be things I'll be unable to review. Hence the Odd-Fixes status.

Applied to fixes. Thanks!


-Olof
