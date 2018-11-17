Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557A7C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 11:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD2220671
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 11:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgITSpKH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DD2220671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbeKQV1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 16:27:42 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45324 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbeKQV1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 16:27:42 -0500
Received: by mail-ot1-f68.google.com with SMTP id 32so23135214ota.12
        for <linux-kernel@vger.kernel.org>; Sat, 17 Nov 2018 03:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sKtSs7b/UrM3wVvSIxclujlNf5Ety+rlyRmk1MtkH/8=;
        b=WgITSpKHq70GE/UShaszHdVZS+z59mQkQ6SSFoPUbMhEHzw+5JRkiJ639MAhNNtXKi
         hjnHKq/XfYk7W8V9taAOmao1jw/JaH5vVkvwHpUaoYlYSCtPa91NWgZQch/QDuL9w0ET
         pZKiYxw4ChTRgsDKx4hx2D4bRWMwXRpVzcOy/t3O0PxDkWt73Onm8oT6vU0CsRMO+Jx+
         dR4l0ofcY1povJ0UrZ8cEDK/cM6Q6lZlGiI3gV8v+sEmnPW+wRD13FNTRGzPEDaFkfni
         CDMiSvjbKBEF1hWLkj2SRaWAEq+PiNzD2f/XzYOrXCbxeglmdpG8lOfUbczrvMix2lHP
         G9gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sKtSs7b/UrM3wVvSIxclujlNf5Ety+rlyRmk1MtkH/8=;
        b=SskBVyilfsmpFx0hyY55D1uUg79pJXngsyYBDME6qBPw3q49egnNdsnKp0+3iweizD
         LaAZ2eDHAqzNH+vPYp0a3ySNYHucFikiSSIFNV6zAS/sw8+QmH5F8nxejeK+OeUO7msD
         v+clutThueVfAeSVDsHDl4f3naPbBYLDd9Bh8I1lA3JXIlfbodpjB72Dsh0GBJrv8lQu
         UesjB3Z++mayPVOTEWFIefzk5oGHm4eIi+vY0wMhBzOqXp7ZFK/ACGfJjZHBwSHF9+oT
         OALvt82SC82xEFHPKWRpUpQ/BcqzGTSuywYTLIq6f2kVwIgdkhGnLEyESE4Efy2CnURW
         //6w==
X-Gm-Message-State: AGRZ1gLfqenGuF0p51/qan4y6v4lFoBjGs33IdyOruf7AZEZk3DPYt00
        PRmW68HpgqpIt0qX31gLoT97jrAiCRU6tbtu59QCwLuq
X-Google-Smtp-Source: AJdET5d7Ooe3ZaPGoL0zEgmBwa9n522DAegd3TZ27LgI6kxHyCHCaEDBO3RltVpWuZGF84zfaSfc/5GrdZucREybCx4=
X-Received: by 2002:a9d:5549:: with SMTP id h9mr7980555oti.83.1542453081320;
 Sat, 17 Nov 2018 03:11:21 -0800 (PST)
MIME-Version: 1.0
References: <20181113034007.3878-1-tom@aussec.com> <20181113034007.3878-2-tom@aussec.com>
 <20181113034007.3878-3-tom@aussec.com>
In-Reply-To: <20181113034007.3878-3-tom@aussec.com>
From:   Philipp Zabel <philipp.zabel@gmail.com>
Date:   Sat, 17 Nov 2018 12:11:10 +0100
Message-ID: <CA+gwMccq0dwEViy-u=_mTsJD+N-Long+-3z3vzvpDfFxT4UgSw@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] pps: descriptor-based gpio, capture-clear addition
To:     tom@aussec.com
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

On Tue, Nov 13, 2018 at 5:08 AM Tom Burkart <tom@aussec.com> wrote:
>
> This patch changes the GPIO access for the pps-gpio driver from the
> integer based API to the descriptor based API.  It also adds
> documentation for the device tree capture-clear option and
> device tree capture-clear extraction.
>
> The change from integer based GPIO API to the descriptor based API
> breaks backward compatibility for the devicetree.  This is due to
> the descriptor based API appending "-gpio" or "-gpios" (see
> Documentation/gpio/base.txt.)

Documentation/devicetree/bindings/gpio/gpio.txt says:
 "While a non-existent <name> is considered valid
  for compatibility reasons (resolving to the "gpios" property),
  it is not allowed for new bindings."

This is not a new binding, so there should be no reason to change it.

gpiod_get() and friends support this by using the "gpios" property if
they are passed a NULL con_id.
of_find_gpio() in drivers/gpio/gpiolib-of.c contains the relevant code.

regards
Philipp
