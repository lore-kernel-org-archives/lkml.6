Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1800EC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 15:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9F8D2080F
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 15:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c87VaKK3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9F8D2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbeKRBzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 20:55:48 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43479 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbeKRBzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 20:55:48 -0500
Received: by mail-lf1-f65.google.com with SMTP id u18so18470512lff.10;
        Sat, 17 Nov 2018 07:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OecdLPBNZZmQfcW0V9qrhMxz7dCa17jXtMDEKRLIv4g=;
        b=c87VaKK3qbslIW6UkblnWyuipig0lKPto5/mzraFMOCBkcmV28miI7GEQ0SFj5IHae
         l6LqgGb1Y8J00+VA0UqKzj0TdC0OBbnwba+eF+6CNJwEEkB4owAvJmy6l1b8wUSYH96o
         rnLyMurmMi7Pl6lACNRq+W8P8gHhay6ufUW23HDKXsZbDaFcbkYlBxJB3UVuS6MIzxaa
         L69B9vc2sos11LCuqQmXR/UIDnuRGCw6ZOQWfGKyIHexl8P+HqaUqTqrXGWVsxPnlbl+
         ldKXM6iiY6ZbCveNeQ93GeaUaSQw1o3eCMyIxpj/OZ/tpLpMrMFMbknkgMEdOWQURuXW
         8KyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=OecdLPBNZZmQfcW0V9qrhMxz7dCa17jXtMDEKRLIv4g=;
        b=YOM51uiPjmHZSL4owjifZiW7t0vANJCoxKoqFwR7mBnP5LtRd2RhzyVQJM86cf4lNc
         92UKsKIlqpXxhVPTsuOZbKChynzCJs9xBACeAurjXbHxXrrVDS1X579D1QDYnsVuL1uS
         c9h2F8rS5wIfqRnc2tVsQtBXL/TcN4oQGRMvaPiUfgJvdx/v3ZT8m5aykjRNtuJDGCcD
         I6ISRf/4IeNjgka9jjRc3Iq9x+LPVBht/qUONZkfiBcp1piQl7a2os6O6+mIcH4kRG47
         gQnF9C3XOJlDXy/cFejHi2NI6KoFyFLPzHD/iu/U9KxQKWtpW5SXUdKBSv3L2eDjXS3Q
         pyHQ==
X-Gm-Message-State: AGRZ1gKFBtTnF703pFnNX5MsTO+V5WPo79lzjrcKNvQGxqZu3lq2P3/+
        QETCr8lY/xWSdajmhftoyDo=
X-Google-Smtp-Source: AJdET5ck3AZy+M8c8Ec6476L0DJXTSFYXu1Aj+GIXfyAIOsJdHuBBxHUisKBc5yfsHqa8XYvmLXN3g==
X-Received: by 2002:a19:d9d6:: with SMTP id s83mr7934043lfi.57.1542469124349;
        Sat, 17 Nov 2018 07:38:44 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id h16-v6sm5561585lfc.0.2018.11.17.07.38.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Nov 2018 07:38:43 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gO2gH-0001Uy-ET; Sat, 17 Nov 2018 16:38:45 +0100
Date:   Sat, 17 Nov 2018 16:38:45 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/2] phy: core: Add phy_pm_runtime_enabled
Message-ID: <20181117153845.GU19900@localhost>
References: <20181117133755.9129-1-tony@atomide.com>
 <20181117133755.9129-2-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181117133755.9129-2-tony@atomide.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 17, 2018 at 05:37:54AM -0800, Tony Lindgren wrote:
> The phy driver may need to check phy_pm_runtime_enabled() in suspend as
> PM runtime for phy may be already disabled when phy power_off() is called.
> 
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/phy/phy-core.c  | 9 +++++++++
>  include/linux/phy/phy.h | 6 ++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
> --- a/drivers/phy/phy-core.c
> +++ b/drivers/phy/phy-core.c

> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
> --- a/include/linux/phy/phy.h
> +++ b/include/linux/phy/phy.h
> @@ -158,6 +158,7 @@ int phy_pm_runtime_get(struct phy *phy);
>  int phy_pm_runtime_get_sync(struct phy *phy);
>  int phy_pm_runtime_put(struct phy *phy);
>  int phy_pm_runtime_put_sync(struct phy *phy);
> +bool phy_pm_runtime_enabled(struct phy *phy);
>  void phy_pm_runtime_allow(struct phy *phy);
>  void phy_pm_runtime_forbid(struct phy *phy);
>  int phy_init(struct phy *phy);
> @@ -240,6 +241,11 @@ static inline int phy_pm_runtime_put_sync(struct phy *phy)
>  	return -ENOSYS;
>  }
>  
> +static inline bool phy_pm_runtime_enabled(struct phy *phy)
> +{
> +	return false

Missing semicolon.

> +}
> +
>  static inline void phy_pm_runtime_allow(struct phy *phy)
>  {
>  	return;

Johan
