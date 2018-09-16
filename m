Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F78ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 15:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BD3C206B8
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 15:17:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BD3C206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbeIPUkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 16:40:33 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49166 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726852AbeIPUkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 16:40:32 -0400
Received: from ben by shadbolt.decadent.org.uk with local (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g1YnJ-0007dc-62; Sun, 16 Sep 2018 16:17:05 +0100
Date:   Sun, 16 Sep 2018 16:17:05 +0100
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Message-ID: <20180916151704.GF4765@decadent.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eNMatiwYGLtwo1cJ"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: ben@decadent.org.uk
Subject: [PATCH] perf Documentation: Fix out-of-tree asciidoctor man page
 generation
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on shadbolt.decadent.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eNMatiwYGLtwo1cJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The dependency for the man page rule using asciidoctor incorrectly
specifies a source file in $(OUTPUT).  When building out-of-tree, the
source file is not found, resulting in a fall-back to the following
rule which uses xmlto.

Fixes: ffef80ecf89f ("perf Documentation: Support for asciidoctor")
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/tools/perf/Documentation/Makefile
+++ b/tools/perf/Documentation/Makefile
@@ -285,7 +285,7 @@ $(MAN_HTML): $(OUTPUT)%.html : %.txt
 	mv $@+ $@
=20
 ifdef USE_ASCIIDOCTOR
-$(OUTPUT)%.1 $(OUTPUT)%.5 $(OUTPUT)%.7 : $(OUTPUT)%.txt
+$(OUTPUT)%.1 $(OUTPUT)%.5 $(OUTPUT)%.7 : %.txt
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
 	$(ASCIIDOC) -b manpage -d manpage \
 		$(ASCIIDOC_EXTRA) -aperf_version=3D$(PERF_VERSION) -o $@+ $< && \

--eNMatiwYGLtwo1cJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBW55z8Oe/yOyVhhEJAQpJdBAAj1ue1pm4008VdtT2olOAY6WuLRweIbrq
QUXc44rIMlP/8os7pC80Dgtn3byUY4j3PFFnwcJLFKn9WKymqFXM2jAPuQePcDCY
rZjHIhhIV2qePLH7qE+9EsZ7LhlyJDnk/f1v4yqhAZtg/1W5JT5eZN8v1mEMjLlN
y4Yid5YWV0z4vEd7AJUw51hSXGcxNGK4lASqneY8KLfS53q0feFIcD9YKAkWAFnD
X1FWpAFmdLwwXbrdJc0s+yL7K8qw1jfkr/clqOpIWY0EY1apFRkJKi+hMpSdO9th
wo1AqVhS3lM9WLs5UnaPfQDIatTixVKqbR+SpbEp2NJgtvJKodYP0MIm1+/JRl7d
KLjqTafsdknt78hKq4hg73BC3z4+PiFHE+2Na7Zc/NaBxStUD9qbUMVskQAs0rmj
la0O5wBqbi5ir5VEW4eie/huyXEvmijPQnrIFPeayi90TQVhuKjVPIvHs5ms20vd
jKmq67Fc84aUvvX+Ver9cJQV4fLaorgKLUIbHX0R4Q9B39L64z7S5UKXEqT/sIFR
VrlvSKjK90jDWUGVdxzp2h7LBmgfo4XsIHM4bgzWCvslHcCr5axNYOPPLAUHWeFh
LLZws8hZESz/tZPUJKvGkL519sng9+ggEfZ3xWUoSOp+CnTOSPnq/+0WLRqMCqB2
AEho7O2hjcM=
=REKT
-----END PGP SIGNATURE-----

--eNMatiwYGLtwo1cJ--
