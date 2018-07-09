Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67FDC5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A260620873
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jpDh73yV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A260620873
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933464AbeGIQQ0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:16:26 -0400
Received: from mail-pl0-f49.google.com ([209.85.160.49]:45639 "EHLO
        mail-pl0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932806AbeGIQQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:16:24 -0400
Received: by mail-pl0-f49.google.com with SMTP id a17-v6so417935plm.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 09:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ervOhoo+C09P5nxNlJ2VW6XOKnApBp31QEZqEUOw8zE=;
        b=jpDh73yVUNNDaCM+q22fbh49I4zJVUDVA3wiDlayNu11ld174w9gzz8QjWamoK0obS
         DGQDIkXYG0E1TK2KqOu45M1TbdvoccRaCbI8ufULY+cRm+GB8TQn1iavIbpmkplf8Jwe
         kk/mJuTRJHIHSij24RAOEXIGK8tv17qCJGl4mhH/yzltJdqf7VKh37qNUZBXmQzEE4Nl
         ILPoBbBUGUMs73GzLupf4vYD1lNke8yhg9CoeVWgez2sanjgOkUOEuRj10F3yGmfRwf6
         kmzBnlXI/cRNi96uQ6KOdnYzQxI5h9WFpf0b925Nevul7+L94hLXkARskh8HFNBpxD5O
         oSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ervOhoo+C09P5nxNlJ2VW6XOKnApBp31QEZqEUOw8zE=;
        b=nzXINmoaC2fwOOcuA60J4sAAJcwq4BvkksWXP3Mr4ev1abFKFsTJI2fiz7Q6wx3XZB
         ZEJUUpG9DG8tDfI5Vi1rVbxi2SURacRXg/6gqpP9G18E7JPzRpIGKc2w3pcHJy9bJ/f8
         bLGAG73Ps9TysQkGH0KYIsIgp64s+xYx69x1eR4XOHpMT2zSr5TjvZcs/XYAs2zmedJm
         NAZSo+WVPl3rbtQyq9mSeiVBCjDHxh1mc5qRbzcq6igHUdxGfelWnNGsM1KfYyh49SLQ
         yASDXuizvUpJonnbL9iLqL6BYnxCxKNRiPlcRMiJ/Qr8QM/WK1asgx9Ko3zcq2c1S1eY
         WN9A==
X-Gm-Message-State: APt69E0kA3Hb0XwAKVdG6LubjY4RPDUE30dDyYl6Pv5ibLSdhXQFhF8N
        UUmn54HnkfhOqfWB12n1AHCqWryDyvHdS+lZTuVZpg==
X-Google-Smtp-Source: AAOMgpe4AicIH0BBoVnDwrQ9rFGJerZGGb71t8GeWi827T30Oez9OZHhq8QuErjGdAovu3YzJA7t7FGIlBSaKUDozok=
X-Received: by 2002:a17:902:8c88:: with SMTP id t8-v6mr21142988plo.117.1531152983385;
 Mon, 09 Jul 2018 09:16:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:950a:0:0:0:0 with HTTP; Mon, 9 Jul 2018 09:16:02
 -0700 (PDT)
In-Reply-To: <010001647fcab0b9-1154d4da-94f8-404e-8898-b8acdf366592-000000@email.amazonses.com>
References: <000000000000afa87d05708af289@google.com> <010001647fcab0b9-1154d4da-94f8-404e-8898-b8acdf366592-000000@email.amazonses.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 9 Jul 2018 18:16:02 +0200
Message-ID: <CACT4Y+ZiVLw4pEt_GXV0DDo95eER5LuwXRo_fjFLwP8fUXzcrQ@mail.gmail.com>
Subject: Re: kernel BUG at mm/slab.c:LINE! (2)
To:     Christopher Lameter <cl@linux.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        netdev <netdev@vger.kernel.org>
Cc:     syzbot <syzbot+885bda95271928dc24eb@syzkaller.appspotmail.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 9, 2018 at 6:05 PM, Christopher Lameter <cl@linux.com> wrote:
> On Sun, 8 Jul 2018, syzbot wrote:
>
>> kernel BUG at mm/slab.c:4421!
>
> Classic location that indicates memory corruption. Can we rerun this with
> CONFIG_SLAB_DEBUG? Alternatively use SLUB debugging for better debugging
> without rebuilding.

This runs with KASAN which is way more powerful than slab/slub debug.

There two other recent crashes in bpf_test_finish which has more info:

https://syzkaller.appspot.com/bug?id=f831c88feddf5f4de09b846bbe53e5b8c06e5c02
https://syzkaller.appspot.com/bug?id=059cee5623ce519359e7440ba6d0d6af8b82694e
