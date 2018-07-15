Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2142ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 02:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CDCD208A5
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 02:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="A4rAyfic";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Qd5hKnMr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CDCD208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732049AbeGOCZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 22:25:17 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:37415 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731944AbeGOCZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 22:25:16 -0400
Received: by mail-yb0-f195.google.com with SMTP id r3-v6so14222119ybo.4
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jul 2018 19:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Opw9YTo5mdk3/DqPQzulhLZI1mMwEuZJhJs46BCxq5Q=;
        b=A4rAyficBU94rrB9or+N1uOz1+JxlulBtYb0/88VGkZJcsJ4qy7b/ikTVtYJYV1Dr2
         kODIDsdrP9cy8/3eARO08f1Pa//x9axFZJV1U4vMmN610FMETSJlCBRxNhluWUUKzkrR
         YcwWnIWO4ECg/tzsA5M5AbRbOgDVDohw7rQZdtMcJRi/eu1zLFzqpN0A+L4sXtwjd5cA
         eGoNES80bk1SwgVQrRklT8rSDseAE3hcVq/6Q1jSur3ic1Lk0nPSiAIB2DfOm2qkPO/b
         Bp3N0ydDe+7JnZdDNzsMpm+pL9KvQvgfn8Hb7nd9+tnv/NGdqafqWbQoNYny6i+5JBNg
         O66g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Opw9YTo5mdk3/DqPQzulhLZI1mMwEuZJhJs46BCxq5Q=;
        b=Qd5hKnMrIrTf6WpB7uJtB/r2OVEVfiV/BR5xD2kYUSJEGRi0wQQ9VG9UcI/HVF1t9w
         3AITaomy1NtYpZ/aTHaujPSRLUakeRYbwPIF3NetqGh3gpYrPNWOC/sOb//vY8BLnOqt
         STGTHnqaAG0ATXyyrPB1h+g6pb7vZpkzoqZ2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Opw9YTo5mdk3/DqPQzulhLZI1mMwEuZJhJs46BCxq5Q=;
        b=Zs8glLGri5xb4NvuTa6Fuo7peldO4JS4V5Qdl3RWXS7JdPbLkeiVhZ01wwgbyLH6/a
         iyl7M2Inoeg4f+00m5hC64seF3lE03qUHLS1VHqAWs3y7othpJ/iV/AisBcsreKaoZR4
         lkbvzY1mWNyXxHPTZpLokNZaXh9mDha6TnavGWtH4Toy4Bh09ZK7lFlJCZhZRU46v9Gz
         68QMngJrSuhdTrTP/MROh5jJnkRSj2GGFx8wpV8imHk+jrAnxg1GlgP+iQ38KrSunjLb
         aYxPjvLlnmwfhfev7o3SN+8/f6055xqP3W7RALrE6zmdMJ2MUirlJ0QjLciFOcUAQ6GE
         Uabg==
X-Gm-Message-State: AOUpUlGB2jYU5SW8QpI0ETNfu5xWdtQR0nXIWAVq1Xefgy2VYOGAifub
        c2Brc0J4JeQeb4vhFtEfXEvmxV+WouJ9e48jIaIr6g==
X-Google-Smtp-Source: AAOMgpdN/G/UuPvlFi5uAzEM6Lj22jT/rIhFGFlxEFhRkRXze/bjSMDg/txBMd3Ek35mulGiWyJLz9G75Oh2bJ7zDzs=
X-Received: by 2002:a25:a302:: with SMTP id d2-v6mr6363016ybi.193.1531620248646;
 Sat, 14 Jul 2018 19:04:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:6602:0:0:0:0:0 with HTTP; Sat, 14 Jul 2018 19:04:07
 -0700 (PDT)
In-Reply-To: <0bf9be39-82bb-ad3a-a3c3-e41bebedba7e@suse.cz>
References: <1530646988-25546-1-git-send-email-crecklin@redhat.com>
 <b1bfe507-3dda-fccb-5355-26f6cce9fa6a@suse.cz> <CAGXu5jJa=jEZmRQa6TYuOFORHs_nYvQAO3Q3Hv5vz4tsHd00nQ@mail.gmail.com>
 <0bf9be39-82bb-ad3a-a3c3-e41bebedba7e@suse.cz>
From:   Kees Cook <keescook@chromium.org>
Date:   Sat, 14 Jul 2018 19:04:07 -0700
X-Google-Sender-Auth: wvU6EJW1WHgTJ00HtvUZwoeqwuw
Message-ID: <CAGXu5jLcx7iFNJGL9=LStCGCq6gx2D7onJAmHsKK3Vxe2pJvdg@mail.gmail.com>
Subject: Re: [PATCH v7] add param that allows bootline control of hardened usercopy
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Chris von Recklinghausen <crecklin@redhat.com>,
        Laura Abbott <labbott@redhat.com>,
        Paolo Abeni <pabeni@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 4, 2018 at 10:47 AM, Vlastimil Babka <vbabka@suse.cz> wrote:
> On 07/04/2018 06:52 PM, Kees Cook wrote:
>> This produces less efficient code in the general case, and I'd like to
>> keep the general case (hardening enabled) as fast as possible.
>
> How specifically is the code less efficient? It should be always a
> static key check (no-op thanks to the code patching involved) and a
> function call in the "hardening enabled" case, just in different order.
> And in either case compiled out if it's a constant.

My understanding from reading the jump label comments[1] is that on
order produces:

NOP
do normal thing
label1:
do rest of function
RET
label2:
do exceptional thing
jump label1

where "NOP" is changed to "JMP label2" when toggled, and the other is:

JMP label1
do exceptional thing
JMP label2
label1:
do normal thing
label2:
do rest of function
RET

where "JMP label1" is changed to NOP when toggled. (i.e. does the
default do NOP, thing, function, or does the default to JMP, thing,
JMP, function)

-Kees

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/jump_label.h#n334

-- 
Kees Cook
Pixel Security
