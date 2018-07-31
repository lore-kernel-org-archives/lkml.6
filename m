Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542A5C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 11:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFF3A208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 11:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="m9me2c1l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFF3A208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732009AbeGaNHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 09:07:23 -0400
Received: from ozlabs.org ([203.11.71.1]:49667 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731639AbeGaNHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 09:07:22 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41fvL82Myfz9s1x;
        Tue, 31 Jul 2018 21:27:26 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1533036449;
        bh=S24hrPLDR9eO/LGQL6jnXPQzZdCQlqFrpEiLf7Z/1UM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m9me2c1l97/1NMIpinRPI4PADcGlfncexf1AQC3hyUL7VOo9uvrw3ymwFT3+5Nibw
         e5Q682mVpJKLRWvQIunKXdrcVvV+CfKizL/fjt9VADMLyw+XHDCzMLvkDcOKyoVaHD
         7K9FoEUAFRmAi+I9nBt4dKzNoeVMowRtsvXRbe3lt7BukyM+/f491DPXf1ce46ONeD
         JeOapmPI6JKibL6A7lnyFvTeCpTDbUt6SCdvsYNPxN8ANbnIHYfl7FONX++/JalLWx
         344KKxeoXsq9VJrsH+7iI0iIHNCKPMYJyxD0cIv4EcOLwlEz59KbEdJ/G1OXfBAdRX
         kkXmpxSIVgfwA==
Date:   Tue, 31 Jul 2018 21:27:25 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Kees Cook <keescook@google.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Popov <alex.popov@linux.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Laura Abbott <labbott@redhat.com>
Subject: Re: linux-next: build failure after merge of the kspp tree
Message-ID: <20180731212725.5523d5dd@canb.auug.org.au>
In-Reply-To: <20180731100918.GC23281@arm.com>
References: <20180727190207.7ce1c9b0@canb.auug.org.au>
        <20180727190647.3525f5f7@canb.auug.org.au>
        <20180727205511.7c0f2e62@canb.auug.org.au>
        <20180727125522.GA6173@arm.com>
        <20180730173356.694fbf4e@canb.auug.org.au>
        <20180731100918.GC23281@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/h_Pcn/AX+rHq_Hoij_BAYX8"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/h_Pcn/AX+rHq_Hoij_BAYX8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Will,

On Tue, 31 Jul 2018 11:09:18 +0100 Will Deacon <will.deacon@arm.com> wrote:
>
> I've pushed out Laura's fix to the arm64 for-next/core branch, so this
> should be resolved in the next next.

Thanks.  I actually applied Laura's patch to today's linux-next as well.

--=20
Cheers,
Stephen Rothwell

--Sig_/h_Pcn/AX+rHq_Hoij_BAYX8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltgR50ACgkQAVBC80lX
0Gxkggf+I5vS7vNiekkQqPRuo9x5AE+WdFyzudW9KS82YsscJXsd7tDT6jjI7/T0
EEiygPK0fuj9KotzIJ9xJsksCB5OXrlPwkEn74ApMh1BryWhtkjqi2ER6wPCuO5n
mw13WG1uEEj4RZAUBZpY83I/OXgO+kQzprGy9nWvp44VGYMhnmLSZszOpNpHravy
4Mo/VYOdAiWHy6595CITi2Ne0M/gtzCqPqF71JgS95qK3ROJw7A2unx9oDP3O5Y3
hsu46Rl08JtynbieVixUXhdk2O764QBHpLFNJoCwY/vVgz7wiQBJgrD8BFJIrROy
QZObclEv1wfq8vyRYp4XAhvXY9a2Zg==
=YBjO
-----END PGP SIGNATURE-----

--Sig_/h_Pcn/AX+rHq_Hoij_BAYX8--
