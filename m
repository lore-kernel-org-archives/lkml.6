Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDB9C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 04:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2FBF21476
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 04:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M4KemmUd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2FBF21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbeIMJeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 05:34:04 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36289 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbeIMJeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 05:34:03 -0400
Received: by mail-wm0-f65.google.com with SMTP id j192-v6so4611585wmj.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 21:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kkNaI0m9BzJAGxPfwnfHRuCZ7+Mrzo6bOQZKi201Lmw=;
        b=M4KemmUd6lvBAnZVtgVriYn3TKdtFfeEz3BliGTOv9HWXIhSYKbURjHDVKRf49Dizo
         HC7Tn2qSXF7uiSJJPUBGt2QAJyndIDUDuaAFC4uLkUIhZklogt2XecbBXGg6F6dK8AQG
         /LfBbrLot6qovralojs+YtqgTEG2ICHVZOCNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kkNaI0m9BzJAGxPfwnfHRuCZ7+Mrzo6bOQZKi201Lmw=;
        b=R3g/umJftH9siP5bKHB0hmjDXuFZOjT4CK5cQs6t+983iU3uaKxArDKo4bUbQnJsDU
         I+pkFfR8AEobgwMykDUKvSyplUzy3NmP0aMwN4KxNcyrJeGPulWf8T8dptVBR9ZwK+7X
         7LkaRY3a2q1vDzT9AlSAeOg8bYTm7gLFxX40Cl22gc/1FKxt+Sgdr0xx47B7MuxIGiom
         iLVR5L7AcrrD7sHhTTnbLa5aiBvCmd2oJlEV7hV1WHTrmgiW/dPTAP6oDGnHWEVcmU0r
         +zGjAIJ6wHWHw7qOwAFh7KROZ1r+5G68tisFho2W7EJf03PR3szSkRk8Y1eUqE4btkBC
         OKew==
X-Gm-Message-State: APzg51AeSLNi1u9zQe4JGMLE1fdHiSQNUlm1x3GuJoFtVvQJ7gbD1PdZ
        NdMc2fBDszLIcp91MRbUazPluUFZaKl2rIEHtNJvMA==
X-Google-Smtp-Source: ANB0Vdb/aOFNfiiLZsXDSCM08xXw5tZ1Mr7zONi7DiECUeoBOd2W+YLx3yVHgNIgEG06Xq5jCziciOI3hh6gtaE8k6M=
X-Received: by 2002:a7b:c18a:: with SMTP id y10-v6mr2870592wmi.87.1536812779701;
 Wed, 12 Sep 2018 21:26:19 -0700 (PDT)
MIME-Version: 1.0
References: <20180912121955.33048-1-cychiang@chromium.org> <20180912122818.GH6062@sirena.org.uk>
In-Reply-To: <20180912122818.GH6062@sirena.org.uk>
From:   Cheng-yi Chiang <cychiang@chromium.org>
Date:   Thu, 13 Sep 2018 12:25:53 +0800
Message-ID: <CAFv8NwJNvCF9+Cg17+j2AKfE6_cjodpTFnjGTc-VBszuBD_4Nw@mail.gmail.com>
Subject: Re: [PATCH 1/2] ASoC: max9892x: Add documentation for reset-gpio support
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Ryan Lee <ryans.lee@maximintegrated.com>,
        alsa-devel@alsa-project.org, Dylan Reid <dgreid@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 8:28 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Sep 12, 2018 at 08:19:54PM +0800, Cheng-Yi Chiang wrote:
> > max98927 codec driver will support reset-gpio binding so it can toggle
> > reset line in its probe function.
>
> All GPIO properties are supposed to end -gpios even if there can only
> ever be a single GPIO.

Hi Mark. I see.
I will update this along with the comments of the change in max98927.c
if there is any.
Thanks!
