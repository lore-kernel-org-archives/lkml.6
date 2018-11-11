Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1758C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CCC920854
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sei0tki9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CCC920854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731727AbeKLGHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:07:20 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45792 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbeKLGHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:07:20 -0500
Received: by mail-wr1-f65.google.com with SMTP id k15-v6so7081662wre.12;
        Sun, 11 Nov 2018 12:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sngmm96Z9HsNEvqgT2i1q25cJ7sOvu12JY9z1ptp2QY=;
        b=Sei0tki9nJ+7IEkgAXoEnqbwalnurm67aufaTKAdYCt5CaDphlBkYlNrYR3yCqZHCz
         mqYj+0ejf80T0Ht3Omg/nIYHh3cpfuFHRtQQ/YIX/w8JFTiNJzn+eY3UzVOgMdf8GIlL
         f86wzp8lbcl44QESxnPkngWPGqb6xekdga2WBXc/QPSz+02C4v94YZffqHCFIV9DyPGc
         DUxYYoCNvCOOKVDk/jj/SFpXrPItFoR2U1+sa0ULI4n6KlDvQzXp1AO3JhO1W9v9QMAC
         JsSXrhSoTK+FjoYTZeGyS1mHpH8RuzuO/GYXplj3EkFFHGlazYCHGBkOgK9t6U6n+yWM
         grbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sngmm96Z9HsNEvqgT2i1q25cJ7sOvu12JY9z1ptp2QY=;
        b=uJnR3oNtRpZRbzvg/tmG4y7Z4aF7jkSmohbtEYRRGAMYMeAub3n1jL0UNlFhiC41PL
         JupVNT91sDcjJ5oIl2wMibNr3Krn/joiTnpN935VD2ClIfoYS18oKGtroxn4Qohs2/dj
         uvQ/dcrbyJI8gsbiljgo04rpWVvi8ycB7l3ls+ia2zBR6ClZ4YIt2bkpO+3ZtRME+KFv
         OK4rYdh3WvPfi/NzmP+gxLMflrFFDFKJI6UygjlaekYtD/07JsI43cK2PkwXe3Zfs927
         0EsfRUiaZBRhOUtu3eoi1PmvEc8t2p73rEN3OMjdCuXB6kqauaXDXIPN2IKVnN1Qerw+
         1Msw==
X-Gm-Message-State: AGRZ1gKlsGELhLdIO4lCw91ufYsiSQ4rp2F3VTilMw9pPJ/PWpz4sRA/
        cdHKDBa5A3t/ttdnav+BDT+0BRZEOPdIf1PpHy0=
X-Google-Smtp-Source: AJdET5eAaCZm0KE5FeZzlaJhdoUSnt8b4C1/HdMwwzpAMUyt4+nQJIQKacRGm/wU2LNNBIAyX/k71y9cQGqmqZUaNdA=
X-Received: by 2002:a5d:4747:: with SMTP id o7-v6mr14412215wrs.256.1541967469482;
 Sun, 11 Nov 2018 12:17:49 -0800 (PST)
MIME-Version: 1.0
References: <lsq.1541965744.387173642@decadent.org.uk> <lsq.1541965745.189575243@decadent.org.uk>
In-Reply-To: <lsq.1541965745.189575243@decadent.org.uk>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Date:   Sun, 11 Nov 2018 21:17:38 +0100
Message-ID: <CACna6rx3LPxuYKtJOmZP-Pt-HMAhh99qHVsxVFv=XoPuJ1azbw@mail.gmail.com>
Subject: Re: [PATCH 3.16 151/366] MIPS: BCM47XX: Enable 74K Core ExternalSync
 for PCIe erratum
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Burton <paul.burton@mips.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        James Hogan <jhogan@kernel.org>,
        Tokunori Ikegami <ikegami@allied-telesis.co.jp>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Nov 2018 at 21:05, Ben Hutchings <ben@decadent.org.uk> wrote:
> 3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

Nack. This patch has caused a regression and had to be reverted.
Please check upstream repository for a revert (search git log for
2a027b47dba6).
