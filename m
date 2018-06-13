Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 806BAC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 17:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34685208D4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 17:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="G6oTQ3xR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I3zAVPxQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34685208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935399AbeFMRaj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 13:30:39 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:47061 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935042AbeFMRag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 13:30:36 -0400
Received: by mail-ua0-f194.google.com with SMTP id d7-v6so2242484uam.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 10:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=VyvOiEa44h873tWuWSnwTmHKgUr6NGdKQeQ8EfJZ9p8=;
        b=G6oTQ3xR/alXzCwYoW6d2aZVIZGT6sCQNQLnatpUnZ6kIsu6QEE9HTOvJLOcX+AR5H
         fB/utF4KtqDag/pffkc0y9SogOOg85XPz+tt3OGB924gdQTGQOZApA7CUDZ4k+8+QntK
         AU6tML8TYqx4ORwRcKVlOsF1qfhsqRxxCb8NXw62p+C1h1vmJvK4pofuCn2nvXsgAeD+
         LFHVXuqxnNOSTw0JsavM6fnHFATNslqwk8jueRbXgEujzvW1EDhfAWIkJbB1rGnAyohb
         uPJZk+Sz8q3GP8WyK0bMOMQPrAg0hHQsTeAxRLiZ54FGVqd70f8kcTp26urkkuDsy21V
         tvUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=VyvOiEa44h873tWuWSnwTmHKgUr6NGdKQeQ8EfJZ9p8=;
        b=I3zAVPxQZZC8a5gQtywM6sKFn5nY9dgpH39H8rcsOjgGI2vPN7laVNlgqtNoaSx00e
         bY5AFG4eMHSQuyJ3pYoXH1nRuKtE+bauFfEWj2pXhWt60my+kKOYt/vqdroyWGXNIyQq
         5P/Ke8DseBp+Z072oAlsv2kuoTiEhFXc7QbDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=VyvOiEa44h873tWuWSnwTmHKgUr6NGdKQeQ8EfJZ9p8=;
        b=C7kPYCfuAuYBeAQjuquW0moS1r98SlU1kfIkXcLTIFFmJzk4+MkrxkUDNiENCHXThC
         075z094W/W21toKIVuWp2d8K+jTk3q4udSR6yUgj04o3iotjynBU76DH4h9BNM5dDCRP
         h4AVue88DQphMQAHO6YFQCO3kpwgTSacHF6lcMC4wQ+55UNUwJLVtzqKgZJJ6ZsJFwHO
         8v6RPQRwhGLnwVa4xgcp3aJJ5nF3qhAkAviJlVk/RN9c0Un86EW4McA0iBRnmKzvAxQM
         ayC5uxMT5oyU4sBsvSby6VdvGS8AS5BtqNvrVv2OpL7QFettKHpeuBFAbFvQrhmb8axh
         q5WA==
X-Gm-Message-State: APt69E0UmP5ssJ8Ya9+0tFYIO6PgzD454eWDgOiVkm9H9TQgyfAgqUfL
        +2weihCgH+TObnrfPMmaW7TpNCtosu3PBmo1XCfsRA==
X-Google-Smtp-Source: ADUXVKI/3jeNFj43sge/NkmEpAWsv4DGIgB8F7+E7iWmFhZMExHo0JwX7PfiByu+iO6ZKgiikBrl4ZNn3dwsLFv9SNo=
X-Received: by 2002:ab0:17d2:: with SMTP id p18-v6mr3716007uaf.121.1528911035757;
 Wed, 13 Jun 2018 10:30:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:9495:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 10:30:35
 -0700 (PDT)
In-Reply-To: <1528823348-30532-5-git-send-email-kramasub@codeaurora.org>
References: <1528823348-30532-1-git-send-email-kramasub@codeaurora.org> <1528823348-30532-5-git-send-email-kramasub@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 13 Jun 2018 10:30:35 -0700
X-Google-Sender-Auth: eV-erlP7e1K3B_6KgjQU3cE2cJ0
Message-ID: <CAD=FV=W05DBCbL9h_40wUJsgjaAxjDbWMp+BUNCkV+GH1JASwQ@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] arm64: dts: sdm845: Add support for an instance of
 I2C controller
To:     Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-i2c@vger.kernel.org,
        Evan Green <evgreen@chromium.org>, acourbot@chromium.org,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 12, 2018 at 10:09 AM, Karthikeyan Ramasubramanian
<kramasub@codeaurora.org> wrote:
> Add one instance of GENI based I2C master controller to enable testing
> I2C driver using EEPROM slave.
>
> Signed-off-by: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 19 +++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sdm845.dtsi    | 28 ++++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+)

Similar for to patch #3 in this series, let's move the discussion to
<https://patchwork.kernel.org/patch/10462687/> and
<https://patchwork.kernel.org/patch/10462683/>.

-Doug
