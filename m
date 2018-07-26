Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71044C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EDA22083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RJvdtN4C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EDA22083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbeGZIhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 04:37:08 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:34244 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbeGZIhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 04:37:07 -0400
Received: by mail-yb0-f194.google.com with SMTP id e9-v6so277075ybq.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 00:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1EbsPcZcjsDuY1dqnolyh+nbnPm1YrwAKtHrJd32bEs=;
        b=RJvdtN4CWuaRHatF6HpNHtCIrNB9v4cY413FmJa8CsqVIEHi5xEgqCrkU7bJiRcokS
         J/sRli/I1iaIXqwyIO8EInKDynFoBV6bMUrZYlad/JNbJKQrwgzaTyPItZqk/pbXhoAn
         AnrIylS5vdGKPusb0IsZ2IYH9KPFJZI5ZHdlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1EbsPcZcjsDuY1dqnolyh+nbnPm1YrwAKtHrJd32bEs=;
        b=TgQUfYO5nJfydGmsBRptARWur/lt7GrUFprdMT3M90nqPKBvFAfHSACMAa9J922Ovx
         2RCd+UpohgFySzSPUXaVKSlgODAoVeAvnhU+Dl5HQDEVat26RtVGNuhQVJkkl1Syhjoa
         v6ktoruKLlCeroyBefR2CIid6P2BPQb5owr/Cy8WWo2CyUJzpSO8kiLqJpWPRBbIYW28
         oP+6vPzkoyx00hd8CE1nos0Cx1433dge13rFvkEIT+9ca86r06bOEd+63ttT/Q1c/0cG
         VrT8eezheV2IMYl47nVU1fxRELroQNaHSZKNqIgQwkzU2XGAeGGfTTJlY9gWbHTooTdd
         TZvA==
X-Gm-Message-State: AOUpUlHYleVLhTIWZl1rqAwYyqULKaipBjunAdg3nT6OSrCcq3APwwa+
        oyEwUeQYQXUkp3L6ea3/5D9hkkmId4yU85oh1ERyAQ==
X-Google-Smtp-Source: AAOMgpe+hpaGC2P8H5n+puWLSm/R1eXPN7E+avyduUd15kb4OaLEdnLdcYn9ilkPnCx0dydHuHt/5K2crCJHQ7GxUtM=
X-Received: by 2002:a25:4a85:: with SMTP id x127-v6mr358689yba.135.1532589698127;
 Thu, 26 Jul 2018 00:21:38 -0700 (PDT)
MIME-Version: 1.0
References: <20180704095318.19218-1-anders.roxell@linaro.org>
In-Reply-To: <20180704095318.19218-1-anders.roxell@linaro.org>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Thu, 26 Jul 2018 09:21:27 +0200
Message-ID: <CADYN=9K5zPmsXOd8N1X9vKRAkKF7nfZXOLMvYNGwLEE9gzJeRA@mail.gmail.com>
Subject: Re: [PATCH] fs/ocfs2/dlmglue: lockdep_keys defined but not used
To:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>
Cc:     ocfs2-devel@oss.oracle.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jul 2018 at 11:53, Anders Roxell <anders.roxell@linaro.org> wrote=
:
>
> When CONFIG_DEBUG_LOCK_ALLOC isn't enabled lockdep_keys isn't used and
> we get a warning:
> fs/ocfs2/dlmglue.c:99:30: warning: =E2=80=98lockdep_keys=E2=80=99 defined=
 but not used
>     [-Wunused-variable]
>  static struct lock_class_key lockdep_keys[OCFS2_NUM_LOCK_TYPES];
>                               ^~~~~~~~~~~~
> Adding __maybe_unused to the declaration hids the warning.
>
> Fixes: 1cd75cdb8fbb ("ocfs2: make several functions and variables static =
(and some const)")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  fs/ocfs2/dlmglue.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
> index 040ddb6e7dab..160e0b224367 100644
> --- a/fs/ocfs2/dlmglue.c
> +++ b/fs/ocfs2/dlmglue.c
> @@ -96,7 +96,7 @@ struct ocfs2_unblock_ctl {
>  };
>
>  /* Lockdep class keys */
> -static struct lock_class_key lockdep_keys[OCFS2_NUM_LOCK_TYPES];
> +static struct lock_class_key __maybe_unused lockdep_keys[OCFS2_NUM_LOCK_=
TYPES];
>
>  static int ocfs2_check_meta_downconvert(struct ocfs2_lock_res *lockres,
>                                         int new_level);
> --
> 2.18.0
>

Ping.
