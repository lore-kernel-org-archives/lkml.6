Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13AC6C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDCFA218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="TVox/jkv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbfBKNBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:01:07 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54646 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfBKNBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:01:07 -0500
Received: by mail-wm1-f65.google.com with SMTP id a62so17597915wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 05:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=seP3OImkzn/QH21KAwtK3NgvsDKt+Cf8pXUvFH1pmis=;
        b=TVox/jkvLjmEj+2ZhYpCGzS/E+XXFkawyBZ+Su2WTiPRPeMHPs55kxfNMozmCKJ6ka
         FWK+JbF1POKmmL3iPpONknkaWm8dx2oLmH7U9woAr1iAI5ehb77SQyjxYF+JeRxbVTM1
         46g6JINgpCmSOJgiyHJznED6WWumUMfCeocE08cio9yPkzAw7nYi2n74h9X8m4GWtW/l
         r6GIIKDRWjJpg0d2T2aZofUW0PwjFOwHRkdYUfoCvRuEjf/7iksaYU6N6XTXNwLeiEN8
         ExGro/dYXwWdEFy2vwVwzTBT9XsAxr3YqGhr+kfRMTyI+jakOJPAIW+K2T2oQIQ7L3Bz
         ml/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=seP3OImkzn/QH21KAwtK3NgvsDKt+Cf8pXUvFH1pmis=;
        b=hPxlxuhyKSTQax+0AOkLBkCf/28+VI5pLw57/nFJumLbe6ffE4oB8NXhcmH6vsD5sL
         v3eBSxcHjkxguayio9r4DMjMIlfEwfJ/+XyM2h/JpCtpmiLGJLs54mMMi0MgY3+fUz6w
         eUeAxbNO/RvZhLFryVyas9Be2Z8M2m+hfBynxgBBXlFx11NGlv3TrGqbnZT6zHhYiqiy
         PHeXFXIG/AwNAn+VxyuNwhhb1I8ov2CSDlEVNQv1zvxREPmn9VYZRvaskwwoZqK5/JOP
         +OJJV8171w3Ao1/y8z6SC1rV+Dsy3sTvO7bmicwcY5ipHFnMYrMlLGk3A1EUNt6b2hUb
         DEig==
X-Gm-Message-State: AHQUAuZva4MEN8Uf8mZaBAWKKoh1EOTujpOUtSRVCmWpdrqK/pC0BD4b
        fknkP89VW3TL4yd03X7rXPc43w==
X-Google-Smtp-Source: AHgI3IYSwICDnksxBa6tbDWP0som5alm5fI0V/qBfOV+liiF70GS5UQ5KWEw6ofuO774dbdU7LBMkA==
X-Received: by 2002:a1c:f707:: with SMTP id v7mr9577420wmh.18.1549890065419;
        Mon, 11 Feb 2019 05:01:05 -0800 (PST)
Received: from localhost (mail.chocen-mesto.cz. [85.163.43.2])
        by smtp.gmail.com with ESMTPSA id p5sm6232019wmh.16.2019.02.11.05.01.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 05:01:04 -0800 (PST)
Date:   Mon, 11 Feb 2019 13:51:39 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, idosch@mellanox.com,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        bridge@lists.linux-foundation.org, jiri@mellanox.com,
        andrew@lunn.ch, vivien.didelot@gmail.com
Subject: Re: [PATCH net-next v3 9/9] net: Remove switchdev_ops
Message-ID: <20190211125139.GL2251@nanopsycho>
References: <20190210234007.16173-1-f.fainelli@gmail.com>
 <20190210234007.16173-10-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190210234007.16173-10-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Feb 11, 2019 at 12:40:07AM CET, f.fainelli@gmail.com wrote:
>Now that we have converted all possible callers to using a switchdev
>notifier for attributes we do not have a need for implementing
>switchdev_ops anymore, and this can be removed from all drivers the
>net_device structure.
>
>Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Jiri Pirko <jiri@mellanox.com>
