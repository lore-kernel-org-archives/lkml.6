Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD0AC5CFC0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 18:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 935E92088E
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 18:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W03SFWem"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 935E92088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932892AbeFPSkY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 14:40:24 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:38195 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932482AbeFPSkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 14:40:22 -0400
Received: by mail-oi0-f65.google.com with SMTP id d5-v6so11601318oib.5;
        Sat, 16 Jun 2018 11:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=poKGrsoHoIz7Jhu5Md6Yv2qNkvPzUI5x5LLjfHHEzgQ=;
        b=W03SFWemEGTVdsU9PaHRRUOtd2WSl/HhLOCURlLM8lf/vAVrQVXbgcTeTUTvVarfA/
         TgvvENq6GbTQp5Xu7m/UEZxUeYQqV1sqjPfb6S30Gf6zxC94xITHJ4Wa0HtO2F8mvy9J
         wYF2M/Ws7rPChgSn4QSq4TtiMeZEO3OeaVgPWN+tmRvK16G1i2PsyePg4HXj1DR4czq5
         BpBTbAzo2xB1uXG3G4ztadyu0TQ7VTkIYaPp0smogcePtT7vvqvA+/1k73iIsJWI8US0
         0tdbnfETcsPcwQ70yOGBYPhwE7DmZ/szkSAG3T0PWX6QlEOjlWolYS57JvMJEnxry+Qb
         mWPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=poKGrsoHoIz7Jhu5Md6Yv2qNkvPzUI5x5LLjfHHEzgQ=;
        b=qiFuRZ1EVTnC4qwqqNLh2MMck5DO6bIq6kghFj4V8xzpiFYupInzvqXrLTDQJ/LK0s
         MZQ1Fha6FeQU/DtdBjFbPrih2sn4xAi9nPxkfATDU2xa8TXU3K24JEHgdLJRQ5HosPwC
         ynFEhKriiDjy142VNIa0FSFj5vyg06iNAbTHC1F4vJX3MlqRmiNgUrKSB6PibhZypuox
         KjQY1qbsXbW5T6QxkuWnTWAOBLxzZb72DvRc/22ERm/j1sDciPw8G4BxDe1USzKXqYIC
         4KbQKSupZPddfp/fbAXO/pWHK3RKwv2PC+clE3RXJzrFMfO8iJmRDDeJKC+yjRLSLF72
         BMKA==
X-Gm-Message-State: APt69E1hTQtqdf8QSD8g0EEasPwGRZnIk3xBLbB4CjdBZ5boVrCc317A
        RuZMAxUiKKK5Cu2sQYx0dmSgejqTVbxCraCfk5I=
X-Google-Smtp-Source: ADUXVKJ0bFYNjeHOqjX/tmnmOHRFSpnaF9Q0Ms8dydinfYC6tKBRfKWDfKr6Mz/bCpjNg58cA62LgXdPPaJZs9zSd6I=
X-Received: by 2002:aca:6144:: with SMTP id v65-v6mr3979606oib.147.1529174421818;
 Sat, 16 Jun 2018 11:40:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1049:0:0:0:0:0 with HTTP; Sat, 16 Jun 2018 11:40:21
 -0700 (PDT)
In-Reply-To: <1529063093-19582-1-git-send-email-stefan.wahren@i2se.com>
References: <1529063093-19582-1-git-send-email-stefan.wahren@i2se.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 16 Jun 2018 15:40:21 -0300
Message-ID: <CAOMZO5D7FAiE8dXKmLHCmOdHek4w_LuYjz8uP9jdD7U6Z-7f5Q@mail.gmail.com>
Subject: Re: [PATCH RFC 0/2] regulator: pfuze100: add pfuze3001 support
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On Fri, Jun 15, 2018 at 8:44 AM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> This patch series adds support for the NXP PMIC PF3001. This
> based mostly on the patches by Robin Gong and Mauro Salvini from
> here [1].
>
> [1] - https://community.nxp.com/docs/DOC-331899
>
> Stefan Wahren (2):
>   dt-bindings: pfuze100: add pfuze3001 support
>   regulator: pfuze100: add pfuze3001 support

This series looks good.

Any particular reason for marking it as RFC?

Thanks
