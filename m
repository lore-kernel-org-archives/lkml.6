Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C94C6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60CC92086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nisSlecL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60CC92086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbeLKVeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 16:34:02 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37762 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbeLKVeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 16:34:02 -0500
Received: by mail-pf1-f195.google.com with SMTP id y126so7758762pfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 13:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:message-id:to
         :subject:from:user-agent:references:cc:date;
        bh=E4R2jPN8BgUUXI+O6RuHCvvD+UsR9iKyuijRiIMusL0=;
        b=nisSlecLCIrGMR16p22AAORccojOBRloSPVe31x8D61drwztFWVvsMNXg+1ERXYoOd
         c/BfkyOVmee1oOepn974wqbNWeQVOxyEw9TVRhuhxVqyYmA7jKtDcL/NhqidbuK8jTzn
         Zkk95jEQY4pJbloQYmrUxLd2trgl6BPKvWDSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:message-id:to:subject:from:user-agent:references:cc
         :date;
        bh=E4R2jPN8BgUUXI+O6RuHCvvD+UsR9iKyuijRiIMusL0=;
        b=nj7nLPgnoZHaQWOf5yEd3j7sZXnvJB8h64Hv2vT7KqYNbfAm1MqT1ZDQNJYPymS6wA
         z2u730Nv6SHdalZjnBNIK6dMM5qga6Zx6R8+zJ6dbSAZ0m/3YMN2YwzkCQIrBOVnVn6j
         AbB1v5DgCk87NPt41vIlFsD7FnpwFzsqcWpiZz2KF1pHzoz+GJiCe4UoLUNr061VY9yw
         pBYBXkEyOVltVIT3IIj7b4FVgMTM6+Et56acBOCfMDS6gTqaru8abfrL7L6hzEYhcjZ7
         5b2SjpiKBjjdgqJ9Z+nzUMQdDtILtcBTfFYW3X8E1LaEmfnNE9yEsuIiD5DP/D9v66Ke
         YYDw==
X-Gm-Message-State: AA+aEWYj0A4Ibw7e51yH9nChbb6v5IM/nIR/EOsYbdz/g6BCvQuhgTUA
        etLAQAw8axj4lsTlOf918IDkMQ==
X-Google-Smtp-Source: AFSGD/WgYt6ZtO80El7nxptBioQkpVSW4/0+zOQuEPCt5RtVyNGnuDM6VugX5Hn8g2uqt2g6kKHKyw==
X-Received: by 2002:a62:113:: with SMTP id 19mr17604773pfb.176.1544564041486;
        Tue, 11 Dec 2018 13:34:01 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id q75sm21152446pfa.38.2018.12.11.13.34.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 13:34:00 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181211094938.25086-10-rnayak@codeaurora.org>
Message-ID: <154456404022.17204.16925201479684260162@swboyd.mtv.corp.google.com>
To:     Rajendra Nayak <rnayak@codeaurora.org>, andy.gross@linaro.org,
        collinsd@codeaurora.org, mka@chromium.org, robh@kernel.org,
        ulf.hansson@linaro.org, viresh.kumar@linaro.org
Subject: Re: [PATCH v6 09/10] soc: qcom: rpmpd: Use simple_opp_to_performance_state() helper
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.7
References: <20181211094938.25086-1-rnayak@codeaurora.org> <20181211094938.25086-10-rnayak@codeaurora.org>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Date:   Tue, 11 Dec 2018 13:34:00 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajendra Nayak (2018-12-11 01:49:37)
> Get rid of the duplicate code across rpmpd and rpmhpd to read the
> performance state value from Device tree and use the
> simple_opp_to_performance_state() helper instead.
>=20
> Suggested-by: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

