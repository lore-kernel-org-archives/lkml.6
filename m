Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CAA8C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0CE92086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731132AbeLNVsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 16:48:04 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34499 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730734AbeLNVsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 16:48:03 -0500
Received: by mail-qt1-f195.google.com with SMTP id r14so7917371qtp.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 13:48:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=4StXW58yzpthNc1xin79Mx1mpOs8TeTw8hd0yZ43/TE=;
        b=lO2xgVAf5shDeb4B9FNF9Gtq9XWpc5fGxTJKsWi9VoEvT50IHJD7Hndl8TDOjYfk8h
         0rwGOT9NjdRUb1TKVKt1avjjTC6aXXzQLyWAv5KU3io5wT6sByFqyT1c0KeCbMQZaI0Q
         urvO0ei16QoYHHaO/pP/tbaVwqCItyc8b4r+fXfPDxCYMNUlmwH1RmUMbsQj8f8kvXFw
         MK034P9Cpdo3z0Wd2BvWn1Uvl0dA8G3sf2E1YmEz/jxwS7dznpWk3In+GJHDm4e/Fcpj
         SaIDUmRit770bxthztguJVxtq8TWQqefhCPJJwgUarW9F5NhLKaa8vjlvXEDx14lGyyF
         H1zA==
X-Gm-Message-State: AA+aEWZFrJOzXZywJ76+MVxh1q6dBfn7HAN+fXFm/HhkKs0TFEsZlZAH
        WusKNbSqB6mNgXdqmPnx+Lu6Rb3H97c=
X-Google-Smtp-Source: AFSGD/WLI+X7DPHXoRKsQ5AeCi0kCa+f77ztV1lWzOYd/gzxN2kCnt2DerMwX3sXhHxNWVHuHPdfIQ==
X-Received: by 2002:aed:25a6:: with SMTP id x35mr4634856qtc.228.1544824082975;
        Fri, 14 Dec 2018 13:48:02 -0800 (PST)
Received: from ?IPv6:2601:602:9802:a8dc::c5f1? ([2601:602:9802:a8dc::c5f1])
        by smtp.gmail.com with ESMTPSA id x49sm4606245qta.89.2018.12.14.13.48.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 13:48:02 -0800 (PST)
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alistair Strachan <astrachan@google.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, kernel-team@android.com,
        joel@joelfernandes.org, X86 ML <x86@kernel.org>,
        linux-kernel@vger.kernel.org, Florian Weimer <fweimer@redhat.com>,
        Carlos O'Donell <carlos@redhat.com>,
        "H. J. Lu" <hjl.tools@gmail.com>
From:   Laura Abbott <labbott@redhat.com>
Subject: Unwinding regression with 379d98ddf413 ("x86: vdso: Use $LD instead
 of $CC to link")
Message-ID: <9aa7b39c-707e-c87a-ad4c-f54ff08e3172@redhat.com>
Date:   Fri, 14 Dec 2018 13:48:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There are two reports of a regression with unwinding with
379d98ddf413 ("x86: vdso: Use $LD instead of $CC to link")

https://bugzilla.kernel.org/show_bug.cgi?id=201741
https://bugzilla.redhat.com/show_bug.cgi?id=1659295

It looks like the unwinding information has been
stripped out. Any ideas?

Thanks,
Laura
