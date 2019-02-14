Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFEEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 271B621927
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S+Yfs7Ox"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408051AbfBNSXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 13:23:46 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37302 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406694AbfBNSXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 13:23:46 -0500
Received: by mail-pl1-f196.google.com with SMTP id b5so3582902plr.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 10:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:in-reply-to:user-agent
         :subject:message-id:references:cc:from:date;
        bh=bWMqxxh71sYomjw3+iVu5SDnYatAZ8LCG9PdU2Q4xsI=;
        b=S+Yfs7Oxw8a3/VwgN8X7DA+pUp78HLGS0qeHTt6RsOZMSV/UHsHhti1t/lj4bjG4JQ
         xsX7gBU5/j+QtHVO2Qbssgf4DycyogbliJDcsI38kiZVNLdhM4oFkF9/1xgLieCltJaQ
         y+VjrA3lk9g+0cJxWaFZ1yLV2H7d4HK3pzwPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to
         :in-reply-to:user-agent:subject:message-id:references:cc:from:date;
        bh=bWMqxxh71sYomjw3+iVu5SDnYatAZ8LCG9PdU2Q4xsI=;
        b=IPCmEaWz3fYSUYwp/oParJzTjuDxtp709zcCPuCwkm/ZwsXncx8hn8EDZ7Iz+FTu81
         VWpJglQKuVkRHPCB7mOqdcvu1nUt6g3uvX5K02iwW2Ng7xDsI16CfbhCFTrD4DIfOPDp
         HiTGOkamhIYqKWC7OUk0LKEBXj8F1bGDcK3Zldgk+LlfmYzcblCW2IhTQvAxvccPaceR
         f6LALzfcv68+jGxJbIsFLM9egR5HWR8AqWro+KsizeOQk57iQwl0ZD1GHnTM7ZUXM5nG
         kz+KmSXyxEV/jOiR7k5JeUFYARQOetwiSTdKLBWfW9Csz2v8ik64X06aQlVKJ4DmjOEj
         kKLg==
X-Gm-Message-State: AHQUAuayb2BIerMMbrH9kqL7DE7Qm3GL7GGhvnAC5UkvRfxgY8yDyIiB
        D4jCgnIBUoZmxH/s8xhz+DefNw==
X-Google-Smtp-Source: AHgI3Ibu3pv63e9hZjTB8VFBPJ6EENseF95lpab9Yko1XmYbUUJCtc5P6IvSqDCeEAhv1xRhyXei/g==
X-Received: by 2002:a17:902:31c3:: with SMTP id x61mr5508579plb.113.1550168625764;
        Thu, 14 Feb 2019 10:23:45 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 62sm3567446pgc.61.2019.02.14.10.23.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 10:23:45 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Douglas Anderson <dianders@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
In-Reply-To: <20190214181249.2749-1-dianders@chromium.org>
User-Agent: alot/0.8
Subject: Re: [PATCH 1/2] PM / Domains: Mark "name" const in genpd_dev_pm_attach_by_name()
Message-ID: <155016862432.115909.9670639610937764563@swboyd.mtv.corp.google.com>
References: <20190214181249.2749-1-dianders@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Len Brown <len.brown@intel.com>,
        Kevin Hilman <khilman@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Machek <pavel@ucw.cz>
From:   Stephen Boyd <swboyd@chromium.org>
Date:   Thu, 14 Feb 2019 10:23:44 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2019-02-14 10:12:48)
> The genpd_dev_pm_attach_by_name() simply takes the name and passes it
> to of_property_match_string() where the argument is "const char *".
> Adding a const here allows a later patch to add a const to
> dev_pm_domain_attach_by_name() which allows drivers to pass in a name
> that was declared "const" in a driver.
>=20
> Fixes: 5d6be70add65 ("PM / Domains: Introduce option to attach a device b=
y name to genpd")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

