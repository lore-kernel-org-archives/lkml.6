Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC54C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 07:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F3A12081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 07:58:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F3A12081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cyphar.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbeKBRE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 13:04:56 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:11326 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727387AbeKBRE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 13:04:56 -0400
Received: from smtp2.mailbox.org (unknown [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 100A543409;
        Fri,  2 Nov 2018 08:58:37 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id mW1eQMjYusdU; Fri,  2 Nov 2018 08:58:32 +0100 (CET)
Date:   Fri, 2 Nov 2018 18:58:18 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Brendan Gregg <bgregg@netflix.com>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <asarai@suse.de>, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v3 1/2] kretprobe: produce sane stack traces
Message-ID: <20181102075818.fk55mxb3snqj5rjt@yavin>
References: <20181101083551.3805-1-cyphar@cyphar.com>
 <20181101083551.3805-2-cyphar@cyphar.com>
 <20181101204720.6ed3fe37@vmware.local.home>
 <20181102050509.tw3dhvj5urudvtjl@yavin>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ohgwqw7to7laxvft"
Content-Disposition: inline
In-Reply-To: <20181102050509.tw3dhvj5urudvtjl@yavin>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ohgwqw7to7laxvft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018-11-02, Aleksa Sarai <cyphar@cyphar.com> wrote:
> Unfortunately, I'm having a lot of trouble understanding how the current
> ftrace hooking works -- ORC has a couple of ftrace hooks that seem
> reasonable on the surface but I don't understand (for instance) how
> HAVE_FUNCTION_GRAPH_RET_ADDR_PTR *actually* works. Though your comment
> appears to indicate that it doesn't work for stack traces?

Sorry, I just figured out how it works! (To make sure I actually
understand -- retp is a pointer to the place in the stack where the
return address is stored, so it uniquely specifies what each trampoline
actually points to -- this trick could also be used for kretprobes).

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--ohgwqw7to7laxvft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb6Gz4/mhjNy+aiz1Snvnv3Dem58FAlvcA5cACgkQSnvnv3De
m5/Fbg//cNaNafzuvOJBuDYI+bTOXGARp3LQ1DyqUSj7Qmak6e5vxtjF6AQgkhs0
HH9bGvIXRfUaWU5bRSCMOkXsRVs3vsuQK7RkDjOx9n3AOtu5+eXay6k/opldFjcG
qRXfiiplsB8ijwF6o1shm95v/g9hsr0hRuP7mxFGdqmbH17i7pJ0VEYFjAIS0+b0
130oOQvP119GVM3wRaOWN88N4DqVjCW5WWURfdWVzH31c9VQzSYy6p7Y/t0ZLkiW
gOOi3/7JrE9dqj2Qp/+dSRa2MEzgD3mHCrcVTDwalR5NScuoDrJQEXHSkrRnborJ
vZ8vDuwuVVNidRys7bH/EE4DSevswoExpNN1OtYKm6f7h3C35DMEyws6MgitHGXI
F4yy07AUFoBUkMZKaFI51Y8gCQZEUv2MvLK+i+Pf0gW1nZNnORUOx4/WnVxO4XTZ
IXoT/Exq8RMVnmEzOQHn6wWSgVLXQvel/TzwoDfbbZb4EJYbs9EevNx9QYcRhPYq
Inte2hnvEW8MWufrxhJKHwE2lbMV90OX6bM4O+4TDZn1F8/Z5BdNI0xQ3K/zi4K/
dWeXvFhkiCPoLsORSzqeby5bUp6c8gjzPNaWQC8BrWwZuSSzX85Dtcs3qIMOrzIj
smbXYhS0nE1FdEIqeZ6RWNPHLHGRyDCHAvZ8mz55H+4+ZIxtqv8=
=kzT1
-----END PGP SIGNATURE-----

--ohgwqw7to7laxvft--
