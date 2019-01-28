Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B1EC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EC0020882
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548699552;
	bh=ybtKNwUH8KqTEdjyylST+lBXgtVYewq5pouDiI/HbNI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XNEmrGLNRlhVDQxbZP657Fp/0mogw8alcTnFuuWEKPUJCJX9ck62iFuyRt5AmyaZD
	 Z3+pHwKMoO4RzcDwxmuz8lqYY+sDQkfzUfBm0P5kHrzPt+xfWmDppJ88dPsv14nx1s
	 0/BNTjhRfoDCn3f3fLXLDy6T2yRpKoKa9o/WJQjU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfA1STK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:19:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:57282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbfA1STK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:19:10 -0500
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58B0B2147A;
        Mon, 28 Jan 2019 18:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548699549;
        bh=ybtKNwUH8KqTEdjyylST+lBXgtVYewq5pouDiI/HbNI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=v7r8IPr3C7dVJSiprjMEMLZxnqCGQ6ilu5s4hJte9Y3TG5E+TGkuiosCZ94gTfd9A
         HF/wwryLxr9g3FOXStFFTHI5P29CYpkPM+wKhtSSB3WhfSERt74+VNDOIyNWdHHisz
         igdzUaQAMFxvfIVPmHvD2bxu8Or/EnIiXoTJdTUw=
Received: by mail-qt1-f179.google.com with SMTP id y20so19269024qtm.13;
        Mon, 28 Jan 2019 10:19:09 -0800 (PST)
X-Gm-Message-State: AJcUukcXQKfmv+pwKB4S1hiCBkglkvdiugfG1VY50cMda7uqw7yTxCXZ
        y3dK8dX5p7IaPZgnPErUg+TEi4+I5BHWvFL/QQ==
X-Google-Smtp-Source: ALg8bN6NNzpWZl1FFvBPYsTfOFx6UuI0OdRzlL2RIaQG/V5hGeekVe6Vu+tLPT6Tiflwk2tIbb4fFx4o24H78Z6VtT0=
X-Received: by 2002:a0c:e2ca:: with SMTP id t10mr21970119qvl.77.1548699548605;
 Mon, 28 Jan 2019 10:19:08 -0800 (PST)
MIME-Version: 1.0
References: <20190124145309.21698-1-ben.whitten@lairdtech.com> <20190124145309.21698-3-ben.whitten@lairdtech.com>
In-Reply-To: <20190124145309.21698-3-ben.whitten@lairdtech.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 28 Jan 2019 12:18:57 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJNtWswQ9=86NdbviKCeTgyF8QGVxvMptNjvGmR8gP-Zg@mail.gmail.com>
Message-ID: <CAL_JsqJNtWswQ9=86NdbviKCeTgyF8QGVxvMptNjvGmR8gP-Zg@mail.gmail.com>
Subject: Re: [PATCH v3 lora-next 2/4] dt-bindings: lora: sx125x: add basic documentation
To:     Ben Whitten <ben.whitten@gmail.com>
Cc:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        David Miller <davem@davemloft.net>,
        Mark Rutland <mark.rutland@arm.com>,
        netdev <netdev@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-lpwan@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 8:53 AM Ben Whitten <ben.whitten@gmail.com> wrote:
>
> From: Ben Whitten <ben.whitten@gmail.com>
>
> The SX125x family are IQ radio transceivers from Semtech configured over
> SPI, they are typically connected to an SX130x series concentrator however
> may be connected to a host directly.
>
> Required properties include the radio number of the host or concentrator
> bus.
>
> Signed-off-by: Ben Whitten <ben.whitten@gmail.com>
> ---
> v2 -> v3:
> * Renamed example node name to be consistent with concentrator
> v1 -> v2:
> * Dropped spi-max-frequency binding
> * Wording changes to commit and descriptions
> * Added spi wrapper suggested by Rob H
> * Dual licence
> ---
>  .../bindings/net/lora/semtech,sx125x.yaml     | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/lora/semtech,sx125x.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
