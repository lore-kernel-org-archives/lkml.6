Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9816C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B47BA20824
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="newRM0o0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B47BA20824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbeJ3BoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 21:44:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:50752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727338AbeJ3BoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 21:44:05 -0400
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8920720989
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 16:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540832079;
        bh=kFriA8bBEr8vvbr7FuzwdmFLezWPVbs1qfsrrCvPUrA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=newRM0o0517EzGZWGZ78FQ6F16yDo70zXNi1CtfPoTpvoDTGHVeg/ZZNazsj4usHU
         VUxO3kCef9GPi4RTqgCywUnUprpeJ34njNnDv8Vtdns5yirVI8ktY+rOqoF/+bu0ai
         MPyLERaQD1iu+BrHr/00r52y5em08zC3WQf+SL34=
Received: by mail-wm1-f52.google.com with SMTP id h2-v6so5177000wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 09:54:39 -0700 (PDT)
X-Gm-Message-State: AGRZ1gJMJMiQ2gu1aPQRNPWOECIHkl15wT36U+ogKl0iqjAQPIxHMXvV
        dvUsHJceZn1nPV3kf3l/MzwJm9laOd0omCknXw4KNg==
X-Google-Smtp-Source: AJdET5cKOdCVIQ29QB2cQ5KQrSFreAXvX1daR2xu6gzFfOd3R0RYUZC9s9OPKT+TlxkDQwgm44uSxXvWLJOSCbUVsPE=
X-Received: by 2002:a1c:b20b:: with SMTP id b11-v6mr14341181wmf.64.1540832077884;
 Mon, 29 Oct 2018 09:54:37 -0700 (PDT)
MIME-Version: 1.0
References: <1540613318-23877-1-git-send-email-ren_guo@c-sky.com>
In-Reply-To: <1540613318-23877-1-git-send-email-ren_guo@c-sky.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 29 Oct 2018 11:54:26 -0500
X-Gmail-Original-Message-ID: <CABGGisxiWaQn9qDqpfxEWcckkGJfMzFvSPGvuhQK7oB404-6DQ@mail.gmail.com>
Message-ID: <CABGGisxiWaQn9qDqpfxEWcckkGJfMzFvSPGvuhQK7oB404-6DQ@mail.gmail.com>
Subject: Re: [GIT PULL] C-SKY(csky) Port for Linux 4.20
To:     ren_guo@c-sky.com
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <marc.zyngier@arm.com>, peterz@infradead.org,
        Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org, c-sky_gcc_upstream@c-sky.com,
        guoren1983@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 11:09 PM Guo Ren <ren_guo@c-sky.com> wrote:
>
> The following changes since commit 84df9525b0c27f3ebc2ebb1864fa62a97fdedb7d:
>
>   Linux 4.19 (2018-10-22 07:37:37 +0100)
>
> are available in the git repository at:
>
>   https://github.com/c-sky/csky-linux.git tags/csky-for-linus-4.20
>
> for you to fetch changes up to 2347e7e1aea410865e3c3f92014b07ff7d4c5b02:
>
>   dt-bindings: interrupt-controller: C-SKY APB intc (2018-10-26 00:54:31 +0800)
>
> ----------------------------------------------------------------
> This tag contains the Linux port for C-SKY(csky) based on linux-4.19
> Release, which has been through 10 rounds of review on mailing list.
>
> We almost got the Acked-by/Reviewed-by of all patches except "Process
> management and Signal", but all've been tested.

I just noticed a couple of build related issues. First, you agreed to
remove the built-in dtb part way back on v1[1], but that's still
there. Please remove it. As Arnd mentioned that is for legacy use and
we shouldn't be adding that for new arches.

Second, the dtb build infrastructure was re-worked for 4.20. See
commit 37c8a5fafa3b ("kbuild: consolidate Devicetree dtb build
rules"). You'll need similar changes for c-sky as other arches. It's
mostly deleting lines.

Rob

[1] https://lkml.org/lkml/2018/3/21/332
