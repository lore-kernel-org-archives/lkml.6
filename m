Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C29BC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C67E4208EB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FJMe1/Pc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C67E4208EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732590AbeGKCsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 22:48:35 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35525 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732393AbeGKCsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 22:48:35 -0400
Received: by mail-wm0-f68.google.com with SMTP id v3-v6so902179wmh.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 19:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x9zUd0heuvaub7AywUX1CUNG3utrAq2Q+71j4G0/TT0=;
        b=FJMe1/PcdwM3CHCFAR1Bl/xMmWiXeG3pBeqoiCJ4ENWfLgyyfZR0H++K5RoiWnirog
         amoTblszRaZ5RzCiyuXvfbjkqDdGomWrKtm9B6CPYhZigzKeaX0vX7LxQ2Mn/w5OwJQv
         Ji4UTIgf+anDTf1pPYq8twewNX14KtzeQigSiAgcHafvfoJ1e7cTRojfyYaijyKA8vP8
         ljI4IgxB9N6jEjc8I4XlbdlGDA9RlPSmq0scFycCeXoNDyMflRMzVeJ46UBcmVQdKhuY
         VskppXpn3HS2syjNG7ulsjjHhmMUidAhk9OEN3Y+102mctci0e82Pi3LohCrdQ0ROOPP
         g7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x9zUd0heuvaub7AywUX1CUNG3utrAq2Q+71j4G0/TT0=;
        b=fKKae2jICDmMqhZj5fHQR3YY/ML2xWsq3xxp6Do5JVSnARNFcCHWahmQ58yfoTDlT9
         DV9T3dxFThMqZXTyvAhSckM7Z2YI84Fn+ENoZ0QsrxOCiDWuW9IUN0rv4C8TeRsgPHB1
         f4CIXVV8pLYUk99jp8oKJ3AySsqULGdSAGRde5UWmb4aq3Pn/eTcXKfjsd3GiRbvsZ45
         t0mh8RWhVWkXoYsA886CNrInThd6dy/Ql8ypC/yFh3sZYMc3WTirNjtUoBv9vmqaikzd
         ky0kf7sD/1NLv2FQ+8oseFURiqfk69xUetWWKYsF1wj50eX1BnP3km0bIaFl8SANuBet
         7vMw==
X-Gm-Message-State: APt69E1ssb1jJAh07VWR4N+OIsVfZb7Tc3drt0i8VzNDkG2U9+JhF7mp
        xWlNid/UfJq5/gsulsi91ctP8h9wtub37vmM33O8gQ==
X-Google-Smtp-Source: AAOMgpcsgU9I2DaYORxRXvn/ydplbZpJPr66WB0W16CrijynTaQ97N68T5oCYBtKUTPFVOk4wEwuV8kaHCBPZqCGVik=
X-Received: by 2002:a1c:1c92:: with SMTP id c140-v6mr14226170wmc.155.1531277191221;
 Tue, 10 Jul 2018 19:46:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180707015616.25988-1-dancol@google.com> <20180707025426.ssxipi7hsehoiuyo@ast-mbp.dhcp.thefacebook.com>
 <20180707203340.GA74719@joelaf.mtv.corp.google.com> <951478560.1636.1531083278064.JavaMail.zimbra@efficios.com>
 <20180709210944.quulirpmv3ydytk7@ast-mbp.dhcp.thefacebook.com>
 <CAKOZuet+pjqM8zghmXYdA9f10bsYOzMuSQhSYXG5wbrNmFEqpQ@mail.gmail.com>
 <20180709221005.sintsjkle4xpkcyk@ast-mbp.dhcp.thefacebook.com>
 <CAKOZuetaKNaJVWcu10ZcsiXiK4X+-2z3eFaz1pF8DSxdQ_mEnQ@mail.gmail.com>
 <20180709223439.uc2a6hyic35inwye@ast-mbp.dhcp.thefacebook.com>
 <CAMOXUJ=QmkjTqbWqPRxb=R7f6EpsHBkDQ4MhrSD=VPiDTj7RiA@mail.gmail.com> <20180710235252.mioihpgtu4n3syaq@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20180710235252.mioihpgtu4n3syaq@ast-mbp.dhcp.thefacebook.com>
From:   Lorenzo Colitti <lorenzo@google.com>
Date:   Wed, 11 Jul 2018 11:46:19 +0900
Message-ID: <CAKD1Yr07uxpd95oGAE7QxfrS_qWuiLcUmy7nsEsC0CzVhV2-rg@mail.gmail.com>
Subject: Re: [RFC] Add BPF_SYNCHRONIZE bpf(2) command
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Chenbo Feng <fengc@google.com>, dancol@google.com,
        mathieu.desnoyers@efficios.com, Joel Fernandes <joelaf@google.com>,
        Alexei Starovoitov <ast@fb.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 8:52 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> we need to make sure we have detailed description of BPF_SYNC_MAP_ACCESS
> in uapi/bpf.h, since I feel the confusion regarding its usage is starting already.
> This new cmd will only make sense for map-in-map type of maps.
> Expecting that BPF_SYNC_MAP_ACCESS is somehow implies the end of
> the program or doing some other map synchronization is not correct.
> Commit log of this patch got it right:
> """
>  For example, userspace can update a map->map entry to point to a new map,
>  use BPF_SYNCHRONIZE to wait for any BPF programs using the old map to
>  complete, and then drain the old map without fear that BPF programs
>  may still be updating it.
> """

+1 for detailed documentation. For example, consider what happens if
we have two map fds, one active and one standby, and a map-in-map with
one element that contains a pointer to the currently-active map fd.
The kernel program might do:

=====
const int current_map_key = 1;
void *current_map = bpf_map_lookup_elem(outer_map, &current_map_key);

int stats_key = 42;
uint64_t *stats_value = bpf_map_lookup_elem(current_map, &stats_key);
__sync_fetch_and_add(&stats_value, 1);
=====

If a userspace does:

1. Write new fd to outer_map[1].
2. Call BPF_SYNC_MAP_ACCESS.
3. Start deleting everything in the old map.

How can we guarantee that the __sync_fetch_and_add will not add to the
old map? If it does, we'll lose data. Will the verifier automatically
hold the RCU lock for as long as a pointer to an inner map is valid?
