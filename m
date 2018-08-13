Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E119AC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 19:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B4402175C
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 19:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqfVxsbd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B4402175C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730767AbeHMWVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 18:21:21 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38852 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730016AbeHMWVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 18:21:20 -0400
Received: by mail-pg1-f194.google.com with SMTP id k3-v6so7986358pgq.5;
        Mon, 13 Aug 2018 12:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oKz8/gmPrXrpmm/bWENiCqQQdiRVmhnGcR/mYjc8to8=;
        b=jqfVxsbdlFg6JzQqiUPRvjxiW5fu3AOdSs44ravFNweP8lI6T2FzZ6jm1c8uQMK6UF
         BFKHDydiN91Y4g2R+cjyLmZDjK+rEoXRpvnGm3LMIJlFjQs6tE9WAQxtGInm0eJ0txVW
         MB9dBv2T2L4yUerEEnH8wP/wE7ZTXbjm/BneYsC1ngCiWD5duByvYpYgM1EorU8ZPX0A
         TgnOiDzDawV3AgsEC77Pc7vYNrBYLDajq4GBBHzj8kdMzvU625uCKtiDSwjVzd1+csOT
         YXSI+f9CzpPMgbB4nTO/jYsKlKJvIXuhR28xmjX94q0K3GvP1qQ7IkUBNql1B6YNEr2f
         cAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oKz8/gmPrXrpmm/bWENiCqQQdiRVmhnGcR/mYjc8to8=;
        b=bzOmlkkfpLx97lg7EhWZFp+8sl29eQrfctPAb3L093djmXGf3GlfgMgPNLiLmXO8mn
         QgZ5g8djvjhBYRdDayBqfie+D0QUK0jET2M/yQZQN4tWI1GeRcMIyp/OYgtUo0NrLmux
         xwrAWj71xBHBRYg8FLWYUGkruEBraSaJ6ol5Eu1H4bwhvefiZXLkmck6z+4F+dDi2awj
         qQ7tjW0wKYfXD73+rD7ITOX55q4bsdmqjM8UaQ/tstgBub3y8QTWEygMSucvDtdj8HWU
         RwnlAA96vWHu/2ZF0Y00AlgXX85yOhowvTVr7ul1jeeUe4uk1uh91CzD+tK5EY027DyE
         3wPw==
X-Gm-Message-State: AOUpUlE7vI4udK6iIRyIH7fJq7Nkg+dCpyWEYlf5IW0voFsjLG7eBrPq
        kfwFLZqIpY6P4j+ST/IjZZo=
X-Google-Smtp-Source: AA+uWPzNm44bdeBBtPTJj//KwWVIEMK+Z5RQFnRaZvK9vQUX0iNuj8etxMamAt/KJuHWfmV5vIqxiQ==
X-Received: by 2002:a62:1756:: with SMTP id 83-v6mr20492348pfx.217.1534189062787;
        Mon, 13 Aug 2018 12:37:42 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:200::7:6f2])
        by smtp.gmail.com with ESMTPSA id s14-v6sm49123529pfj.105.2018.08.13.12.37.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 12:37:41 -0700 (PDT)
Date:   Mon, 13 Aug 2018 12:37:40 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     "Tobin C. Harding" <me@tobin.cc>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-doc@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 0/4] Convert filter.txt to RST
Message-ID: <20180813193738.od5k2wwc7dtrxyqp@ast-mbp>
References: <20180809052328.27942-1-me@tobin.cc>
 <20180809060734.rtqqu4sexbwzuqmm@ast-mbp>
 <20180809072753.GF32374@eros>
 <80bdc251-9f57-602f-6536-b34651684bb7@iogearbox.net>
 <20180810014636.GJ32374@eros>
 <20180810065752.2ab5473d@lwn.net>
 <CAADnVQL-ekJXQoP+Peuh1uBJ1RGxMJ0G0DVp-UoGcWOY9BATeQ@mail.gmail.com>
 <20180811115058.GN32374@eros>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180811115058.GN32374@eros>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 11, 2018 at 09:50:58PM +1000, Tobin C. Harding wrote:
> On Fri, Aug 10, 2018 at 10:51:28AM -0700, Alexei Starovoitov wrote:
> > On Fri, Aug 10, 2018 at 5:57 AM Jonathan Corbet <corbet@lwn.net> wrote:
> > >
> > > The objective actually is to have SPDX tags in all files in the kernel.
> > > That includes documentation, even though people, as always, care less
> > > about the docs than they do the code.
> > 
> > right, but let's do that as a separate patch set.
> > In the current set I'd focus on reviewing the actual doc changes.
> > In particular completely removing
> > Documentation/networking/filter.txt
> > feels wrong, since lots of websites point directly there.
> > Can we have at least few words there pointing to new location?
> 
> Something like ...
> 
> 
> ------------ filter.txt
> 
> BPF documentation can now be found in the following places:
> 
> - Introduction to BPF (Linux Socket Filter) - Documentation/userspace-api/socket-filter.rst
> - Classic BPF (cBPF) - Documentation/userspace-api/cBPF.rst
> - Internal BPF (eBPF) - Documentation/userspace-api/eBPF.rst

Internal ?
that was the name we used for may be a month many years ago.
Please use 'extended BPF' in new filter.txt and all other places.

since merge window is open the patches would need to wait until
bpf-next opens up in few weeks.

Thanks

