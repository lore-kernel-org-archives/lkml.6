Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59EC6C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 10:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 014C1261B3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 10:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tyesKPB8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 014C1261B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753637AbeF0KhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 06:37:00 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40715 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753337AbeF0Kg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 06:36:58 -0400
Received: by mail-lj1-f195.google.com with SMTP id a6-v6so1219653ljj.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 03:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=q3r807uefo6LqCgvqjsizQqGnIS0cNltwm1C9DuyTLM=;
        b=tyesKPB8RmbWBls1MyY/QPd2VvvCxu4UVqZ/FUbnQrzUbN9ZrZGU1nRsHawjeVjDDc
         NvrNB3UK6hNnNBkV9aRilGzNB7SECZnavkEwwfFtYBjXCsC9upwo7ZlZIKKg30KxuKDv
         Ya92O143JuvvaVwLNsrDAO3NdG/9lteKiTGPsSKT3fPi8c7KcC1pm3o5zPcJAcALeujA
         SlUaeNjiAxUSQ+Lfrx/B8bB1f7N4qV5zgPf485nhUjlkgzn0qH/BRxxMZUg5LC4ohmyj
         icThabYAgJUZZqz4zZ7fpyK4nDXSfqwBA2IDTjw+oTfjsOb8fnawY9stvmZkn0fVrFog
         Otdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=q3r807uefo6LqCgvqjsizQqGnIS0cNltwm1C9DuyTLM=;
        b=nRAR//bcxDQR/QZ1ML3pM+cM6OVB7Nag1US2TLJQd8masQuT5ytxujG0SP2JOPFZwG
         bFCdFBY9biPMG/jEGEoCfW09DIzVytqDmOd+lUtHEgZMS3NqNxBgAQRYZFqudTxVO2zG
         Y5seHzPHOMiCif2HZeCieG82JOhD4YprGOTL6n2MUIWShEneTUaRYCo/pX8MiVug5Ajd
         ZjXUcufRTalAQN2Xw51N1yhXkx35XldS/kxL9e/sFScwQtPEuUWG3psoCOQw0OwrB4o7
         tq+yua9T4/qzLIH7+AU1us86m46W5GE/SW0GemFBOGHLrf3+Cr7lRfJPyVD9u8qogHkN
         9SFA==
X-Gm-Message-State: APt69E3FNLyNptZZgQI6PfRfy+ri4Xa7sOW+dl1vqLx1NRsW6X96czF3
        a/ctR33tcpg5YhvwxP4LHvanXQfVZ2SaNcnWmdMfGg==
X-Google-Smtp-Source: AAOMgpf8vMdXg0CWODbtsVMOMgw+aPeXrnFBCNzLmLYWdaXTBnul15IN6t+/kv9y4iNV4OBcFaGogFaPxGpRsDqKcXM=
X-Received: by 2002:a2e:8051:: with SMTP id p17-v6mr3712729ljg.22.1530095817428;
 Wed, 27 Jun 2018 03:36:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41cf:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 03:36:56
 -0700 (PDT)
In-Reply-To: <87y3f06e9a.fsf@concordia.ellerman.id.au>
References: <20180619140229.3615110-1-arnd@arndb.de> <87y3f06e9a.fsf@concordia.ellerman.id.au>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 27 Jun 2018 12:36:56 +0200
X-Google-Sender-Auth: KyE1IRdD8G7TPik1PowWBRMIwpA
Message-ID: <CAK8P3a2HwOe2D4LXgFsfhFXpeUBpHZiB5PCk0nkAwqX3NKCmFA@mail.gmail.com>
Subject: Re: [PATCH 1/3] [v2] powerpc: mac: fix rtc read/write functions
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Paul Mackerras <paulus@samba.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Joshua Thompson <funaho@jurai.org>,
        Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Meelis Roos <mroos@linux.ee>,
        Andreas Schwab <schwab@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 6:32 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> So I think I can take this patch in isolation via the powerpc tree as a
> fix for 4.18.
>
> I'll leave the other two alone.
>

Yes, that is what I had intended with this series but should have made
clearer. The two m68k patches are 4.19 material.

      Arnd
