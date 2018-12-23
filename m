Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1A5C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 03:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60C1121920
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 03:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXfN9+01"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393081AbeLWDAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 22:00:45 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38757 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387701AbeLWDAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 22:00:44 -0500
Received: by mail-pl1-f194.google.com with SMTP id e5so4253745plb.5;
        Sat, 22 Dec 2018 19:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vYa18Rz8NMTPK9foY4G30QJN+CBPDZCSj4oOmObdA88=;
        b=AXfN9+01KI1Fa7BWVwLQrcsp/yIST70GEslQYBYrTwa3cxEPoCbuJfxhO5O3cFUmVR
         Z3UJ5jrZrQ6UFBppdzHq+Pbml/UB08Fk+s5LPpk8LR9pc5KMXgIUfgB35mkxf0XEQHgW
         mIDnnkcHSk4Qb21q9/1zvibcMSjVxKxg3cHyftMCLZwIBAI+SHRSrg2XbeU+WyQxyVVZ
         1BXH5U37YetDhMJLmVRLjUsY7M8q6/pIoGP31bknhC7RojxdXjZbkNd1xeEltv9o2RCl
         LV8hxzNeKo86Tzv8HJ6zfKbndOqyLdAR2OUJck6ImVylb8qInt5rQJljVb7pMWEbUDXN
         2F9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vYa18Rz8NMTPK9foY4G30QJN+CBPDZCSj4oOmObdA88=;
        b=YDnKS+/iv5iANDb5qIHf2qdN67zNwBrQYBtv+Qwcm+AzRrTTyEy1xfZ+IAQAwsxh9+
         YSkOH5JWj+ZPGwVRiZxQ+x45d/siDG6Iuxzfo1m8QqyHo27lzOM6+KnJAJ4vTP6d4L+4
         DPTo7V7jq+4kKK4UOEDHrEhjdN1tCe1oi8o3MyPTCnQbQmv3iqOiNmbi4kCFbKjQVoAH
         QDHX831U7SpF+odt6dggJULgMRxLJTDx+5s5BOfW9W3FC/yjYK/637HXm4PaI1kf7Yzr
         x5ZQ1sYTcD2pJ1ijLi72G40k7xeVnL8t0oPIwt+iLviGLZDzgG1qOJMiugyyOgLGy2Qr
         O2aw==
X-Gm-Message-State: AJcUukdoBYPOsVLcQJdbXGhOLutwuOh65HMgyiFf6hhRkINBsxAPKR0Z
        Gx92QR4MNSA1pQW1wmCL12Y=
X-Google-Smtp-Source: ALg8bN6AC2EOkWSXKnpdfM7mhS5CMoc7rEnh0E9Hw6bE9QMgbFpLhU2oBDCdWk51hK1rxDeBpkYeYQ==
X-Received: by 2002:a17:902:bf44:: with SMTP id u4mr8464740pls.5.1545534043415;
        Sat, 22 Dec 2018 19:00:43 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::1:76e6])
        by smtp.gmail.com with ESMTPSA id g136sm40091600pfb.154.2018.12.22.19.00.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Dec 2018 19:00:42 -0800 (PST)
Date:   Sat, 22 Dec 2018 19:00:40 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     David Miller <davem@davemloft.net>, ast@kernel.org,
        daniel@iogearbox.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: core: Fix Spectre v1 vulnerability
Message-ID: <20181223030039.wrpytx7pwfcljdjm@ast-mbp.dhcp.thefacebook.com>
References: <20181221204901.GA30045@embeddedor>
 <20181222.150722.1493687829239836271.davem@davemloft.net>
 <20181222235952.keue7a336sg7jfim@ast-mbp.dhcp.thefacebook.com>
 <20181222.184051.718127928973898182.davem@davemloft.net>
 <e1c8e69b-3417-6176-6b49-1b7a23febb21@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1c8e69b-3417-6176-6b49-1b7a23febb21@embeddedor.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 22, 2018 at 08:53:40PM -0600, Gustavo A. R. Silva wrote:
> Hi,
> 
> On 12/22/18 8:40 PM, David Miller wrote:
> > From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> > Date: Sat, 22 Dec 2018 15:59:54 -0800
> > 
> > > On Sat, Dec 22, 2018 at 03:07:22PM -0800, David Miller wrote:
> > > > From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
> > > > Date: Fri, 21 Dec 2018 14:49:01 -0600
> > > > 
> > > > > flen is indirectly controlled by user-space, hence leading to
> > > > > a potential exploitation of the Spectre variant 1 vulnerability.
> > > > > 
> > > > > This issue was detected with the help of Smatch:
> > > > > 
> > > > > net/core/filter.c:1101 bpf_check_classic() warn: potential spectre issue 'filter' [w]
> > > > > 
> > > > > Fix this by sanitizing flen before using it to index filter at line 1101:
> > > > > 
> > > > > 	switch (filter[flen - 1].code) {
> > > > > 
> > > > > and through pc at line 1040:
> > > > > 	
> > > > > 	const struct sock_filter *ftest = &filter[pc];
> > > > > 
> > > > > Notice that given that speculation windows are large, the policy is
> > > > > to kill the speculation on the first load and not worry if it can be
> > > > > completed with a dependent load/store [1].
> > > > > 
> > > > > [1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2
> > > > > 
> > > > > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> > > > 
> > > > BPF folks, I'll take this directly.
> > > > 
> > > > Applied and queued up for -stable, thanks.
> > > 
> > > hmm. what was the rush?
> > > I think it is unnecessary change.
> > > Though fp is passed initially from user space
> > > it's copied into kernel struct first.
> > > There is no way user space can force kernel to mispredict
> > > branch in for (pc = 0; pc < flen; pc++) loop.
> The following piece of code is the one that can be mispredicted, not the for
> loop:
> 
> 1013         if (flen == 0 || flen > BPF_MAXINSNS)
> 1014                 return false;
> 
> Instead of calling array_index_nospec() inside bpf_check_basics_ok(), I
> decided to place the call close to the code that could be compromised. This
> is when accessing filter[].

Why do you think it can be mispredicted?

I've looked at your other patch for nfc_sock_create() where you're adding:
+ proto = array_index_nospec(proto, NFC_SOCKPROTO_MAX);

'proto' is the value passed in _register_ into system call.
There is no need to wrap it with array_index_nospec().
It's not a load from memory and user space cannot make it slow.
Slow load is a necessary attribute to trigger speculative execution
into mispredicted branch.

What tool did you use to analyze this?
Did you analyze all warnings case by case or just trusted the tool
and generated these patches?

