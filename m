Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1192C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC68D21726
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOoRn5Dz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfAWI0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 03:26:50 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41780 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfAWI0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 03:26:49 -0500
Received: by mail-pf1-f196.google.com with SMTP id b7so808658pfi.8;
        Wed, 23 Jan 2019 00:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=LuWlSf5byRxNQY8vlLfNujb2aMA3zIoo8fg2vwGaxzw=;
        b=NOoRn5Dz/eerxK3p3IjDuPT+b7I4YjQvulIFr1f34G1GEMEDAGKk2qU6hEzsUQEpDx
         /yvxPzlzArCtq55bHrEVinUXRT50cmzvcc8A5M3W41qekTue+mHmxNROMdze8x/ZpF7O
         GdDSVk2egG9l/LJnJ+Ws/aXKgJeYW/JyUjIccRC/oMu3CjJfqSTI6vu8URVDc/ilht7L
         drIOAsLV5CzeInDMWJknaLUNxtQkiXeysBDIg38sov8BRUt0xyuk58MKS30JW1iZhnwm
         TZwZAzfH+WPDh5MZ8SJoCfkaWfaErPlbKqpG/sRll8eCLH6rGTtdhy7kmEgDxDII6qXu
         Wcyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=LuWlSf5byRxNQY8vlLfNujb2aMA3zIoo8fg2vwGaxzw=;
        b=VpVMmNYlRG/QITT9J7xbzwXUUrsu3F+jGbuYZVAjhzvjGi09YeAmW+gqNiDg/7egXz
         lbHuTD35TtzL0krPgQelE3MCIGhSwIG5QD+MWxH68c/TD5FCpk+cWMEyczxXH3t3Y+E7
         1+/5k8Fj1kqDF/aLtgIZlgvWegJ3Rua9djIH1dN5dhGSihJD8w2DRVc0dj32s/HQPnrg
         V80EBXcgsncZSAqEZP9QNGnO9MWzr5qgcC7oSiEPB56Ij5MneIWPUIGpiSHebovcI3+z
         wgZUYN13HSp7GiC37glefLZ/N8Dn8z9xEgnxP3dMWGr9PmWDpvMnf6NM8KnIe9rbhSdN
         tBJA==
X-Gm-Message-State: AJcUukdV2hs8g0pozBhA5ka9l/zgHlNSKhhjDiu8jE5QAUpywUlhD9f1
        KECnVENFSG7CrEJTvufoPQg=
X-Google-Smtp-Source: ALg8bN5tG5sZRBMEYsC+c0jy4VqW7aCuFjg/vq6JK57leDKFeT/F+eKJ5/Muit/cPJklJTTNyxjOqg==
X-Received: by 2002:a63:4e41:: with SMTP id o1mr1206995pgl.282.1548232009112;
        Wed, 23 Jan 2019 00:26:49 -0800 (PST)
Received: from localhost (193-116-78-72.tpgi.com.au. [193.116.78.72])
        by smtp.gmail.com with ESMTPSA id s79sm32756271pgs.50.2019.01.23.00.26.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 00:26:48 -0800 (PST)
Date:   Wed, 23 Jan 2019 18:26:35 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/2] kbuild: remove top-level built-in.a
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <1547436479-10491-1-git-send-email-yamada.masahiro@socionext.com>
        <1547536378.afs6amsrzj.astroid@bobo.none>
        <CAK7LNAREyw=qhRO-Cvg4O2fOnbV=zVJDE_mRZcVTkKG+B1gkRQ@mail.gmail.com>
In-Reply-To: <CAK7LNAREyw=qhRO-Cvg4O2fOnbV=zVJDE_mRZcVTkKG+B1gkRQ@mail.gmail.com>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1548231946.lwdxf373y2.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro Yamada's on January 15, 2019 7:01 pm:
> Hi Nicholas,
>=20
>=20
> On Tue, Jan 15, 2019 at 5:07 PM Nicholas Piggin <npiggin@gmail.com> wrote=
:
>>
>> Masahiro Yamada's on January 14, 2019 1:27 pm:
>> > The symbol table in the final archive is unneeded because it is passed
>> > to the linker after the --whole-archive option. Every object file in
>> > the archive is included in the link anyway.
>> >
>> > Pass thin archives from subdirectories directly to the linker, and
>> > remove the final archiving step.
>>
>> This seems like a good improvement. As far as I remember, it was slower
>> to do the final link without the index built. Maybe I was testing it
>> in a revision before moving those files into --whole-archive? If there
>> is no slowdown, then I have no objection.
>=20
>=20
> Thanks for the review.
>=20
>=20
> I measured the performance of scripts/link-vmlinux.sh with 'perf stat'.
> (20 times for each)
>=20
>=20
>=20
> Before this patch:
>=20
>  Performance counter stats for 'make vmlinux' (20 runs):
>=20
>        5.266796537 seconds time elapsed
>           ( +-  0.12% )
>=20
>=20
>=20
> After this patch:
>=20
>  Performance counter stats for 'make vmlinux' (20 runs):
>=20
>        4.945576395 seconds time elapsed
>=20
>=20
>=20
>=20
> So, the performance is slightly better.
>=20
> Maybe, does omitting the 'ar' save some time?

Wow yeah that's a good speedup and simplification to boot. Thanks for=20
checking it.

> Anyway, this commit is good.

Yes, it's a good improvement.

Thanks,
Nick
=
