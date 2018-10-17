Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2912ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A8A32150F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BNberKtF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A8A32150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727596AbeJQXj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:39:58 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41339 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeJQXj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:39:57 -0400
Received: by mail-pf1-f195.google.com with SMTP id m77-v6so13391289pfi.8;
        Wed, 17 Oct 2018 08:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=frAx4qwIJKyvoQ6OKQmKnVvCEvDLL2FXOZbZSN9O/EU=;
        b=BNberKtFEcGcAIvtPpZtxVf+7dHGbzsPc+dfIpso8I0QIA2Cftv1QcU1KitQopyqQ8
         Rpp259bhWr5NHOYMu7RPI+4yKrds0Er1wbNPkv1FhGaGU0m3rELPQvOn3uifLjAakmtI
         RG9BSWkR9J5fuIiSsm05l5Fi18PeijY6PsvlJFfbcLqQOpeGDOOPWkIdKg0+JXbw0BjZ
         pB2+8uLFctkkn/zPEg/zJEEH1y0b9xFJNyrvdx4yyd7uvyNwosr8xo21vrBVCvjI7bbo
         /jjjQNokpBTx04RHEIZfGnch1aM3ELJRv5SDYgdQkLLzOj0sur4SyoeDkuAWZs06UDB5
         nXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=frAx4qwIJKyvoQ6OKQmKnVvCEvDLL2FXOZbZSN9O/EU=;
        b=UA3mEKnB1yXkuCUrLLdB0AaMZUHgDHatAYnx8cgv4j45lGqP2fyH9yoGEhv4MeTYMp
         1m8RKMpgolHZ5d+ka1ZXCBYFvSxnBWx4yT4+nd+yt0rJfqooHDwJiP6200iEbW11oKxV
         AgnjuMcwL+tEb8wTaALfQMtakUrD7+HWdU71PCwjaX6uZhH+CUiXSAGs3aZHyrIToEE+
         vlKyGFvMYaL22rBUzryDSJ7rqnYDVbXYPZd0JqMTyV0B31mhvOuWTSIP1JMoX714KlF0
         D4nl/iE7P5nYXu/KeNtaf8qbxYDUmx7MzTcrF8263F1/j4q9nH3Em+21IF1gxa350UeL
         Ab7w==
X-Gm-Message-State: ABuFfojiMERfD1d0Yapr5MAgRNfkA47YePTsBwMcCxv+opKuxvqKsBhk
        omC/jRYWicyDivKdYGeTJ20=
X-Google-Smtp-Source: ACcGV63CbYYXkJ/SS1vO0dq2UOEYi6WbaMI0kEyCmV9fFgpEmeYDw/qLPlJpD+OcyFTxZI4LGge06A==
X-Received: by 2002:a63:1066:: with SMTP id 38-v6mr25200909pgq.254.1539791020145;
        Wed, 17 Oct 2018 08:43:40 -0700 (PDT)
Received: from ?IPv6:2601:647:4201:6700:b990:46cf:5e72:63f5? ([2601:647:4201:6700:b990:46cf:5e72:63f5])
        by smtp.gmail.com with ESMTPSA id z70-v6sm23033709pgd.64.2018.10.17.08.43.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 08:43:39 -0700 (PDT)
Date:   Wed, 17 Oct 2018 08:43:30 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <0100016682aaae79-d1382d3d-83f8-4972-b4b9-6220367f4f65-000000@email.amazonses.com>
References: <000000000000e5f76c057664e73d@google.com> <CAKdAkRS7PSXv65MTnvKOewqESxt0_FtKohd86ioOuYR3R0z9dw@mail.gmail.com> <CACT4Y+YOb6M=xuPG64PAvd=0bcteicGtwQO60CevN_V67SJ=MQ@mail.gmail.com> <010001660c1fafb2-6d0dc7e1-d898-4589-874c-1be1af94e22d-000000@email.amazonses.com> <CACT4Y+ayX8vzd2JPrLeFhf3K_Quf4x6SDtmtkNJuwNLyOh67tQ@mail.gmail.com> <010001660c4a8bbe-91200766-00df-48bd-bc60-a03da2ccdb7d-000000@email.amazonses.com> <20180924184158.GA156847@dtor-ws> <20180927143537.GB19006@bombadil.infradead.org> <20181017000955.GG230131@dtor-ws> <0100016682aaae79-d1382d3d-83f8-4972-b4b9-6220367f4f65-000000@email.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: WARNING: kmalloc bug in input_mt_init_slots
To:     Christopher Lameter <cl@linux.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot+87829a10073277282ad1@syzkaller.appspotmail.com,
        Pekka Enberg <penberg@kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Message-ID: <CE3D3608-F320-4DAB-8BEB-3EFDDB54F97E@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On October 17, 2018 8:35:15 AM PDT, Christopher Lameter <cl@linux=2Ecom> wr=
ote:
>On Tue, 16 Oct 2018, Dmitry Torokhov wrote:
>
>> On Thu, Sep 27, 2018 at 07:35:37AM -0700, Matthew Wilcox wrote:
>> > On Mon, Sep 24, 2018 at 11:41:58AM -0700, Dmitry Torokhov wrote:
>> > > > How large is the allocation? AFACIT nRequests larger than
>KMALLOC_MAX_SIZE
>> > > > are larger than the maximum allowed by the page allocator=2E Thus
>the warning
>> > > > and the NULL return=2E
>> > >
>> > > The size in this particular case is being derived from a value
>passed
>> > > from userspace=2E Input core does not care about any limits on size
>of
>> > > memory kmalloc() can support and is perfectly happy with getting
>NULL
>> > > and telling userspace to go away with their silly requests by
>returning
>> > > -ENOMEM=2E
>> > >
>> > > For the record: I definitely do not want to pre-sanitize size
>neither in
>> > > uinput nor in input core=2E
>> >
>> > Probably should be using kvzalloc then=2E
>>
>> No=2E No sane input device can track so many contacts so we need to use
>> kvzalloc()=2E Failing to allocate memory is proper response here=2E
>
>What is a "contact" here? Are we talking about SG segments?

No, we are talking about maximum number of fingers a person can have=2E De=
vices don't usually track more than 10 distinct contacts on the touch surfa=
ce at a time=2E


Thanks=2E

--=20
Dmitry
