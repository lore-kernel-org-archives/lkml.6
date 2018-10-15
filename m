Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63F8C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 15:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75A3D2089D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 15:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cy/6IlOd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75A3D2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbeJOWqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 18:46:25 -0400
Received: from mail-qk1-f170.google.com ([209.85.222.170]:42074 "EHLO
        mail-qk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbeJOWqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 18:46:25 -0400
Received: by mail-qk1-f170.google.com with SMTP id g20-v6so11981882qke.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 08:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=it9sdntJnUAheJwRHJKa46U8K7Ep4vCABqTkQapRLNg=;
        b=Cy/6IlOdZ3aFNa6XhE8Or9UmBd1dfY73qlAS7/R9jgoKMblmhtE1iJyzUUY0mh+tyT
         dLeyLYWMji0SjLL6EumLHt5woNU7qf66O1zjW0jtMVYBMYjKPNp5BNNfz0ajVbUUqYRc
         Ob3unUwdOYHAeR8v89sRjBt8PX7/vJmZQZ37D20CCAYtcvQ1d2XqxfFcHpRhIV+SfeqA
         2XCLMnDT3BvgmGdbW8mYr7xmfzT5rlTSL6rVJCSAHwMCJGJdH2XrpAx8UMds1KzXUiAa
         Of4VslhItPMKC7ViHtLYkPVZZiAtSXuIQPJV6fMTddZ2mH71qbPdCcuJlzkdS8ImeFKc
         QpYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=it9sdntJnUAheJwRHJKa46U8K7Ep4vCABqTkQapRLNg=;
        b=l41p9r+WxBCPJFcmTzH2DAACR091szlG3URRICy9DyjC6D3OGofLubGz+cftOmzPjn
         UtaKpMtsk+bmS3Pnm8nvvMN0OxI3Saoom1Qfmb8YJfY9kju7SwS7NOYRbH1BOrZx2cVR
         Bvw/irpw7FqYcw8oR8nzcbJj8wFbAv5cFqoG0b0kRUYI5xU7uHW7UOYSKiejVHHAZNjm
         qWiWoKyXVIQ3qIFwWe/Olv8COho2xQ5HxuDvR1AOszRWknyr9c/CxMxdhOFvXHJ0BB/5
         xhhNzbi9kR6M+JVYmXgv+Zd6/YLc+cwzN4t5Thk6YxOJu3H9eRGOm849RaK6N9P9DUQ/
         lLvw==
X-Gm-Message-State: ABuFfogrcN2RmdUHp6eRTsjpDg7FtVHGAADhTra0/Mn14EQSUu4Nz5X9
        BC2319Fxhz9//wYKoxysDm8=
X-Google-Smtp-Source: ACcGV62wwk3NsyVej6dzAWgnfdabu1ZbcPv6XDtcPOV0sJeivFBOrqqQnJN4Xlfw6BVmC1Y63HZ9qQ==
X-Received: by 2002:a37:90c5:: with SMTP id s188-v6mr16243423qkd.104.1539615646593;
        Mon, 15 Oct 2018 08:00:46 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id y20-v6sm6729117qkb.46.2018.10.15.08.00.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 08:00:45 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 0FE4C2222F;
        Mon, 15 Oct 2018 11:00:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 15 Oct 2018 11:00:45 -0400
X-ME-Sender: <xms:nKvEW4adOqPasmRz14QFwWgjdpZtpITn9GxKuGD-Rk59hXo9SsRCqQ>
X-ME-Proxy: <xmx:nKvEW46gCxI0ZFf2d20Iy1cf9WqL5PdG8E73Oh5a0ZG-KP4P_FHZ2A>
    <xmx:nKvEWzUmXPWXtn888uIem6Xo94nb0300eUl04hhFNgeQAsz8MxVKlA>
    <xmx:nKvEW3AwAsBSoVDJ9ngaGbuBpwmCPsRIf_YnNCthv1oXrXFjXj6SIg>
    <xmx:nKvEWy5TngeAij3LVX3jqa9HMvl2I5mu66pOVb-Ysu9C-KavYF0Chw>
    <xmx:nKvEWyyluSr4d-kPwZu4x9qsH6JGDJi8ttEpa31UEUywcz-FBqbWvA>
    <xmx:navEW2gJbXpCZGSdg-RDQ_ck5hWzb-qpp-qROf9sco3oIBfuipARYw>
Received: from localhost (unknown [45.32.128.109])
        by mail.messagingengine.com (Postfix) with ESMTPA id E142CE4623;
        Mon, 15 Oct 2018 11:00:42 -0400 (EDT)
Date:   Mon, 15 Oct 2018 23:07:15 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        tglx@linutronix.de, Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] rcu: Use cpus_read_lock() while looking at
 cpu_online_mask
Message-ID: <20181015150715.GA2422@tardis>
References: <20180910135615.tr3cvipwbhq6xug4@linutronix.de>
 <20180911160532.GJ4225@linux.vnet.ibm.com>
 <20180911162142.cc3vgook2gctus4c@linutronix.de>
 <20180911170222.GO4225@linux.vnet.ibm.com>
 <20180919205521.GE902964@devbig004.ftw2.facebook.com>
 <20180919221140.GH4222@linux.ibm.com>
 <20181012184114.w332lnkc34evd4sm@linutronix.de>
 <20181013134813.GD2674@linux.ibm.com>
 <20181015144217.nu5cp5mxlboyjbre@linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
In-Reply-To: <20181015144217.nu5cp5mxlboyjbre@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi, Sebastian

On Mon, Oct 15, 2018 at 04:42:17PM +0200, Sebastian Andrzej Siewior wrote:
> On 2018-10-13 06:48:13 [-0700], Paul E. McKenney wrote:
> >=20
> > My concern would be that it would queue it by default for the current
> > CPU, which would serialize the processing, losing the concurrency of
> > grace-period initialization.  But that was a long time ago, and perhaps
> > workqueues have changed.=20
>=20
> but the code here is always using the first CPU of a NUMA node or did I
> miss something?
>=20

The thing is the original way is to pick one CPU for a *RCU* node to
run the grace-period work, but with your proposal, if a RCU node is
smaller than a NUMA node (having fewer CPUs), we could end up having two
grace-period works running on one CPU. I think that's Paul's concern.

Regards,
Boqun

> > So, have you tried using rcuperf to test the
> > update performance on a large system?
>=20
> Something like this:
> | tools/testing/selftests/rcutorture/bin/kvm.sh --torture rcuperf --confi=
gs TREE
> | ----Start batch 1: Mon Oct 15 12:46:13 CEST 2018
> | TREE 142: Starting build. =E2=80=A6
> | =E2=80=A6
> | Average grace-period duration: 19952.7 microseconds
> | Minimum grace-period duration: 9004.51
> | 50th percentile grace-period duration: 19998.3
> | 90th percentile grace-period duration: 24994.4
> | 99th percentile grace-period duration: 30002.1
> | Maximum grace-period duration: 42998.2
> | Grace periods: 6560 Batches: 209 Ratio: 31.3876
> | Computed from rcuperf printk output.
> | Completed in 27 vs. 1800
> |=20
> | Average grace-period duration: 18700 microseconds
> | Minimum grace-period duration: 7069.2
> | 50th percentile grace-period duration: 18987.5
> | 90th percentile grace-period duration: 22997
> | 99th percentile grace-period duration: 28944.7
> | Maximum grace-period duration: 36994.5
> | Grace periods: 6551 Batches: 209 Ratio: 31.3445
> | Computed from rcuperf printk output.
> | Completed in 27 vs. 1800
>=20
> two runs patched followed by two runs without the patched:
> | Average grace-period duration: 19423.3 microseconds
> | Minimum grace-period duration: 8006.93
> | 50th percentile grace-period duration: 19002.8
> | 90th percentile grace-period duration: 23997.5
> | 99th percentile grace-period duration: 29995.7
> | Maximum grace-period duration: 37997.9
> | Grace periods: 6526 Batches: 208 Ratio: 31.375
> | Computed from rcuperf printk output.
> | Completed in 27 vs. 1800
> |=20
> | Average grace-period duration: 18822.4 microseconds
> | Minimum grace-period duration: 8348.15
> | 50th percentile grace-period duration: 18996.9
> | 90th percentile grace-period duration: 23000
> | 99th percentile grace-period duration: 27999.5
> | Maximum grace-period duration: 39001.9
> | Grace periods: 6540 Batches: 209 Ratio: 31.2919
> | Computed from rcuperf printk output.
> | Completed in 27 vs. 1800
>=20
> I think difference might come from cpufreq on the host. But in general,
> this is what you have been asking for or did you want to see something
> on the host (or an additional argument to the script)?
>=20
> > If this change does not impact performance on an rcuperf test, why not
> > send me a formal patch with Signed-off-by and commit log (including
> > performance testing results)?  I will then apply it, it will be exposed
> > to 0day and eventually -next testing, and if no problems arise, it will=
 go
> > to mainline, perhaps as soon as the merge window after the upcoming one.
> >=20
> > Fair enough?
> sure.
>=20
> > 							Thanx, Paul
> >=20
>=20
> Sebastian

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlvErRoACgkQSXnow7UH
+rgbOgf+NAmPB5Jt+P7zW4TjOubjn6wAUqTFGk95EWV+sc9FnYLwscM9TLQO3JxD
Zh8+8s53WQz8o1Fu+vBU07Mrnv0TCSVM7uNr1SlC3vI/uGXR0L93CmsYCl2n1ZnV
T5w/Y+BKtnHLYbSt9e32voIgSzdBccEFqn16tXF4WubNmWiC83nTL9Gupgp3UrNJ
guEZnYpvpPkpC3Q8VhJg54Hk3PZka9n79BPWJMYz3VC49778CZLft21Pw4MqAdit
XdUta7zP0sWMngDFRTYyQXZ0dKq0iY8WSlIM7DBLSDQUc4NEGEauvReaV3mbhfrM
/e0aZMhoLFm1Y3J0kozRwfSRjHDgBA==
=z+M5
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
