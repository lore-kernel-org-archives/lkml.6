Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C53C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF90720873
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxQ7DpAT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF90720873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbeKZUzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 15:55:48 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37921 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbeKZUzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 15:55:47 -0500
Received: by mail-pl1-f195.google.com with SMTP id e5so13631936plb.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 02:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EI5BtG5paQ00Ah9guSo1nmyi36CwlgDSC08swm8W+Fw=;
        b=JxQ7DpATAoVzmAK1ePeHVJWC+pLPUewDC4TbxkIt9F3p7FbC+cKJbCEp69dnDAfjut
         WmAPc3o4ODvrAu1arTKkFJGmaMslbdPj95gEN3bfXFNGKhS7XmQg8SOXqSHOglLDOTZg
         JohhT5kCVlnS0sTDpNwmRNUm2o3lKvauoeLAAxIKRFnBRngDI+IXilw30x0lYAQLidZh
         AIQX1SrfGznMoIZnGOvRAkNdaJWnsZtZ2RSmd1xjT4h/6dpfOeke2p88nxhDqiMScyLM
         GHX2O4WR0qFI7gjHy0cuMOLB6Yc0oYx/MZHwTDzOq4hzP9aScSXfcpzyp3DKRV9zTeht
         ck6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=EI5BtG5paQ00Ah9guSo1nmyi36CwlgDSC08swm8W+Fw=;
        b=FZukH6MwkadKsxZKM8OdE4b0oXvel4BXQVVODWKu5WB1rFIyyk8ekT6yZwIbDWHriW
         yoE98GC4z3cpYmCrdudN7vjoJ4wKBY2s3O7zs4VWL8JO8weJHU37jMFIAy+Wa3OTi7e6
         QLnCU4ZXMGhJcQ4Ue7jCw+tr98APV8hsDTxsdkIzUMMj4GRZteCVtUYkPDPVVHRLwsbV
         GPQLsXXMb2q3BgqBZuy4DODhjaZufkdFxOYiUk12NlQ9N1811nIfdh0VuIBfs89HX9Df
         GLkszMKcJGi1VFuuMJJi/oUQKVunDpjNkOK5tICQYdcqRPsAY9nHa2QqVuS/1sR99svn
         h7VQ==
X-Gm-Message-State: AA+aEWawrdWHFTQr2g7AWriaORUBmurbX7vQa9XRWIJrtz72Xr++EKYd
        f/LHO9dkuKyQ7QxpE96aKTo=
X-Google-Smtp-Source: AFSGD/WS8Huo0Pxj4dDYKtoJfbNZsQJoauMP8adJPBTlan/Nr/yu9M2wkAU8/XrQ6OnE0ekc+G2ErQ==
X-Received: by 2002:a17:902:9a47:: with SMTP id x7-v6mr26975967plv.316.1543226531196;
        Mon, 26 Nov 2018 02:02:11 -0800 (PST)
Received: from gmail.com (cpe-98-150-136-16.hawaii.res.rr.com. [98.150.136.16])
        by smtp.gmail.com with ESMTPSA id n186sm40478496pfn.137.2018.11.26.02.02.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 02:02:10 -0800 (PST)
Date:   Mon, 26 Nov 2018 00:02:07 -1000
From:   Joey Pabalinas <joeypabalinas@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joey Pabalinas <joeypabalinas@gmail.com>
Subject: Re: [RFC][PATCH 08/14] function_graph: Remove unused
 task_curr_ret_stack()
Message-ID: <20181126100207.3kcu2ej5eoxzubqq@gmail.com>
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
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mitvxyijjs3f5rvv"
Content-Disposition: inline
In-Reply-To: <20181122012803.706044851@goodmis.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mitvxyijjs3f5rvv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 21, 2018 at 08:27:16PM -0500, Steven Rostedt wrote:
> The static inline function task_curr_ret_stack() is unused, remove it.

Just want ot make sure I understand this correctly, instead of using this
function, the convention now is to just directly assign `t->curr_ret_stack =
=3D -1`?

--=20
Cheers,
Joey Pabalinas

--mitvxyijjs3f5rvv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEENpTlWU2hUK/KMvHp2rGdfm9DtVIFAlv7xJ4ACgkQ2rGdfm9D
tVJKhBAA2Puw2mBGAf6NQxmCak48ypr1zz7qQghGbiUqzbeCkC3DZ401rfjfANlq
tP/ArhtPI0Hp2i3Bwootkvo0FbDld5uOdsc/ej7pTuQBkichkF0MzgCxsVBR3Yt+
onQ9+brVu3N3Gcq4qbjSBQrA8k2fTFbXvdbDeLrcbhj+7WuFwoz3d+c2TLsjTbPa
FZLMZdg8ZsMTHYwYelOHP4sr17Ow6RxFgiynTjmswsr/HaWEVcDBo6rDttzTELga
7r/Cg2mq5FpVbapjwwjXSW2KrAcPMV6uowtD9AiRKTtWeiDPGi49qi+bURljeTTc
gyoAQqU6wJK2OXsOYH8Ysbx2vvF77dMCMRzaCIbhjcd4hxSubLtSUWxbgacmqEiM
u+M+oP1hlPBsFN+DXmMto5mNJ/KWYOcmND5e7iabV/HBTJ9dZf9BjZZbXGiyhvy0
wq3CzBB7KzFuYnzzBpsXrSU6ZBOVLpUPSgHbJ2e4ELLvovrmkugmY931nibu3d0s
19stv0arRRu50a1UZW+i2atBKCdjB+ah3qfotCOjVzL8qlBTx0PazH29OtnKJXdE
vC56jdLcD9mZqSVb6ZOacSY9fnM9QOvYlSJHu5j+EMK5BEaLIxxCUoYppS7BDBx8
dJ8JV3NvM3OkBC9Wz8WW2+blWnJ17r2up+HvrY6/Invgtq2tncM=
=0p8Y
-----END PGP SIGNATURE-----

--mitvxyijjs3f5rvv--
