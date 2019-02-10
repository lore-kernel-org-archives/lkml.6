Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEEBC282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 18:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A008213F2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 18:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VekFdBVt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfBJSO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 13:14:27 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44768 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfBJSO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 13:14:27 -0500
Received: by mail-lf1-f66.google.com with SMTP id g2so751971lfh.11
        for <linux-kernel@vger.kernel.org>; Sun, 10 Feb 2019 10:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=30SpIIvIwmNkmS25lx5v09Jh7dFj4Q7imgsmbeRlLc8=;
        b=VekFdBVtJDCZcDSLcyNkYhnGKfDxHl3EUX9i0kWKzb8iLeCiECpYqVmXBJI3dAaw1S
         NKJQDUOOM3aYCwhdyfBfl9ID8RJnqMpAe0yBti2nwMUG9APDOIuj2sCcy6sk1Z28HL2Z
         H0ZDhp45/gw8mRCV+mA4nC60mR/jGvm3lxC+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=30SpIIvIwmNkmS25lx5v09Jh7dFj4Q7imgsmbeRlLc8=;
        b=TerVnmtyJoAJMatoDJXLSMyyPsz1LE8QXs7n4IC/pxhqjnfEFS6tspnEfOWPAE1AVh
         1ApAKkmXSPI4n/UgP5zRbVtwsmSQDbBamJGGIqFj1pEaM/COyGA956/UTlMXGAuMtaed
         H1ZUQ58stP80gh8y9cre4OJVdQiqtn0U6sYpnEq1abiGzfG5WJzFD9BcYwUlIcN2WCdV
         GXALtRQr/HVbFmfcyahrxOcUHLdV9xhSZzyEWE9ffgo+cA+kMWlzpoahFUeNQjRs42gE
         NDk2QVMlZliCtGkiSMYCrLk2Lv2oWeCJxZgK4nSqrefguHFQP0dURqW4dLlE3PnmRBv+
         JtfQ==
X-Gm-Message-State: AHQUAub1Jtpieoclfw5GBBPadtSUZtYRzwSC1UiwjY+0AH7YQ9MHAwoR
        4gVgdcTwq+U3DjZt8LYYXKwZrJqHmBE=
X-Google-Smtp-Source: AHgI3IZwl3XDXiOrLnmVAOCzc9C7HocNpfHMEEZRSzSvcHqKrypGLUUDC9DX2nMbOBLNe930Wm4Tyg==
X-Received: by 2002:a19:a98f:: with SMTP id s137mr20685310lfe.18.1549822464426;
        Sun, 10 Feb 2019 10:14:24 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id u12sm1633072lfl.44.2019.02.10.10.14.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 10:14:23 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id s5-v6so6904435ljd.12
        for <linux-kernel@vger.kernel.org>; Sun, 10 Feb 2019 10:14:22 -0800 (PST)
X-Received: by 2002:a2e:96c9:: with SMTP id d9-v6mr4593593ljj.105.1549822462429;
 Sun, 10 Feb 2019 10:14:22 -0800 (PST)
MIME-Version: 1.0
References: <20190210074056.11842-1-jgross@suse.com>
In-Reply-To: <20190210074056.11842-1-jgross@suse.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 10 Feb 2019 10:14:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj4CYgo7=LJOcXmCOUS5ovcu6ep_TJQdHrEOoUO5G4PFA@mail.gmail.com>
Message-ID: <CAHk-=wj4CYgo7=LJOcXmCOUS5ovcu6ep_TJQdHrEOoUO5G4PFA@mail.gmail.com>
Subject: Re: [PATCH] x86: make set_pmd_at() paravirt aware
To:     Juergen Gross <jgross@suse.com>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        xen-devel@lists.xenproject.org,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        sstabellini@kernel.org, Peter Anvin <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sander Eikelenboom <linux@eikelenboom.it>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 9, 2019 at 11:41 PM Juergen Gross <jgross@suse.com> wrote:
>
> Make set_pmd_at() paravirt aware by just letting it use set_pmd().

Well, that was simpler than I worried.

Just checking: Is this purely an x86 issue? ARM is ok perhaps because
there's no PV support?

             Linus
