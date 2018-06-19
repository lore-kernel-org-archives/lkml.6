Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC9BC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4714A205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="PdNEWqGa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HeKmn5c+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4714A205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966915AbeFSPsT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:48:19 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:40826 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966449AbeFSPsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:48:15 -0400
Received: by mail-ua0-f195.google.com with SMTP id l11-v6so104586uak.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 08:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=si1rY/Wi265qBgJxvcGA+SYRygmkY/Nzwi+P9V/26ik=;
        b=PdNEWqGaALogSI9YhgxJ3KTsx3RhT60GRUaLugMNze4IR8LEJhCu+cElxQWLnM/7G5
         YOuycvVKhkFyby+WhuPq34YuVdJqf6nGNVru+BQKPQrA85Hlq/u7aqpA8FeLpwAHlQtk
         U+6Sz1Snjzc2Wal3ye/MIKfcuLlY2JmORG8RqNT7ZqWBZiVnkY6+uuUi7l1WA3ddbKGz
         wjP2M9swhq+k3DVjgcgIPfDtLDcRvTxbwsO1mewet0NAMWskTD6fb/4QQB45M/69wA88
         6ahdpbvgr0QEv2Tf6weYr3hoapU5JBOeRsmxv/K9Tq1QqxpnVhxM1TEssts4reRRlinW
         U0xA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=si1rY/Wi265qBgJxvcGA+SYRygmkY/Nzwi+P9V/26ik=;
        b=HeKmn5c+uywfWCrw7+Hzel6TQWTrxc3ABHoYWgj7XBBagrrokUw3Qoj+1xG0XydFI2
         1jXDBT8ZO2orVO+TTPGoi4ciXBh5wbBn//O+ybUa80580SgBdkE5X6DBJsfzBlOHR/5J
         GhSbx3ggMrUw6BhW3ijAZFe5WQ+3t6qTGWbwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=si1rY/Wi265qBgJxvcGA+SYRygmkY/Nzwi+P9V/26ik=;
        b=hF7mTlHUeHPauW6I0DNVOUe+uzyK/nYTnmjpCWXAtHqnZC8fx23wwcFP2NiACUbKny
         AP1YUlvFYHh3W2fNdvoXtmrlYuFiTmXEvniuvDyeWHXXTMtM8JLDGADIdUSFhlVgIyRI
         1AWT/aGtgX0NILx/Wd5t5MgCie2UZrzzulg6XJLP2snhZ4oQR1cbX2NVBN25rd/cE1Vo
         89N7NVViSoVlX2Ax6KLO/Ju/HLKjY1rXvaE1vt2TwmhmXUgQQhuUcbaf0n6I7aZmMbXY
         xI+dQ3Wz87daO7TGIIywq2L8s0GmUZRSok4q+Dhl4dzEWccil4M5DcF5D60HBIDef10q
         jrHA==
X-Gm-Message-State: APt69E23Msdaeqruertws96X7GO52rqaDobKTCNzzt6FF6CshU1XoOTi
        rTD0lxO5gJS3VSGc80mD5L/92h32g+F1H+vDg3USbA==
X-Google-Smtp-Source: ADUXVKLGaCpiBze+Y9FDbaBpGqY9IqwPdoDwdoFXguGT66e7HqKBJBk2g3cQzfFlTUFKekn1BXUtnGMwEKJgGAsemKg=
X-Received: by 2002:ab0:47d0:: with SMTP id w16-v6mr10813713uac.20.1529423294349;
 Tue, 19 Jun 2018 08:48:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:9495:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 08:48:13
 -0700 (PDT)
In-Reply-To: <20180618205255.246104-4-swboyd@chromium.org>
References: <20180618205255.246104-1-swboyd@chromium.org> <20180618205255.246104-4-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 19 Jun 2018 08:48:13 -0700
X-Google-Sender-Auth: Vxg2Z1JzGmEgeUOYQmc5W9bz2Lo
Message-ID: <CAD=FV=VfGkOepP3KgYXZLq5esy6rWLr8zf8xiYoPOPN5vmCgGA@mail.gmail.com>
Subject: Re: [PATCH 3/3] pinctrl: msm: Configure interrupts as input and gpio mode
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 18, 2018 at 1:52 PM, Stephen Boyd <swboyd@chromium.org> wrote:
> When requesting a gpio as an interrupt, we should make sure to mux the
> pin as the GPIO function and configure it to be an input so that various
> functions or output signals don't affect the interrupt state of the pin.
> So far, we've relied on pinmux configurations in DT to handle this, but
> let's explicitly configure this in the code so that DT implementers
> don't have to get this part right.
>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/pinctrl/qcom/pinctrl-msm.c | 37 ++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)

This seems like a reasonable idea to me.  I'm not a huge fan of all
the boilerplate code copied from gpiochip_irq_reqres() and
gpiochip_irq_relres(), but it looks like that's the way it's done at
the moment.  Thus:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
