Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C957C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6546B218D3
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ViP4o7nL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfBFVEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 16:04:55 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35693 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfBFVEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 16:04:54 -0500
Received: by mail-pg1-f195.google.com with SMTP id s198so3474110pgs.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 13:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:in-reply-to:user-agent
         :subject:message-id:references:cc:from:date;
        bh=fPLjGlqReW8R3/Rrke2fNcnowF/7bAVMyCUc2xdQWgQ=;
        b=ViP4o7nLA2rVBYlNNnIwJCngAkXwNo1IGEXK1VrrnHNDpGxNQJ0FUz7kn0aO3G2jxS
         eFCyLe/TUy6WpQrJEgBj0W1BDGUGTw20NlCfeE2Y37C6UYzCR+kMOqP6RAF/egU3xjNq
         +HW6lOUC16AQUhbXTPhYAevBfvgxjTS48TowU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to
         :in-reply-to:user-agent:subject:message-id:references:cc:from:date;
        bh=fPLjGlqReW8R3/Rrke2fNcnowF/7bAVMyCUc2xdQWgQ=;
        b=gRVdxM3RyJTQOcafiMMnsI8xhyzT/3Kh3ol1gBAaNhSjjoxOTcQOUDUdOOzzMYZxDN
         oi1Fy9GteClASbzFHDKFpRmu3VncpnsdWXdatW+yLh1OAER184vKzpVMI9AaD83b2lHZ
         0cLT2iIM939et4Zwrek+nBSFF2TpHWfjb92/6pJzip622s13+8YBYMHhiNzCHvr0FVTx
         CX/PKKfaqtOsKloujCB+7/ceFVBtrgahuuwC4IlnMpFiR2cpkI4+f8bt6OyTsjGMLa9D
         FNpOpcfqH4ufruCTAjfIbtwLkX7UW2bwUtkFwxQFPViXspDji7UFA4dSuUoI2mGkkBs1
         4AvQ==
X-Gm-Message-State: AHQUAuY8L6X+Yd3YzxyHmHt1I63rvPT6MOenTliqdTbdgCoYWaTtnCmN
        hcstv2UClLfyyKhid2yA3WOB+g==
X-Google-Smtp-Source: AHgI3IaJiG9smRLpuEJWBGEmmZ+ocjgm9SgzRC2rSOZpeoNKKUx5b/HE9SWsYaFlCjdnp56XBl6Qvw==
X-Received: by 2002:a63:e80e:: with SMTP id s14mr11460138pgh.30.1549487094122;
        Wed, 06 Feb 2019 13:04:54 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id b7sm9439585pfa.52.2019.02.06.13.04.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 13:04:53 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Andy Gross <andy.gross@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
In-Reply-To: <20190205185902.106085-7-evgreen@chromium.org>
User-Agent: alot/0.8
Subject: Re: [PATCH v3 6/8] scsi: ufs: qcom: Expose the reset controller for PHY
Message-ID: <154948709228.115909.11813314659494594710@swboyd.mtv.corp.google.com>
References: <20190205185902.106085-1-evgreen@chromium.org> <20190205185902.106085-7-evgreen@chromium.org>
Cc:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Can Guo <cang@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Stephen Boyd <swboyd@chromium.org>
Date:   Wed, 06 Feb 2019 13:04:52 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Evan Green (2019-02-05 10:59:00)
> Expose a reset controller that the phy will later use to control its
> own PHY reset in the UFS controller. This will enable the combining
> of PHY init functionality into a single function.
>=20
> Signed-off-by: Evan Green <evgreen@chromium.org>
>=20
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

