Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E582C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 22:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD8A921916
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 22:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="QSUVO2EW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfBHW2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 17:28:49 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39727 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfBHW2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 17:28:49 -0500
Received: by mail-pg1-f195.google.com with SMTP id r11so2182179pgp.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 14:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=67GnGD2t9tSfA0mA0vr59+dLv6I5EckKQTlt2UbrRTU=;
        b=QSUVO2EWRHg08nxSUEdVvx+l2lt73ihq44l1HdbY9zUzAUhzM82jXAaK52MWuQ1gZ2
         81e1Nhya834lLvTOlqhpWB9BJ93x/9hvvkkjqh56pv/5B0i+gMex1xHp0ZHuIhMM1DoR
         DqsFYkow7iDcyPSPGvqQCM04/8tLRjR+ozVnT5oPh7Jec7ori0N/MV/X+VPsEexqGA4Q
         ztbMNbLWux+QmSPQmOHjx2Jw4SlX1NqX243SUBQJ+KkntCFgXieSrxvqFO7r6zL8rBv1
         fKlKZ0u7WrYAbTSKTcGrmrFeuD2eNY9spOxc9c/QdIWs71/qDyJGwS8yuyS043W9q53M
         JywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=67GnGD2t9tSfA0mA0vr59+dLv6I5EckKQTlt2UbrRTU=;
        b=qKzdK9s6h04jHvwLSSc9AyuCxX1GbVfIkaPt2WU0Vfj+vGMNzcWfEygKUxWOJt0jq2
         dlpERTgjkdlY0hYRv6qawOheDpLLrAEsm7TIQGciroPwpl+foEmVOVy3Cik1ABt+wvHc
         x+2JY4V6ykOopcXxHY9RVlnsl4IepE0T1aPujwz7/QTbEO7qjoocoFcVoyGKb/e+0T4y
         hpgatVup0MDJvumpwNP/jRImNZEyMl5TuojxBV6J9Jbtkxc5GMByjQ06mFGYhQiAey6b
         Xi8QZOfdPcbT8l6qcl71PQKqk89Uj+pUEIoetEcaj+T2R2XEwevf5DyWXbQhb716UJ+D
         QFxQ==
X-Gm-Message-State: AHQUAuYzboB+s+fljyVQpzlnv4nySQs0NnkB1yWzBoLbg0CIR4/tEDCG
        S/0r1p8n5IX0wdecUF5t3hp4Qw==
X-Google-Smtp-Source: AHgI3IYmf7VLE5sM7UD7dkZet7rVT58GWTDqOSN5j+GuZT0FTDiVVxCRbgSE+rg5l6Q4s3yLZ1tIug==
X-Received: by 2002:a62:3541:: with SMTP id c62mr24471418pfa.19.1549664928006;
        Fri, 08 Feb 2019 14:28:48 -0800 (PST)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id t5sm4583245pfb.60.2019.02.08.14.28.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Feb 2019 14:28:47 -0800 (PST)
Date:   Fri, 8 Feb 2019 14:28:40 -0800
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Kimberly Brown <kimbrownkd@gmail.com>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>, devel@linuxdriverproject.org,
        Haiyang Zhang <haiyangz@microsoft.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Drivers: hv: vmbus: Change server monitor_pages
 index to 0
Message-ID: <20190208142821.0ccc0d3f@hermes.lan>
In-Reply-To: <181a0a2a82e1ad0353a7bdd55a3bdaa0891812cd.1549619051.git.kimbrownkd@gmail.com>
References: <cover.1549619051.git.kimbrownkd@gmail.com>
        <181a0a2a82e1ad0353a7bdd55a3bdaa0891812cd.1549619051.git.kimbrownkd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Feb 2019 04:58:52 -0500
Kimberly Brown <kimbrownkd@gmail.com> wrote:

> Change the monitor_pages index in server_monitor_pending_show() to '0'.
> '0' is the correct monitor_pages index for the server. A comment for the
> monitor_pages field in the vmbus_connection struct definition indicates
> that the 1st page is for parent->child notifications. In addition, the
> server_monitor_latency_show() and server_monitor_conn_id_show()
> functions use monitor_pages index '0'.
> 
> Signed-off-by: Kimberly Brown <kimbrownkd@gmail.com>
> ---
>  drivers/hv/vmbus_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 403fee01572c..f2a79f5129d7 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -234,7 +234,7 @@ static ssize_t server_monitor_pending_show(struct device *dev,
>  		return -ENODEV;
>  	return sprintf(buf, "%d\n",
>  		       channel_pending(hv_dev->channel,
> -				       vmbus_connection.monitor_pages[1]));
> +				       vmbus_connection.monitor_pages[0]));
>  }
>  static DEVICE_ATTR_RO(server_monitor_pending);


Looks good.

I wonder if ever gets used though since it returned incorrect data...

Acked-by: Stephen Hemminger <stephen@networkplumber.org>
