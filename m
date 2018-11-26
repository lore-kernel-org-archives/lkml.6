Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0375C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E647208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTjvufb0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E647208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbeK0Ict (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 03:32:49 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40281 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbeK0Ict (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 03:32:49 -0500
Received: by mail-pg1-f193.google.com with SMTP id z10so6776803pgp.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 13:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UVFC4wG7FPzpHHIFTU84k4j33ssVBLwPG9hwAg+pavc=;
        b=iTjvufb0tLkxfLU3We973aK9g8FYNEz8S8hcVketXEXr8c9kZwmUY+IKHGD/9V3VUX
         a4Lkwnq38nkYXirjfr36Vdm9wAFuhgsso34WWP8UBteMDoo+BlxA/qDf7Wt5qRXeuPnB
         DPg0yTZT6ysNyLJTxZWjsFgFLqWi/aorZ/AILcVf8jIN2jgKFj7UdoQLA0sCjV6V6jls
         jxuiEi8ZbKYqSJrVZc1scBxlWvGeytpFtrDuNmiv2Q2UoNBdNZR3RSP1HCftEvEp7I7V
         5l/He9XxAb2IcxMOnGcKghPXzoZNgAD0VNaOhXmdftiZxcX+s9R3LzDrBt6ik6MtegJL
         1dEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=UVFC4wG7FPzpHHIFTU84k4j33ssVBLwPG9hwAg+pavc=;
        b=eVfANkBIzcQrqN6uZZwIie6alNe7Hf+SHZBVGayPeKxDHfiCz5SVrCt/hp7hqpG/YZ
         Jhm6/0h0VpneBr4kj1nKeETtkl9/skSrcAkjb40zAEIF4/nL3QZukE6gaa+IkGAuE+Ea
         kDOkNAFJ7ymJbQgG3qN2Di0/WAyL8JTewaskc/qCSGqKI2UJVVY5vinrvb3lTX7h7Co/
         3PV98SDEWOGLrXyBo2qtFtJIRE/7W1tbZ3aPay6pWC0svqI2KTHHWKl+0C6ti42+YAvt
         ggcVhOrW9SJeWBGOqujSjWDjfAnV6Dbrqj1+cnr7fok0zf/DxJrgpuMbxk6p6lj08vSM
         Q1fw==
X-Gm-Message-State: AA+aEWaadk1rbl/42w55u1gl2G+OOQO/G7FPt/zQfSGuOyMiXyHivM+s
        NmBRd+c0XwwcaIY2srcwlyc72wW173a7qw==
X-Google-Smtp-Source: AFSGD/WS0cMuiLFLEUwr14tSGTdZ+Y8mcPSbQJYqjtryaUKl3v8TJ1RKeP6Z+hc3XDqg+3bxXSyCaw==
X-Received: by 2002:a63:b4c:: with SMTP id a12mr27086750pgl.131.1543268239562;
        Mon, 26 Nov 2018 13:37:19 -0800 (PST)
Received: from gmail.com (cpe-98-150-136-16.hawaii.res.rr.com. [98.150.136.16])
        by smtp.gmail.com with ESMTPSA id d25sm1855914pfe.40.2018.11.26.13.37.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 13:37:18 -0800 (PST)
Date:   Mon, 26 Nov 2018 11:37:15 -1000
From:   Joey Pabalinas <joeypabalinas@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Joey Pabalinas <joeypabalinas@gmail.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: Re: [RFC][PATCH 08/14] function_graph: Remove unused
 task_curr_ret_stack()
Message-ID: <20181126213715.s2bn3wztxqikee35@gmail.com>
Mail-Followup-To: Joey Pabalinas <joeypabalinas@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20181122012708.491151844@goodmis.org>
 <20181122012803.706044851@goodmis.org>
 <20181126100207.3kcu2ej5eoxzubqq@gmail.com>
 <20181126162750.500a7dbd@gandalf.local.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d65uo5mk5fmomzrh"
Content-Disposition: inline
In-Reply-To: <20181126162750.500a7dbd@gandalf.local.home>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d65uo5mk5fmomzrh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 26, 2018 at 04:27:50PM -0500, Steven Rostedt wrote:
> On Mon, 26 Nov 2018 00:02:07 -1000
> Joey Pabalinas <joeypabalinas@gmail.com> wrote:
>=20
> > On Wed, Nov 21, 2018 at 08:27:16PM -0500, Steven Rostedt wrote:
> > > The static inline function task_curr_ret_stack() is unused, remove it=
=2E =20
> >=20
> > Just want ot make sure I understand this correctly, instead of using th=
is
> > function, the convention now is to just directly assign `t->curr_ret_st=
ack =3D -1`?
> >=20
>=20
> Not sure what you mean. This function would just return the value of
> curr_ret_stack, it didn't modify it.
>=20
> -- Steve

Sorry for wording it a bit weird, I was mostly trying to figure out what
these functions were originally used for. The uses I found in the git
log were mostly things like:

	ret =3D trace_vprintk(ip, task_curr_ret_stack(current), fmt, ap);

I guess the 2nd argument for these trace functions are implicit now and
these functions are no longer needed anywhere?

--=20
Cheers,
Joey Pabalinas

--d65uo5mk5fmomzrh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEENpTlWU2hUK/KMvHp2rGdfm9DtVIFAlv8Z4oACgkQ2rGdfm9D
tVK0BhAA2GbW7eXXtwN3wIz4qF4gUrXpUZ5fGXcWp7tn+nOaNlvLpmQ/0GpYU09D
trJhFqspht+8dAv95Y5I1Eajfo3n/fDP5snaggI2fNfWUBG5nS947SsI8L5hwIUW
fMFGHjO4xYzkGMBxa2bR4MyG2ObyYXsVjGoGrHdYXA5mmDfqIlnDb5XJL3cTPw5Y
ze45/kBGxhSojsDnwbKmfqprub9bHv3Jb16/QvOvwZuMAwem9qfppkCC8K9hif/s
bW6lZLXc30WJOsQM8/VX3Ld4s2KfpBYR1XmdJcrieveEaB/ywe74F1lq+lAnfgdq
3wNTNNmLndQ4hqfMNQjQiNpvlLybcIKta46y1Kx5SLNKCvLDaW+rAwlmmCnV99DG
34XLXCasalsw7oIvYMgXLKg/IPoMh/+sRZquLHTCeZwc18u7FWdFbyNoA0EbLg9f
2ggTR/kP7eBTVIN7cTEGWN1x5lznCO1zAMfzP0EP9yqdulcBQBoSbxXBqJJ8mS+c
bwycRVu4IY75Wyw/XRNmZ9p0+PkjwDEKdOi2ZhWpppa+ISREEukzltG3/nIDGkPA
6BCY1tWSrNubBA9gs9DwUPo7+ng08REPRq58hiPb4dIM1h7S+8WbmcJqwc1KZiq9
OqE3h4dxFJY5wVCV659TDtd7vZnt1csiI8XodiudAdXm1LibRmY=
=nyIq
-----END PGP SIGNATURE-----

--d65uo5mk5fmomzrh--
