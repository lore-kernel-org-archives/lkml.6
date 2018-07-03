Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668A1C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1927E24625
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:32:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1927E24625
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934496AbeGCTc3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 15:32:29 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:44386 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933196AbeGCTc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 15:32:26 -0400
Received: by mail-oi0-f65.google.com with SMTP id s198-v6so6099324oih.11;
        Tue, 03 Jul 2018 12:32:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gIGN36IUEMCStOLlmFeCJzWbXLac1ZeWJE7alWOPrVM=;
        b=qMwpBH+LkEKK2AJlA2/2l/K53SQjKYmL3s/qakhnY9iQYxjCPZSC2HmQnbmcX7j7hD
         r2Pp8GsdoxRQmtGAE1HrIY+v8ZhewRP0ShI7UrbRDt1p1U2LBpBvATpwiN81UpKG820e
         P5nCAxHhEDGtfk37lTRRBkGcdpUTpHW0/O9xjAPF52ZF5EsLMXTeurnzqfKiYDSCw6sj
         1/WXgd1FqLaUYH/oBxwyubZ5O0e8COxbx8StTzk9Au8xnv3Te6saiRLplTRfvZ6g2Tnc
         ZSENkUKa+oLCOcY9dI3xxib/mFLcscbUcJVzP/Y3wS0VnSVVwJhy1/5mxxxnDyyto3Kc
         FLmg==
X-Gm-Message-State: APt69E3b9/D7Ht0XqLWetd7Y9WO7YcRwfwMkX3fVJnT4y2sGAkHaTtGP
        Xx5ZkbTmpFSxCDwwyE9H4ssz+devm+S8M4BRNIM=
X-Google-Smtp-Source: AAOMgpeqDeuJ+WX9XvzawN3Ed6bH+RnsqAvEhFjV63D/CkiH0FZVbN3GAo7idsvKNs4g7zvEf6awDDiWsmRn/cYrVE0=
X-Received: by 2002:aca:5e07:: with SMTP id s7-v6mr22819060oib.353.1530646345795;
 Tue, 03 Jul 2018 12:32:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180703123214.23090-1-paul@crapouillou.net>
In-Reply-To: <20180703123214.23090-1-paul@crapouillou.net>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Tue, 3 Jul 2018 21:32:13 +0200
Message-ID: <CA+7wUsykjQkSHshNNVJaZJ4d_U9Q4fhaoRaNOTHhjoj43xRPLg@mail.gmail.com>
Subject: Re: [PATCH 00/14] dma-jz4780 improvements
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     vkoul@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        dansilsby@gmail.com, dmaengine@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 3, 2018 at 2:32 PM Paul Cercueil <paul@crapouillou.net> wrote:
>
> Hi,
>
> This set of patches by myself and Daniel extends the dma-jz4780 driver
> to support other SoCs (JZ4770, JZ4740, JZ4725B).
>
> Some fixes are also included, for proper residue reporting, which fixes
> errors with ALSA.
>
> Finally, the last two patches update the devicetree bindings for the
> JZ4780 SoC and add a binding for the JZ4770 SoC.
>
> This patchset was tested on JZ4780, JZ4770 and JZ4725B, but was not tested
> on the JZ4740, so it would be fantastic if somebody could test it there.

For the entire series, everything works as expected on JZ4780 (Creator
CI20), including reading from sdcard.

Tested-by: Mathieu Malaterre <malat@debian.org>

> Regards,
> -Paul
>
