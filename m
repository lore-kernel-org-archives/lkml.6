Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76111C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 16:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 167C2215E6
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 16:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYot/A2W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 167C2215E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933487AbeFUQdj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 12:33:39 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33648 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933297AbeFUQdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 12:33:37 -0400
Received: by mail-wr0-f193.google.com with SMTP id k16-v6so3882793wro.0;
        Thu, 21 Jun 2018 09:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3jX2mDRawyUiAYh606d92THsF6t4qiOtqzQy3Fu0Q5c=;
        b=mYot/A2W6oJY+UwoT0QFSaRJx6gYbjCQJaXs+ZKhcEL1/95+DPxM1N65iJvZIYjpT9
         oMZ0yH/ZvsOu8XJBgfKq8GrJHqftL7vR09ajEnPdPKo5968kBchbgHkRCQ9aWJae0zqH
         yOpinUJv/ohuqM6e+Kl7eMfVSQLPT1gYrQpqB7uzShWGmQjDxUR/0mByEufWu/1aVHHv
         ekdp4wf1Dx0M4yM71Hs38FRG3eP+A7vlEqLOk5bWnCrZLmWzJx3pR3lQb1a26Eh+V4FA
         DcubCrcO5mcvbFJWlNam1C3ISY40711mDywc5iorPf+We8RzKjXXC6edY5jUVEOoLuP0
         YEMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=3jX2mDRawyUiAYh606d92THsF6t4qiOtqzQy3Fu0Q5c=;
        b=nsJiBN4wsHixtySj0kLs3KVpNoMBSsmmq9FcMqsmsOOOU+RWKSx3ixGZxpRzGZJWXd
         lp8OeAxvaJrh1g8Vg04B7PN5SyPC2Kg6B5XVOvrxZA1tmAyzUS43aXao7ARxOgsC7tcn
         TIH3+nIyxsgdXkrkURhDhfSOf5v1T8NqJl2IUiAuXw2mTz2AYNLARodti/znd/swiISB
         ypy5DGVGJC9vieI9dwirHwBKa4ShdVDwmeUTvI/2fJwgauii66auu3hvtR1v/xFgGSq4
         j2EqXNbH1yr5bUTafZVeSo2mVowmoVdE6RI36wFdqN/UEptRp6Kc2MV5vatMS9dKh/KV
         dh6A==
X-Gm-Message-State: APt69E3DO2PFkYw6yrZX4+LJ9o6JlS60I+Mvc3TgR2oA2LsqJlazkLaZ
        aHS1p1IfQfy1aPDEbEfbILU=
X-Google-Smtp-Source: ADUXVKJKgSXB942vdkycHnq0LGZ4BOgfg7zLkpovXkeHjhDlxJlUCHfqvwByrTzB25XH9difE+j2HA==
X-Received: by 2002:adf:8f23:: with SMTP id p32-v6mr21862384wrb.193.1529598816378;
        Thu, 21 Jun 2018 09:33:36 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id n7-v6sm6837070wrr.39.2018.06.21.09.33.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 09:33:35 -0700 (PDT)
Date:   Thu, 21 Jun 2018 18:33:33 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Matteo Croce <mcroce@redhat.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        alexei.starovoitov@gmail.com, sfr@canb.auug.org.au,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Subject: Re: [GIT] Networking
Message-ID: <20180621163333.GC14171@gmail.com>
References: <20180620.213540.214945910722071226.davem@davemloft.net>
 <20180621084510.GA22870@gmail.com>
 <CAGnkfhxGAYZNhJp7eyg+_j3LY31w7muFqerhQp7jGqQ02iFxkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGnkfhxGAYZNhJp7eyg+_j3LY31w7muFqerhQp7jGqQ02iFxkg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Matteo Croce <mcroce@redhat.com> wrote:

> Hi Ingo,
> 
> are you compiling a 32 bit kernel on an x86_64 host?

Yes.

> then I tried to compile an i386 kernel on an x86_64 host and I get the
> same error:
> 
> $ make -j8 ARCH=i386
> ...
>   LD      vmlinux.o
> ld: i386:x86-64 architecture of input file
> `net/bpfilter/bpfilter_umh.o' is incompatible with i386 output

Correct.

> Any idea how to fix it without building it twice, for host and target?

No idea, sorry ...

Thanks,

	Ingo
