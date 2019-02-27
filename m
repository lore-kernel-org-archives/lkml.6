Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3329AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 06:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0CE2218D9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 06:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NdpavKz6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729930AbfB0GdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 01:33:16 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45354 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728930AbfB0GdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 01:33:15 -0500
Received: by mail-pg1-f196.google.com with SMTP id y4so7422792pgc.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 22:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Eqf/+uqpeAO6UH5WgS+NXlMaq5lKEuQnmqJ2CT9DPM=;
        b=NdpavKz6ISpY+J6gJjDrBUST39MIbLCS36oEHLI0V7pOnW5bt8myGc+kiJmBKMV3uA
         RzkNTvOmw7XfqKYSI50qFv850oSiXb9IjSg1PV+/hW/QxfF1CdLZL2DvGs0kxfud4XT3
         KTx9Y4qXU0OXP+lcQa0fiifKVwbdbG/E8VO1HGE6GfYQGkmTUp1g8n7afZzBmWztt8kX
         tm3rUNZuFqllIIUFARXtHvDNRDFpOpDkZYtvCCw+x5t2ZRl9zjzXBXxFn4Ok8uT+lyvm
         TtfPRASs7McsponB05HGzbcBlgQEG46G/uWCDCe59Dk+NfxGF/1BBLlRbxkxrUgG5J/A
         EZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Eqf/+uqpeAO6UH5WgS+NXlMaq5lKEuQnmqJ2CT9DPM=;
        b=TXn/PteNntIa2+DUgg9mBO3JrHR9lPh+eOZiRC8cEaYj9SdzlF0cenV5SmqoWgwGDu
         1lY0GYZRRKM7pCHt0E5Dq1W186zCP2pJiNPS/TpEUBmoFfn+2kOBO6NPvJqqPXwTxD+8
         +ExmmLblW9aPw4v7J3ccWfzs/UQljFFJ3H2jdQ6do/B8lyrd/FMpJ00n2IM9QTIY+u9z
         70rfbMg0nHKwI5akPmqomX1hdD3PL4YrlzB4hJyw0Qs/c2cgeK4/yc154R9pYTACmFCz
         CM6R353+kKPNZsk/12DszoNhE1QbAoBiFIJ1BzOOI/GLQCUQnVCTEMIASewqAyXvLZdP
         fjpA==
X-Gm-Message-State: AHQUAubZDyMSMlGRwICKB2CYc/yYWksR/AelUo4fFjOUZX+UKu72aqN2
        ZY+I9mCvf+YTVzAgB0vfFD67sP8v1dt8Km0uG9mnng==
X-Google-Smtp-Source: AHgI3IYB1ClU34t8GMG3z0JI3SnWMGRmB+v2nBZNMbCkmbkeF/RtBNeNLSZQmMTNEai2FPUzW3IsUCF2XaSb4nhjUko=
X-Received: by 2002:a65:6483:: with SMTP id e3mr1435780pgv.273.1551249194720;
 Tue, 26 Feb 2019 22:33:14 -0800 (PST)
MIME-Version: 1.0
References: <20190226194647.146078-1-mka@chromium.org>
In-Reply-To: <20190226194647.146078-1-mka@chromium.org>
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
Date:   Tue, 26 Feb 2019 22:33:03 -0800
Message-ID: <CAOCOHw4sPXTuKEMxRxVXTCE6s2wyyPSqxyOHaPMkUxpZWDThkw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Bluetooth: hci_qca: Add delay after power-off pulse
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Hemantg <hemantg@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 11:47 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Initialization of the QCA WCN3990 often fails at boot time:
>
>  [   15.205224] Bluetooth: hci0: setting up wcn3990
>  [   17.341062] Bluetooth: hci0: command 0xfc00 tx timeout
>  [   22.101453] ERROR: Bluetooth initialization failed
>  [   25.337740] Bluetooth: hci0: Reading QCA version information failed (-110)
>
> A short delay after sending a power-off pulse (which is done immediately
> before sending a power-on pulse) fixes this.
>
> Also move the delays to qca_send_power_pulse(), since they are directly
> related with sending the pulses. Change the interface of
> qca_send_power_pulse() to receive a boolean instead of a power pulse
> command, this improves readability of the function with the delays
> added.
>

For the series:

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Matthias Kaehlcke (3):
>   Bluetooth: hci_qca: Pass boolean 'on/off' to qca_send_power_pulse()
>   Bluetooth: hci_qca: Move boot delay to qca_send_power_pulse()
>   Bluetooth: hci_qca: Add delay after power-off pulse
>
>  drivers/bluetooth/hci_qca.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
>
> --
> 2.21.0.rc2.261.ga7da99ff1b-goog
>
