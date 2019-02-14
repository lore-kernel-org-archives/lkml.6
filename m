Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CDDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 22:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 207F921B18
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 22:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550183249;
	bh=q6+izAjYkpJKumR76WP8XtF4rZPjRPQaG2hlvlgQ/OU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=uXth+GSXgcq0SBb1iLwhay7DtIg51V3HDRJ/A5fbQbC+KYmiWmnJfCyDR7z7sfvKU
	 ptpJpo/rdZptxEEB7ufVn7pDpoxTByw3zNR8YLePsFJEB+jjALQOR5wds3l8MdBNlp
	 xaZDn6kdy3vX3OoUGX13hppOzR00nTf9I8iGeUuE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408123AbfBNW10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 17:27:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:47950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406507AbfBNW0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 17:26:34 -0500
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52E4821872;
        Thu, 14 Feb 2019 22:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550183193;
        bh=q6+izAjYkpJKumR76WP8XtF4rZPjRPQaG2hlvlgQ/OU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lrtlQBPUuLJrf3eEXsWdXL6i1arwVyn0ny0KRZ2rceBEg+ZtHj8eg99skp+bDZ72J
         hoEeXwuHs9XpHqnYpUZKaKFwQICnGKSifYB4QUsyH4loKQnFWNr5QTHH47LTVxEu++
         MmztmiNfiTOZu5VHg8KgdgKisNPTc3AjgR4AV1yE=
Received: by mail-qk1-f171.google.com with SMTP id w204so4623638qka.2;
        Thu, 14 Feb 2019 14:26:33 -0800 (PST)
X-Gm-Message-State: AHQUAuYHfxjMlxeHHYT0cp61wLzGdTJMVcmr8iHS11gOMwIq2AqfTRMW
        L+OSSYSGPJmAcxTmY+XZHWFoObMuxIlW4202rA==
X-Google-Smtp-Source: AHgI3IbbExBUfuNOf+o0KBoR+Zzu+gAXVcHlaHJ+l6wSxlvWVm6ptjiEf1IzhG9L7wLSZxje2w3fKv1esiYVXY10ieA=
X-Received: by 2002:ae9:dc45:: with SMTP id q66mr4714547qkf.147.1550183192583;
 Thu, 14 Feb 2019 14:26:32 -0800 (PST)
MIME-Version: 1.0
References: <20190214175725.60462-1-ray.jui@broadcom.com> <20190214175725.60462-7-ray.jui@broadcom.com>
In-Reply-To: <20190214175725.60462-7-ray.jui@broadcom.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 14 Feb 2019 16:26:21 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ2sFc=K5tezmdcjLT9v7_5QFZ1F-azMdsXyjf=t7Zycw@mail.gmail.com>
Message-ID: <CAL_JsqJ2sFc=K5tezmdcjLT9v7_5QFZ1F-azMdsXyjf=t7Zycw@mail.gmail.com>
Subject: Re: [PATCH v5 6/8] dt-bindings: i2c: iproc: add "brcm,iproc-nic-i2c"
 compatible string
To:     Ray Jui <ray.jui@broadcom.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 11:58 AM Ray Jui <ray.jui@broadcom.com> wrote:
>
> From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
>
> Update iProc I2C binding document to add new compatible string
> "brcm,iproc-nic-i2c". Optional property "brcm,ape-hsls-addr-mask" is
> also added that allows configuration of the host view into the APE's
> address for "brcm,iproc-nic-i2c"
>
> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> ---
>  Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
