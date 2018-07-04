Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440CFC6778A
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 02:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED505246DE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 02:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PM54rj4O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED505246DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753583AbeGDCZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 22:25:44 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35597 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753466AbeGDCZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 22:25:43 -0400
Received: by mail-lf0-f67.google.com with SMTP id i15-v6so3128366lfc.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 19:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZTww2MKkNZZyRk3Zr43hPVrkLJ3/5/a2mmGVcbT7H6o=;
        b=PM54rj4OSA6cwU69/dfaxpSGCwYL1SsH9NKjTXDXCShoEEiG9rxAnmMR+9nGyTUn9/
         gRwaB6S0D7wDXgnNz8vQ2kvnHqXELczEdnzdEb8RMSuh+0KA9qgvEzOJyrdR/iGqKJYO
         cYaGvM80ba2r6SHDkqilxZiqy2QkX1dvlez2QbyPQtQl9Tmpqi0uoCwpswEzkn7NseXP
         lXjPxyhF0nAebTTpcdawm3+1gfAVpafi61qnDopphXFZ4HEQ7YhMyUKQivayEBq7Ha3o
         sxqFU1B7w1tYZ/REpJ6lK8A3bgRvsWa/kfEJh4oqbUc7pezkZ6mHu+7OEKC60IoNmcmM
         vXlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZTww2MKkNZZyRk3Zr43hPVrkLJ3/5/a2mmGVcbT7H6o=;
        b=i4Sj5KAUaZJlX64RlFCK+0eAYDqbzsDPBExPc5b7+UfwOaVmPg3Y0m5JaWiCQuigl6
         0q1oxtlq+67GL1A2N698SnUx3J5SB0Ipp1lis/swd7Y+kKbmryQMkC16uxaT7E2oFgnI
         FLIQGpZXIpahT1Vc2Xm/tbPvLuSOZczmHe8SaRp9OVeW3j2t7xMao/rBWK770a8TsMzk
         6fyztZtp8aK0ouDfUkQt0Qh4GSiuroq9ua01RicMA936t/2jdbJt9qzVhDWyisb7tcde
         f1L0thQ64G97ruWvMeofoTNWihOqSE+c4TsFcdw99k6odxyRP/bIlxGgkiWCyOvbueRd
         zYQw==
X-Gm-Message-State: APt69E10rpcNplYd3k40tZ22FR34c1f3W6sUMT2UY7vEfnp+THY/cGJY
        dY6I2I/xF+iSfA5BCNYXrXksMJ9hypFx/uuyJ38=
X-Google-Smtp-Source: AAOMgpdaU4dE8xi70BjXEB6jsI70dYnKZpz4Z0na1OjsWFEDImzciRizgVNdPmcqo4sCH7UzJq/APw/WT822R3mPBjc=
X-Received: by 2002:a19:e40d:: with SMTP id b13-v6mr76982lfh.141.1530671142227;
 Tue, 03 Jul 2018 19:25:42 -0700 (PDT)
MIME-Version: 1.0
References: <1530376739-20459-1-git-send-email-ufo19890607@gmail.com> <CAHp75VdaEJgYFUX_MkthFPhimVtJStcinm1P4S-iGfJHvSeiyA@mail.gmail.com>
In-Reply-To: <CAHp75VdaEJgYFUX_MkthFPhimVtJStcinm1P4S-iGfJHvSeiyA@mail.gmail.com>
From:   =?UTF-8?B?56a56Iif6ZSu?= <ufo19890607@gmail.com>
Date:   Wed, 4 Jul 2018 10:25:30 +0800
Message-ID: <CAHCio2jv-xtnNbJ8beokueh-VQ6zZgF1hAFBJKHCNyuOuz2KxA@mail.gmail.com>
Subject: Re: [PATCH v11 1/2] Refactor part of the oom report in dump_header
To:     andy.shevchenko@gmail.com
Cc:     akpm@linux-foundation.org, mhocko@suse.com, rientjes@google.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, guro@fb.com,
        yang.s@alibaba-inc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Wind Yu <yuzhoujian@didichuxing.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy
The const char array need to be used by the new func
mem_cgroup_print_oom_context and some funcs in oom_kill.c in the
second patch.

Thanks

>
> On Sat, Jun 30, 2018 at 7:38 PM,  <ufo19890607@gmail.com> wrote:
> > From: yuzhoujian <yuzhoujian@didichuxing.com>
> >
> > The current system wide oom report prints information about the victim
> > and the allocation context and restrictions. It, however, doesn't
> > provide any information about memory cgroup the victim belongs to. This
> > information can be interesting for container users because they can fin=
d
> > the victim's container much more easily.
> >
> > I follow the advices of David Rientjes and Michal Hocko, and refactor
> > part of the oom report. After this patch, users can get the memcg's
> > path from the oom report and check the certain container more quickly.
> >
> > The oom print info after this patch:
> > oom-kill:constraint=3D<constraint>,nodemask=3D<nodemask>,oom_memcg=3D<m=
emcg>,task_memcg=3D<memcg>,task=3D<comm>,pid=3D<pid>,uid=3D<uid>
>
>
> > +static const char * const oom_constraint_text[] =3D {
> > +       [CONSTRAINT_NONE] =3D "CONSTRAINT_NONE",
> > +       [CONSTRAINT_CPUSET] =3D "CONSTRAINT_CPUSET",
> > +       [CONSTRAINT_MEMORY_POLICY] =3D "CONSTRAINT_MEMORY_POLICY",
> > +       [CONSTRAINT_MEMCG] =3D "CONSTRAINT_MEMCG",
> > +};
>
> I'm not sure why we have this in the header.
>
> This produces a lot of noise when W=3D1.
>
> In file included from
> /home/andy/prj/linux-topic-mfld/include/linux/memcontrol.h:31:0,
>                 from /home/andy/prj/linux-topic-mfld/include/net/sock.h:5=
8,
>                 from /home/andy/prj/linux-topic-mfld/include/linux/tcp.h:=
23,
>                 from /home/andy/prj/linux-topic-mfld/include/linux/ipv6.h=
:87,
>                 from /home/andy/prj/linux-topic-mfld/include/net/ipv6.h:1=
6,
>                 from
> /home/andy/prj/linux-topic-mfld/net/ipv4/netfilter/nf_log_ipv4.c:17:
> /home/andy/prj/linux-topic-mfld/include/linux/oom.h:32:27: warning:
> =E2=80=98oom_constraint_text=E2=80=99 defined but not used [-W
> unused-const-variable=3D]
> static const char * const oom_constraint_text[] =3D {
>                           ^~~~~~~~~~~~~~~~~~~
>  CC [M]  net/ipv4/netfilter/iptable_nat.o
>
>
> If you need (but looking at the code you actually don't if I didn't
> miss anything) it in several places, just export.
> Otherwise put it back to memcontrol.c.
>
> --
> With Best Regards,
> Andy Shevchenko
