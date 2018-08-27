Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C90C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 21:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDD0C208B4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 21:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="TiCcnIGY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDD0C208B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbeH1BL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 21:11:59 -0400
Received: from ozlabs.org ([203.11.71.1]:45089 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727199AbeH1BL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 21:11:59 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41zlHT5J5fz9s47;
        Tue, 28 Aug 2018 07:23:33 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1535405014;
        bh=P+R8RjgEeibySxefzvy3NtVX7eVlhM+GKhnm5llztMo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TiCcnIGYEoiQLmPwYgEmld0hGz/4/w91JfDFN1Wz3Ic1H5Lr/mJTYgvDc7qQ6Sj2s
         AFUOYYbrrAwTONq9Fat+UTi8M/uyW+wCbRhCZ0x/IkF6Zc/MzOH4jniIqtgIugyVQ2
         6bWoMzw6AAIUIBNfSD/N5+oj51O287atkxZULi13jpkbWU4wiCRiK4NbCxXRH3f/OQ
         ldFD42ez0xb87cSGu1LW8YfBaAcwOwOhpYFEAOxekkX+9cV9JaxP/9ynmqcx679q1q
         0oSVWOH5WmVAtnGWV8hdfRX/a0rVdNjhMq+SnAD4MSdWn7QdpvSdJ4/3SXN1EYd2ar
         +A5uvyb2RhNKw==
Date:   Tue, 28 Aug 2018 07:23:33 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warnings from the build of Linus' tree
Message-ID: <20180828072333.36af4d5d@canb.auug.org.au>
In-Reply-To: <20180826171058.e07f99e6e03f7497e5a46ed3@kernel.org>
References: <20180824133206.4218c2e5@canb.auug.org.au>
        <20180824172053.20fa197294f51496dcec5605@kernel.org>
        <20180824204756.e787765461975cd1e27502dc@kernel.org>
        <20180824224211.2934d7c0@canb.auug.org.au>
        <20180826171058.e07f99e6e03f7497e5a46ed3@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_//omMfqXpt1An4ALDYVQP7Lp"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//omMfqXpt1An4ALDYVQP7Lp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Masami,

On Sun, 26 Aug 2018 17:10:58 +0900 Masami Hiramatsu <mhiramat@kernel.org> w=
rote:
>
> Hmm, unfortunately, I couldn't reproduce the ".data..LPBX1" error with
> my gcc-8.1.0 + ld-2.30 distributed at https://cdn.kernel.org/pub/tools/cr=
osstool/.
> Could you also try to enable CONFIG_GCOV_PROFILE_ALL=3Dy and build the ke=
rnel?
> If it causes similar error, it should be caused by gcov support.

Using the allyesconfig as a base and disabling CONFIG_COMPILE_TESTING
allowed me to enable COMFIG_GCOV_PROFILE_ALL, but that just generated a
lot more messages.  Some about data..Lusan sections (I think).

--=20
Cheers,
Stephen Rothwell

--Sig_//omMfqXpt1An4ALDYVQP7Lp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluEa9UACgkQAVBC80lX
0GzUAAf/dzQZ4V9HiAcBkm6EQIGvlTA2Wf+LfXobKYTxDQUAGLSR0ztWBB4bnhHo
lBxafIkS/8RwYCxOudRIKUiBAiQqNN5R02s9calBax3uowsEmw9BmN3f39qTixsl
ahAuCRsgrfzfUp0LZCDFG3UQb9qEfExqe+nCfknhoNjrN0JkMBEmtpPfW2i3zEVj
X9aIJtoWr8LKzwJ5CFurWZCqPieqdsZosPuOMX6z2PVPSqivkMMr+J1UeEoS1Fxq
jynshQqNWU9AYnJ1AQp8wTCv5+yT5OwEoOkgaVQJxfFldnc4pDWmXeeJQxO6bwmQ
hHnnE+qyyknq/0evyNpsthZ0itrk2w==
=uoOO
-----END PGP SIGNATURE-----

--Sig_//omMfqXpt1An4ALDYVQP7Lp--
