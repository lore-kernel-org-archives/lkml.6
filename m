Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D29C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 468BD20894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vqnq4Phu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 468BD20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389463AbeHAPiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 11:38:54 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40753 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389436AbeHAPix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 11:38:53 -0400
Received: by mail-pl0-f66.google.com with SMTP id s17-v6so8852343plp.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 06:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=j8T4anH1xkGduRuYGBbfGYJQNBNV0RDS5hm0aa8moy8=;
        b=Vqnq4Phuog+7WXzHOd3XxY3a3DS/gvoMCvI7eCttxcHe+GAvZkrZRDf2tnoZiWpyY+
         c3pjc5By+XKH5qMp03rMSEyahiDYNF2Ilw9FINJIWsGRGOhhUvL+gpVRyLgOCwMT21Ce
         1R2utOD97zkyF2LJSqxiwA1vHoCFiz2JxavecOOYwNlZhJksGF7JUKGYV3dN+SRb5NTU
         8xEiMxoAdIY6hF7GpaERluFg+vsnihmS8t2u/YON842L1G2gD8vRJ+gGRBhFvh1uv874
         QWEahwOGhKbQ669nxlUXO+IZzf+Q5ET7VMMl9q/0HKaCWxkMYMyoHddNjfMOrBiTe4NG
         oKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=j8T4anH1xkGduRuYGBbfGYJQNBNV0RDS5hm0aa8moy8=;
        b=qsNLRK33QM8p28VT1VqLg68Jvnic12NSmT2x4TTp5A93Sxchp6B1r32jAa739YF9KE
         YoxzLMMMIPcl+BggWphHNY+7mCw53bqgZFFPg3CR6zmjpCJ3BvzoOPvnDNKUFqH5rkl0
         8Btr5XPNBwG/QqxQBOo/9F2U9PU2HyktY9U/qk2kzHYQqKLVISY7sFv3KCz/2lO7Pbhx
         8ARBp7mMtxTdzjvy0l724h1inrWb4ZxhLARo1bW5XGToVTocDGTdP54kocGarKeg/aa7
         PZga3jWUyO/dCJmcR4uwHNekWf2nZ13aM0v4QQ0Y734GAeVXsxmql39e5B7DvxgKj9pe
         6JmQ==
X-Gm-Message-State: AOUpUlHVUBga9ry2jacky44AgL2A7k5MDo2aEZc0AkVZG/Ro/l7if9oM
        f5T3xyXJ19A51YvnqVYlxkHg6tMzm32gyny6kRiJMw==
X-Google-Smtp-Source: AAOMgpcY1YCgvNC4kg0TK8aBQQZy7vOkG1C4+tHVvTqr7ecuZf1ZhjxMuAg6oDVPboKU1ngqcUlCyeinDfMol/FkUlk=
X-Received: by 2002:a17:902:4401:: with SMTP id k1-v6mr22667391pld.97.1533131581038;
 Wed, 01 Aug 2018 06:53:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Wed, 1 Aug 2018 06:52:40
 -0700 (PDT)
In-Reply-To: <20180801134628.ueyzwg2gszrvk2hc@breakpoint.cc>
References: <e3b48104-3efb-1896-0d46-792419f49a75@virtuozzo.com>
 <01000164f169bc6b-c73a8353-d7d9-47ec-a782-90aadcb86bfb-000000@email.amazonses.com>
 <CA+55aFzHR1+YbDee6Cduo6YXHO9LKmLN1wP=MVzbP41nxUb5=g@mail.gmail.com>
 <CA+55aFzYLgyNp1jsqsvUOjwZdO_1Piqj=iB=rzDShjScdNtkbg@mail.gmail.com>
 <CACT4Y+aYZumcc-Od5T1AnP4mwn8-FaWfxvfb93MnNwQPqG8TDw@mail.gmail.com>
 <CACT4Y+ZkgqDT77dshHg+hBtc9YPW-eZ8wVQA9LTDQ6q_y99oiQ@mail.gmail.com>
 <20180801103537.d36t3snzulyuge7g@breakpoint.cc> <CACT4Y+aHWpgDZygXv=smWwdVMWfjpedyajuVvvLDGMK-wFD5Lw@mail.gmail.com>
 <20180801114048.ufkr7zwmir7ps3vl@breakpoint.cc> <CACT4Y+ZNnYojj0x_DoUxeUREaEgzcf3UG=UW_P4vzsnZNjjgMQ@mail.gmail.com>
 <20180801134628.ueyzwg2gszrvk2hc@breakpoint.cc>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 1 Aug 2018 15:52:40 +0200
Message-ID: <CACT4Y+ay6+UTLMr4K_RTTubjzpGZXe2n7T8Q=kC=Q1baHshkHQ@mail.gmail.com>
Subject: Re: SLAB_TYPESAFE_BY_RCU without constructors (was Re: [PATCH v4
 13/17] khwasan: add hooks implementation)
To:     Florian Westphal <fw@strlen.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        linux-ext4@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        David Miller <davem@davemloft.net>,
        NetFilter <netfilter-devel@vger.kernel.org>,
        coreteam@netfilter.org,
        Network Development <netdev@vger.kernel.org>,
        Gerrit Renker <gerrit@erg.abdn.ac.uk>, dccp@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Dave Airlie <airlied@linux.ie>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Eric Dumazet <edumazet@google.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ursula Braun <ubraun@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 3:46 PM, Florian Westphal <fw@strlen.de> wrote:
> Dmitry Vyukov <dvyukov@google.com> wrote:
>> If that scenario is possible that a fix would be to make
>
> Looks possible.
>
>> __nf_conntrack_find_get ever return NULL iff it got NULL from
>> ____nf_conntrack_find (not if any of the checks has failed).
>
> I don't see why we need to restart on nf_ct_is_dying(), but other
> than that this seems ok.

Because it can be a wrong entry dying. When we check dying, we don't
yet know if we are looking at the right entry or not. If we
successfully acquire a reference, then recheck nf_ct_key_equal and
_then_ check dying, then we don't need to restart on dying. But with
the current check order, we need to restart on dying too.
