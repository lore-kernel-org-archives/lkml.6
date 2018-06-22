Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED9EAC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0A5123FAD
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:50:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0A5123FAD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752652AbeFVJuC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 05:50:02 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:33466 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751242AbeFVJuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 05:50:01 -0400
Received: by mail-ot0-f196.google.com with SMTP id h6-v6so6872338otj.0;
        Fri, 22 Jun 2018 02:50:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4z78ZTinj+MQvYO0TTtI/xZWXHuutMfmsU/LTy1MT9w=;
        b=VR/IwjjW0kw5LXlDuU7dL3WXGV1blB9GDrBpjTXki5uD9CUofJcE12dYVo8SmkwvpD
         MZ+tc3dP2cf4Qccq23WWTMiFBtuLcLAHOlLu+LrlV2fiPFfFkeoJUs/SypfHHcYBhcGx
         KoEQymcXc53aG7uRxC1lrJCVY5zhua7ExzNH78wnB4p2vkonkiPqEv+5I4xpAm0d06B3
         GMa2AObAIArU0sf6YILB/WS8SC7fRUXMl3K/r0rZiHn4rR3QG72QwTaBc7eg15vhGgyr
         H9L1dDMzefJgTWxM95SPjrJuCCZ/UCjp0vPpoW2y327IOKNDmbSWOqGk6D5SNl07sOud
         hAHg==
X-Gm-Message-State: APt69E0Rk+8A6118o2uZvovIaBkl7OrgTtBr40E1u+lPDQeCTangsjkA
        nU4T77Wr0mth4pRtKqiknAce23t3sepp2Z4VMHs=
X-Google-Smtp-Source: ADUXVKJkuXFzq5R4T/AjJUDDkedzUTp08l/Frz2ey2irMrCoi+Oi2b0bm6YpfbM8N5msdJQMHJj7zanWEtcWa4ujl0U=
X-Received: by 2002:a9d:56ec:: with SMTP id b41-v6mr442505otj.339.1529661000396;
 Fri, 22 Jun 2018 02:50:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180322202007.23088-1-malat@debian.org> <20180322202007.23088-17-malat@debian.org>
In-Reply-To: <20180322202007.23088-17-malat@debian.org>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Fri, 22 Jun 2018 11:49:49 +0200
Message-ID: <CA+7wUsxFJqjnygdg0a84QYktFGMUYeSiGD6=Ld3O06QsZkgG9g@mail.gmail.com>
Subject: Re: [PATCH 16/19] powerpc/powermac: Add missing include of header pmac.h
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>, kvm-ppc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This one is also ok.

On Thu, Mar 22, 2018 at 9:21 PM Mathieu Malaterre <malat@debian.org> wrote:
>
> The header `pmac.h` was not included, leading to the following warnings,
> treated as error with W=1:
>
>   arch/powerpc/platforms/powermac/time.c:69:13: error: no previous prototype for ‘pmac_time_init’ [-Werror=missing-prototypes]
>   arch/powerpc/platforms/powermac/time.c:207:15: error: no previous prototype for ‘pmac_get_boot_time’ [-Werror=missing-prototypes]
>   arch/powerpc/platforms/powermac/time.c:222:6: error: no previous prototype for ‘pmac_get_rtc_time’ [-Werror=missing-prototypes]
>   arch/powerpc/platforms/powermac/time.c:240:5: error: no previous prototype for ‘pmac_set_rtc_time’ [-Werror=missing-prototypes]
>   arch/powerpc/platforms/powermac/time.c:259:12: error: no previous prototype for ‘via_calibrate_decr’ [-Werror=missing-prototypes]
>   arch/powerpc/platforms/powermac/time.c:311:13: error: no previous prototype for ‘pmac_calibrate_decr’ [-Werror=missing-prototypes]
>
> The function `via_calibrate_decr` was made static to silence a warning.
>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>  arch/powerpc/platforms/powermac/time.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/platforms/powermac/time.c b/arch/powerpc/platforms/powermac/time.c
> index 274af6fa388e..5cc6fa40fcc4 100644
> --- a/arch/powerpc/platforms/powermac/time.c
> +++ b/arch/powerpc/platforms/powermac/time.c
> @@ -34,6 +34,8 @@
>  #include <asm/nvram.h>
>  #include <asm/smu.h>
>
> +#include "pmac.h"
> +
>  #undef DEBUG
>
>  #ifdef DEBUG
> @@ -256,7 +258,7 @@ int pmac_set_rtc_time(struct rtc_time *tm)
>   * Calibrate the decrementer register using VIA timer 1.
>   * This is used both on powermacs and CHRP machines.
>   */
> -int __init via_calibrate_decr(void)
> +static int __init via_calibrate_decr(void)
>  {
>         struct device_node *vias;
>         volatile unsigned char __iomem *via;
> --
> 2.11.0
>
