Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309EEC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A18BD21537
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.ch header.i=@protonmail.ch header.b="nAqR3YEs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A18BD21537
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=protonmail.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbeI0DBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 23:01:50 -0400
Received: from mail-40135.protonmail.ch ([185.70.40.135]:37381 "EHLO
        mail-40135.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbeI0DBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 23:01:50 -0400
Date:   Wed, 26 Sep 2018 20:47:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
        s=default; t=1537994824;
        bh=4Mvr1/KVuC6V/lUHO1HHuOOD/Jq9Xg/AhjROziIrmgg=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=nAqR3YEs6Rp1mR7uPjwc/ekZ9Re9pBd7moW+9QBzLxnK2db26H6FXNEJMv7r4KaP2
         U1uOxVZ/x5N1noQJl+ic6GfAvvoPxd7DHvYOromwB5KfWaiuaM0WKEr1tzn5JgTTt/
         KaYUAPEq1xu6T0xHpe4AOgVLWPWabOC+akMCevZc=
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Jordan Glover <Golden_Miller83@protonmail.ch>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Reply-To: Jordan Glover <Golden_Miller83@protonmail.ch>
Subject: Re: Linux 4.19-rc5: Missing iommu fix
Message-ID: <1eoZuKZCC_M_pHNio6_-AJoLPBDTI_RoPWKupVF0ge7XQ1DDM_HkLXiyzPIR-Ly2c5RvtW-mdDDn0R0q1X_usrnJYLDWqndqwu2I7OBElU4=@protonmail.ch>
In-Reply-To: <20180926195917.GB20689@kroah.com>
References: <CA+icZUUdxjVe4p-9aui0cqj_EiHD3O2VZ=dW8HqWf-+9jqnWCA@mail.gmail.com>
 <20180926195917.GB20689@kroah.com>
Feedback-ID: QEdvdaLhFJaqnofhWA-dldGwsuoeDdDw7vz0UPs8r8sanA3bIt8zJdf4aDqYKSy4gJuZ0WvFYJtvq21y6ge_uQ==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Wednesday, September 26, 2018 9:59 PM, Greg Kroah-Hartman <gregkh@linuxf=
oundation.org> wrote:

> On Mon, Sep 24, 2018 at 11:33:39AM +0200, Sedat Dilek wrote:
>
> > Hi Greg,
> > thanks and congrats for this release.
> > Me and several other people have an issue with "intel_iommu=3Don" (see
> > [1]) and a patch is pending in [2].
> > Unfortunately, it is not in linux-iommu Git.
> > Hope this will soon happen.
> > Just want to inform you and let people know if they have a similiar pro=
blem.
>
> Is this all now merged properly?
>
> thanks,
>
> greg k-h
>

Yes it is:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Dbe9e6598aeb0db70a7927d6b3bb4d3d6fb1c3e18

Thank you.

Jordan
