Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B01BC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9C60218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548347352;
	bh=oUVkLvLzOCg4mEZy4XJotoHmEuKxUxZKCX02acgwcTY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=n92IbsJN+pBmzyI5arWJB+Av2+n+Ci/QF6CMpi+rEu/eMq0ZlicoPN/vXQqfowTSG
	 /Up7ZMpQDN7oDCg/d2Ia9Quysb/vkdxSWSyWNMX4qydEalaA8T2NuUXj69b+3ad2wM
	 NauBZXkMJpiEc/bjdoNqsqAM2uNpMb/GjOKjN1SM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbfAXQ3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 11:29:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:37290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727573AbfAXQ3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 11:29:09 -0500
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E83B8218B0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 16:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548347349;
        bh=oUVkLvLzOCg4mEZy4XJotoHmEuKxUxZKCX02acgwcTY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P4es8OP+UCdHqmu1o15vUOfWECMW/MB+WNtMEdgk8tYYg7rTw779C/fnVmLrOZU1A
         /pqIwqoyzHEcdL+QGZ/TMd5MYThOlIHk7T00Yzd8cGaEPrjDy3EIzgOvuAkJunGsX5
         S4IEqSlTSbk9ikXaV/pOIT2+aoCuctL1cbSaOBSg=
Received: by mail-qt1-f169.google.com with SMTP id p17so7262689qtl.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 08:29:08 -0800 (PST)
X-Gm-Message-State: AJcUukcSU6cz9pV7/Ii795/m17KTLQj2zg9jTQg9Pv3TmF7qm39Jot1+
        dSIUfZ92+rhR1GEc3oMde0fq3k2DHvc0ZJ6JZA==
X-Google-Smtp-Source: ALg8bN5iVp3AYNN5zaaTrmaDZq9BJXh0wqoJQzSpqg/3e/KijRnVqWVxlC1YR2U2Q+yyFqyypLOYSYdKxBxgky6Gvqc=
X-Received: by 2002:a0c:e2ca:: with SMTP id t10mr6866647qvl.77.1548347348122;
 Thu, 24 Jan 2019 08:29:08 -0800 (PST)
MIME-Version: 1.0
References: <20190124121703.2337-1-abrodkin@synopsys.com>
In-Reply-To: <20190124121703.2337-1-abrodkin@synopsys.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 24 Jan 2019 10:28:57 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLfe0YN9ytYfE=quuqSpNgavGhr5rDc42SirrUfYXO66g@mail.gmail.com>
Message-ID: <CAL_JsqLfe0YN9ytYfE=quuqSpNgavGhr5rDc42SirrUfYXO66g@mail.gmail.com>
Subject: Re: [PATCH v2] ARC: [scripted] fix node name and address spelling
To:     Alexey Brodkin <alexey.brodkin@synopsys.com>
Cc:     arcml <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 6:17 AM Alexey Brodkin
<alexey.brodkin@synopsys.com> wrote:
>
> From: Alexey Brodkin <alexey.brodkin@synopsys.com>
>
> 1. Remove "0x" prefix from unit-address of node names
> ----------------------->8------------------------
> sed -i 's/@0x/@/g' arch/arc/boot/dts/*.dts*
> ----------------------->8------------------------
>
> 2. Make all hex addresses lowercase:
> ----------------------->8------------------------
> sed -i 's/@\([0-9A-Za-z]*\)/@\L\1/g' arch/arc/boot/dts/*.dts*
> sed -i 's/0x\([0-9A-Za-z]*\)/0x\L\1/g' arch/arc/boot/dts/*.dts*
> ----------------------->8------------------------
>
> Inspired by [1] and the like.
>
> [1] http://kisskb.ellerman.id.au/kisskb/buildresult/13612017/
>
> Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> ---
>
> Changes v1 -> v2:
>
>  * Convert all hex addresses to lower-case [Rob]
>
>  arch/arc/boot/dts/abilis_tb100.dtsi    | 58 ++++++++++++++++----------------
>  arch/arc/boot/dts/abilis_tb100_dvk.dts | 14 ++++----
>  arch/arc/boot/dts/abilis_tb101.dtsi    | 58 ++++++++++++++++----------------
>  arch/arc/boot/dts/abilis_tb101_dvk.dts | 14 ++++----
>  arch/arc/boot/dts/abilis_tb10x.dtsi    | 60 +++++++++++++++++-----------------
>  arch/arc/boot/dts/axc001.dtsi          |  6 ++--
>  arch/arc/boot/dts/axc003.dtsi          | 16 ++++-----
>  arch/arc/boot/dts/axc003_idu.dtsi      | 16 ++++-----
>  arch/arc/boot/dts/axs10x_mb.dtsi       | 22 ++++++-------
>  arch/arc/boot/dts/hsdk.dts             |  4 +--
>  arch/arc/boot/dts/vdk_axc003.dtsi      |  4 +--
>  arch/arc/boot/dts/vdk_axc003_idu.dtsi  |  4 +--
>  arch/arc/boot/dts/vdk_axs10x_mb.dtsi   | 18 +++++-----
>  13 files changed, 147 insertions(+), 147 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
