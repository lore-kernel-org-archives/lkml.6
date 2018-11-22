Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00A6C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79EF720831
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClCNWAJ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79EF720831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392795AbeKVShi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 13:37:38 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:38913 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbeKVShi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 13:37:38 -0500
Received: by mail-wm1-f50.google.com with SMTP id u13-v6so8114358wmc.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 23:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oj4zkF+hWIB7AEGVJqUV5Rmp/k0rmykxqnfJzic6ZGU=;
        b=ClCNWAJ9VbrO4265yvDBXi+Tj/xuGckBsHWVrfU3cdcGN0T0UFv+jZtLybvIyFJzyy
         BSE76xmzaMBsF+UlrmjaYWwH0L0JiMAkG3L7U5Yj/ps51LdekRrs9SlvodonMln+bB8n
         XzaRtgsQZOUDVyZqrY219aMdfVcizXRnb0I0+ic+Qnix4beEtAQqx1SYKqLBmqDJql/3
         0VpzJmwPlxqpP10N2xdoHG83P6zr6aHrwquYc1Zi/kpKxANUVFXv35NjBG9W3NgM/y0L
         j4Cpn5iHahSjhh/a+py+okhfHgY5TVhQkZYMqHIf9EaWXUbwCE73x8FkhSQPZ4Mc84pj
         9VUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=oj4zkF+hWIB7AEGVJqUV5Rmp/k0rmykxqnfJzic6ZGU=;
        b=pZ4mzkPSR9CJ6nl/EQNJf0+64Z7KA3fx8XpXOZGnGQ2BHPfr1j3vPd9TRM31WqXWxq
         mMNbqMSArnj1qrBs8adzehylL28Sdfw9GUVQgWpRR7YUR98ZsBDiQifblG4P0zj3pGKC
         NhJfspGYUeiDGZEK3p38EOTCPy5YthWh9r5ZxnoHk4LtpKGDaqoQllv5TCcVtMjkQ+Xe
         MlEpOTm0e9Fkf1SOGzKLT3af9k4DVnawS95ks/qn8d5OVcQJRtEzsRLQbdyKVpr0aJXc
         zgUE6JDC0MglGOuN5nPzuaY9AsVDJ7zk2/AjcK095E8nzxGHhyCIiuFIO4khc5bH6QdG
         sQ5g==
X-Gm-Message-State: AGRZ1gImN/xzedvzLIdFuS/u0zphEuN43PoGdbB8iLmpJRYXY1SiVXxy
        wXSC+cAbS4sc8VD05E3Iod0=
X-Google-Smtp-Source: AJdET5cyQhfE1Vqmv4R3ZeEqlx7VT+Btrz0lRQBbuv24dxAwiPFrfJVBEWCUKrEVSJmVIJFx98B5Ag==
X-Received: by 2002:a1c:85c5:: with SMTP id h188-v6mr8395156wmd.59.1542873559726;
        Wed, 21 Nov 2018 23:59:19 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id r76-v6sm3769649wmb.21.2018.11.21.23.59.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 23:59:19 -0800 (PST)
Date:   Thu, 22 Nov 2018 08:59:16 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Stewart <david.c.stewart@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [patch 14/24] x86/speculation: Unify conditional spectre v2
 print functions
Message-ID: <20181122075916.GI41788@gmail.com>
References: <20181121201430.559770965@linutronix.de>
 <20181121201723.673022436@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121201723.673022436@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> There is no point in having two functions and a conditional at the call
> site.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

patches 1-14:

  Reviewed-by: Ingo Molnar <mingo@kernel.org>

15-24 look good to me too, modulo the (mostly trivial) feedback I gave.

Thanks,

	Ingo
