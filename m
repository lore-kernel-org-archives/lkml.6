Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A199C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECDCE2229E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549906669;
	bh=4a1+y7vT6Q1B7WpEHHF/rwh9t7jJXODLy7CwHUvRklk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qN9bIARt/7vBelEylCm+iKMq0yvV/IeT1RK3k8RNbZaiaeAlWcDSqxZvUuaeiNaHy
	 FrzsLVA7sLPfUZEh25Ah0i7y6REovtqf+33RFaRsEIgoOjeyfW6dkx54Z3vBPmRSNl
	 Ls827IQVhkWvFeCDK0O9/J5nHWwLCO7VS8CkOfQ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732315AbfBKRhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 12:37:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:49982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731376AbfBKRhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 12:37:45 -0500
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73773222A0;
        Mon, 11 Feb 2019 17:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549906664;
        bh=4a1+y7vT6Q1B7WpEHHF/rwh9t7jJXODLy7CwHUvRklk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=r988kz9BtUbsSCh2sOH807x0GEF8uhvJad0uYCM31ariJmQYwb9cqTF1MlvWWin60
         fSd0MrJ5rQp+EX3HFv1Waa/jNSiG6PhaQFPUZFdp5rQAzxs12Vb1mssLLD/vF25bF/
         Y2yCkk1qi6iNyTFFw8jH+3fl5yQ5SHqhBoxx3iZI=
Received: by mail-qt1-f172.google.com with SMTP id r9so13136575qtt.3;
        Mon, 11 Feb 2019 09:37:44 -0800 (PST)
X-Gm-Message-State: AHQUAuYJNWXvQeI31pdn9Rb5ALP7FhD8MFjVEIOGOzPYrzavXWVIv8ih
        dGiDTfn9jmaU2jsDsZqbXfl9X2b7zFzPcaVlpQ==
X-Google-Smtp-Source: AHgI3IYZyPwSMnKPTAWIKJ024659CCHXHppHIP/fURrBtisnAfznyYJGruY6pXPoml4t9uD0ZUzH1d5sqRYpRI99M/w=
X-Received: by 2002:a0c:91bb:: with SMTP id n56mr8263252qvn.77.1549906663703;
 Mon, 11 Feb 2019 09:37:43 -0800 (PST)
MIME-Version: 1.0
References: <1549628749-30379-1-git-send-email-sugaya.taichi@socionext.com>
In-Reply-To: <1549628749-30379-1-git-send-email-sugaya.taichi@socionext.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 11 Feb 2019 11:37:28 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKofn_H0GE5JR8VEKdbf30iCK_QOyiaR1W=JxcCW7XJxA@mail.gmail.com>
Message-ID: <CAL_JsqKofn_H0GE5JR8VEKdbf30iCK_QOyiaR1W=JxcCW7XJxA@mail.gmail.com>
Subject: Re: [PATCH v2 02/15] dt-bindings: arm: Add SMP enable-method for Milbeaut
To:     Sugaya Taichi <sugaya.taichi@socionext.com>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 8, 2019 at 6:25 AM Sugaya Taichi
<sugaya.taichi@socionext.com> wrote:
>
> This adds a compatible string "socionext,milbeaut-m10v-smp"
> for Milbeaut M10V to the 32 bit ARM CPU device tree binding.
>
> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
> ---
>  Documentation/devicetree/bindings/arm/cpus.yaml | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Rob Herring <robh@kernel.org>
