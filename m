Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367FEC4161B
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 06:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE1A420865
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 06:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vPYQ+cNW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE1A420865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbeKYRHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 12:07:50 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39897 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727245AbeKYRHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 12:07:50 -0500
Received: by mail-pf1-f193.google.com with SMTP id c72so5039339pfc.6;
        Sat, 24 Nov 2018 22:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JGxxvjP1uf9aBMwNE2l4Fw52itgun4YZNtruaS9qrDA=;
        b=vPYQ+cNWo+fRUsG4fMTrkFG1U8w99QlZpifkpMmEKarVo+xc1c8nwAHQdbQnGTEMzJ
         d+gzs2GXMfqGBFRDSdcTgjMFIbHZM0Cg3N6iHykr6lYEnXhZ9dGObEnyL81LP2Hk1Lgd
         4RO02GIqQks1utjWWWhdJstihkIpPi8CnW2Sc/9xB7ZCRABxGvDpgtTJJjWZT6xqTtZc
         7Afq3+Xgzzsy9YebXvEtuxkf8HPG2MzOl7+84KQnEC4PhK0DKB+DbVERr7FOpZ8dJ7Lo
         ypY1Kyg07SGl2oafatd8AMJwqjFWtY3EKuv7D8n6C0oB1jrH7An2Q2PEoyiTpF44QBr3
         /8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=JGxxvjP1uf9aBMwNE2l4Fw52itgun4YZNtruaS9qrDA=;
        b=EgFhSCizcA0i2riLo0fT6OjNp9X//8mLJ5sDjZCYzFyR/bm0F3gxcrduxs4ccWh/dZ
         fiwgtbwHPcMB1zFCaXhrSbhHIaPQXAt6vdrNwciNqBSk28/XMMQx4R3YEeOzSCag4Ic2
         0Zk3gUw6emBlj2DNNAExThtM1HmqcGSSgDVZxrCJvvGhF1vMo6xuTVYfM19gV166n4Zn
         Jey8rQLLvBcqVBOItQk1ydObCANOh4L1YcifkZnyQA91lAx/s3zgzHBmVSrjvI7BER9Y
         E9Cb7NjTWDBG1Achefp7zSC3l9FoYxv2t7gYVjxiHajwwelBIxqkN//UJ2fqxkAURl8Z
         wOMw==
X-Gm-Message-State: AA+aEWbQ6lKoIoRYUC/9yfavJ6THNAzcaIwJLUKnF3TvnKaj2+3qyJf/
        nFC7LFttHfnhxPGtDWnHymI=
X-Google-Smtp-Source: AFSGD/XdPfsvkakAaH4uaahhINbcnBDdJ5/jjrSFzdUo1IKEgXfytx9l1rv3xc45jcjhejvXSccKwA==
X-Received: by 2002:a63:3287:: with SMTP id y129mr20116782pgy.337.1543126649671;
        Sat, 24 Nov 2018 22:17:29 -0800 (PST)
Received: from gmail.com (cpe-98-150-136-16.hawaii.res.rr.com. [98.150.136.16])
        by smtp.gmail.com with ESMTPSA id f22-v6sm62742673pfn.177.2018.11.24.22.17.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 24 Nov 2018 22:17:28 -0800 (PST)
Date:   Sat, 24 Nov 2018 20:17:26 -1000
From:   Joey Pabalinas <joeypabalinas@gmail.com>
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Joey Pabalinas <joeypabalinas@gmail.com>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        strace-devel@lists.strace.io
Subject: Re: Re: [PATCH RESEND v3 1/3] ptrace: pass type of a syscall-stop in
 ptrace_message
Message-ID: <20181125061726.jtalb5t4tgigzzue@gmail.com>
Mail-Followup-To: Joey Pabalinas <joeypabalinas@gmail.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        Eugene Syromyatnikov <esyr@redhat.com>, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, strace-devel@lists.strace.io
References: <20181125022150.46258a20@akathisia>
 <20181125022227.55e8caf7@akathisia>
 <20181125015402.glcaw3kghcu4pr22@gmail.com>
 <20181125021059.GA1190@altlinux.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4ktpenoxjmibnb6h"
Content-Disposition: inline
In-Reply-To: <20181125021059.GA1190@altlinux.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4ktpenoxjmibnb6h
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 25, 2018 at 05:10:59AM +0300, Dmitry V. Levin wrote:
> Given that without this patch the value returned by PTRACE_GETEVENTMSG
> during syscall stop is undefined, we need two different ptrace_message
> values that cannot be set by other ptrace events to enable reliable
> identification of syscall-enter-stop and syscall-exit-stop in userspace:
> if we make PTRACE_GETEVENTMSG return 0 or any other value routinely set by
> other ptrace events, it would be hard for userspace to find out whether
> the kernel implements new semantics or not.

Ah, I see, I agree that definitely makes sense.

--=20
Cheers,
Joey Pabalinas

--4ktpenoxjmibnb6h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEENpTlWU2hUK/KMvHp2rGdfm9DtVIFAlv6PnUACgkQ2rGdfm9D
tVLTKBAAwZqcHYLXU10sq1ZI/dIsYmjVmsCSC7bhuxjAi3cVnkw89BqlbTBfl8s5
bJcVhmPayYWCWE2paglX31lp1DKKtvWiFkbLE2jF601rAYekH69ty5Qvx8DMcrQV
Ar2rnb8KECJE7pf9Fdexpx+FyhaM6wkj04YkysMOSEBbBA5ue4pSA5yIkO142jqw
WRlqYBwYqGkNXWW74Ea8ZNEFPZxMrvBtI2olwqEs99erNGpTcafuchTAhdrKuDKZ
62zQEnD229IDXeLZV5+rbbyT7UiWb2xuw/xcOreCRhd8EArxgvFc5VcuywHTI6DM
nPhWsvw7+XUXHpq406m5mLMq1TJMUwrCw+wQjfmaLvehOm+p16z9F3nsjAvUU/ez
bGbTpgv/315EVtm8nqWl1s6pbBgK9cxnIl1DFmKptWbIl96FlSTCo1cOS4fRUNUC
1pgAUh2sVTxuTdARAmTkfKOmj1WoVnVJ+qke+0j/Knye9poolvZngb0PgaKdEwps
i3Wq3OSv7OUGjwIPlYy3oAblfZpC4mhDe9uV+ytzGWfqJoY4hcyXAVOL6rXHx9ih
XxnxIMd/vpKyc882gzKZ3wc6JOMl2QdJ2nPwb9OeK6qls3csaCHWa9ty4+tnUitk
nbN53QvbmBiGDHJjTa6Tj9Lu40Buguhoipqu38ynV18XuUrKKQQ=
=yO6t
-----END PGP SIGNATURE-----

--4ktpenoxjmibnb6h--
