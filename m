Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6757ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 22:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 927812084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 22:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lQjzx3dn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 927812084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729972AbeGRWn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 18:43:58 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:43718 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729654AbeGRWn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 18:43:57 -0400
Received: by mail-yw0-f196.google.com with SMTP id l189-v6so2315738ywb.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 15:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lsF+qf8kRVG9v7coCvG402E6jft6QBl8PzFCg2w+LzI=;
        b=lQjzx3dnjBT8GqUqzM4p+ssAOi3hJlObEkrieCnYp18Tb7fl3L7ndTwbZfF6IknqHn
         zdx8vHN0PUuZoXgNAb/13wIHfs7gztNsrDkElCqIs2NLSnTN+yR1vpyMSLRxmcp1kq4K
         uJTw8PDEvuNoznhy5zWJeMsleDXl/92wNoybvkiFJKEVFcfRoF/CNeta4SUJvPj2T8jp
         A0FU9+jU26QBZuVg+iftL4/hFD2UMDUmlbz/apiHACu/fY5qu+RmMoLi7nNrpWFI9Afb
         HquGSwnSJxQtDn2jOwLZ9mRoUt0UC/+0Mi+I2rgV8FfYzB7WrbFF6W/FFHndKOBbeoL6
         3ZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lsF+qf8kRVG9v7coCvG402E6jft6QBl8PzFCg2w+LzI=;
        b=G5tYOYzOxJ3W/1GZuQ/57yblPPVw9CAQCbSoKOSXwMG22MCaPcEuUX96La/4pSDYUQ
         F/lmMTGmQdJQQ4geydke8wpLHPLJJyuQ5B78ISCR/b8VmYgEgGAJMCf3CR4SkBb34ccF
         SBmUwN+62qEuWp6SkbyjoRDGrIvdqb/gMG2+OIEGB+yUJrjYLnIlALCOLJUtTdyflhRm
         PVlvplf4/I3X6G/w92vODRm/gcj6vYc44AoCI2YCeXo4fdZxnGWtv3E9BpMDcQudXU0B
         0slwXF5JPL1x5UAWYkqAx+kjujQhSAHXQRUvNb1i6AHiTwUeb+1BpN2pCLuU3VCberUc
         LMog==
X-Gm-Message-State: AOUpUlFTyGXQ0GsfwMngQWMXD1PgRp62FHQruC1EWlRfh7KtVFhwyPym
        mgo+Da46rpiuwkQTemmeZUUKl/c6TwtCvU6xSjyK8EQ=
X-Google-Smtp-Source: AAOMgpewEKlodDQ4/hKNHilMBCY2/9WKKJ0e8avoOYmUgBdeKynYX8TJeO+nkIpNuJxc0hn4hUCM+DcTMOvfx8VS7V0=
X-Received: by 2002:a81:1e51:: with SMTP id e78-v6mr3995527ywe.20.1531951442349;
 Wed, 18 Jul 2018 15:04:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180719074927.68da9f86@canb.auug.org.au>
In-Reply-To: <20180719074927.68da9f86@canb.auug.org.au>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Wed, 18 Jul 2018 17:03:51 -0500
Message-ID: <CAErSpo5nbS5oUpkEQGfG3VFEaR_JDjFRCOior33zms_NL7qZrQ@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commits in the pci-current tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-next list <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 4:49 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Bjorn,
>
> Commits
>
>   27a6c9ebf29b ("PCI: v3-semi: Fix I/O space page leak")
>   db2aff16ea70 ("PCI: mediatek: Fix I/O space page leak")
>   52022fc6f6ad ("PCI: faraday: Fix I/O space page leak")
>   a9c0419ec92f ("PCI: aardvark: Fix I/O space page leak")
>   45cb32b4e8ea ("PCI: designware: Fix I/O space page leak")
>   89c0f3551827 ("PCI: versatile: Fix I/O space page leak")
>   596c66bf9663 ("PCI: xgene: Fix I/O space page leak")
>   ede26a1e8c35 ("PCI: OF: Fix I/O space page leak")
>
> are missing a Signed-off-by from their committer.  Presumably they were
> all rebased?

Yep, sorry, I picked those from Lorenzo's fixes branch.  I added
signoffs and updated my for-linus branch.
