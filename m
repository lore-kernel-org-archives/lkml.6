Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7AFC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F95020878
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bvx+Ookx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387701AbfAKRxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 12:53:08 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35524 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728616AbfAKRxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 12:53:08 -0500
Received: by mail-pg1-f195.google.com with SMTP id s198so6620995pgs.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 09:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7fRNInaCBWZlvEVNc9vh6Dr5T5/rRKJ17S7vHd4b2IA=;
        b=Bvx+OokxKIHsm3XaopYU9UKMtG7r9k86gw1aForZNuNUcT7QtcuP8ZVTt9l08BI6Zg
         +1Bplr4zHrqdaQ8bB/THwH5t3vFD9zYMWki6e2UBs3E7HsYM3y/f5zwBxolMM93mk4Jt
         n2PN/q6AesR+FgbExWDxWmGIGYlnJInGDRTZrnavtTI5eW3uoYd9swEKQVqBA+4JNN1O
         7wofCFWFHFZnAgYrJWOBGYuB/4kOF6xaHdgUqvQ6Dy1LqjPivAJ5kxSWD91wZuxFjYcX
         mIPJ5+BHDZ5qmdvWLMZxFI+QxTSUDowljyg3AcueXhyak3t+/TfIYenEcGB4dEbOhDKw
         PeSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=7fRNInaCBWZlvEVNc9vh6Dr5T5/rRKJ17S7vHd4b2IA=;
        b=UW4PWcYAUzgfWiiql3/Tf//VLYiLIDcV7ELSLQM36/cqLCBJto753ahkvh3aE13Dss
         8kC6CacOgKW92V3DW6DqkHScbuqJySRHJHSvM677aR9/SFWkUFhqtnA4/7iL+3q74SwA
         jBjrdAaqlLFR211YGBB6hP6KGGn8+oNNhc7VznGLucqzqhZUqXGnrAIp7XCAYwFnEl2g
         HRbKuRMQOmtXR+aCaPYm25Z/DzSbkYk+sb8nk/9AGrTRGVsQAJPQfnUOwXRFcK+YF14R
         66HlNRxWXg2XWGK73KyPBPR+eV5q9rPFwSAko+4CcUqJ0atrZB8YeVKFJsGX9Tg8L8Ln
         NFcQ==
X-Gm-Message-State: AJcUukeR629Ihlr2iEiK1o1wJ6qtGxJziYthxALZZ+bC357t4szbDHd/
        IVtELxxzClSA/Jo7zpVmDu0=
X-Google-Smtp-Source: ALg8bN5RXGjK7hSUJRT5njiuevML7mx7BRm585RvbAiNCXrxyZj6cX5w87QlO+XLhLi0ett1I7ihuQ==
X-Received: by 2002:a62:345:: with SMTP id 66mr15378960pfd.189.1547229187178;
        Fri, 11 Jan 2019 09:53:07 -0800 (PST)
Received: from gmail.com ([2605:e000:1117:c227:3b53:d0fe:bff:4913])
        by smtp.gmail.com with ESMTPSA id d13sm123522290pfd.58.2019.01.11.09.53.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 09:53:06 -0800 (PST)
Date:   Fri, 11 Jan 2019 07:53:03 -1000
From:   Joey Pabalinas <joeypabalinas@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Qian Cai <cai@lca.pw>, akpm@linux-foundation.org,
        esploit@protonmail.ch, jejb@linux.ibm.com, dgilbert@interlog.com,
        martin.petersen@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Joey Pabalinas <joeypabalinas@gmail.com>
Subject: Re: [PATCH] rbtree: fix the red root
Message-ID: <20190111175303.72a43mdulvfd6wf3@gmail.com>
Mail-Followup-To: Joey Pabalinas <joeypabalinas@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, Qian Cai <cai@lca.pw>,
        akpm@linux-foundation.org, esploit@protonmail.ch,
        jejb@linux.ibm.com, dgilbert@interlog.com,
        martin.petersen@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <YrcPMrGmYbPe_xgNEV6Q0jqc5XuPYmL2AFSyeNmg1gW531bgZnBGfEUK5_ktqDBaNW37b-NP2VXvlliM7_PsBRhSfB649MaW1Ne7zT9lHc=@protonmail.ch>
 <20190111165145.23628-1-cai@lca.pw>
 <20190111173132.GH6310@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hlwwm3l6upzhm7g4"
Content-Disposition: inline
In-Reply-To: <20190111173132.GH6310@bombadil.infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hlwwm3l6upzhm7g4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 11, 2019 at 09:31:32AM -0800, Matthew Wilcox wrote:
> On Fri, Jan 11, 2019 at 11:51:45AM -0500, Qian Cai wrote:
> > Reported-by: Esme <esploit@protonmail.ch>
> > Signed-off-by: Qian Cai <cai@lca.pw>
>=20
> What change introduced this bug?  We need a Fixes: line so the stable
> people know how far to backport this fix.
>=20

Breaking commit _might_ be 5bc9188aa207dafd47 (rbtree: low level optimizati=
ons in rb_insert_color())

I'm thinking that the when `parent =3D rb_parent(node);` was
moved from the beginning of the loop to the function initialization
only, somehow parent not being reassigned every loop resulted in
the red root node case.

I'm sort of just guessing here admittedly and I'll do some testing after
breakfast, but nothing else in the `git log` or `git blame` changes really
jumps out at me apart from this one commit.

 void rb_insert_color(struct rb_node *node, struct rb_root *root)
 {
-       struct rb_node *parent, *gparent;
+       struct rb_node *parent =3D rb_red_parent(node), *gparent, *tmp;

        while (true) {
                /*
                 * Loop invariant: node is red
                 *
                 * If there is a black parent, we are done.
                 * Otherwise, take some corrective action as we don't
                 * want a red root or two consecutive red nodes.
                 */
-               parent =3D rb_parent(node);
                if (!parent) {
-                       rb_set_black(node);
+                       rb_set_parent_color(node, NULL, RB_BLACK);
                        break;
                } else if (rb_is_black(parent))
                        break;

-               gparent =3D rb_parent(parent);
+               gparent =3D rb_red_parent(parent);

--=20
Cheers,
Joey Pabalinas

--hlwwm3l6upzhm7g4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEENpTlWU2hUK/KMvHp2rGdfm9DtVIFAlw41/8ACgkQ2rGdfm9D
tVKT6RAApztW+XKuh1xfqQ6x5SICKuk9Kc+wQD6wp+nmhij5CHWhRH0OQV8/QcnO
ieTU3tSCr62nGAfhtqEVwKyubAMuJlYdb4WqVcXHYIkymRijiqhcCjGq/mbj/Nza
rua9lpKfKcb/o+gg7vojZV6sVB3GzE0mXFAmjdaRXCe+1+m8ZyDpnxTVH2PjsR7p
bn/d3V0j7gTUcZ2qclX0OloJC++dhG8+1Y4dhl2R0QOFQ9TKj7ChQbA5IKBFzK1Q
dVVHcFayJMhzPdKuh7PsqjQJmlFRjoL+1Fy4ocF8Co7VYP7mA//hBREmNj6qpZ8X
oCc0I/oZ00KRZBhRNYG2S9d+MsJV9csoL6F0QIq8D2ZBa+3u6qWp5rjemI8T6BnS
Lh2/+eVoRaVz7lVqsEpJiFghmdzIAv+bqbqoLjhIRuQ5pvNjLfwUrgDqvKYyxQ86
GvTHbaszdur0cdzG7OPqPCyYdsUPoBrV2nirZMDo1seaHFxcQ48mf4+Sd6a1XocT
vaEXGFqwY6lE9R21u4RSU0VMfUj6fX+Cp9pm7VH2DZrXtdV7e3/Q/TwbXUy0T9aD
tzL7CbA27IvgHCyEYeRcUni4yoY4W9t+GfMFAc2MzSW38CjkxmQIQwDTYsJCeXBV
mC79qjd6r0tqG4pZpu0zuwQ78OW+2XYnWs4T3Hv4bQKIZw+OGQU=
=F32/
-----END PGP SIGNATURE-----

--hlwwm3l6upzhm7g4--
