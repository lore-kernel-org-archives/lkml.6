Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE9CC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FACA217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="rzXuX6wl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbeLRIaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 03:30:35 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41279 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbeLRIae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 03:30:34 -0500
Received: by mail-wr1-f66.google.com with SMTP id x10so14921149wrs.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 00:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6vtoAZDWB6d72bsfhuRuDAYI2YAn1wAXF262N6zlQ9g=;
        b=rzXuX6wl9UWOz3eHzTzw0freV0en0/eEaOLG3mFK8/DsJW5scR2lR89esXb0rXU+Sv
         LP91c7XkqG67r0APqeusPjaDFaR4c94tNQgiUCXemUk9sT1xRhcvSaado3z304heWHba
         nB+rh1dAJ7TZf3Nt+BtUz1WpsY+BmxQaNIT74ihBgdxAtbDasjLQ70+HsfwX6ixsVGwm
         1CA7I/vjFoY5GHQBkz0NTT09SI1n3pFArqkEg0rVC5xQf48eMDqKAb4ykOiV9DrmzyWT
         3nf5Jm64kkkZSpMc/5PovTRqcgWTxnxP4v71PrrdN6Yk2kRXckFcFKRk6jQDALz0toag
         T5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6vtoAZDWB6d72bsfhuRuDAYI2YAn1wAXF262N6zlQ9g=;
        b=WlMktVcueX9FvookYGpjIMxwprVcwE2oxrHkmTaY4w2afcF0ePMULvTh8KpZlIzKus
         Kpu4gU//MCPODPku8mVoOvOhDHtwPWbQzhmpykE78P+AEcm7KBA/k/Dxqrt3BiEheFSN
         2bbrgwd3JncLdUj4Se67U1x0cgDdtyypYiFieJDGvEyuo/ESvSXY6Cyuwob9KUyGOAFv
         0zXU2v9rETx9Ci4740f+NJbVc3jAlH8DwDENRoGqGRBVtG2bsiODpKS5C9+EK/DVzihf
         USsDoTS6zwoW5VR5742mPWo4NUuwBo987SHPHpiDmXyhxc3Id0ss6V2yLJJG+2GWOpAG
         RbPA==
X-Gm-Message-State: AA+aEWb4dSJ4tXtTWMLdTDMubps0GyXwjg0G/Hf6h9a8kZ/D1u5LPo6L
        ehOqqoi2x7D2kcixwtLLmhFkz4gGmQ5dW47fAZzvmQ==
X-Google-Smtp-Source: AFSGD/UFO3Uq7RUEy+TbXqXUlEpP5VpULpXnuIj65KrAeFA++M0PUkmid3oIh4mJQcnCxzxjzgRT0BszrwzkQMALgio=
X-Received: by 2002:adf:ee07:: with SMTP id y7mr14201034wrn.187.1545121832742;
 Tue, 18 Dec 2018 00:30:32 -0800 (PST)
MIME-Version: 1.0
References: <20181130080207.20505-1-anup@brainfault.org> <20181130080207.20505-2-anup@brainfault.org>
 <20181217182520.GB7086@infradead.org>
In-Reply-To: <20181217182520.GB7086@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 18 Dec 2018 14:00:21 +0530
Message-ID: <CAAhSdy11WFLjMGa6PVWdL1=YVQLA_nHB5kA1rBj2FFuk0dOeMw@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] irqchip: sifive-plic: Pre-compute context hart
 base and enable base
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 11:55 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Fri, Nov 30, 2018 at 01:32:02PM +0530, Anup Patel wrote:
> > This patch does following optimizations:
> > 1. Pre-compute hart base for each context handler
> > 2. Pre-compute enable base for each context handler
> > 3. Have enable lock for each context handler instead
> > of global plic_toggle_lock
>
> All of which is pretty obvious from reading the patch.  The big question
> that needs to be answered in the changelog is why you do that.

To compute enable_base and hart_base is two integer additions and
one integer multiplication. This micro-optimization simply avoids this
repeated operations.

Regards,
Anup
