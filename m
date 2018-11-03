Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DCCC6786F
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 13:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBFF020833
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 13:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcXwgoCb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBFF020833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbeKCWVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 18:21:32 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36783 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbeKCWVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 18:21:32 -0400
Received: by mail-lf1-f67.google.com with SMTP id h192so3129905lfg.3
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 06:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KfYz/Gxq6msLjt5/tyimuL9FdpTXz/dCzIrraza+DvQ=;
        b=HcXwgoCbB6P5w6MlQZ8mK0jzeRN3QAIHfA8w6+eJK5YgA1kanQ1DSsR14O8pysQH8S
         /LPbFhaiOwDy7qsfJJoA2tupgVgOcdWc9UyqOYJKa1Ao/GDRPlV4qlMuvkleXDwoVGMs
         E0tKAdKYlPofZZjyjO3OrE0iiXvIoxC5IVGR6aSAWAI4xC5IsDCNeSIjyPHcx6qiXiyS
         izwYiECGNMlGAlfZ6c8eVEnd1XG2sC3uLw+AvaGxM1/w1ROe7Y71GsMlz985G8HzIHO1
         HYBcRW5GozNR8h13N104Yjokp7aFLL9cTbM4kH2o7ix2kCHxXOteL/KvEjFKv7A8VPiE
         DQNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KfYz/Gxq6msLjt5/tyimuL9FdpTXz/dCzIrraza+DvQ=;
        b=CCPsYi7I0Y0u5MDj50MsSIAHhlbnAw3w52bJ2KstMlVaMBVy3b7UWxB95S1AtZdn5A
         EOctXOfTXV1GOyNsitaHdj+/lWbaAFifpaG2xCEfdsneu6vih71eD1Ox3pMU0chFbJ3n
         evopi3JZPZi8k0JYuZdbehM5xqUjPVNhdDF5fDyMaoZDoSAO2QRUBPxtiOMiQWTBii3A
         +XSmXBQG61J5oZL9nfzH7aMvfLw3zIZpPVmoJIkPDdaXZP3lZ2DN7fQMWQDo0JvC2Gzs
         JQmxyyYVWlSbbdbA9wFwO3tvXLITmiUN0o8ZNR52+S3eSHdSAkTJIBd6VozyjW04o8Hh
         Dk/g==
X-Gm-Message-State: AGRZ1gK8cG4BdqjtEjA8Ahr4wz1M7rgclkSLP/xoZd4kqrk/i1bKqpEn
        6hbgPXj637u2njhp6mjuu4eMGEHBbS6TNj3Y5Ig=
X-Google-Smtp-Source: AJdET5dbJj7HX2sAdXS8WPbuThO0sS7yB2FfBL13Z4+wgnl+bglVfTcOVh7BqvwrYZg7bzcNyrfMFkXZNwKKSj6chs4=
X-Received: by 2002:a19:cfc6:: with SMTP id f189mr9562170lfg.102.1541250613015;
 Sat, 03 Nov 2018 06:10:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wj-17w3-m9EGVZGeWYpuYM8V=x8py2s5EcAHeinF24TQg@mail.gmail.com>
 <20181031193903.203914-1-ndesaulniers@google.com>
In-Reply-To: <20181031193903.203914-1-ndesaulniers@google.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 3 Nov 2018 14:10:01 +0100
Message-ID: <CANiq72=V7f8aEeUG5XYTMRvByboR0wbXREKYdDTb3HgDWQxoTw@mail.gmail.com>
Subject: Re: [PATCH v3] include/linux/compiler*.h: define asm_volatile_goto
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Paul Burton <paul.burton@mips.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 8:39 PM <ndesaulniers@google.com> wrote:
>
> asm_volatile_goto should also be defined for other compilers that support
> asm goto.

Picking this up into compiler-attributes.

Cheers,
Miguel
