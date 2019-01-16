Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB88C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AFD520657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390246AbfAPPxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 10:53:49 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:36112 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbfAPPxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 10:53:48 -0500
Received: by mail-ot1-f43.google.com with SMTP id k98so8032940otk.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 07:53:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eAvxNtZoC7Ibcb7e6PHv9+1R2qLZQ9sqMFt1pZuFfCQ=;
        b=XnulpuJRLw0o3PsDLRAIgsVGr6rVmurjY6OxxX05c2Mkj7GSRqmXJCRxe9A612Em5Z
         ZGXuxnmweHZ20pxDNLppbHEdy9VVYEhK51f/VJxmeQiM8U/NfhWV14M5evRCfsXLfdA/
         AZF7GEomONygiZG1FbBBsSYVbPPhmGiPdJ9xOmKeycFqJyQ5Zr7hXxDjLu6fLU5mcJdJ
         emEYOGRPC+14razit2M0ieOfqEymqJVACkWzmD618+rHtNsrAdknOxkf9GEc0LJpPNtU
         hztgbQ1amgkUguVZ5X63Vtx76mp+vvZLNF6C2TZy7vUfxUSMb1sqTkrW9CxICv/7E4kA
         sPIw==
X-Gm-Message-State: AJcUukd/aN2dXGHm3TR0YFeBfDDawTorIXEw2QaCAzjumQY6Dz4pVi1G
        ++dDLUi7dWOKG6npkLpIbMVUb2vs04Rs0qXO5AkOGg==
X-Google-Smtp-Source: ALg8bN4ig5vmObzH6z9Il9ChXUS2MFKqXpPPysHeEkH/mZXt8xQC8sk+pgXFj9ISzDlYcXyWOq1OINcHDkuDSWsrCes=
X-Received: by 2002:a9d:39a6:: with SMTP id y35mr6368873otb.253.1547654028045;
 Wed, 16 Jan 2019 07:53:48 -0800 (PST)
MIME-Version: 1.0
References: <1541437840-29293-1-git-send-email-neelx@redhat.com>
 <tip-a786ef152cdcfebc923a67f63c7815806eefcf81@git.kernel.org>
 <CACjP9X-ax44OxjRmVPJaAu93ZJJySuuFO9mtsvSc6Lfpipzspw@mail.gmail.com> <alpine.DEB.2.21.1901112143540.1661@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1901112143540.1661@nanos.tec.linutronix.de>
From:   Daniel Vacek <neelx@redhat.com>
Date:   Wed, 16 Jan 2019 16:53:21 +0100
Message-ID: <CACjP9X_pwYyBvh6Zu0R1sbkzLoXJ7U2psFfK4wFeSz614_hvNA@mail.gmail.com>
Subject: Re: [tip:x86/timers] x86/tsc: Make calibration refinement more robust
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     mingo@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-tip-commits@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 10:03 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> No. The branch was not sent to Linus during the merge window due to holiday
> season induced oversight.

So does it wait for the next merge window now or is it still going to
be sent? This is actually worth stable branches. I've confirmations
from Hitachi and Nec that this really helps latest Skylake-X systems
boot reliably.

--nX
