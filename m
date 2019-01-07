Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECA0C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DAEC2089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546858441;
	bh=40BVRKJ/UrnBsTBVh/RJ2fv1pxx7QhlVbbTmV6CeIEQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=nb6T+lkZ5roKkgKz9o2XuycvRj8G1jk1b0OM0ZNIrbSSfzVMFOqvaDkMHrHD5K+O2
	 JIfd3wlj9jI7zgCs4kkh+Z1ScEMxYIF4UOB2gqqlARpxJuJ30T+1XRi5gPvB/hIa6E
	 7pjnLJmefsNEl5SRnqSEUEAhR8uo6SimhwkUMS5o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfAGKx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 05:53:59 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40285 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbfAGKx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 05:53:59 -0500
Received: by mail-ot1-f65.google.com with SMTP id s5so37405094oth.7;
        Mon, 07 Jan 2019 02:53:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=40BVRKJ/UrnBsTBVh/RJ2fv1pxx7QhlVbbTmV6CeIEQ=;
        b=kCXIl5sizBSHpcorBn5C5+G0xgxtRW72ypQggmRyHNDCMlSPyDsWjcqnoeI48EBnUG
         yhc61lnOuwV02PdA3bDf5IWRHxRLjAvgaFDZu4k128qVpbSdVIL5YX9IuSpLoXa7c/KC
         3/YxKrec/VP3KH58DBp4kl2cBH732wDCrEXRZGVSVqnMvwLRNYy1/PyJQsokK1kCEsF5
         RHqOlO1sxoPRvOOFFc0ZAzM1FnLeF+hcTi3N0ainMYNq8sTHDMIcv7cnSKLZdqPx6MYi
         +kvWJtcoGKV/FCmARR3+TyxScRVC5/ZxEv2hOAhrJRaBcsy5meh0tpOPwg7tibu9qtZg
         +usg==
X-Gm-Message-State: AJcUukd23q1nNH0jCLN5lwt0TOuoSwHkN5tvuuTnjNrZTY6xKBadw5MU
        X9shQ6+gWCrem9URPDcBEW05btgy2ArMQiCsTmQ=
X-Google-Smtp-Source: ALg8bN4saM45GgyR1U2OTye/FeoZM84WPVyg1i5diRMn+RkgqMakdmsOR7cQQmP09GlVA2XjR4cLaWDXyVYPFYXZrRs=
X-Received: by 2002:a9d:2062:: with SMTP id n89mr39634945ota.244.1546858437958;
 Mon, 07 Jan 2019 02:53:57 -0800 (PST)
MIME-Version: 1.0
References: <20181230195612.6657-1-okaya@kernel.org> <20181230195612.6657-4-okaya@kernel.org>
 <20190107103448.GG21184@phenom.ffwll.local>
In-Reply-To: <20190107103448.GG21184@phenom.ffwll.local>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 7 Jan 2019 11:53:46 +0100
Message-ID: <CAJZ5v0hJXSg5iAg4noFaut4AW3V1J0j4N1n1mq2zV3=4Ls5=uQ@mail.gmail.com>
Subject: Re: [PATCH v4 03/11] vga-switcheroo: make PCI dependency explicit
To:     Sinan Kaya <okaya@kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 7, 2019 at 11:34 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Sun, Dec 30, 2018 at 07:56:04PM +0000, Sinan Kaya wrote:
> > This driver depends on the PCI infrastructure but the dependency has not
> > been explicitly called out.
> >
> > Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
> > Signed-off-by: Sinan Kaya <okaya@kernel.org>
> > Reviewed-by: Lukas Wunner <lukas@wunner.de>
> > Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>
> I'm assuming this goes in through the acpi tree, correct?

I'm going to pick it up.
