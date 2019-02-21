Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CF2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E83582147A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="c3lIDbUa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfBUKGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 05:06:22 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40193 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfBUKGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 05:06:21 -0500
Received: by mail-wr1-f67.google.com with SMTP id q1so29253370wrp.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 02:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w3slMKyScVk3c/M1GuHIqCx1zuG1ZZC5YGoJKU1LGyg=;
        b=c3lIDbUaNjNLMyKHG9p/+qRfL45neoeyY+a3GQMuBg+G2+iGr2jvRHpQ/C4XiiVTt0
         PHmLhyDfF63qME6vUgspNt7diDY8DnHztkCKe1BQAJeexxyQZseSmz1ZgdtO8Y/yy8U9
         8OONkTl5FrtpyVSfe3CdlZxTT+xeLLVAfl0XeVCKr3i6FNevbGGx/nRb3/JdHXNwq1DV
         xuTnU1dElwmE14bsgQO5NrpJnNGtg+0NgVgxaQtLq6FmUizkppyOdaW75LGrY+QRMV7t
         f0ouAQV/9rGQY9z/Cp3mAkt4RzFmTcPvyR7SuJLggCZGP79JmT0Nte92ixHMNsPmGWjR
         +b9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w3slMKyScVk3c/M1GuHIqCx1zuG1ZZC5YGoJKU1LGyg=;
        b=LnrCNbvYmn9P//vjkW5WOQS8zlZhKQnyIHAQMRGK+IzZtgSsIG9DyptkRqgihbH/0B
         RmJsRcn/vmWdGVWOFN319/2oQX1xYMEYE9jC47zNePY2xqx9AUTfzKC/6SjGnPQNvOrE
         T9/oAVMZXukr0CBfwPIcBGYBsaabyXVyYw5IntXLczFIVJjLAleaTnNQonj54xZ0bEcP
         H0Gw7Vnjj7m/1F8uIdCoyIKIDhaY1O2rvVKkxlWOYn6VtoAAV/9VezxZYbjFI3x3/HDZ
         5VUKlN5Ej1p8g/f7WXIUGgDVKnTLLgoxnPVJbZYxcraU2Lbhd2uIgNLbkn+63aAjFKZg
         +DeQ==
X-Gm-Message-State: AHQUAuausTUVMQkfVqUXQ7++vl1eBJENxLb8yUnEV4NpX1nxDYDCSvgi
        VNS9arFXNOZVDPEffcMe3nMPwA==
X-Google-Smtp-Source: AHgI3IajtGsGPGLOtN1yyy0k/Fr1gmYcEEbK1JyxjcofV+QNKPUYNTjzqnn/0zNg7X40f0Dwv9WpUg==
X-Received: by 2002:a5d:6a8e:: with SMTP id s14mr15917104wru.31.1550743579902;
        Thu, 21 Feb 2019 02:06:19 -0800 (PST)
Received: from localhost (ip-89-102-139-73.net.upcbroadband.cz. [89.102.139.73])
        by smtp.gmail.com with ESMTPSA id v4sm9499290wme.6.2019.02.21.02.06.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 02:06:19 -0800 (PST)
Date:   Thu, 21 Feb 2019 10:56:40 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>,
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: Re: [PATCH net-next v3 1/8] net: switchdev: Add PORT_PRE_BRIDGE_FLAGS
Message-ID: <20190221095640.GD2312@nanopsycho>
References: <20190221005826.26317-1-f.fainelli@gmail.com>
 <20190221005826.26317-2-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221005826.26317-2-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, Feb 21, 2019 at 01:58:19AM CET, f.fainelli@gmail.com wrote:
>In preparation for removing switchdev_port_attr_get(), introduce
>PORT_PRE_BRIDGE_FLAGS which will be called through
>switchdev_port_attr_set(), in the caller's context (possibly atomic) and
>which must be checked by the switchdev driver in order to return whether
>the operation is supported or not.
>
>This is entirely analoguous to how the BRIDGE_FLAGS_SUPPORT works,
>except it goes through a set() instead of get().
>
>Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Jiri Pirko <jiri@mellanox.com>
