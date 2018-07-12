Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69982C476E8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23B3A20842
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="kaqRUP81";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L3C71xn5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23B3A20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732522AbeGLR0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 13:26:15 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:42664 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbeGLR0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 13:26:15 -0400
Received: by mail-vk0-f65.google.com with SMTP id t4-v6so16653431vke.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 10:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=YYiSlz0Wkyrm77lIMGDpvJWBOeQvsof50ruEHd8VCrc=;
        b=kaqRUP817toUkpqle5B3I7WCUovQgCtztzGU875qiZFSZzgLc4N2Cs8XQrXo/VPJ1i
         k20ZFEE9U2MMRVY+ACL0/lL7RndAHIM4amPfz2J2EImgksuiXhWDnq2n5ztpmYxMmHmn
         NMROMEbqBLSCvfGtZBEbnzaI5sBxwHFLYMUAYPeGWhFlnvQusYjPoFlP+LFZL1JzY4jn
         xZnVNLP9c1QsN9FdQHhXgJkfiqjodZtCZVbfAxwC4WI0B3H7ew0do//ZVxoFtWtV/6Qa
         IRAMwXcv5mzeT+ADpdcqSFz+V04VihjG1T56wl3MnIxTQKqj0fDrDS5A5qlFT9OCsnCX
         7Jhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=YYiSlz0Wkyrm77lIMGDpvJWBOeQvsof50ruEHd8VCrc=;
        b=L3C71xn5ujPAzPT+z3ULUa/kJM8W8p5IU6Kd4VpbJYW8T5WZs5qxPNKNswfKSJ2lVb
         tu+4On9KbRuL9GnvTfVpGxK5NLjGF0y67TFmYzE/B8NbEnR1p4xupWKIYJd0GaBS495h
         mw6hjZ9d/prQHP7BgXAlKDvBIFM3YityQG7t8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=YYiSlz0Wkyrm77lIMGDpvJWBOeQvsof50ruEHd8VCrc=;
        b=m087GJn3UY7SNgJoTBeoDxkqTKTZsXO1h2ltd6fV6YVI6fM8BaN+By0qGDcUMzhpzs
         ww+3Oie7RB+KKHD2NubdySOy5V+q6jwsbrERfDz5TBpUEwWtXtrw28F2jflA8aHhBQm5
         BknM0MnNJxzdkN/wmEf9wZEy1/vG565KJZ3LPwt0U7Y7qJlEdI+KQZiRL1zCR71cslyb
         NK8WH/Q0GTmkYyuxllsk/TOMJi3p5t9gfELdV4LmvLM3WtxxRWkeuY0VIlQjvA+o95Pb
         m8lLhgegAQNAT9y9/16EksvLH6W2bQ2R3Ra46q7Dkg1nNPCGEqwTb6bahVeuFwTMnb6S
         HsxA==
X-Gm-Message-State: AOUpUlGjyJcEu4gJDb1KFjPPv39yU9f5+CBBovAE4eYaj2lebQXqIYiZ
        W2jwlxa98pt3TMqkKUddhN/x426zaLi8IcSb9mLEQw==
X-Google-Smtp-Source: AAOMgpeSxe80rGxtnbzeitJKErxCig8tXwUJY68m+B082ojuoNBi7ByKQiZMb5b51xQ8iVO4kAwKfJOAtoxck3by/rA=
X-Received: by 2002:a1f:5347:: with SMTP id h68-v6mr1719655vkb.141.1531415746308;
 Thu, 12 Jul 2018 10:15:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:9495:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 10:15:45
 -0700 (PDT)
In-Reply-To: <a385dfac661b04befd221f3012b2ca56576aada9.1531384019.git.amit.kucheria@linaro.org>
References: <cover.1531384019.git.amit.kucheria@linaro.org> <a385dfac661b04befd221f3012b2ca56576aada9.1531384019.git.amit.kucheria@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 12 Jul 2018 10:15:45 -0700
X-Google-Sender-Auth: 2yZh3WlKGbgPjHJBmqiZuaB-A2E
Message-ID: <CAD=FV=V42W417=WD9Xh4naf3fMd_sZvG6=DtKqCTSsofZFSckQ@mail.gmail.com>
Subject: Re: [PATCH v7 5/7] dt: thermal: tsens: Document the fallback DT
 property for v2 of TSENS IP
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        smohanad@codeaurora.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 12, 2018 at 1:39 AM, Amit Kucheria <amit.kucheria@linaro.org> wrote:
> We want to create common code for v2 of the TSENS IP block that is used in
> a large number of Qualcomm SoCs. "qcom,tsens-v2" should be able to handle
> most of the common functionality start with a common get_temp() function.
>
> It is also necessary to split out the memory regions for the TM and SROT
> register banks because their offsets are not constant across SoC families.
>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  .../devicetree/bindings/thermal/qcom-tsens.txt     | 31 +++++++++++++++++-----
>  1 file changed, 25 insertions(+), 6 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
