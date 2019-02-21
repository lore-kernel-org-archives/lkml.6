Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61EDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96C352147A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="Y9/qrD9C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725814AbfBUKHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 05:07:34 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53114 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbfBUKHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 05:07:33 -0500
Received: by mail-wm1-f65.google.com with SMTP id m1so9659750wml.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 02:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=74HDA01ZuhzfE/t+K1Yobxx5BIN5qc8lkgw+PBzwH0w=;
        b=Y9/qrD9CCe98QX8XY/r+j3afxzu3MvbcBF4NtGCrEETsqDlTUoINgpRoA7ErraLyoA
         jQ8c5q8hwKZwKE3zRl11vwc0393WtjGrTtICGo99IPH5RZjYVTWX0Sp0tr1ouOQmvIgB
         tOezwa2LV/V8wldsc3PVzhRqpaNb+rCXspW0oNdVqJRg3oVKJAYaG9axyBWY89ux4O/L
         LD+6E0PUbXWxJYgCzV+Z+ouxBbDQm/jdNG9e3Zbq1c1gpXeNuKVYPaxIElNoN3CSWa6K
         8HRazZNKA0GtryWark0a7ufCOqVldjOG5Md+KqWoNr8I7xw75340Ioe2vldx52kpprep
         MxyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=74HDA01ZuhzfE/t+K1Yobxx5BIN5qc8lkgw+PBzwH0w=;
        b=aRtfJcBzODJmtPzbE8oYzLCiZI/jbT7QDmanhz8+n/cnukumX3A/Kj0CI4bh4UUEEU
         uGZ1cH/Xv/wJjNRSQ7xHRvvenaBlb7gmR2zJWR4+pHB01gxjat3LGK7a3glLY9MmokDz
         mjEyFE2rz0kog3YVnV+InfWR5XmeFGRvhQZa3OKB62OZ1Z3vmA0qRogDbDtbFXRzXTTt
         vn6NfSE061uOXYUnsNBcmjAPTK9S3/maFf7msDYizMNfH+KnG0a/IKANW3/xtTjf6XcE
         KW+eFQEU2GD2Se8sbvWJudDMYGxjvB7zZfLDSKPHbbqKCw9lTr9900GeAGPTQuheL2TD
         Mqaw==
X-Gm-Message-State: AHQUAuZDMmuJZ6d+QCnXoVM2O76p6XXm5WNkyjK+uW8mxe7urp3UzLz+
        MrYpiHnkh9iwlSZAT/CNQUzUmZLZiv4=
X-Google-Smtp-Source: AHgI3IbYHKcOfRJTRcusLmR5dUWh5X7bcbK7LTcdRrCKtSXxrqDhq4AUXkrZL3vYmpCQ4lM5dEnbmw==
X-Received: by 2002:a1c:7a03:: with SMTP id v3mr9674322wmc.59.1550743651646;
        Thu, 21 Feb 2019 02:07:31 -0800 (PST)
Received: from localhost (ip-89-102-139-73.net.upcbroadband.cz. [89.102.139.73])
        by smtp.gmail.com with ESMTPSA id a9sm5938055wmm.10.2019.02.21.02.07.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 02:07:31 -0800 (PST)
Date:   Thu, 21 Feb 2019 10:57:52 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>,
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: Re: [PATCH net-next v3 8/8] net: Get rid of switchdev_port_attr_get()
Message-ID: <20190221095752.GK2312@nanopsycho>
References: <20190221005826.26317-1-f.fainelli@gmail.com>
 <20190221005826.26317-9-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221005826.26317-9-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, Feb 21, 2019 at 01:58:26AM CET, f.fainelli@gmail.com wrote:
>With the bridge no longer calling switchdev_port_attr_get() to obtain
>the supported bridge port flags from a driver but instead trying to set
>the bridge port flags directly and relying on driver to reject
>unsupported configurations, we can effectively get rid of
>switchdev_port_attr_get() entirely since this was the only place where
>it was called.
>
>Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Jiri Pirko <jiri@mellanox.com>

Thanks!
