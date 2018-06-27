Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F87C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 02:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40671268E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 02:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzHA2+N1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40671268E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932145AbeF0ChB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 22:37:01 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36174 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932084AbeF0Cg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 22:36:59 -0400
Received: by mail-ed1-f65.google.com with SMTP id t3-v6so2147107eds.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 19:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nAKIdftLAzCTciWiV0wp+TprdRezJeYm131lTdpZyPs=;
        b=IzHA2+N144g388aV9DEe/a0lvkzcqndugeYIfxh7TBwPDY8Qpt+f3RlVjqiJ3+gxKF
         fYeBgT+NC/kFFiWj+EH/pbbg2BWYmr2nw9Cw5yCiu+kllj/uk0ccujsfWAHWcYok6jNq
         9nam8lw8qg+16JjUcE34uzikYR+9gKqiIwrysr+DJuHXml1+5jZbe1nSUR9kfqMNXzzU
         5b3IEnRq36EMuVrH1pQoI19W8Njm3Iw4RljScyMN0gb4SzW3o2ZXaD6LbovteWOVrjQL
         wowpeIgsqkbd5I8gb7vzrx9UPXrLPXEEnWqGOKWmMgff3twJpDKfewnMH0uvbGY2dXUx
         lpLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nAKIdftLAzCTciWiV0wp+TprdRezJeYm131lTdpZyPs=;
        b=bZKdLwKBw/ktFyPrze7h6GkvV9uL1xHlK2XlTTiILDg4LGczcQnRMza8PQYK8sS4kF
         Nhj8TzaD0hWWLOo8mbhjZZObDxHiM4RYidhFy/ETA8pqSR+XSEBpJOqJJI6eoAQ8HqH4
         /LJjzUl3lJrbP9RO7RusSSygMiYiLABMJ1Hdlzk1dSGRLKrgGduPt3TXxb/jaJWrXgYm
         vUjD9oRmpuT2bcsmzFlIn0XTaWzjmS9baNBZZLt8CS0FgcGelPt4trlePBWYq9PzntG1
         9L92KWmtSj1zmcPIqTL8bKw/bRv5AWhLG78oCJ+Lp73HiLJIvhOETnLlyipPmc1xH+74
         lWUA==
X-Gm-Message-State: APt69E1LHfCGiFYMyMK3NcIRoiIjD/QC8nc+x0Hz5WN0Odj1PFLOpER0
        ofhQL3ekAzWbZbcKUEm13M4=
X-Google-Smtp-Source: AAOMgpcLtnJVv+aMl7fCtn+MWkOp8P4y54X3plHfiTCo4WpWi2PBoNSSmefuqGOk1bG/lgO+XKlypA==
X-Received: by 2002:a50:96d1:: with SMTP id z17-v6mr3589565eda.55.1530067018551;
        Tue, 26 Jun 2018 19:36:58 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id m10-v6sm1398209edp.57.2018.06.26.19.36.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 19:36:57 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id D3F6721C24;
        Tue, 26 Jun 2018 22:36:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 26 Jun 2018 22:36:54 -0400
X-ME-Sender: <xms:RvgyW2Zfrcy26wxDTo6SaLy4-9zki94ZtPieuGCL_WV0q_TuCx71rg>
Received: from localhost (unknown [45.32.128.109])
        by mail.messagingengine.com (Postfix) with ESMTPA id D1B6410285;
        Tue, 26 Jun 2018 22:36:53 -0400 (EDT)
Date:   Wed, 27 Jun 2018 10:42:01 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 2/2] rcu: Make expedited GPs handle CPU 0
 being offline
Message-ID: <20180627024201.GA27704@tardis>
References: <20180625224308.GA10064@linux.vnet.ibm.com>
 <20180625224332.10596-2-paulmck@linux.vnet.ibm.com>
 <20180626093820.GG2494@hirez.programming.kicks-ass.net>
 <20180626104447.GG9125@tardis>
 <20180626114652.GH9125@tardis>
 <20180626192746.GJ3593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
In-Reply-To: <20180626192746.GJ3593@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 26, 2018 at 12:27:47PM -0700, Paul E. McKenney wrote:
> On Tue, Jun 26, 2018 at 07:46:52PM +0800, Boqun Feng wrote:
> > On Tue, Jun 26, 2018 at 06:44:47PM +0800, Boqun Feng wrote:
> > > On Tue, Jun 26, 2018 at 11:38:20AM +0200, Peter Zijlstra wrote:
> > > > On Mon, Jun 25, 2018 at 03:43:32PM -0700, Paul E. McKenney wrote:
> > > > > +		preempt_disable();
> > > > > +		for_each_leaf_node_possible_cpu(rnp, cpu) {
> > > > > +			if (cpu_is_offline(cpu)) /* Preemption disabled. */
> > > > > +				continue;
> > > >=20
> > > > Create for_each_node_online_cpu() instead? Seems a bit pointless to
> > > > iterate possible mask only to then check it against the online mask.
> > > > Just iterate the online mask directly.
> > > >=20
> > > > Or better yet, write this as:
> > > >=20
> > > > 	preempt_disable();
> > > > 	cpu =3D cpumask_next(rnp->grplo - 1, cpu_online_mask);
> > > > 	if (cpu > rnp->grphi)
> > > > 		cpu =3D WORK_CPU_UNBOUND;
> > > > 	queue_work_on(cpu, rcu_par_gp_wq, &rnp->rew.rew_work);
> > > > 	preempt_enable();
> > > >=20
> > > > Which is what it appears to be doing.
> > > >=20
> > >=20
> > > Make sense! Thanks ;-)
> > >=20
> > > Applied this and running a TREE03 rcutorture. If all go well, I will
> > > send the updated patch.
> > >=20
> >=20
> > So the patch has passed one 30 min run for TREE03 rcutorture. Paul,
> > if it looks good, could you take it for your next spin or pull request
> > in the future? Thanks.
>=20
> I ended up with the following, mostly just rewording the comment and
> adding a one-liner on the change.  Does this work for you?
>=20

Looks good to me. Only one thing I think we need to modify a little,
please see below:

> 							Thanx, Paul
>=20
> ------------------------------------------------------------------------
>=20
> commit ef31fa78032536d594630d7bd315d3faf60d98ca
> Author: Boqun Feng <boqun.feng@gmail.com>
> Date:   Fri Jun 15 12:06:31 2018 -0700
>=20
>     rcu: Make expedited GPs handle CPU 0 being offline
>    =20
>     Currently, the parallelized initialization of expedited grace periods=
 uses
>     the workqueue associated with each rcu_node structure's ->grplo field.
>     This works fine unless that CPU is offline.  This commit therefore
>     uses the CPU corresponding to the lowest-numbered online CPU, or just
>     reports the quiescent states if there are no online CPUs on this rcu_=
node
>     structure.

better write "or just queue the work on WORK_CPU_UNBOUND if there are
no online CPUs on this rcu_node structure"? Because we currently don't
report the QS directly if all CPU are offline.

Thoughts?

Regards,
Boqun

>    =20
>     Note that this patch uses cpu_is_offline() instead of the usual
>     approach of checking bits in the rcu_node structure's ->qsmaskinitnext
>     field.  This is safe because preemption is disabled across both the
>     cpu_is_offline() check and the call to queue_work_on().
>    =20
>     Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
>     [ paulmck: Disable preemption to close offline race window. ]
>     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
>     [ paulmck: Apply Peter Zijlstra feedback on CPU selection. ]
>=20
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index c6385ee1af65..b3df3b770afb 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -472,6 +472,7 @@ static void sync_rcu_exp_select_node_cpus(struct work=
_struct *wp)
>  static void sync_rcu_exp_select_cpus(struct rcu_state *rsp,
>  				     smp_call_func_t func)
>  {
> +	int cpu;
>  	struct rcu_node *rnp;
> =20
>  	trace_rcu_exp_grace_period(rsp->name, rcu_exp_gp_seq_endval(rsp), TPS("=
reset"));
> @@ -493,7 +494,13 @@ static void sync_rcu_exp_select_cpus(struct rcu_stat=
e *rsp,
>  			continue;
>  		}
>  		INIT_WORK(&rnp->rew.rew_work, sync_rcu_exp_select_node_cpus);
> -		queue_work_on(rnp->grplo, rcu_par_gp_wq, &rnp->rew.rew_work);
> +		preempt_disable();
> +		cpu =3D cpumask_next(rnp->grplo - 1, cpu_online_mask);
> +		/* If all offline, queue the work on an unbound CPU. */
> +		if (unlikely(cpu > rnp->grphi))
> +			cpu =3D WORK_CPU_UNBOUND;
> +		queue_work_on(cpu, rcu_par_gp_wq, &rnp->rew.rew_work);
> +		preempt_enable();
>  		rnp->exp_need_flush =3D true;
>  	}
> =20
>=20

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlsy+XUACgkQSXnow7UH
+rg9Qgf/T8Qa8u4WX4Dz+LoBTKOlU9MKjwZAtHwFy7gFwZJW4uwmny1OYOCihTM0
05MRWbiG6n5Z8UOSDN3gIUAGXWFGU16FWSDL3qGoUZQ+0Wo2OwgBE5kDWmz5AXVM
P397HRVQN7PCiNLiTdG/cZJ9L0XE2oJYHv2WJHW4g6FRZiUGD2pZrHq7RBOTwyMm
l524N48xZBLMjnoEKhCrDSD1eG68izsZKm5slM+ZEoImhzrDwh116x927ijjDmOx
NjGcoTDRg9CK06FS2fu8ybYOL5EdOB7X8kLuMIxXwUjkxnwh76FJO5M2nPV/2G1A
VO8AkZVj0srVv/AtWrshCnyeFtjDgg==
=Ahp5
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
