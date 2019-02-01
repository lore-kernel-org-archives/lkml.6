Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9A1C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E8DB21872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gw2JDs4e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731399AbfBARlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 12:41:04 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43666 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbfBARlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 12:41:04 -0500
Received: by mail-pf1-f196.google.com with SMTP id w73so3539184pfk.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 09:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:subject:from:message-id:cc
         :references:user-agent:to:in-reply-to:date;
        bh=tVKhEsQJcL5lc5IBwSf45PH8dkjJpIbFVJ/czDzRG/g=;
        b=gw2JDs4eI1R04STaoGHSxXMaigb3G0BAi3Y8xEUnf8aXmfdBQghG4sbV3zNEmaHA8L
         +tCiNB9LLKyPFKoffkAC2xoWFCEAzkVM6tkiqVr/wZLj8jghBrz8ZN5NcVfU4XZIX5TR
         xxiAPJf6as5pico8gf0qEyBowjczM5pNlzgmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:subject
         :from:message-id:cc:references:user-agent:to:in-reply-to:date;
        bh=tVKhEsQJcL5lc5IBwSf45PH8dkjJpIbFVJ/czDzRG/g=;
        b=p/uwOueVU5ln9l0x9sydRoS88RVLU7WnJ5G9mwDapGVsMGPCP55n3Sp+zv+sWChgil
         eiipi58pND3Owkn5b0GpRmV56EHY6gBnqw6bylkaQYly/E1tp58vO0E7Mka29kW64RKs
         N1fHtoGnpxaDQ9S17Wr4aE6lvrdfaV52RDS9EJwk1w3GYYsG4PqbBujiWdL1kYU3NqWH
         2A4coygCllE+LnaSL0aehCi/M5bgpqDlzkdyy9BJCaN2cHRdPCb/WImDcwLuSD2EdWAB
         CI2uhXSxDe9aBtOoQSvJ8oFJCV7ndsEpR6jNvh+9mrav6UwE224b2igQSxMoAExBP+QK
         XqSA==
X-Gm-Message-State: AHQUAuYEX7AG5GkgxGbGycAhx6Wot89p+AbOBxX4I0WZvsm0613C/b/N
        6woKfkwPsbGFc16phH51g1UGyA==
X-Google-Smtp-Source: AHgI3IY2eZdjmQVFfnMK5n1adQMeQx7xYbi02EZcPxwRgUv7aIIfgECjABioxqAzhrKcQnOdn0j6jQ==
X-Received: by 2002:a63:dd15:: with SMTP id t21mr3020303pgg.347.1549042863354;
        Fri, 01 Feb 2019 09:41:03 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id w3sm10563230pge.8.2019.02.01.09.41.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 09:41:02 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/9] dt-bindings: ufs: Add #reset-cells for Qualcomm controllers
From:   Stephen Boyd <swboyd@chromium.org>
Message-ID: <154904286159.169292.15890098179989196572@swboyd.mtv.corp.google.com>
Cc:     Can Guo <cang@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Evan Green <evgreen@chromium.org>, devicetree@vger.kernel.org,
        liwei <liwei213@huawei.com>, linux-kernel@vger.kernel.org,
        Subhash Jadavani <subhashj@codeaurora.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>
References: <20190123221137.41722-1-evgreen@chromium.org> <20190123221137.41722-2-evgreen@chromium.org>
User-Agent: alot/0.8
To:     Andy Gross <andy.gross@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20190123221137.41722-2-evgreen@chromium.org>
Date:   Fri, 01 Feb 2019 09:41:01 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Evan Green (2019-01-23 14:11:29)
> Enable Qualcomm UFS controllers to expose the PHY reset via a reset
> controller.
>=20
> Signed-off-by: Evan Green <evgreen@chromium.org>
>=20
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

