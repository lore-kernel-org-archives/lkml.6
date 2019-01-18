Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E36BC61CE3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F51720449
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cruF1C9i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729995AbfARWUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 17:20:41 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34455 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729932AbfARWUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 17:20:41 -0500
Received: by mail-pf1-f194.google.com with SMTP id h3so7269192pfg.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 14:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:subject:user-agent
         :in-reply-to:references:cc:to:message-id:from:date;
        bh=kv+0xA5Gd/VUKxtH5FOUWv6VloSRZZSBZ6nIvmpR4qM=;
        b=cruF1C9i0kWJw7e51lIMfIsc72ZXzx0GlvfsvBjqv1hKmkwAl4pQuSjZGcM5XYVpAS
         R7+koVgaTb6ff4jqONrJsV2OEyPtVT8fZSPF6M5wZwf602rpNf8q8Wg7F/jFUfwNWfTp
         LNjBiIh8uhtmBwzAfJ/AupjU6D+KI7VwKZakQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:subject
         :user-agent:in-reply-to:references:cc:to:message-id:from:date;
        bh=kv+0xA5Gd/VUKxtH5FOUWv6VloSRZZSBZ6nIvmpR4qM=;
        b=dAcvS3fjGdm/sgzsmHKU2cLOVKJ6vWp3LgyylXSJmjFgB3gETrgVxcwHlnR1WRdaee
         RganKontJ9Qwg5Mk0WwSXlC5NxkW2yP9SqLisOTEVl4Ibc8HZQ4QJBZ5Me8zqS7zVY1Y
         4K+eh13ghE47dEAGgCOj4NXK2am2SHC+tI0kLykqt+VtNRX57vdmekd5gSf09x5T+xZI
         46zhL266CUwcVYASFAWu5a8rbxvbKjXsZPz1W8idihaFhBD441lCihMsXQSnxrUSxlkl
         smenumZ9aQyeHcqnYqGY/grBSpihc3eUVeC+B0bIAIkqMAELZC5SGUC1Bu7PnatrMOCl
         OJiQ==
X-Gm-Message-State: AJcUukfqQtiK2gvfPoyFE15J/TYybbGzhM+9wVBKORAU+NXYZa8iJiCQ
        sAnc2eaWbbinPT85dqzhK8D3DQ==
X-Google-Smtp-Source: ALg8bN7tYCFSR2hwM3zdHM9InYNZ8YsnFo5x0rIWisZI9s1Pf/VQrlBY+1U2MGrBZtjyLk7IPJcykw==
X-Received: by 2002:a63:184a:: with SMTP id 10mr19222216pgy.81.1547850040404;
        Fri, 18 Jan 2019 14:20:40 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id w128sm7730334pfw.79.2019.01.18.14.20.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 14:20:39 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 4/8] arm64: dts: msm8996: Add UFS PHY reset controller
User-Agent: alot/0.8
In-Reply-To: <20190111230129.127037-5-evgreen@chromium.org>
References: <20190111230129.127037-1-evgreen@chromium.org> <20190111230129.127037-5-evgreen@chromium.org>
Cc:     Can Guo <cang@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Evan Green <evgreen@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
To:     Andy Gross <andy.gross@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
Message-ID: <154785003879.169631.14118359438599821275@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <swboyd@chromium.org>
Date:   Fri, 18 Jan 2019 14:20:38 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Evan Green (2019-01-11 15:01:25)
> Add the reset controller for the UFS controller, and wire it up
> so that the UFS PHY can initialize itself without relying on
> implicit sequencing between the two drivers.
>=20
> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

