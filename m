Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0AAC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDBD52083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjfpcCQt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDBD52083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbeIGX0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 19:26:17 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40183 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbeIGX0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 19:26:16 -0400
Received: by mail-wr1-f66.google.com with SMTP id n2-v6so15906139wrw.7;
        Fri, 07 Sep 2018 11:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=XWq8NkvCfXgb0A2yW3w95vsSjh8wCd6g9bOryYAODXQ=;
        b=SjfpcCQtYruHVXDxA65wO8aMw98yg73v8vkj/7sWRuBIheTcg0fyCc8di8Eyz8bugo
         HosfPZoGqJZUf+J0PfoDnaC/tFacdeLFdz9XJbz69IDKqzi9ic9RC4ihP4gSbS7HSpCb
         lWc0i7MM6AVOuSPaJ1brGzKVkTenvwc0mod7CFEQgqdWpMu7kpIPD1bgttfb+r5OwsSc
         CvqkinbCiKtz0xaBogHNz87Ou8i2A5OfKJ8LyKmHzTYoLxz9uCiipwcRCIYccjOD+SkD
         NKwoYpJiF2QoBWWC8+Wgo+nEC13WIxYdZhwLVYZJyXoE4kOmmOmUvKT+tk8pLMlhHz5R
         OTYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=XWq8NkvCfXgb0A2yW3w95vsSjh8wCd6g9bOryYAODXQ=;
        b=U7YoSfbrwDa3xUhQiGDNiyyVDD8a2eo2tEgAp6y9/zQGepRXrgYB2uhM4hOaAiH3La
         MZh7pn25vzGN975yllHSg0/esTSFV5mrrkv6i+exLR3PicA13Jd+NhlLt66jiCwMR3qB
         74UIkT5O4TX5BKCuMTui5+6z40b4zYQEnYGEEQMVz2Ux4/kodF18tqPX3gGPJbfcFbDY
         VJTPU0KF4Q9w8DXs/yW6gvjYr8Ns/SToEFkOYBQZcT+iSt3Z5wwDMMlebarwUxDiGq6x
         bqJ3/YARnVPfk2EhJHtCRW9RxXAFcxgbeby0NiQMWzsrO3Gl5PC9+J1i5TWwLDw+9T1/
         tZ/A==
X-Gm-Message-State: APzg51C7UqXXeSLWLZ/tFV2NFwyfzdIstlb5Ukormwctzibm9W1+y52i
        PaP4hUQLCCL8IuFMWG9u4r+XViwC
X-Google-Smtp-Source: ANB0Vdbx9+mGHAHbCgl1YthCnWW0QLBRH4CW2w/Y22ZZyj+mupWO/stshe0icz9dNZ0RCHzoM9NkIQ==
X-Received: by 2002:adf:f28c:: with SMTP id k12-v6mr7450598wro.263.1536345842047;
        Fri, 07 Sep 2018 11:44:02 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:4006:df00:c856:97f7:a8a9:88f6])
        by smtp.gmail.com with ESMTPSA id h206-v6sm9914569wmf.25.2018.09.07.11.44.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 11:44:01 -0700 (PDT)
Date:   Fri, 7 Sep 2018 20:43:59 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Christophe LEROY <christophe.leroy@c-s.fr>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sparse@vger.kernel.org
Subject: Re: [PATCH] perf: enum overflow in uapi/linux/perf_event.h
Message-ID: <20180907184358.pg2ho4m4tc3dpwlw@ltop.local>
References: <a70172863fa7d3c138f788b18d36524bd45b0a73.1536326078.git.christophe.leroy@c-s.fr>
 <20180907134246.GC24106@hirez.programming.kicks-ass.net>
 <ae32181d-37b2-1a13-3c72-66775e05ff88@c-s.fr>
 <20180907135817.GF24106@hirez.programming.kicks-ass.net>
 <7a086a56-a896-9513-7315-9d0d21b61a44@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a086a56-a896-9513-7315-9d0d21b61a44@c-s.fr>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 04:15:33PM +0200, Christophe LEROY wrote:
> Le 07/09/2018 à 15:58, Peter Zijlstra a écrit :
> > On Fri, Sep 07, 2018 at 01:50:18PM +0000, Christophe Leroy wrote:
> > > 
> > > 
> > > On 09/07/2018 01:42 PM, Peter Zijlstra wrote:
> > > > On Fri, Sep 07, 2018 at 01:27:19PM +0000, Christophe Leroy wrote:
> > > > > On PPC32, enums are 32 bits, so __PERF_SAMPLE_CALLCHAIN_EARLY is
> > > > > out of scope. The following sparse warning is encountered:
> > > > > 
> > > > >     CHECK   arch/powerpc/kernel/process.c
> > > > > ./include/uapi/linux/perf_event.h:147:56: warning: cast truncates bits from constant value (8000000000000000 becomes 0)
> > > > 
> > > > Urgh... what compiler is that? I've not seen anything like that from the
> > > > build bots.
> > > > 
> > > 
> > > [root@pc16082vm linux-powerpc]# sparse --version
> > > 0.5.2
> > > 
> > > [root@pc16082vm linux-powerpc]# ppc-linux-gcc --version
> > > ppc-linux-gcc (GCC) 5.4.0
> > 
> > Ah, that's a sparse warning. But does your GCC agree? The thing is,
> > sparse uses the C enum spec, but I suspect GCC uses the C++ enum spec
> > and it all works fine.

Sparse is a bit weird about the exact underlying type used for enums.

> Ah yes, it seems that GCC is happy. So sparse should be fixed instead ?

I'll investigate (I suppose the same is given on x86-32).

-- Luc
