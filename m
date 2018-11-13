Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7B0C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D472921780
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1me0rAW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D472921780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730954AbeKNEvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 23:51:22 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42903 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbeKNEvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 23:51:22 -0500
Received: by mail-qk1-f195.google.com with SMTP id m5so21337937qka.9;
        Tue, 13 Nov 2018 10:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TJfxLZ4vQ7YRb3fkYw8oONYWIga59O/1rvaCVPeun9M=;
        b=D1me0rAWjYnmkTSijPaeQn/9HdIC/So+OxjeI+Y4eh2cklju7jJaVTk82n72DJLcV3
         P+o5p6MuCe6WEjjqN5yxLAl7j43OrX1zKVTuEsi8AJQC43QEHv7rf/5MgThtjjRN3b94
         Ss476N1TkN28WNsF0pjtrSUQBfeqTV9W/GiSLCrVtwoXH2T/RccZEvq/AMcgjAX8oQMk
         s9E4RdhsIuPSbURHJew9xqR+kBo1rQK3A1qbebL3vVdFrcyL3ETsGbKXVLA/1OTgC4g/
         LS2yAjEpd6zXArg/uNlVr/6oXoUqpb+e+goPOWaXKrOeBhdbut1oFGPbj7lCyQCfqpro
         1Ytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TJfxLZ4vQ7YRb3fkYw8oONYWIga59O/1rvaCVPeun9M=;
        b=Rn4y3C8Op/G5c6Ji6qitrdpJ1Tf2sjaz0j59v1vGyAgMMd8cuMAgGD6ZdFEieymyvx
         ksXTWrT2t34e3bD71X5cOQIVK5HyEfKDJoy4SzphIetRnQnY086Ax5NS9UepsXbEeZBt
         +y3NkJ3vCWi/xEMVdBioSGcIUxE9irw8aEPpgeD/j7LEUg0zWu9AkP2zRjiwBn4z3xwJ
         lEvvuvXdfyALHDchWBAqeiJhnFh4qr3x59pUL5qYDrUmirsvQfJ0UYsKpEoxMqr9M4RJ
         7CveuBjBZfpP10KMX+FFm2s1ysL9h2o1uOW1H7J8isJTSWDWO1XlpGAbwcbpToxvmPd2
         YDDA==
X-Gm-Message-State: AGRZ1gLST6rAPpIf74HXLlHw3KcpHF9CZHMAJCHQ/71bUk3IDHDmwKDD
        SdPrhRCZaaMhxc9GiV6DSo80fodO5Y9f77juEt0=
X-Google-Smtp-Source: AJdET5d/8eLbajBcI+gB+SoP+aogswqUXvBfoCYvDI+PU+e60pHnkq0gZS826PZ+b7E63zOkB6Kacd0uj1adOondsU0=
X-Received: by 2002:a0c:d268:: with SMTP id o37mr6541053qvh.136.1542135117968;
 Tue, 13 Nov 2018 10:51:57 -0800 (PST)
MIME-Version: 1.0
References: <20181111190250.6055-1-ayman.bagabas@gmail.com>
 <20181111190250.6055-4-ayman.bagabas@gmail.com> <s5hsh04c28h.wl-tiwai@suse.de>
In-Reply-To: <s5hsh04c28h.wl-tiwai@suse.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 13 Nov 2018 20:51:46 +0200
Message-ID: <CAHp75VfH3ypEeM+kEOCsAkKmd9NRUq3Q-soYJ4aPB9+icn3Rdg@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] ALSA: hda: add support for Huawei WMI micmute LED
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Ayman Bagabas <ayman.bagabas@gmail.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Hui Wang <hui.wang@canonical.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Kailang Yang <kailang@realtek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 7:32 PM Takashi Iwai <tiwai@suse.de> wrote:
> On Sun, 11 Nov 2018 20:02:45 +0100,
> Ayman Bagabas wrote:


> With that fix,
>   Reviewed-by: Takashi Iwai <tiwai@suse.de>

Ayman, please, send next version with requested changes and appended
tags. I will apply it.

-- 
With Best Regards,
Andy Shevchenko
