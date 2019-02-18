Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56D1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71FE720700
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nH2FfnmE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390937AbfBRRCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 12:02:10 -0500
Received: from mail-it1-f177.google.com ([209.85.166.177]:40158 "EHLO
        mail-it1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387648AbfBRRCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 12:02:09 -0500
Received: by mail-it1-f177.google.com with SMTP id i2so42589717ite.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 09:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=8giBFLa/6EJULGKbVseEpa5JgyJ5hnHBS5FmwtBLcvo=;
        b=nH2FfnmEMYbVA5JGK+Ii5TNJNGtPIeft3XTi60B2+FhIjVBDXzL9C9LWIfZg+Zb57R
         m5b6F1+lh8HI0QxXWjWyCwm2UKjAUKJHzEcOcPfH7inLBhOZdnZ7jC+j3RGW0umjuG5L
         MC6VXZp2SefY6cd54cF4RGOsHJK/Yk84nf3/uKZpafBkBE5h1UYu4zWBM/sKsO2PkX1g
         wCvISVOHpbs50hyJboeAf1PjocFgCwrtyTFi9Xb6gy4RLV77zGvSY4LcwTa3tcyed2Pi
         Lgz1KPSNS4RBOuLiUghZWMaCEkx7ubI0CpgKPyQ3XOvhSq15lKoS26b9uKrnp04taeHh
         JXFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=8giBFLa/6EJULGKbVseEpa5JgyJ5hnHBS5FmwtBLcvo=;
        b=sKQC9QFvKgJ8OqOYSbZdg25/6aRXwQg8Ko5w+G1+AW+Vv2zl2kB/mcwWYqw01mPqcu
         HKgs1oZH3Duj96xV4rFhiWTVffpeSWKzvqV9c7McvEVJy4s78tGXTuceX0CtvNhmUODp
         rrs5W0H2qlOWGPrlkCNZpMXZUrRHFDIVgz850u2SglHmBbi0duUz6O/y6dgmQF4GINJU
         dT30wSeNZqeLH0pHiT39o1Vdmw2APdYUYKWGECRiBbNLKGQdA0KGAMAtW7ss6vV/ppBW
         oiHiRnZlTcqKu74Dm5ekEsTtBZszPXqkW5oKEiJwulKR/PaJZpNMO/ZzOW/cPPTTKCP9
         BTHg==
X-Gm-Message-State: AHQUAuYPDyocqMDGQKHkhmQf8pT9IHbwujfJG9XLmHbj45NlRE6A3Ben
        aHaLljIeFSijBqEVtiudD+h2FsKg6LcvWKPrsSuuf74U
X-Google-Smtp-Source: AHgI3IYSMpmkE/KaLQCY1dJwB5T55Q4SPc++viyH62BASZZ//WnbYPiPAdNtkQo6EOuP8/Chvnq1pBJFVy958rgl1gI=
X-Received: by 2002:a24:5608:: with SMTP id o8mr11834924itb.35.1550509328514;
 Mon, 18 Feb 2019 09:02:08 -0800 (PST)
MIME-Version: 1.0
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Mon, 18 Feb 2019 11:01:57 -0600
Message-ID: <CABb+yY2SrgwFNgKa4+ossU3i3U76m2sa63r1=QsRg=PGGWAPxw@mail.gmail.com>
Subject: [GIT PULL] Mailbox fixes for v5.0
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit a3b22b9f11d9fbc48b0291ea92259a5a810e9438:

  Linux 5.0-rc7 (2019-02-17 18:46:40 -0800)

are available in the Git repository at:

  git://git.linaro.org/landing-teams/working/fujitsu/integration.git
tags/mailbox-fixes-v5.0-rc7

for you to fetch changes up to d7bf31a0f85faaf63c63c39d55154825a1eaaea9:

  mailbox: bcm-flexrm-mailbox: Fix FlexRM ring flush timeout issue
(2019-02-18 10:40:58 -0600)

----------------------------------------------------------------
- API: Fix build breakge by exporting the function mbox_flush
- BRCM: Fix FlexRM ring flush timeout issue

----------------------------------------------------------------
Rayagonda Kokatanur (1):
      mailbox: bcm-flexrm-mailbox: Fix FlexRM ring flush timeout issue

Thierry Reding (1):
      mailbox: Export mbox_flush()

 drivers/mailbox/bcm-flexrm-mailbox.c | 4 ++--
 drivers/mailbox/mailbox.c            | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)
