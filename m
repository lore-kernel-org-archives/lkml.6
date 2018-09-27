Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A46C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D184F21531
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FfO2gH0t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D184F21531
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbeI0T0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 15:26:31 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:37956 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbeI0T0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 15:26:31 -0400
Received: by mail-it1-f193.google.com with SMTP id p129-v6so7566282ite.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 06:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SrKuDVS7DclTQSqUDMmGvliPjeTUGz/gCPUuZHfV6KA=;
        b=FfO2gH0tVyyU2N8o68kTEb5a+Boat/SGGV1oCfwrBVUQiyyGs8Gq2KMsiBUkbuQmQp
         3xuKf78lQ5LUFglapSAitTCF9vQ9vDF0qXjFsEjcYKYIbXHnaRM/ETiyHKOJcW55QAfO
         t6xRBkxPAmeINPUL4Awp8uIyJkush5mezxP1kWqHeKar17b8ULmAgA9bA1x3W53EpMk3
         nZgLwyligDpDru3eokJCbdx3yIY4LDXJTozUaCBnGBC4Q6W+s43nPfXwH/wtH/ErCpyw
         diU2yqPF3Rmfn1GWfaR9tMefTSLCPoVVfaus+zs8zLRWi6OSVoLcI7Swc8hKkxIXPpoj
         KXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SrKuDVS7DclTQSqUDMmGvliPjeTUGz/gCPUuZHfV6KA=;
        b=qJoeh1I3otUqvjBNcNvJV07Z7/Wnb9gwKvlx6F1JUweVFhaAY+uZAF0EGMo5eAX8w/
         UDTaTFdPJMsYgR0wHd68FFCZYFwnYqvoBqpopDDkFWyTOs9yh3O29s2LHdktIw2SLbfi
         lOZ+sxY9HTuHAqdZx7hiNUdt8/az8K95oLbCXJk+xot0vpf73evqfhWFW6eP9BXxlntl
         agbQNvhO288sNFXMStcziC1lVJJaoPe8IlU7jTA7cjRSO8k8uvKJuzTXgsNh+7PQqbnz
         pjwMEzj574+zIR+YsKVhXBvTw2irWq2xC7DqTrk+mjCH0L4MofLkjnKdDzbbK+hkkv6l
         /thg==
X-Gm-Message-State: ABuFfog/fPeSN3WixgW4MVNigdmV2p+0RyJ7NgQk55KzouC3QLE0z5fZ
        Fj2nXpHG97Ews25RNq2/KLONPA8+HmkK0+NNx/5OsQ==
X-Google-Smtp-Source: ACcGV614VSbVwiXTEAt+d6CYmZEMI+fjnJBLr6ewFdl9/nG6L1ivDjVmt5pJYKp1cAkwAHNrGx9DtyFDdWNi1n2DIXA=
X-Received: by 2002:a02:4009:: with SMTP id n9-v6mr10000085jaa.19.1538053699577;
 Thu, 27 Sep 2018 06:08:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:ab8c:0:0:0:0:0 with HTTP; Thu, 27 Sep 2018 06:07:59
 -0700 (PDT)
In-Reply-To: <01000166110bb882-0b1fa048-fe1c-4139-a1ba-702754bbc267-000000@email.amazonses.com>
References: <000000000000e5f76c057664e73d@google.com> <CAKdAkRS7PSXv65MTnvKOewqESxt0_FtKohd86ioOuYR3R0z9dw@mail.gmail.com>
 <CACT4Y+YOb6M=xuPG64PAvd=0bcteicGtwQO60CevN_V67SJ=MQ@mail.gmail.com>
 <010001660c1fafb2-6d0dc7e1-d898-4589-874c-1be1af94e22d-000000@email.amazonses.com>
 <CACT4Y+ayX8vzd2JPrLeFhf3K_Quf4x6SDtmtkNJuwNLyOh67tQ@mail.gmail.com>
 <010001660c4a8bbe-91200766-00df-48bd-bc60-a03da2ccdb7d-000000@email.amazonses.com>
 <20180924184158.GA156847@dtor-ws> <CACT4Y+ZPrngv8GTC-Cw68PBDxZ2T5x1kKMNXL3DmP24Xd0m_5g@mail.gmail.com>
 <01000166110bb882-0b1fa048-fe1c-4139-a1ba-702754bbc267-000000@email.amazonses.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 27 Sep 2018 15:07:59 +0200
Message-ID: <CACT4Y+aUdAmRmgiV5-KWXF-eGoCUCMhUC+ddLU-heQTQ53PhRA@mail.gmail.com>
Subject: Re: WARNING: kmalloc bug in input_mt_init_slots
To:     Christopher Lameter <cl@linux.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        syzbot+87829a10073277282ad1@syzkaller.appspotmail.com,
        Pekka Enberg <penberg@kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 4:04 PM, Christopher Lameter <cl@linux.com> wrote:
> On Tue, 25 Sep 2018, Dmitry Vyukov wrote:
>
>> Assuming that the size is large enough to fail in all allocators, is
>> this warning still useful? How? Should we remove it?
>
> Remove it. It does not make sense because we check earlier if possible
> without the warn.

Mailed "mm: don't warn about large allocations for slab" to remove the warning.
