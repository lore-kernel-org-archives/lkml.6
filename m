Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23493C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 22:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D01F820867
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 22:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cJJF4ekJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D01F820867
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbeIZEiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 00:38:12 -0400
Received: from mail-vs1-f41.google.com ([209.85.217.41]:38088 "EHLO
        mail-vs1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725733AbeIZEiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 00:38:12 -0400
Received: by mail-vs1-f41.google.com with SMTP id y11-v6so11312683vso.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 15:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vaKpk1KBgvPkms6L0mj4us9w16TgoO45tFosF0Sy88E=;
        b=cJJF4ekJU7abSID98n0o3gumKsk7yVIb9K54X+TT8gqD2naYD2xtNlRYOjjLlTymzG
         dYo/9BYvLezfngZ9Xm7qqyQBn8a4fV3wq6EGvChxX8fjj3BhdBcWHB5ewFkSfBAInxmd
         A4JxpqV3Y8fnlwtkMxgnJyNojhvrqEnc93O7YRK1aTbKQ2x6fYvjWEJvYTPcxSqZf2W2
         7NePgTLQPn0T5k4kfqczSLhdYNGVpr2zr97cAk4ej/bhHAzHpQ8WNSQh1JirAef9ZEZm
         WitEx+a2u1dAkKZgev3TSGepRbiZqpzDgVnFhZf6Yvqjb6FeqNn6O8usoJIOj8BB9KBQ
         hHZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vaKpk1KBgvPkms6L0mj4us9w16TgoO45tFosF0Sy88E=;
        b=UDEblA2kx1E2LHQIxZqCeUTPp06jgl+Sf+pVzIEYYjItaVqdjpq7m+G77VSymV2JOR
         DKE5CNZ60R7YsgRfrcIR+xrpqRXqi69nzpSrpro7+Zsiwf+aSPAbu7WLxG2n9i3NVj8I
         cB4t7gTdrCpkPwuVrXrW3eQFS8JIb1lzVAmno9UkKjLV/MrPqRhEK/jq9vDt7H63KyV3
         7chvXICBqeHgKl9r8YPM3MeDooa/6Y9/OZS4xppvB7pJ9H06s9l/CU1RrCYopQiTGxhK
         9YHIFzDhA52lYe4u4qvaZUSLvvwfd59q53dLVPxfR35+K/NRt+4jeW5KlM2vRaiVAxI9
         nFkg==
X-Gm-Message-State: ABuFfojvnh/c0l5PIlvVi2zsj/TXGIFeuhox9EFLJrHibPlVYqYiPiAe
        mbCuFrSmWpLNRx3OhCDT/gtZ2r5fabuyjpFfe+9IMg==
X-Google-Smtp-Source: ACcGV62btAPuFfCMjSPl7rhKzfuutSzX+YBllCPi+VEO51SwfAKuWP6lwghKB8nAPeGBrlI+NMx1h3mB//DJwDf2bDM=
X-Received: by 2002:a67:3511:: with SMTP id c17-v6mr979519vsa.42.1537914507645;
 Tue, 25 Sep 2018 15:28:27 -0700 (PDT)
MIME-Version: 1.0
References: <1537887875-29494-1-git-send-email-vbadigan@codeaurora.org> <1537887875-29494-3-git-send-email-vbadigan@codeaurora.org>
In-Reply-To: <1537887875-29494-3-git-send-email-vbadigan@codeaurora.org>
From:   Doug Anderson <dianders@google.com>
Date:   Tue, 25 Sep 2018 15:28:15 -0700
Message-ID: <CAD=FV=VxLR6v3vyimjznrqa1Tj5rPziPQX7Pt+wJRR+xm1N-0A@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-msm: Re-initialize DLL if MCLK is gated dynamically
To:     vbadigan@codeaurora.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Asutosh Das <asutoshd@codeaurora.org>, riteshh@codeaurora.org,
        stummala@codeaurora.org, sayalil@codeaurora.org,
        Evan Green <evgreen@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 25, 2018 at 8:05 AM Veerabhadrarao Badiganti
<vbadigan@codeaurora.org> wrote:
> +       /*
> +        * Whenever core-clock is gated dynamically, it's needed to
> +        * re-initialize the DLL when the clock is ungated.
> +        */
> +       if (msm_host->restore_dll_cfg_needed && msm_host->clk_rate) {
> +               msm_host->restore_dll_cfg = true;
> +               mmc_retune_needed(host->mmc);

Using the boolean "restore_dll_cfg" to communicate like this seems
really fragile.  I have no basis in fact, but I worry that something
will happen in the meantime that really ought to invalidate the
"saved_tuning_phase" but the boolean will still be set.

Is there a reason you can't just call msm_config_cm_dll_phase()
directly from sdhci_msm_runtime_resume()?  Perhaps after the
clk_bulk_prepare_enable() call below?


-Doug
