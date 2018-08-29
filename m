Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FBEC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45E6A206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6xEniE9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45E6A206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbeH2Md7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:33:59 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179]:42744 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbeH2Md6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:33:58 -0400
Received: by mail-pl1-f179.google.com with SMTP id g23-v6so1978164plq.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 01:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+4Mhwns+g3RMeGa5TK7Mcv01PQnwPYQk/1LhjugUUrc=;
        b=P6xEniE9gIDNVo1WZmKT6a5t7ifk9AbNQlLCSXWsORLtHD45uY90Aa/yOWwSiKKtGz
         +U1Y/JXry94nvC+frFRYuxj+rJMKsmlLrAnWPduU39Oy8VCc9BVHohvNughVUhnHtSUn
         02iAcCkArKP95tHYUum2zyRyek1SHPKt98s3mguhaLznsO5U2kwm37T2kdtIFtFID3lX
         gAhfZFfLswXJfBNgyhlXYDw8onMOAxvYQ6aisI4aFHvT/JPyX+mXEKvD6WSzQAdDXmiq
         CNDP8PVcEaNlHGU9xWoRGiG/4mEbwHHmiTPKm2iBlh/JmcncZD8msQksTW37ZSzT+Oqf
         9vvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+4Mhwns+g3RMeGa5TK7Mcv01PQnwPYQk/1LhjugUUrc=;
        b=LPip7LL8lszX3RhPte/g9Hs8fh3/rwoknuOW4pXxHgY0Fl6a7H8qy2CbTW5pf5Grom
         cv8ZkOEyhrTaTObqRv+c1IBbGbVrt6WMje0vzpMwZY3maufZ4j/253bfo1pbDPPI/BWg
         6ojCfYa2xbtyqXK0ARaGcIM6BtLzbbY1JW/iCldr2EnNOjm5ccUoTzoyJuJ9FU/DM7uy
         EiovTZ3crrSu9a1A1mN3tIc6cxe6KRXHmIDHS3MjywRq8+7RTqymzJdJFJym5mykMCpR
         6/TZwV+2ML/RQwn415saBO0ifZAoXnb3JqhsQ9FG2ruSIxzEg1egFqrptA4QKrHYBXNY
         NIWw==
X-Gm-Message-State: APzg51Ae+K16Z496XIwbgv4uDqV5Qkaaa2NrCk9tIhRdT/6tGczmbGJ5
        2g6oS5C+QFCk5IRlRMbS/bQ=
X-Google-Smtp-Source: ANB0VdaydCf+S8TKtU6iRezEAjxa+5SA2h6VRhveyyMCTHX4UuKlkN4fmqOsp6/QNZx9HWsI/W7S7w==
X-Received: by 2002:a17:902:b70f:: with SMTP id d15-v6mr5126250pls.53.1535531890121;
        Wed, 29 Aug 2018 01:38:10 -0700 (PDT)
Received: from ?IPv6:2601:647:4580:b719:fdb9:18c9:b2e3:3456? ([2601:647:4580:b719:fdb9:18c9:b2e3:3456])
        by smtp.gmail.com with ESMTPSA id s195-v6sm5591525pgs.76.2018.08.29.01.38.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 01:38:09 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: Flushing user entries for kernel mappings in x86
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <CALCETrWy3v-DiCNJs=wkym_q4U07-mtmEqy1YgMvAJ8AOT8MJQ@mail.gmail.com>
Date:   Wed, 29 Aug 2018 01:37:55 -0700
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7EDEB913-E4F8-481F-93D3-EE158641A366@gmail.com>
References: <8F811430-A9D5-446C-9D6A-C4CA82555559@gmail.com>
 <CALCETrWy3v-DiCNJs=wkym_q4U07-mtmEqy1YgMvAJ8AOT8MJQ@mail.gmail.com>
To:     Andy Lutomirski <luto@kernel.org>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 8:45 PM, Andy Lutomirski <luto@kernel.org> wrote:

> On Tue, Aug 28, 2018 at 6:46 PM, Nadav Amit <nadav.amit@gmail.com> =
wrote:
>> Hello Andy,
>>=20
>> Is there a reason for __flush_tlb_one_kernel() to flush the PTE not =
only in
>> the kernel address space, but also in the user one (as part of
>> __flush_tlb_one_user)? [ I obviously regard the case when PTI is on =
].
>=20
> In most cases, probably not, but it's fairly cheap, I think.  And it
> makes it so that we're okay if the TLB entry we're flushing is used by
> the entry code.

Thanks. I assumed that=E2=80=99s the case. I don=E2=80=99t know how =
cheap they are
(especially if INVPCID is not supported) but I guess they are not that
frequent.

