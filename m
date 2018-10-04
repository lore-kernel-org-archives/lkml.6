Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7FEC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 818DD206B2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="muOAV5B5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 818DD206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbeJDXo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 19:44:59 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44488 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbeJDXo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 19:44:59 -0400
Received: by mail-pf1-f194.google.com with SMTP id r9-v6so3513603pff.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 09:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=NuSFvU6mksMMmx+Ai23GH9YjuyxFzvL4ep+n0IFWo00=;
        b=muOAV5B5ZFAC5LvGAs638C00/kcvJtKdhTb5H3LmQcjunnMEY/ZDHQZ+PqeQwPb39u
         xvjOww9e7hZO4Z073cvvPJ5811Qk0OFcotQTSm/tqYJ6A2/C/sNN6VV+so35c9F0w8Fe
         noKMgrnHFUq69YURKeGC1zUtoJfOpgc0HcDPRuXA/6VdmKLiAvlYWr8hHA7P8Nvxo9yq
         NySpSIY4sGHOO6ttR4NXVkHDDUu266UQQtE7GAH+26o6SIcshY1kr3rhKd7JhHcmp0gJ
         pT6O1zJCt6NX3TUVLb1tc8InfxAiZ3Kr0RfPCjYKmwmWLCU3WEwlZrfNeh0s+fB7i3Fx
         7Glw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=NuSFvU6mksMMmx+Ai23GH9YjuyxFzvL4ep+n0IFWo00=;
        b=dTHbsgzyxKjV28ywg46uwUsF87s0a5NSdnikyTRpmeXP09cD5gvJka2hxDRdUQYndS
         rf+KC9GWYDISiJ3UO0MjatzY0Wbcs7HAuCYayZgXVk/AllI25jLXWQbhW/D4faaPAZT+
         Hj4eiHYwA4OZutnX+fLatCiHrdZdBv+RWiyZmIiKwt2So+52UNH1j1zwzpAuxD6MtpUx
         QUUAW91gsLrIemPLlda1mJpAAKqDDswEhxM+7yCjlZAT9GbU6feG8AZvnvihbkthrwbK
         mjh3TXRCheChflEvBlw4JlBBFATXLftagECDfwsKk84TdycofkG72+cQ8Zl8hxtncT4v
         8Z3w==
X-Gm-Message-State: ABuFfohB++ndBEw606BHMqZQv2mipddBQU3h7C8v2/7LS6nVUOn4sG8D
        LuWig7tZ/2iFT9PvV0ZN24kkPw==
X-Google-Smtp-Source: ACcGV61RxyMgutle2UE4PyYZx2VXMcFZCIzSPfePSGHT5VBYPRlgOJDqFitnoUIxgpaYHnwSj7UCag==
X-Received: by 2002:a63:525c:: with SMTP id s28-v6mr6418696pgl.78.1538671853024;
        Thu, 04 Oct 2018 09:50:53 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:8123:d110:9b20:937c? ([2601:646:c200:7429:8123:d110:9b20:937c])
        by smtp.gmail.com with ESMTPSA id h5-v6sm7507146pfo.135.2018.10.04.09.50.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 09:50:51 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 00/11 v3] x86: load FPU registers on return to userland
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A366)
In-Reply-To: <8ea44ae2bb4844df812ea4c6cb0c00ef12708c51.camel@surriel.com>
Date:   Thu, 4 Oct 2018 09:50:51 -0700
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?utf-8?Q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Transfer-Encoding: 7bit
Message-Id: <1DDD1BB3-A306-4366-A941-4F7321672C6B@amacapital.net>
References: <20181004140547.13014-1-bigeasy@linutronix.de> <8ea44ae2bb4844df812ea4c6cb0c00ef12708c51.camel@surriel.com>
To:     Rik van Riel <riel@surriel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 4, 2018, at 9:45 AM, Rik van Riel <riel@surriel.com> wrote:
> 
> On Thu, 2018-10-04 at 16:05 +0200, Sebastian Andrzej Siewior wrote:
> 
> 
>> In v3 I dropped that decouple idea. I also learned that the wrpkru
>> instruction is not privileged and so caching it in kernel does not
>> work.
> 
> Wait, so any thread can bypass its memory protection
> keys, even if there is a seccomp filter preventing
> it from calling the PKRU syscalls?
> 
> Is that intended?
> 
> Is that simply a hardware limitation, or something
> where we can set a flag somewhere to force tasks to
> go through the kernel?
> 
> 

Hardware limitation.
