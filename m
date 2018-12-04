Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBDCC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF2F82081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlC9Lq44"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF2F82081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbeLDTpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:45:02 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34534 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbeLDTpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 14:45:02 -0500
Received: by mail-pg1-f195.google.com with SMTP id 17so7854469pgg.1;
        Tue, 04 Dec 2018 11:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=h/WGcDBlkFhA27cXAvj5y+7rgOt6LBLLcXWwGSkEtVY=;
        b=TlC9Lq44k0PQKrLUh6lAjsQ2dm3ZowPCTMMH9A3Jcj05BTn9VWpfAPi9Odlg5bJ8cE
         fUAgyE/PvW+B3seCnDe9bmWxZzsWfteDJLqYwEvOdUyrOz/FdhI/o6zKcOpJ7RNEPIQw
         cJw91L3leJ2IIWRAmTvDI1wovcDKy4S6pO5xWlb5Dta0/nEVqVkr7Wwh9iMZmpJAMF1W
         CAhGXgQhIoiXn48++Wn6oVAkbTiy4Ew0/mHxYKCmFqF/7lPY25tQjdU/e33Bicu6gFj+
         c8JJ201TVUGquI4iLZl+LCh/er/5yxR3cQsm/yHM/Fuyqb0XTfABvk9kKEbdj5UkDi9V
         gzeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=h/WGcDBlkFhA27cXAvj5y+7rgOt6LBLLcXWwGSkEtVY=;
        b=Y4j/Eyv40RIw0tfC9vNCfEGNLweh/qN/BUkphaAqNRvnfI6CJ9PAuM9j9sHUjVt1Vm
         /jZLAOU4gcqR+fZ+nwMg7m8keBwJdh/Vn+nyxIPVqyS8pzZV5th787bnJT5Tcyx8N3lS
         tn0u+CbQyHWN0U6piTci8FtzzDrK5n+FWCUPzH1nt4kbcg0gvaZ9YkdGduY8yAO6bIHr
         nJUgqOhFMJxOYRRZqVqUMBqLaAcdDUrnBQ0b336chXzqY1Q8UMXizlOIu5Vr1UpjW66u
         U8vGxsW9PRF7RbeFx03rKl59tht18WU6g5kQtJpF//R4vHFMze/I+ruyQ3TiHpGYnoiu
         Fvsg==
X-Gm-Message-State: AA+aEWbIocrCeLZv9JVS5hdVj9Ew+jB3pyN4by4KEzsvbUP+T8AFjr9A
        PdUertuY9BpgJiED/cDJuyo=
X-Google-Smtp-Source: AFSGD/VjJWirFUj/ejvfo345ERZDgq8ccQbsvgeMWfWcHkeuM5feZNEZuaohcA+mkwF/Rs069i/9Xw==
X-Received: by 2002:a63:2643:: with SMTP id m64mr17555130pgm.35.1543952700849;
        Tue, 04 Dec 2018 11:45:00 -0800 (PST)
Received: from ?IPv6:2601:647:4580:b719:9448:6a51:fd0f:790f? ([2601:647:4580:b719:9448:6a51:fd0f:790f])
        by smtp.gmail.com with ESMTPSA id g11sm22596415pfo.139.2018.12.04.11.44.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 11:45:00 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [PATCH 1/2] vmalloc: New flag for flush before releasing pages
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <CALCETrXvddt148fncMJqpjK98uatiK-44knYFWU0-ytf8X+iog@mail.gmail.com>
Date:   Tue, 4 Dec 2018 11:44:58 -0800
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, jeyu@kernel.org,
        Network Development <netdev@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <08141F66-F3E6-4CC5-AF91-1ED5F101A54C@gmail.com>
References: <20181128000754.18056-1-rick.p.edgecombe@intel.com>
 <20181128000754.18056-2-rick.p.edgecombe@intel.com>
 <4883FED1-D0EC-41B0-A90F-1A697756D41D@gmail.com>
 <CALCETrXvddt148fncMJqpjK98uatiK-44knYFWU0-ytf8X+iog@mail.gmail.com>
To:     Andy Lutomirski <luto@kernel.org>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Dec 4, 2018, at 10:56 AM, Andy Lutomirski <luto@kernel.org> wrote:
>=20
> On Mon, Dec 3, 2018 at 5:43 PM Nadav Amit <nadav.amit@gmail.com> =
wrote:
>>> On Nov 27, 2018, at 4:07 PM, Rick Edgecombe =
<rick.p.edgecombe@intel.com> wrote:
>>>=20
>>> Since vfree will lazily flush the TLB, but not lazily free the =
underlying pages,
>>> it often leaves stale TLB entries to freed pages that could get =
re-used. This is
>>> undesirable for cases where the memory being freed has special =
permissions such
>>> as executable.
>>=20
>> So I am trying to finish my patch-set for preventing transient W+X =
mappings
>> from taking space, by handling kprobes & ftrace that I missed (thanks =
again for
>> pointing it out).
>>=20
>> But all of the sudden, I don=E2=80=99t understand why we have the =
problem that this
>> (your) patch-set deals with at all. We already change the mappings to =
make
>> the memory writable before freeing the memory, so why can=E2=80=99t =
we make it
>> non-executable at the same time? Actually, why do we make the module =
memory,
>> including its data executable before freeing it???
>=20
> All the code you're looking at is IMO a very awkward and possibly
> incorrect of doing what's actually necessary: putting the direct map
> the way it wants to be.
>=20
> Can't we shove this entirely mess into vunmap?  Have a flag (as part
> of vmalloc like in Rick's patch or as a flag passed to a vfree variant
> directly) that makes the vunmap code that frees the underlying pages
> also reset their permissions?
>=20
> Right now, we muck with set_memory_rw() and set_memory_nx(), which
> both have very awkward (and inconsistent with each other!) semantics
> when called on vmalloc memory.  And they have their own flushes, which
> is inefficient.  Maybe the right solution is for vunmap to remove the
> vmap area PTEs, call into a function like set_memory_rw() that resets
> the direct maps to their default permissions *without* flushing, and
> then to do a single flush for everything.  Or, even better, to cause
> the change_page_attr code to do the flush and also to flush the vmap
> area all at once so that very small free operations can flush single
> pages instead of flushing globally.

Thanks for the explanation. I read it just after I realized that indeed =
the
whole purpose of this code is to get cpa_process_alias()=20
update the corresponding direct mapping.

This thing (pageattr.c) indeed seems over-engineered and very =
unintuitive.
Right now I have a list of patch-sets that I owe, so I don=E2=80=99t =
have the time
to deal with it.

But, I still think that disable_ro_nx() should not call set_memory_x().
IIUC, this breaks W+X of the direct-mapping which correspond with the =
module
memory. Does it ever stop being W+X?? I=E2=80=99ll have another look.

