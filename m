Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09046C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA5FD2064E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rMhs0zSL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA5FD2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbeJIS0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:26:15 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34166 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbeJIS0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:26:15 -0400
Received: by mail-ot1-f66.google.com with SMTP id i12-v6so1175924otl.1;
        Tue, 09 Oct 2018 04:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Au8/ydA/7QtQmXFjgivVts11SWfsBqDEN6Zjj7iS9Fg=;
        b=rMhs0zSLSed5ecrRmaQJT04qItLiiIbU+cBXxG2f/THbBMPz04nhMDBEiDlveQU++w
         qjnnzIng1RX9TfuReDvLWgz9G7CV1SXpoeGu3EspEXfLEH/8Z8SRfHvkOKD3KnO3xg6a
         8n6OvA1fLuKkCWJqZj/M4vjxwvIqcF3YvC+Vf4hzYgG6kX64ixQUasle7Pa23Z6/peuu
         836BdbZGGRwlmQnCV1gfS2Va8gvzIsCXhsFPtbjmnJxfq3ERsxeqn6XcO75kZs5XJzFk
         nigCh+TMXS4GOE+aHQ65yCzb2BZREg7BVxMZqB8F5i19FF8CeP3hMNBs57lGH1O99ZJt
         A8wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Au8/ydA/7QtQmXFjgivVts11SWfsBqDEN6Zjj7iS9Fg=;
        b=gBn3Cls680doPkQ3Sq6FIg6RoURq1pbhMcZ4K0AbhtBy0tBxWK+ouOCoT5YOHrmdKD
         hOIHm7D7ZWE2SuO2YcE/l048/+kRbs8sL+jEr5ULjBRl49pvEurDE+pINzYbEc+dxC0z
         /ZvkZuwvJvCc1NZ5Ir5bZTnNPJ7DPkPC3S8EcvDac62KVJxBr7RSVxArgSQwWA5xC/eU
         NQcU2aRm6aco5UToHKNb+eAVvz7fvI4yIdC3LKcj6xXiJpmzJD2qTynJ8u5rnrm/84hK
         vnO9dWjPMAy7mJCZYs4EesclCxjeVpIgpy4ea4sFENMXwpLhwmF2yqU3J5JIVm2HzfIL
         85kA==
X-Gm-Message-State: ABuFfohlxQVsTb5UC8lsbgiLov0rQDk3w/zhfLn/U6DmW6WkPWqe27N8
        BDX+iKJfWSAUI+H2KSUHimjlpuEtal1BJxafYccCxw==
X-Google-Smtp-Source: ACcGV62KgdnN87wALr/P9t+WvPvOSQXbPAw6B/zTj4Sjz8kwyvYMAyhp7ugm4/rvmHe/IClxtybFly9cZoKEqxsZsaY=
X-Received: by 2002:a9d:2f23:: with SMTP id h32-v6mr619096otb.255.1539083389317;
 Tue, 09 Oct 2018 04:09:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180921152726.31742-1-lukma@denx.de> <20181009105028.17971-1-lukma@denx.de>
In-Reply-To: <20181009105028.17971-1-lukma@denx.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 9 Oct 2018 08:09:46 -0300
Message-ID: <CAOMZO5C86vXGAvcXxsTk3nJFf_J3eqVBkkgMG13VGOqO=MJFOw@mail.gmail.com>
Subject: Re: [PATCH v3] ARM: dts: Add support for Liebherr's BK4 device (vf610 based)
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        Fabio Estevam <fabio.estevam@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 9, 2018 at 7:50 AM Lukasz Majewski <lukma@denx.de> wrote:
>
> This commit adds DTS support for BK4 device from Liebherr. It
> uses vf610 SoC from NXP.
>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
