Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C92C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2AB9207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EGljOfDG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2AB9207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbeJWR6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 13:58:17 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:34966 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728644AbeJWR6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 13:58:17 -0400
Received: by mail-lf1-f41.google.com with SMTP id d7-v6so596846lfi.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 02:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J1+EROeEjWTWEKvw09h3UwBdHMUt8ySP2FzjmP4Y2nk=;
        b=EGljOfDGM9VsrjADrUVBiVOVw0PH/tN1YBJwUT9SvroFyYfrRax32433AZltcfRCBP
         9dIHps5ZPrSoOOIjKXy4SvXqr3j1DYmFNGFh7SQUNH3MFw4imrU1V1Ma52M3Q53ZGbrh
         tWFT9uABHUd2eD7hR9ZlOhAxoG4se+xoavYNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J1+EROeEjWTWEKvw09h3UwBdHMUt8ySP2FzjmP4Y2nk=;
        b=XLlvC7fEFNMOp5z8E1+RG947YNhwH/sgjwAIdu0qMS4ToWwMCjXMxdQRDrSrmlgCb2
         DpeN5UO9YWWWqTdCQERPLtZ+3IKN29Cx5yZCizazWZcdxgRbSbEizIzwFPusz+EOC3x0
         u852VrYk1BsFcQiUAl2w3syx7FtH02VEHlq9jqkcSdJbdHDR1g/4YW5nZBVfnAhGRckG
         mMdObtUnrsr2QAkOD/NzoK8VGROo2UTxJC6phMyF3FjkAgTjmPwLX5spAJBVDUiuhIve
         jC8PW6lz/sQKgI0KoE6mSQ2BX7+MMZ2UGInbuhtBadqGDVDjaACj3kScrJGs4xmEWJJ2
         9w5Q==
X-Gm-Message-State: ABuFfohwOVFCPXBhF/dU8OKc8zlkC+tugFb1iiDdZSC5fVeqAgCFnKky
        OZ5jqSkniG3l/gU+3nWDpmo9ekEy9hEIlcls
X-Google-Smtp-Source: ACcGV63TOR4nNlgrIEzefO/mVHiGPVifMHL6nfVx7lqC+gAulkNLJEtggXdHuJmxnoK/lcEahxnpjw==
X-Received: by 2002:a19:f115:: with SMTP id p21mr10702487lfh.20.1540287339642;
        Tue, 23 Oct 2018 02:35:39 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id i186-v6sm136362lfe.41.2018.10.23.02.35.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 02:35:38 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id o2-v6so568234lfl.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 02:35:38 -0700 (PDT)
X-Received: by 2002:a19:3fcf:: with SMTP id m198mr1102833lfa.106.1540287338182;
 Tue, 23 Oct 2018 02:35:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0jbwJ04_n0xrs+9hL-hVT5+JYcMRo1MMACbKgHVsFnpTg@mail.gmail.com>
In-Reply-To: <CAJZ5v0jbwJ04_n0xrs+9hL-hVT5+JYcMRo1MMACbKgHVsFnpTg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 23 Oct 2018 10:35:22 +0100
X-Gmail-Original-Message-ID: <CAHk-=wjtp3wTzAKH5KGb_uTg-uu2PfAV6g_Tg=-OP_N=tZ+nsA@mail.gmail.com>
Message-ID: <CAHk-=wjtp3wTzAKH5KGb_uTg-uu2PfAV6g_Tg=-OP_N=tZ+nsA@mail.gmail.com>
Subject: Re: [GIT PULL] ACPI updates for v4.20-rc1
To:     rafael@kernel.org
Cc:     linux-acpi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 6:41 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> ACPI updates for 4.20-rc1.

This - and the power management updates - pulled.

             Linus
