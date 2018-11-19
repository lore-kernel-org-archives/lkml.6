Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A07DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 11:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 360B320851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 11:16:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 360B320851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbeKSVjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 16:39:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:49824 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727857AbeKSVjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 16:39:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D320CAE1D;
        Mon, 19 Nov 2018 11:16:20 +0000 (UTC)
Date:   Mon, 19 Nov 2018 22:16:09 +1100
From:   Aleksa Sarai <asarai@suse.de>
To:     Daniel Colascione <dancol@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, rppt@linux.ibm.com,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
        Prashant Dhamdhere <pdhamdhe@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2] Document /proc/pid PID reuse behavior
Message-ID: <20181119111609.v4j2j53zpd6hvk2c@mikami>
References: <20181031150625.147369-1-dancol@google.com>
 <20181105132205.138695-1-dancol@google.com>
 <20181106130524.GC2453@dhcp22.suse.cz>
 <CAKOZueu5aDtHDBzp6qKECTHEejjb=dyegQkuHh8NfwgNktzFow@mail.gmail.com>
 <20181107160015.GI27423@dhcp22.suse.cz>
 <CAKOZuevb-MED0QiL5RWJ0py=yt48=N7bPSq5bFqiwWcqN9L=Xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3ds7txroqa3vkjpz"
Content-Disposition: inline
In-Reply-To: <CAKOZuevb-MED0QiL5RWJ0py=yt48=N7bPSq5bFqiwWcqN9L=Xg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3ds7txroqa3vkjpz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018-11-07, Daniel Colascione <dancol@google.com> wrote:
> On Wed, Nov 7, 2018 at 4:00 PM, Michal Hocko <mhocko@kernel.org> wrote:
> > On Wed 07-11-18 15:48:20, Daniel Colascione wrote:
> >> On Tue, Nov 6, 2018 at 1:05 PM, Michal Hocko <mhocko@kernel.org> wrote:
> >> > otherwise anybody could simply DoS the system
> >> > by consuming all available pids.
> >>
> >> People can do that today using the instrument of terror widely known
> >> as fork(2). The only thing standing between fork(2) and a full process
> >> table is RLIMIT_NPROC.
> >
> > not really.
>=20
> What else, besides memory consumption and (as you mention below)
> cgroups? In practice, nobody uses RLIMIT_NPROC, so outside of various
> container-y namespaced setups, avoidance of
> system-DoS-through-PID-exhaustion isn't a pressing problem.

systemd has had a default pid cgroup controller policy (for both user
and system slices) for a quite long time. I believe that the most recent
version of most enterprise and community distributions support it by
default (and probably even some older versions -- commit 49b786ea146f
was merged in 2015 and I think systemd grew support for it in 2016).

I agree with your overall point, but it should be noted that the vast
majority of Linux systems these days have protections against this (by
default) that use the pids cgroup controller.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--3ds7txroqa3vkjpz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEXzbGxhtUYBJKdfWmnhiqJn3bjbQFAlvym3YACgkQnhiqJn3b
jbQ0aw/8DVfcFOcsOSHtls6XOQp7nAUApvojwiqJZMGknbiSNUFN+E3XDyCN9KNk
ncMKEBpzWttE11bEs9htNVlGyrOyFhZa1bwOECN+supF3Npw2P7xiL9ldgorIaek
u97ksYsJ4BvtPf3uFZIzs56LdK+/KfS4qF/IuloOa1icgvVPGnZGIHDEvmQhwQIE
K0YbhwYruNpH3/gLCtwEPOLqLZ4mW6s1ghPkAM7Oh/N0jGHGrMttiZzQSwYHO1Gm
CysiXLjHxVPsS9Da7OV8kpS2ED8p3L2Xsy9SSvvvUcUKlgmu7svq5zTafBz5UPvj
gQmpO8zXr9hhldZiLu/9ppWClSILoh5ND2FVaglsVgmB08NvAUoJnaAtWGLjOmMS
2jHOnOnuwCTNi+LTVl+PfNbGC+mJYnhac/IdZTOg8EYAzDGwp7kX6NCWZFJwMlNf
ht4HeIOzM45N0L41NGqeSU356U269xWDZA1NsyJ6RCB64zEKTB9TXaeuHGs6M6Iu
iiECtJLSMo+dWhlv2HYUjCJict43owREvH0WhOLM7gDw6CJ06HwQ2xKiPhVY1OAw
UV5qVJGVAY02mIzVTlwGIlsHqkJgxzcuDY3kF7VRTjFNCvUH6dnCYxWJ9GW5k7R8
5Rb6117P+uwrjXpfjb48SHZ7nfN66lr07TekInLq5/Wc8RhmJQU=
=kgBp
-----END PGP SIGNATURE-----

--3ds7txroqa3vkjpz--
