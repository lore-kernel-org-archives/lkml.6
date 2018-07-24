Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95A7ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86F1A20874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9giYCcK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86F1A20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388488AbeGXRzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:55:20 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:33689 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388366AbeGXRzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:55:20 -0400
Received: by mail-yw0-f196.google.com with SMTP id c135-v6so1781231ywa.0;
        Tue, 24 Jul 2018 09:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4osEqmHfFW6eorHBKgXcnpl7P0iPuLxKk27eYCPoeVo=;
        b=b9giYCcKu9F4v3s9KtSs+LdkJFS578GjWS7EFcMedKCdaDATCGcnggy77O+E8bUTCz
         NItLVZXQp7qvFB3aYDfzG18UhjijTVwTCU2llOFf8FKy0LAjrpVSEFfxK+YxQ4PmmRSN
         SFt/2S4uGGZ8uqkPG+uKtk+xMUjMPgSiDNYqoL0tVwYLZoMMUeFaxcFVv4G9nRC1lzqm
         Byj7xJxa8rJy8xRIANOj+yJWGjNasVekLy35KXCDMt1Mfx97doeKF5Iq1FJSzAWJpayw
         3dny76a/BZRzp54ZHA4zo9+qQ0Sfnr4EPx7LArXxOQVFD2Isn1zBmeZs2+i+Vb7osyOx
         J4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=4osEqmHfFW6eorHBKgXcnpl7P0iPuLxKk27eYCPoeVo=;
        b=PGYYeRB+NQcJG+ncnQWr7jh7pXKBy49UiYHRLPyxdKAPOBWLHCkFzRgC/kDw4bJ2Qe
         sqab4W0qI2XqO8SFcvsjSSdD759kJO4QV21U3iJCzV+UDSkop1Jt8sZ2kv4l5xxV8Rlf
         z3vyv/bE8vboivieEdYKHTpVh2gitf5cTuJeFQnEgsjMYA4mY/y5MnzrlIOjuFLMDBPs
         FzYkWdfDsxhrwWKN51jrDdrp4m3RfuJ6xNQ9dVScgqWOlxLBjAEptWOXkpOXtxw98m+9
         G/9cZolCK6h2+RlDzuCiGvMNTqBLuk7sNDFJ8fx5WZvgki7Xu+LU8aH3QszfYhaemAvF
         MXlA==
X-Gm-Message-State: AOUpUlG8ogFEp6kirsExrYtza2DIY7JgSVvBsm/MsP+l/vzKtcTdSpB8
        ovd5+yTlqParYexDf33ZNWRqBmHE
X-Google-Smtp-Source: AAOMgpepYm/+jm8uzzUElkaBJQl1Pu8oYkb7+nhc+ch6WvdSlZGG/TtTK4VeItyqI1pBLDmFrHU8pA==
X-Received: by 2002:a81:2d57:: with SMTP id t84-v6mr9717524ywt.152.1532450879619;
        Tue, 24 Jul 2018 09:47:59 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2:c936])
        by smtp.gmail.com with ESMTPSA id u64-v6sm12992129ywu.107.2018.07.24.09.47.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 09:47:58 -0700 (PDT)
Date:   Tue, 24 Jul 2018 09:47:57 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     hdegoede@redhat.com, sfr@canb.auug.org.au, mperttunen@nvidia.com,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "ata: ahci_platform: convert kcalloc to
 devm_kcalloc"
Message-ID: <20180724164757.GO1934745@devbig577.frc2.facebook.com>
References: <1531824575-852-1-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531824575-852-1-git-send-email-clabbe@baylibre.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 10:49:35AM +0000, Corentin Labbe wrote:
> Since ahci_platform_put_resources() use target_pwrs after "devm_" freed
> it, we cannot use devm_kcalloc for allocating target_pwrs.
> 
> This reverts commit bd0038b1b4f499d814d8f33a55b1df5ea6cf3b85.
> 
> Reported-by: Mikko Perttunen <mperttunen@nvidia.com>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Applied to libata/for-4.19.  Sorry about the delay.

Thanks.

-- 
tejun
