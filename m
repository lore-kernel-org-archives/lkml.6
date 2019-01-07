Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1018AC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 04:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA3BC2070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 04:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GpIx4ERj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfAGEle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 23:41:34 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38301 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfAGEle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 23:41:34 -0500
Received: by mail-wr1-f66.google.com with SMTP id v13so41801772wrw.5
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jan 2019 20:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o+KJwyA6per4XLo3a8AN/JoxpgSO7smJc09PXpuJYQA=;
        b=GpIx4ERjFM2xVKM4LvLmMPMuhnm+jdl4aZM+HjEhO2AS08gJnt89Vo0WilFfH7qgHY
         7JR9rBet8WO60pS4y+PjNMRVgytD7YJ3gBwjVd46olhWR1zzSnXQjFdih5W2a1fXaF/g
         dAXv3fLfVHPikaBOihIxwJznO+j09aqLWJz9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o+KJwyA6per4XLo3a8AN/JoxpgSO7smJc09PXpuJYQA=;
        b=QX/3/skUzb0OcB8qDXB7XVAkunUdApw15BfISH4LjFOw0bSB9EM8MoDtZCwUX7Xmo1
         PIy1gdEgu/pRI5bVuMJmiuKZIUIUK561u9spFSKlavozW22VzcqcJFEZ4GByY3DE8ivN
         rlJDLljvGkAEvVLWoaqHApASEzketXte0Rd9xp1qfZLEPvak/sotd4eWePr4kaEzp5TY
         RLYu7aQYtwU7yNLTGZhMsO7Zge56ZY5XJEcWfaSEfFsEwEvBEw1s1WUY4MAM5MfYCKWH
         zy/5jdROwX9lxRhPsR52UdNoGhBq+QiHw9W6OsSgORiSvJbWE4ZfBytsu0qklwHj8G8N
         RceA==
X-Gm-Message-State: AJcUukdHTERsqukhq2TCHbPCIgyziKP/14KcDycaAyryf7s9lOn6jBlm
        gTZTJKBjbxLfipcsJVWaxSBmImIltLGy4czJfpaHEg==
X-Google-Smtp-Source: ALg8bN6UpkddzH4MoTOSR0G63vlm2Y9eRO1zYPMUTr4gOz9G7MtSjgV/wmtOqBZiE6PU42ZAJoGQYU3ryLEJfU1dOKg=
X-Received: by 2002:adf:ee46:: with SMTP id w6mr52275966wro.261.1546836092201;
 Sun, 06 Jan 2019 20:41:32 -0800 (PST)
MIME-Version: 1.0
References: <1546505734-24527-1-git-send-email-srinath.mannam@broadcom.com>
 <1546505734-24527-2-git-send-email-srinath.mannam@broadcom.com> <20190103170117.GA11469@bogus>
In-Reply-To: <20190103170117.GA11469@bogus>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Mon, 7 Jan 2019 10:11:21 +0530
Message-ID: <CABe79T4Q=76NRx=uj1LQg9Wu54=Sj+F68Tk6S5nNX5-WHzCsNw@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] dt-bindings: thermal: Add binding document for SR thermal
To:     Rob Herring <robh@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Pramod Kumar <pramod.kumar@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thank you for the note. I will take care from next time onward.

Thanks & Regards,
Srinath.

On Thu, Jan 3, 2019 at 10:31 PM Rob Herring <robh@kernel.org> wrote:
>
> On Thu,  3 Jan 2019 14:25:32 +0530, Srinath Mannam wrote:
> > From: Pramod Kumar <pramod.kumar@broadcom.com>
> >
> > Add binding document for supported thermal implementation
> > in Stingray.
> >
> > Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
> > Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> > Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> > Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> > ---
> >  .../bindings/thermal/brcm,sr-thermal.txt           | 105 +++++++++++++++++++++
> >  1 file changed, 105 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
> >
>
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
>
> If a tag was not added on purpose, please state why and what changed.
