Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B3BCC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCDB520652
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Sv4jC31K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733285AbfAPWcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 17:32:16 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38313 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732911AbfAPWcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 17:32:15 -0500
Received: by mail-pg1-f193.google.com with SMTP id g189so3458592pgc.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 14:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:subject:user-agent
         :in-reply-to:references:cc:to:message-id:from:date;
        bh=s52TufgdnA1Jpsl6ZZ0u+tFTg6i3vn3OhwSJLLQGsNc=;
        b=Sv4jC31KiGmyb5B0TQ8kIWLxnz8L+wgRIlFifHYmgjg3C1WDv1kF+LrdiWC87bFJxF
         hkmZfX2NmxOsNpP8Lltzyxkm1KjAGzSM5LK3GOOwYRpnnknxNdLCmg8uKk4MTePBjcsG
         /BOSGlBenfByFZqkVTqdznoKXvU/Unw2X2+k0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:subject
         :user-agent:in-reply-to:references:cc:to:message-id:from:date;
        bh=s52TufgdnA1Jpsl6ZZ0u+tFTg6i3vn3OhwSJLLQGsNc=;
        b=fdPwRhVrRVfhwwVnWyI2UgAwqJxQskBGGJMy/k0sel4kB/LJSPa4Zz3ZTblvt4SX6a
         oFVqfMb7upF1a9IumkKCzYayhTTaeJP6fLmRK2CjYqPuVm/wwhGTV3Hy65C6uVmqU/wv
         Au3U1xZc1YmIQn0pvq2B3l2EE3OxeO9tlYhYpJ1XaD1ijgoEx43qZgxIpalVnEWbFLIM
         VZFE165CJxxRLzDZwYPRYFVTpSq/w5vyHKTaJh/jooKmwtzHnScQAqi/VwzYci+xppCt
         1hRLavkRaXacEpmLgN8kgNzTsSoNTJq5wIThtDc6Akm5Lo5dmh5QazBZbmt8DFBaThaQ
         QZug==
X-Gm-Message-State: AJcUukfmI1/nHKKdriFhbDyxMGsl2ecBJ4X3ucd1T6wOCDSmoScoQE4J
        JJXchFHxoAbQgTkv41l1GM8DyQ==
X-Google-Smtp-Source: ALg8bN6S67wTjHSFHvr5/AmEyXUEZee1Yn2llTcYysGQ0RxdYgomLZqwx4JqPFUOIUBAs9IpqYOHMA==
X-Received: by 2002:aa7:810c:: with SMTP id b12mr12158397pfi.44.1547677934715;
        Wed, 16 Jan 2019 14:32:14 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id k14sm7593063pgs.52.2019.01.16.14.32.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 14:32:14 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 0/8] phy: qcom-ufs: Enable regulators to be off in suspend
User-Agent: alot/0.8
In-Reply-To: <20190111230129.127037-1-evgreen@chromium.org>
References: <20190111230129.127037-1-evgreen@chromium.org>
Cc:     Can Guo <cang@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Evan Green <evgreen@chromium.org>, devicetree@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        linux-scsi@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        Manu Gautam <mgautam@codeaurora.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Andy Gross <andy.gross@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
Message-ID: <154767793304.169631.18064099850112277477@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <swboyd@chromium.org>
Date:   Wed, 16 Jan 2019 14:32:13 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Evan Green (2019-01-11 15:01:21)
>=20
> Because the UFS PHY reset bit is now toggled in the PHY, rather
> than in ufs-qcom, this also percolated to all other PHYs using
> ufs-qcom, which from what I can see is just 8996.
>=20
> There are a couple of tradeoffs in this series that I'd welcome feedback
> on. First, it breaks compatibility with device trees that don't expose
> this new reset controller. Making this work with older device trees
> would be pretty ugly in the code, and given that the SDM845 UFS DT nodes
> aren't accepted upstream yet, the breakage seemed worth it. I'm not as
> sure about 8996.

It may take some minor surgery to the reset framework, but it should be
possible to register a reset lookup that can be used if nothing matches
in DT. Right now the reset code looks to only want to use DT if it's
there for the device requesting the reset. If there isn't a DT node for
the device it will look in the global lookup list. That could be changed
to fallback to the global lookup that uses device names (similar to clk
framework) when the DT lookup fails. Then it's just a matter of
registering the lookup for this reset with the handful of device names
that need the non-DT way of finding the reset.

Of course, that's another change and if breaking DT is simpler and
acceptable then I would say go for the path of least resistance and
don't try to modify reset framework for this.

