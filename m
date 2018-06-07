Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id UAhkAmf/GFuvBQAAmS7hNA
	; Thu, 07 Jun 2018 09:49:04 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 69B02607E7; Thu,  7 Jun 2018 09:49:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 221D6606DD;
	Thu,  7 Jun 2018 09:49:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 221D6606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753601AbeFGJtA (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 05:49:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:56459 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750919AbeFGJs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 05:48:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 286B2AD4A;
        Thu,  7 Jun 2018 09:48:58 +0000 (UTC)
From: NeilBrown <neilb@suse.com>
To: James Simmons <jsimmons@infradead.org>
Date: Thu, 07 Jun 2018 19:48:47 +1000
Cc: Oleg Drokin <oleg.drokin@intel.com>,
        Andreas Dilger <andreas.dilger@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lustre Development List <lustre-devel@lists.lustre.org>
Subject: Re: [PATCH 10/11] staging: lustre: move ldlm into ptlrpc
In-Reply-To: <alpine.LFD.2.21.1806070546210.23188@casper.infradead.org>
References: <152826510267.16761.14361003167157833896.stgit@noble> <152826511923.16761.9237280635711887801.stgit@noble> <alpine.LFD.2.21.1806070546210.23188@casper.infradead.org>
Message-ID: <87sh5zlyf4.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 07 2018, James Simmons wrote:

>> The ldlm code is built into the ptlrpc module, yet it lived in a
>> separate directory.  This requires filename editing in the Makefile
>> and make it difficult to e.g. build the .s file for code in ldlm.
>>=20
>> All the ldlm files have distinctive names so confusion from having
>> ptlrpc and ldlm in the same directory is unlikely.  So move them all
>> into ptlrpc.
>
> Nak. The reason is it would be nice to keep the directory structure.
> What really needs to be done and Oleg has looked into it is to reduced
> the number of modules created down to two, one for LNet and the other
> lustre.ko. This also is a step in the right direction to remove the
> create struct obd_ops and struct md_ops pointer madness. Well their
> is the issue with obd echo client but we can deal with this at a later=20
> date. Also the number of EXPORT_SYMBOLS and things will greatly reduce.

Yeah, you are probably right.
I had a bit of a look at how to build everything into a
single module.  You can do with by having a single make
file that lists parts from other directories - the same way
that ptlrpc includes files from ldlm - but that is rather ugly.

I've very nearly got it working using the lib-y infrastructure.
I can build lnet as a single module, but the dependency calc isn't
quite right so things happen in the wrong order.  The build
fails the first time because some files don't exist, then
succeeds on the second run.
Hopefully I'll figure out how to make it work tomorrow.

Thanks for the review,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlsY/4AACgkQOeye3VZi
gbnYWw//XUQQgqitDLcH3XdHXNQv4ntl7Ew4+hB9Buz9P+bA3xSDerjT5LSnqwGJ
WqbwtVNG3UYWlvGF1xSLOyb1BVFqYhV9S8D8g4ujo84CKwsQ90tU/v+v2q8HTr7c
aiz4hQTp9d9zPq7X8Zc0hXXFbT7yeB9O/xaxmouPRTSGDwc+5nZzEK5v5TkpKP8F
n86eUqyhW6jZZp/lbkDSMl1Gur6c89FaBGrDa3yPmhFuju9mDnYKy1CEye7UGfqL
l6CBdaiYIadwpoVUQpILZriigcfuTDCnKce+BGmINAepWHqWgBu1V2OPAUxXX69E
CwNc7IBH102C5/jsYlDX2RT6cnufttKWEeiDq1ih//eGBXiPiUQtKrKz3HSoo2qi
pElxegskA+P/q0J57yi4Z/OfgLdS0aClpxoTquW8BlERKG9RieBnfBFJCplUOcK0
u+ZR/LFlaZ5AbojbXVfj8AdN9cH17XRJWEWTZ07ahCGlQ45MUeEY/8hcDI+MwerP
XqZ7BDHAXuD8ACadOZOonCHjAw9mpc7qdgBRsdlV196cCUxAFWhNF+2GClpiJcL3
ekcPLJ9ljyjUyOXvMNWWHc01vklqbpVVWVAoy6xNTfcqXu0SLvyUTnQ3SfQGonTt
EgzFaMRy472HG8ezTdaxMkaepgJ+juABE1WrBNolks3qUR4RA0s=
=wWDY
-----END PGP SIGNATURE-----
--=-=-=--
