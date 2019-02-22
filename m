Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECF7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48309206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fO+8G72o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfBVU2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 15:28:22 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42276 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbfBVU2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 15:28:21 -0500
Received: by mail-pf1-f196.google.com with SMTP id n74so1595675pfi.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 12:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:subject:message-id
         :user-agent:references:from:in-reply-to:to:cc:date;
        bh=KCWbgn8HqUUvwSGqpPxINncwGWSv6rhm56YbIxqxJBQ=;
        b=fO+8G72osJE1YhCmIDbGFCY5/P/t6uQJzkjfmzcfLKpG8OY+xBWnZB+goosjz761om
         MHQtuUU4fYNZARAicUKm0+GAq//HZId4qu7x8UOlFQ64eBGaUFQWUJ8gpVz5lGs+KJ6N
         Vw//c15xAIiQ545tjWRRcsIxnrk9pmk1xUApA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:subject
         :message-id:user-agent:references:from:in-reply-to:to:cc:date;
        bh=KCWbgn8HqUUvwSGqpPxINncwGWSv6rhm56YbIxqxJBQ=;
        b=SLVBMv1H0xJ9xJVOgNVeEMxIhXjsao5Gk75R/y8ESgc4gfhXquZADZL1uiVhQW1+Xt
         JSCh72WhvicWVnKZnCOKu6S3cCKo7YpC1g8cRjAIRkUYx4L4GXOtaVV9MSrjHizNQS1J
         bX3lGT3IlTfCFXI9nshZcus7CwRtl2nGlCAEARYPY2hEEhoiqPHwLOXnYKL31XNILSyG
         2RwZPmHRokkAK52dl3qWmXQDVy5cSHL/rcJB4hHgnVVfbLwnIFuXXCS04CQyVoIx2aIn
         a9oYgn5EovUrknjK7zATMVx08rKeS3HFMzse2i1vEVYdqGgCj3KOjFA9bumqtuYRHxIq
         F09A==
X-Gm-Message-State: AHQUAuaes1+oy8heWTAFT+Z3ZoTpRQsG/M28567bImIPoGz8OhzszQ42
        5ZDefdyQVRjIZg/rDMOJOkO93Q==
X-Google-Smtp-Source: AHgI3IYiqsOaznx7z921u1BEwGo7C0fKPGoPpk93PFlH9mIpgkdotc4P4Gswa1XFBGnMQhL1h4dcbQ==
X-Received: by 2002:a63:c04b:: with SMTP id z11mr5593343pgi.135.1550867300933;
        Fri, 22 Feb 2019 12:28:20 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id s1sm2938079pgv.30.2019.02.22.12.28.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 12:28:20 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 7/8] phy: qcom: Utilize UFS reset controller
Message-ID: <155086729867.77512.8850537052264643664@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <20190213232526.26995-1-evgreen@chromium.org> <20190213232526.26995-8-evgreen@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20190213232526.26995-8-evgreen@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Can Guo <cang@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-scsi@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, Manu Gautam <mgautam@codeaurora.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Vinayak Holikatti <vinholikatti@gmail.com>
Date:   Fri, 22 Feb 2019 12:28:18 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Evan Green (2019-02-13 15:25:25)
> Move the PHY reset from ufs-qcom into the respective PHYs. This will
> allow us to merge the two phases of UFS PHY initialization.
>=20
> Signed-off-by: Evan Green <evgreen@chromium.org>
>=20
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

