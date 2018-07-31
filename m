Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1422FC46462
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 18:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B931620844
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 18:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aRlXLcEF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B931620844
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731899AbeGaT6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 15:58:13 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:43584 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728140AbeGaT6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 15:58:12 -0400
Received: by mail-ua0-f194.google.com with SMTP id x24-v6so10900897ual.10
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 11:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DTjXcujdgZpGHh7EfF5Xue7aXiadmLUkC/Ykc5iWe5E=;
        b=aRlXLcEFFhcXvAI+wlASznx7Qlgiyt8ynfxkjZzDOcLdfhmibji0ClI6CZSAPFjIWl
         ywm3WbaKizd7b3Y+yr5Isohd7mhJTG36UUoIwjZwi601QJ3FB9ATaw/Cxl28PTq11+Dn
         Fkoe2J4FoUPyqA5VaUMbOc+1vJu31K38uUb967zj9kx/N/oTQ3e4tEjczkv8StljYB75
         ntY4ed1tuVKexFU5/hIEpbchSlLSEw89yRS2QxNbpAWt7o7F8XUhTjZ5JK+/Z6f1T+hM
         hRMAbsXwZJK2bK8kZGacfb1violra9gUii5Z8EiLekmU0/pwTeJUDzHyTTWWvtCon9bp
         yhOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DTjXcujdgZpGHh7EfF5Xue7aXiadmLUkC/Ykc5iWe5E=;
        b=gf0tTFAjFRh+KmGWR4xLCA78zKzVAQ5fJwhdIC9nd5KixUXUbkZxkfhEnW472W1Cij
         /HEJlIt0xgQP3AbeWFN50EFZf1F8jeJBG+PDOTmF/yA5eExOA5jt5hyhe2t4ijn+XbOt
         bzEbpWrt5BNP2aWloJRu3oPHIiCPl2HIqUOZHPuCBfZqAHshCRXZuFy4e7R3N5TH60HE
         VG5fVOZm19EF5RI7caZwghP+1exZP/IPA/h2eFa13a7OUc0/AFIxayE8odZsO4E/+rte
         Rwrj/FD1ECjoqT/efD1oq79EH6ydRHsp1fcx5KwvZ5YigzTEOePXdvKZLyuGxdOcN5cp
         EiEA==
X-Gm-Message-State: AOUpUlE/HAr96aN8SZHqshOthj6SuOOyVquwFDJs+wKpbPjom7jSXlHo
        vkZhHuFv+dAF7143ArXsy/EB4F7x4KWpG/FN9tC6Nw==
X-Google-Smtp-Source: AAOMgpduxcUlIlLcijvZPcp+oSiPl2N7VHA58IFaDILX7W80KVqYl9RQyh5oYditSpPf9xNQ+6CE5rNaEWZkcjT6HLQ=
X-Received: by 2002:ab0:7055:: with SMTP id v21-v6mr16024703ual.44.1533061000916;
 Tue, 31 Jul 2018 11:16:40 -0700 (PDT)
MIME-Version: 1.0
References: <e3b48104-3efb-1896-0d46-792419f49a75@virtuozzo.com>
 <01000164f169bc6b-c73a8353-d7d9-47ec-a782-90aadcb86bfb-000000@email.amazonses.com>
 <CANn89iLLQP2vA+2J-zxL3Fa75zNw=yRmv3Jg6vcEc=fYeEZ2ow@mail.gmail.com> <CACT4Y+Y6dhNgisDM9hdP-M-Rnk66DxZWcX7v39ESGJR8RY3asQ@mail.gmail.com>
In-Reply-To: <CACT4Y+Y6dhNgisDM9hdP-M-Rnk66DxZWcX7v39ESGJR8RY3asQ@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 31 Jul 2018 11:16:28 -0700
Message-ID: <CANn89iLjk-mV3kZGASvZQtYaBDy9sbo=NW4Tt_V=dOP_-b=VNQ@mail.gmail.com>
Subject: Re: SLAB_TYPESAFE_BY_RCU without constructors (was Re: [PATCH v4
 13/17] khwasan: add hooks implementation)
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        "Theodore Ts'o" <tytso@mit.edu>, jack@suse.com,
        linux-ext4@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        David Miller <davem@davemloft.net>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev <netdev@vger.kernel.org>,
        Gerrit Renker <gerrit@erg.abdn.ac.uk>, dccp@vger.kernel.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ursula Braun <ubraun@linux.ibm.com>,
        linux-s390@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 10:51 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
>
> Is it OK to overwrite ct->status? It seems that are some read and
> writes to it right after atomic_inc_not_zero.

If it is after a (successful) atomic_inc_not_zero(),
the object is guaranteed to be alive (not freed or about to be freed).

About readind/writing a specific field, all traditional locking rules apply.

For TCP socket, we would generally grab the socket lock before
reading/writing various fields.

ct->status seems to be manipulated with set_bit() and clear_bit()
which are SMP safe.
