Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Uds0OPhiGVsEZAAAmS7hNA
	; Thu, 07 Jun 2018 16:55:25 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 695F5607E7; Thu,  7 Jun 2018 16:55:25 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klY7oAG/"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id EFDA860115;
	Thu,  7 Jun 2018 16:55:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EFDA860115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934336AbeFGQzX (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:55:23 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:40528 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934365AbeFGQzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 12:55:19 -0400
Received: by mail-pf0-f196.google.com with SMTP id z24-v6so5200917pfe.7;
        Thu, 07 Jun 2018 09:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aBid5YyZ6egphb25/1IoadslkDcJ6RfN2payxMAwW10=;
        b=klY7oAG/mGYnbByNldCX0xGBPN7XH4cmz/kNr8fCmC4Dz9HIUJTtpEiRzgb+3gJlJ/
         TjKOdDf7KZZN2DtxjtLKNeOhMmqNtgfxbisZoM9c7NTUR4G0Jb/1yJcZpEAyocrhLaus
         OtV1mmYag4OuigJCdI1YBEyNgmEYTF2eVLB/P0qarBcCsydm8o4WYgCXuwntJ+OBiHz+
         M88QFeMstIi+kxvXJ3pHqG+b05uJxCbisLNUgrhTOpO3/EppgaiDL7Dm+z3ewtvq+zYM
         J/h7YZPdU8UNcWteShftg/JEib3xgEnhQHwwTa1BtlejLOGRh6X2ZTdIJAsyx4rObVJ7
         4n+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aBid5YyZ6egphb25/1IoadslkDcJ6RfN2payxMAwW10=;
        b=SuDJJifZ+jUNf2Q46A4VPek4QUS3iNCh9kJ/JxHGNgiHnccJxZX/QyV2N39K2xkBUy
         CQqVDdTvIeaQgsNaI1Cn4+vyjRIltNyH6tVaE9l3NPEpHBOglPdfYyhNWV8BN25R818V
         j3GFtpIKkVCKNQzozgpFwe0UTq1l/iUNevL6EaM/uYjOLBiPDnd6/vdvQ9xoIdnYTX41
         jWkA5EIxj5FyfkY5vCYrGWfyE2SA9Tg9wtxdWL0foOEFYheBQ73epl9pSvFweleAjuzC
         pvSsRNf6B4YN5Ifv7xK8alTvzN740tag+LfhJ3tBa27lkd0YXEsSlkiTJuSfRi5KNWem
         BTAQ==
X-Gm-Message-State: APt69E1+YeBGlO84J1MNluCmF1lldoLwm2KDtV9A5AjY9QDTzWOONV1v
        cFO1FqN9oNnMbRkrtT9mYS8=
X-Google-Smtp-Source: ADUXVKJxPlqqyr2CZIlQw1UEltLsnCVLZmsw3EmVm4IPPImeisGswqzpTt1nQ/Nk1Hphkxo0QtGpxg==
X-Received: by 2002:a62:ecdb:: with SMTP id e88-v6mr2545371pfm.16.1528390519227;
        Thu, 07 Jun 2018 09:55:19 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id r26-v6sm71951202pfj.180.2018.06.07.09.55.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 09:55:18 -0700 (PDT)
From: Florian Fainelli <f.fainelli@gmail.com>
To: bcm-kernel-feedback-list@broadcom.com,
        Scott Branden <scott.branden@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Clement Peron <peron.clem@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Mohamed Ismail Abdul Packir Mohamed
        <mohamed-ismail.abdul@broadcom.com>
Subject: Re: [PATCH v2 1/1] ARM: dts: cygnus: enable iproc-hwrng
Date: Thu,  7 Jun 2018 09:55:16 -0700
Message-Id: <20180607165516.2089-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <1528309291-25579-1-git-send-email-scott.branden@broadcom.com>
References: <1528309291-25579-1-git-send-email-scott.branden@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  6 Jun 2018 11:21:31 -0700, Scott Branden <scott.branden@broadcom.com> wrote:
> From: Mohamed Ismail Abdul Packir Mohamed <mohamed-ismail.abdul@broadcom.com>
> 
> Enable the HW rng driver "iproc-rng200" for all cygnus platforms.
> 
> Signed-off-by: Mohamed Ismail Abdul Packir Mohamed <mohamed-ismail.abdul@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> ---

Applied to devicetree/next, thanks!
--
Florian
