Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD41AC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69ED520851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ogek93o4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69ED520851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbeLLUxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 15:53:20 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:36807 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728442AbeLLUxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 15:53:15 -0500
Received: by mail-it1-f195.google.com with SMTP id c9so459406itj.1;
        Wed, 12 Dec 2018 12:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tfFxHHTCkRVCftKlTYJFAzH4cbVpcVCWxb8aY4mGzaM=;
        b=Ogek93o44Rp4EeCXt9PwFOZ1kWLFvfAMS8uXHMShNzvTf+k1UMsWNQRt2Le2RPlfnn
         F0q1K5uhVAMI+1CZaGjA7tl6o7fM093e8ClFG02HtYrLBC9XmciZ2bgVibzxndiMd1ox
         YTKy86qwy+BroTRyUYyijJtOcvC4S7hGMtI8Nn24WfW+jmNnrQoAyN3SKVC5aKwf8fwZ
         WYILCaw6B99OKlxJf9BELrY7ZHDqHAB9MthWGDrXCR5ZFMPFA5rV0Zz3JR9A73dUTxhH
         C+xwrmfvIFZ6yB7tF5/ftAgjc22X6h/meNg2LZoZMN+noIQo8V8byovcOERxJKB+unfh
         yHQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tfFxHHTCkRVCftKlTYJFAzH4cbVpcVCWxb8aY4mGzaM=;
        b=FKfPaofKdPeRKGyUjiYdOFBRhSFdCUw57qb0dv6aU3M2DMLkKGcirAwKIfha2iqNBq
         Iabo4TalhyWObZjmbv15rpoRGKucjs65iQpcVStQ+lIWti6PmO6cpb/J7m6LcXGLejyP
         jvpuqgYJ0viclxL7STZhC9FCoMPWb7d9JWpC+o6EgCUAP3Lm+UXfGs9oD8MkTipfUp44
         YckOh6PPLF3BjIWITjGrHXRGU5xBTK4Oe+JhYB+diubyCErOwYtkUXSQBMlCKxxboo7J
         Y0rnd1YPglwvuvBLf+EBwQgdoE+ekeCXwpVVN+HhyVC+1ujekmYNkz6AnbxoXakB2bI4
         9J7w==
X-Gm-Message-State: AA+aEWZz45ddVo+NGqlkQ7WikCuMPoD1Y6sLotv9x0bOCL/oemLF+dRx
        7dVXtsCI6wMpLGa83TG3nelxyKqg
X-Google-Smtp-Source: AFSGD/WQeWeTM52zZcFwa+8lvd31UKoZv8aEiqPB27Sjt/z2QmbYtVl/DJEh/p/wAPSQiY/0cVHmMQ==
X-Received: by 2002:a02:516:: with SMTP id e22mr20062412jad.82.1544647994501;
        Wed, 12 Dec 2018 12:53:14 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::1:2c20])
        by smtp.gmail.com with ESMTPSA id b192sm109879itb.12.2018.12.12.12.53.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 12:53:13 -0800 (PST)
Date:   Wed, 12 Dec 2018 12:53:11 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commits in the bpf-next
 tree
Message-ID: <20181212205253.d3reuxcyjhnwh3ul@ast-mbp.dhcp.thefacebook.com>
References: <20181213073245.5b2d2536@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213073245.5b2d2536@canb.auug.org.au>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 07:32:45AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Commits
> 
>   3bdc28aa2340 ("selftests/bpf: add btf annotations for cgroup_local_storage maps")
>   1dfd1959fed4 ("bpf: add bpffs pretty print for cgroup local storage maps")
>   3adc62d9a5be ("bpf: pass struct btf pointer to the map_check_btf() callback")
>   9cf3a785dc4c ("selftests/bpf: use __bpf_constant_htons in test_prog.c")
> 
> are missing a Signed-off-by from their committers.

the must be a script mistake?

I clearly see SOBs for all of them.

