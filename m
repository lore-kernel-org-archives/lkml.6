Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122B5C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA39120660
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="SOWHN5HD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA39120660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbeLALH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 06:07:57 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39660 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbeLALH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 06:07:57 -0500
Received: by mail-lj1-f193.google.com with SMTP id t9-v6so6470458ljh.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 15:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CP3v+8d1ujQgXXZ15DRe9aJvH1aYib247lxF953bnAQ=;
        b=SOWHN5HDYdoEejSh0oaKIthatsiQqeJ8le0cPg1PydE18VJjHBKjonBOXGNZgsq3rF
         qXkeFywIwuVWCHcW8ZTE0Cy46VK46aFDNZgO5/7C6G725URhygpY+BOja0pRJHCypHRG
         4VjrEsDfxKchMmSmD/18GHxmTDKTaxGp8v7cnoV3KpgFhqXZbdue0CY5agcQ67ZOFrwc
         b5ivoRF6U9GbvSAoXlv24bcVpUYggQUHVEyoOHW+JwsxQpeMPP5JmEy+uUAObm1wQ3l2
         qt7V8Hxq93ZKAo/Qdln9k9ClBqs/bqoiCU4jGXe+dq1smiSmP9Tn362KozCQN8RJF3Ua
         paQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CP3v+8d1ujQgXXZ15DRe9aJvH1aYib247lxF953bnAQ=;
        b=I+2EqrEWblQFspIWllXrNtcZU3B9kfIJXBqTQopMmCzgwXGv8s8swywwMO1XjJqyM0
         +UdLge+oxUaZ7NY+jhCPa9M6sko3LGU614aqMEa0cZW9sPRbdos8Zu4hc4tj2whrmSdn
         n03+MpdiuS86rK7h7J9MjK9poV4+ucBDLN+KOQvZmO7CE1MnkV0tyYPBE7OTFulC7yV8
         yRjMoy3TLF7HSJK1gLeL1Qn8k1dVoOYyLbs8cWYGmf372+IG5k8hVKmPym4FNWKDGgfv
         4QKSJQqoiuWJW+vBU8LAp/pXSz7qcz1A/ur7TX7SvaUAFS+Xr0/xIsxSX9b3OcZ5u6LH
         Gnmw==
X-Gm-Message-State: AA+aEWar+qtyudzXsE5meZF46Yb7QSL3RdzTUiKmbMtZ7zTIbIS5rsJB
        lqQG9Z6/hNqePS7BrUAx/PhsZQ==
X-Google-Smtp-Source: AFSGD/Wi+w+KGLud2zAZUcbmDDyNMPk6SSlNIdQ5hUkbqFJYgMPEhxIi2Laz9Ad68s8LQbRf7/hdmA==
X-Received: by 2002:a2e:9457:: with SMTP id o23-v6mr5453857ljh.7.1543622213046;
        Fri, 30 Nov 2018 15:56:53 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id v19sm1046630lfe.69.2018.11.30.15.56.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 15:56:52 -0800 (PST)
Date:   Fri, 30 Nov 2018 15:11:38 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     arm@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Pavel Machek <pavel@ucw.cz>, James Cameron <quozl@laptop.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/20] DT: marvell,mmp2: fix the gpio interrupt cell
 number
Message-ID: <20181130231138.fxpee3dinkopkcnn@localhost>
References: <20181128175324.163202-1-lkundrak@v3.sk>
 <20181128175324.163202-3-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128175324.163202-3-lkundrak@v3.sk>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 06:53:06PM +0100, Lubomir Rintel wrote:
> gpio-pxa uses two cell to encode the interrupt source: the pin number
> and the trigger type. Adjust the device node accordingly.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> ---

Thanks for these patches!

Applied patches 2-10 to next/dt for 4.21, using different patch prefix:

ARM: dts: mmp2: ...

Some of the others (gpio, irqchip) should be reviewed and/or applied by
the corresonding subsystem maintainers.


-Olof
