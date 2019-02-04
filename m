Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13EE4C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6D902073D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549312050;
	bh=Qgosmz3c19ve/+XghqQRXAjVuEdEsze0qR1KCexpGgY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0CguA5AYBUOFPGgW7L/aP4qVOJUUQUnH9cRje+N5x4mmXqLokRnq9jKhykwKjR9tv
	 isBb+3OWo1ow1MqxJHXiWtIUpQSqv9QxNOuoSoRN8JpIegXpZEj/RX3geL8t2/M4ov
	 xke97t5r1N2bj1gnjvUs8MSWDdkNU7WivoA+y46g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbfBDU13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 15:27:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:54514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728622AbfBDU12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 15:27:28 -0500
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9280920815;
        Mon,  4 Feb 2019 20:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549312047;
        bh=Qgosmz3c19ve/+XghqQRXAjVuEdEsze0qR1KCexpGgY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ABpNwkJNZMwE7qvGnAIBi785oS9+Z/fIBP8OBJk+A1XReI7fXTAVtKCR7VP9afOSh
         +5a7YL0YlPEpoHHvugVM4t/DmgRhKeb8d3VvlhO/8NgVqR5R0MA/npKO3oopM7KwR5
         WZc5EqLor+Z/l/nOShoBhl27cXDfznaY/CvDvNfE=
Received: by mail-qt1-f171.google.com with SMTP id e5so1401015qtr.12;
        Mon, 04 Feb 2019 12:27:27 -0800 (PST)
X-Gm-Message-State: AHQUAuY+t16/mEbSk8QUhpflyKvwZI7CeN9bJq1rM4NoBqz680B1QvTK
        eZbshc4GMhcyKnyQ3ZWwAT9dUEZtC520/SDM4Q==
X-Google-Smtp-Source: AHgI3IZXuyQZ3BH0DX8+B/aa2Blt8W/P1/EvnnsNJD4igItDl+lGWau4d5e5svLRLYGVkA5Lp4JuM2QXPsNcuW93f6M=
X-Received: by 2002:ac8:1712:: with SMTP id w18mr976833qtj.76.1549312046833;
 Mon, 04 Feb 2019 12:27:26 -0800 (PST)
MIME-Version: 1.0
References: <20190204201906.8859-1-jgebben@sweptlaser.com> <20190204201906.8859-3-jgebben@sweptlaser.com>
In-Reply-To: <20190204201906.8859-3-jgebben@sweptlaser.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 4 Feb 2019 14:27:15 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+Qej8XWDhLXzKJFSpuS7vdadko1N=EDyL-ysNuP4THcg@mail.gmail.com>
Message-ID: <CAL_Jsq+Qej8XWDhLXzKJFSpuS7vdadko1N=EDyL-ysNuP4THcg@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] dt-bindings: Add LM96000 as a trivial device
To:     Jeremy Gebben <jgebben@sweptlaser.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux HWMON List <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 4, 2019 at 2:19 PM Jeremy Gebben <jgebben@sweptlaser.com> wrote:
>
> The LM96000 is a temperature sensor and fan controller based
> on the LM85.
>
> Signed-off-by: Jeremy Gebben <jgebben@sweptlaser.com>
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
