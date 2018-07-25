Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC816C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 911E720833
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Dxs3PkJC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WllO5pdt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 911E720833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731735AbeGZAgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 20:36:09 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:33558 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731584AbeGZAgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 20:36:08 -0400
Received: by mail-vk0-f66.google.com with SMTP id y70-v6so4657369vkc.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 16:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=4kVwTB8IZ6V1aNaWOFfmCp2xA+Vf2dAJQj610ioZ+fc=;
        b=Dxs3PkJCS1iwOvMMkTGY1l5eXVxWdABQenSBv3isjKIg1Yx9F8QzuTXmG0bRc9KPOP
         Fg2OrZx8bamfOlSmep04Ep08n9N3FbAzoe0k4I7z0996tohw4SZdpTllHuuS07vDzUfk
         UB5WoAfzc3D9UqhIzF7YyK0hAxL2A+9U8NrlsSs18Nts0Al+lTu7OqQbONKIhgLYVYcL
         GljRmgxuuQRk4Bc+BUxn9fsKdO15BjxpzEjO2WPqYM+NlAIrIuv93ffRtTg/5M55NaKn
         ZyxsAjkHRSgYP4OndJaW9FaqaX3myAtzmN1/GwmWNLtUKCmsbO2tI+tWhJRrGqvDJ88F
         3shg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=4kVwTB8IZ6V1aNaWOFfmCp2xA+Vf2dAJQj610ioZ+fc=;
        b=WllO5pdt+NWJ7hvcSJwivU7YDUrTxq25PGrKLzO7fAVDkuwhzgS+gTwW1w5xhhZuxD
         3yzgPMIFON75EpQWlTnr3d4SziXGl1suzwGQWhHNRIB3RA2/nSd1e2jEnYX0XuTUvuPJ
         kZQkUbl5ggX7TyhcJvk7yABYfSFxu5Hb6MZ9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=4kVwTB8IZ6V1aNaWOFfmCp2xA+Vf2dAJQj610ioZ+fc=;
        b=bqN8tvH8Nvje6CADQskBhWI38ycRKemlln5jeZtavZiX285gbcyykI4hzOlYydr85m
         S8U7LEA3As+bcADRtd8xWtenpqWISDpoMnS/vQPsO58NW4ls348BYL6WWEDFUDlMIHM1
         GCc5OagZ2+6WUyRnVRiNR84//kVK8Q+pxc3i5w4mJXWWeud4XBs2j8a0eeZQUBafrA+R
         +A7ME5aJP+I5GCp9G8YldwtkmmKPJ8aCsMuNZf1Kpy5Bu0m5e06Mo9w1ciIBV8vOx7Ok
         VZvVrCe6srFx39jkhb1GVtEmqeay8YXQIzPeyaFM6KWC4gvSLQ3sjTsuVwPmaRjlBSZS
         Ht6w==
X-Gm-Message-State: AOUpUlHsRoWfwgWoVkp2ZvTOWl23KIx1/KNCc2vap3go8nTJTtH2iIv2
        l74u8KgbyUqrmkV7RsgfpaWB4EQnDwNPN4hNHL+dnA==
X-Google-Smtp-Source: AAOMgpedv9Tyc7VAqBd1XLfcMqhaBANLJpktQtYpbpf2s4CHGljpSQeEaKi2iowMr4Fmt9fn4IktVqjbI+C5zmoIhLk=
X-Received: by 2002:a1f:ebc7:: with SMTP id j190-v6mr14505071vkh.114.1532560932079;
 Wed, 25 Jul 2018 16:22:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:cd5:0:0:0:0:0 with HTTP; Wed, 25 Jul 2018 16:22:11 -0700 (PDT)
In-Reply-To: <20180724235130.58592-1-mka@chromium.org>
References: <20180724235130.58592-1-mka@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 25 Jul 2018 16:22:11 -0700
X-Google-Sender-Auth: SLBEuCETY3MNcvI5yzhU_z6EBiA
Message-ID: <CAD=FV=WDtb_kpF261GgGjG-2-yo0HHySkdrWWqsNMyLOZZ+W3A@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: thermal: qcom-spmi-temp-alarm: Fix
 documentation of 'reg'
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 24, 2018 at 4:51 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> The documentation claims that the 'reg' property consists of two values,
> the SPMI address and the length of the controller's registers. However
> the SPMI bus to which it is added specifies "#size-cells = <0>;". Remove
> the controller register length from the documentation of the field and the
> example.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  .../devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt     | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
