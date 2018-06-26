Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8C6C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81A462406C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlDhR7T5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81A462406C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964796AbeFZKkA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 06:40:00 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35555 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933721AbeFZKj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 06:39:58 -0400
Received: by mail-qt0-f193.google.com with SMTP id z6-v6so14657116qti.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 03:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6UrwfuBSqXNdzGPeOBdKVCQw9nsWtjrQcbllkG1F3JU=;
        b=JlDhR7T5rT2cuOhxUkn1YySmmdQqzuw0GPHTDuGGkqRzTcwL8ywngCUE/zNiyRkrx5
         S66g+L1JDlrZhNwisjLWKJiNmPXHUTbW0RqAzqp15KJ2+8WFUzh8Jr8bpVpOZUDQSsWR
         VPrFGLUVUHgyKs1SBiPoLzsOC4ukewPrJHXGac6zmy5P7YQrYhxXEoBcfi40Nn3Yi6Mm
         1GirXHU8yndrGGzs7QP2whOzPYuMyAg//AhFFEx3a66daWKYm0deL4bwjwcM+kvZc3XU
         stEkiJeQIhkpath0t64u/1P6rY9Dlfq1V1sUdr/Vk2TmgRzXm61EUDLzP7wMxSm6QrS9
         l5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6UrwfuBSqXNdzGPeOBdKVCQw9nsWtjrQcbllkG1F3JU=;
        b=SZxWIZK5jobLq5KAbeavQGUhIJoXKYXB4JrYPaZ4bksk+ffM/QRRLtTQVzgKrmWl5j
         FolSseWWfu3eS2qCrfkOWCOiwAAGiSvLA09yXJttSABknAb+ZHDtbtAzSLDzbLlOnIff
         vX6nRl/JKN1O92kLBgEiMAqGd0w4yRckkKNtHgY95X7odsk9fz0k2cZCcfZKIvknS5IH
         Umze6kvqTU/Or8T4an0dN+rAOME8sPpxwe49+pHb5zILKvuJJ/0PbHylIemr4iE7zq32
         Gzy31Uml0F4i4yGloCPFbYEEhYeqkA6kOA4D5RuqAr0JWsf8vaEyK980zzK/YpfAGL7N
         mb6g==
X-Gm-Message-State: APt69E2IGgCU3xZNvgj5Rf9wwix7V2BnI2/5WsVTniXmeuJFKgwcWHuA
        bP8DzAeXLvredqhjSPA7Skc=
X-Google-Smtp-Source: AAOMgpeHDhxVoa6jNFSP9kvIUtxMbyxSF+pcDgk//rmjmUsXlIwUX4I2kCrMnMypRTSebbLyURA4Ww==
X-Received: by 2002:ac8:8af:: with SMTP id v44-v6mr789744qth.33.1530009597988;
        Tue, 26 Jun 2018 03:39:57 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id k50-v6sm992315qtk.88.2018.06.26.03.39.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 03:39:56 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id C4D1621908;
        Tue, 26 Jun 2018 06:39:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 26 Jun 2018 06:39:55 -0400
X-ME-Sender: <xms:-xcyW-ipo1Bf0PtmoxfS93x9BqGfpbXHaGi7qoi5QEVGP765OGbjVA>
Received: from localhost (unknown [45.32.128.109])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8D8E7E407B;
        Tue, 26 Jun 2018 06:39:54 -0400 (EDT)
Date:   Tue, 26 Jun 2018 18:44:47 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 2/2] rcu: Make expedited GPs handle CPU 0
 being offline
Message-ID: <20180626104447.GG9125@tardis>
References: <20180625224308.GA10064@linux.vnet.ibm.com>
 <20180625224332.10596-2-paulmck@linux.vnet.ibm.com>
 <20180626093820.GG2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HCdXmnRlPgeNBad2"
Content-Disposition: inline
In-Reply-To: <20180626093820.GG2494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HCdXmnRlPgeNBad2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 26, 2018 at 11:38:20AM +0200, Peter Zijlstra wrote:
> On Mon, Jun 25, 2018 at 03:43:32PM -0700, Paul E. McKenney wrote:
> > +		preempt_disable();
> > +		for_each_leaf_node_possible_cpu(rnp, cpu) {
> > +			if (cpu_is_offline(cpu)) /* Preemption disabled. */
> > +				continue;
>=20
> Create for_each_node_online_cpu() instead? Seems a bit pointless to
> iterate possible mask only to then check it against the online mask.
> Just iterate the online mask directly.
>=20
> Or better yet, write this as:
>=20
> 	preempt_disable();
> 	cpu =3D cpumask_next(rnp->grplo - 1, cpu_online_mask);
> 	if (cpu > rnp->grphi)
> 		cpu =3D WORK_CPU_UNBOUND;
> 	queue_work_on(cpu, rcu_par_gp_wq, &rnp->rew.rew_work);
> 	preempt_enable();
>=20
> Which is what it appears to be doing.
>=20

Make sense! Thanks ;-)

Applied this and running a TREE03 rcutorture. If all go well, I will
send the updated patch.

Regards,
Boqun

> > +			queue_work_on(cpu, rcu_par_gp_wq, &rnp->rew.rew_work);
> > +			rnp->exp_need_flush =3D true;
> > +			break;
> > +		}
> > +		preempt_enable();
> > +		if (!rnp->exp_need_flush) { /* All offline, report QSes. */
> > +			queue_work(rcu_par_gp_wq, &rnp->rew.rew_work);
> > +			rnp->exp_need_flush =3D true;
> > +		}
> >  	}
> > =20
> >  	/* Wait for workqueue jobs (if any) to complete. */
> > --=20
> > 2.17.1
> >=20

--HCdXmnRlPgeNBad2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlsyGRkACgkQSXnow7UH
+ri1SQf/X3ITEo/cU0FHDbMb6hayVbEJ9vrw03PuRR5dxbaWQfs+VMxs65BBs1Vy
mWJYx+Hf5oSsSXn6DJshe429YsBDHdgmjVX7j+qiKoQKl55dFnpJqPQDFpMyXo87
8NQ5BsBfQZkX9AagGWst+iblJcaItG5rHExzDpvZZfY3PjKng1Tc7K5yhmPqqG6g
93Zj88Wy7fAva0ObmIDzmhBkQf/OBZlOZt4sYCL7HyfnUt+E/bwaW1VIwF6V1qJ1
Y0mWW1eMgcCbUlFVcoOt+7BZGzqPi/29FTAMpdNrvNXPeB1HKsgS04i5LKRutheX
qkrDdkPrdiiZPHGOAYJsmZAIrMxd4A==
=5QpE
-----END PGP SIGNATURE-----

--HCdXmnRlPgeNBad2--
