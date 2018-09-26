Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE81AC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 06:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C9EA21480
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 06:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="W04il+Te"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C9EA21480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbeIZNJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 09:09:20 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38375 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbeIZNJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 09:09:19 -0400
Received: by mail-io1-f66.google.com with SMTP id y3-v6so22454500ioc.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 23:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Iu7gwAJiG/N8xTqMvdF2e6/NJTw2qef+al/ZS7Tv/Xw=;
        b=W04il+TeGc7/DuuipqIhrPiKxvpfEcr7JRTC0ji0VXtBLWIJtzOAXzSzavyPxwrW7d
         SPcLDwU8OVuLRLqMNtGsBC2kMJQK0OeoVsiEFjxBWwTkFvBBCnJPNWQtwuONepdMBizZ
         UtikbzmvVdDCBfmHMi+HL8elbETOBCRQVbCkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Iu7gwAJiG/N8xTqMvdF2e6/NJTw2qef+al/ZS7Tv/Xw=;
        b=KAdcWwfm3FKSoQKf/RS+QzR4iacYxW9o10uASfNOrVrDiDfiw+xp5asl1UI35QdeY5
         rCuXmYLZEJCxbVEsf2KujZYNjH+h4TFfP+i4r5QF+G/DGGt0XymKA6f/gMG74XhqgLGL
         3GXFGAXCBkgGdoaLX5MpTNkbgFYDdzz97JWvQjKy1WLJ4XMzC+dQq02kDbq2+UR5mlUC
         AtRXuRPOzqfO8MrLnGGR5TwXeyzjiBnYnqdzOmxdpMhhRwwBn+7jksGiej6ZLMXuI46K
         +xgAbIqBqZv4m3v1WLkL9DqC8N6HDE01BIxxUmojrHVpvPgEnJ1tPxUtqBmKpENewuDe
         U5WQ==
X-Gm-Message-State: ABuFfohC7iOIpvSObilCvR5pZbH3DUQhp02DclrAi93uwhi3gSolutMx
        /Na8P4x0hPQb65oWmUvtO1ywYIA+9rodpjFRA8PhEw==
X-Google-Smtp-Source: ACcGV60rj2ZEpjCkKxjuIqIhPw2Uh1qxl5mLd2Rp8l4vidaCsjaZ+zNjcMOBHJgU/b+mBk9FuSXmIhUvn/JuQKkmoDk=
X-Received: by 2002:a6b:c3c4:: with SMTP id t187-v6mr3856565iof.304.1537945073291;
 Tue, 25 Sep 2018 23:57:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180812142413.20856-1-ctatlor97@gmail.com> <20180925173801.3835-1-ctatlor97@gmail.com>
In-Reply-To: <20180925173801.3835-1-ctatlor97@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 26 Sep 2018 08:57:41 +0200
Message-ID: <CACRpkda4SuPVz8Awg6OhhanmZKEs4URw3WBMv0Fa8iJa2MD-KA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] pinctrl: qcom: Add sdm660 pinctrl driver
To:     Craig Tatlor <ctatlor97@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, neeraju@codeaurora.org,
        vabbar@codeaurora.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 7:38 PM Craig Tatlor <ctatlor97@gmail.com> wrote:

> From: Neeraj Upadhyay <neeraju@codeaurora.org>
>
> Add initial pinctrl driver to support pin configuration with
> pinctrl framework for sdm660.
> Based off CAF implementation.
>
> Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
> Co-Developed-by: Venkatesh Yadav Abbarapu <vabbar@codeaurora.org>
> Signed-off-by: Venkatesh Yadav Abbarapu <vabbar@codeaurora.org>
> [craig: minor updates for upstreaming, updated tile handling]
> Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>

Co-Developed-by? That was innovative.

Anyways, since there is also a signoff all is fine.

Patch applied with Bj=C3=B6rn's ACK.

Yours,
Linus Walleij
