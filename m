Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC12AC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B833620834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:53:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B833620834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbeLAKEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 05:04:44 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:38730 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbeLAKEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 05:04:44 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id AD47C72CA65;
        Sat,  1 Dec 2018 01:53:50 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 9B1F27CC796; Sat,  1 Dec 2018 01:53:50 +0300 (MSK)
Date:   Sat, 1 Dec 2018 01:53:50 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        linux-api@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        strace-devel@lists.strace.io
Subject: Re: [PATCH v4 1/2] ptrace: save the type of syscall-stop in
 ptrace_message
Message-ID: <20181130225350.GA8096@altlinux.org>
References: <20181128130439.GB28206@altlinux.org>
 <20181128130601.GC28206@altlinux.org>
 <20181128134913.GC30395@redhat.com>
 <20181128140533.GF28206@altlinux.org>
 <20181128142006.GE30395@redhat.com>
 <20181128152346.GG28206@altlinux.org>
 <20181128221125.GA2800@altlinux.org>
 <20181129144742.GB10645@redhat.com>
 <20181129211044.GA20529@altlinux.org>
 <20181130112920.GD23670@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
In-Reply-To: <20181130112920.GD23670@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 30, 2018 at 12:29:21PM +0100, Oleg Nesterov wrote:
> On 11/30, Dmitry V. Levin wrote:
> > On Thu, Nov 29, 2018 at 03:47:43PM +0100, Oleg Nesterov wrote:
> >
> > > > so that PTRACE_GETEVENTMSG users can easily tell
> > > > whether this new semantics is supported by the kernel or not.
> > >
> > > Yes. And how much this can help? Again, an application can trivially =
detect
> > > if this feature implemented or not, and it should do this anyway if i=
t wants
> > > to (try to) use PTRACE_EVENTMSG_SYSCALL_ENTRY/EXIT ?
> >
> > How an application can easily detect whether this feature is implemente=
d?
>=20
> As I already said, it can just do ptrace(PTRACE_GET_SYSCALL_INFO, NULL) ?
> If it returns -EIO then this feature is not implemented. Any other error
> code (actually EINVAL or EFAULT) means it is implemented.

Fair enough.
We can change PTRACE_EVENTMSG_SYSCALL_ENTRY/EXIT to 1/2 if you like,
and document this trick somewhere.


--=20
ldv

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJcAb9+AAoJEAVFT+BVnCUI5qYP/jM4uf1ITca2zNNi1qDuHHv+
fk42Rqr2J5XTxa+gxMpVXhR3MvBtq6p3NRcWZ04YoFZlD6RGXVhAOjO/qDL/K64B
c3hgDcFVzAQgW4meGcBP6z4sU4jston0a+UAWaCrO5seC95LU+biBO6RMLlmxepw
0VHvczLcpFz9ikBmmOQs+6wfwtJCj56SVsxRSIscw5pJ845zX6+S6vMq4J1t0smC
k7iOgSiJYyPFIMVuhNWqUiqH7viY2H2JTRqBVNy6yBQvxb/Akfcdm6f1qHeJg3x1
NT8pg9Fxri0zRfZ9MnBSGinA3JeGMuMgZvDs5UweUQ4RRAnQkwfXkkJYMm/CmuXb
7V8kUhUNcDoNrYApwEKa5/j+QaNnDQGEGUlRC8GGs1qQM3dW5G5srUU1y0H6gmBb
Wnc+fuHgiJDdqdqlOZH641d/HRx1KplsJ3zHimEMWWk87zlwRlLtnT9zi+J5TWYn
X2bv/MfqunqUvHb5SmMu1nvMxEb9F32MkgfkdYF2bfiie9sv20FdO+m+pXLj0Jk0
BTzw+GpS0oqelTnAk0ZltSOZMXwlU3iJOsPKMzbVz/SEUKq1NGv3vaG4fDHYLsd0
v8fKde54QnKT9lvqTBop/Y38D4neA+c/SlCX9FdLqloScRr8t+oTtoe9DWgWEsA2
VN7U+Tqw8txlfk7X0ALS
=aZFi
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
