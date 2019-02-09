Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6FDC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4637E21916
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmTGBipt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfBIMg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 07:36:29 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39744 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfBIMg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 07:36:28 -0500
Received: by mail-lf1-f65.google.com with SMTP id m11so4515675lfc.6
        for <linux-kernel@vger.kernel.org>; Sat, 09 Feb 2019 04:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bfgNr3JAzUOTRynOjZLInmhtYTp+llBnaLinVAJ3I8o=;
        b=lmTGBiptUSb/Nb38ex7PQdU2yCcI615IeiCmQMBGWZ+NpIHHSiCPrSK9DeHVJ22Ymj
         bINxI/WwBbh4VQYohvfpQaTOWTfDQtTRf8K7lj2u/tjSyfJjD2bMRwiNtDNlOq6716oM
         GKFiAcyld4mwz26gIqt1dBSrQqFa+hgIaVxd/eYs+hDtYu1gCCS6ZriRji8O14cVtGeY
         sBOvoPpshcoHILI7H/MZdCgBcYg4Q8r7enMjkVW3D5RCB//4sTu6zq8XmBE5FQVVn2cv
         z/j6nBbXYn65tJ2VRoBGQoD/Q/O8ijHI7C1Kr43BnghwJyukU3TPz8RLzHTaeiVXywiq
         3q6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bfgNr3JAzUOTRynOjZLInmhtYTp+llBnaLinVAJ3I8o=;
        b=siaQsETqJa+EbWebAzuNbY+30LSU9M5wKbBnFrCXoQgb3wZCH5vzMVP+nGSuMTRGvD
         hTSDfm9XOTOYRq1TOxfsKN6YZXwMe4T+tqN0oreOSicOF+4JMm4MASHchzhzzGKsKpkP
         pz89EQzf3FIP65X/T6wNN9uRYfM8ZuLFmrB0YKo4b8FuhsZfHVoXyi7Ap4E4tBbxdkYh
         fMC1b9JhJSEzWhHvxXI7BwCWfS3LfteM+jn9xaUUhtTRGx2iSSTrT12nA2zCOuLbYPxP
         ylOx5Ft/bvUzkrtdn5xTPTdgLRKTcITFMt3uQvBLyPA3ljao+GjQkod5TwwTIs9aQyqn
         9gZg==
X-Gm-Message-State: AHQUAuaiY5DAfuDjmiB5AlE7Um+vX7iAZ7nPSjAp1ATk6Jl5Tn2dGn8w
        zyDsBYHSEItbn7NlmY2g0q5btP+gc41r0Z/yuz54ZERWNfs=
X-Google-Smtp-Source: AHgI3IagN0l1td6/GG9NrE5r+oivyWYm4Y5eMSJk70j3klxcIMq17NhBk8sMCjgYcF+16GYxNS629PjC9qw8hxyZkz4=
X-Received: by 2002:a19:a84e:: with SMTP id r75mr15072399lfe.45.1549715786554;
 Sat, 09 Feb 2019 04:36:26 -0800 (PST)
MIME-Version: 1.0
References: <20190209000840.11018-1-miguel.ojeda.sandonis@gmail.com>
 <20190209000840.11018-3-miguel.ojeda.sandonis@gmail.com> <CAKwvOd=hhSY9msLQvwWRjuYuqR7VtW8+Pr9+y-10_khzbtQ8_g@mail.gmail.com>
In-Reply-To: <CAKwvOd=hhSY9msLQvwWRjuYuqR7VtW8+Pr9+y-10_khzbtQ8_g@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 9 Feb 2019 13:36:15 +0100
Message-ID: <CANiq72nBc3wy3rN_hDa5gkpzFCM8RT9en9sip-GwQFkt4RqGjQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] Compiler Attributes: add support for __copy (gcc >= 9)
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Martin Sebor <msebor@gcc.gnu.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Laura Abbott <labbott@redhat.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kees Cook <keescook@chromium.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 9, 2019 at 1:41 AM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> Drop "they" from this sentence if there's a respin, otherwise looks helpful.
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Good catch!

Thank you,
Miguel
