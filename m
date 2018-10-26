Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF8BECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 00:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2CC02084A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 00:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7GLl2AL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2CC02084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbeJZIwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 04:52:03 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:36884 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbeJZIwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 04:52:02 -0400
Received: by mail-yb1-f196.google.com with SMTP id d18-v6so4471113yba.4;
        Thu, 25 Oct 2018 17:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z7Wvlm+UPuunyxf7xRLHkbAOSpFa6NUPWmoOQFvLsak=;
        b=E7GLl2ALsu8z4sBIzlm5YqkDAz7tvrafyI92q1olDcRFI9VHsCcEeSrSzYHnMfXEM9
         aQntRb6T7cEsQ40ZWnPZKKdxsTBO9Z4hnBYZmPxigkPetlxoCbArzbDtroIeGRCGnhiQ
         IUWvQSq7ItnzZMiGVAbtBq/eg/LuoS9HptJVwXmn5dukE57wd0lqppb07wbR6vqnlmdg
         YzFWXTWEoQwXFF34QeVk9/YGsRQ6XhHi3/z2lmg0u9aw2ndONq5c+qULloeEEyd9JIvU
         ch7pSq/IM+4ExNP8M8x/PpFS7yUVyrG8QsuISXS5kfMVL65YpoYPRyUinI3LUmoUlnkE
         Y8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z7Wvlm+UPuunyxf7xRLHkbAOSpFa6NUPWmoOQFvLsak=;
        b=PK6dv1BCSsj8U5FNrkhk25WraFNcQ2QuyBmHXmaBoasfS+k4D9J1syNfqsdoumbrB0
         BHwbv8sVA18cOE+dFxSmtMWEi+kAC5UcXm4JV82NHUL5aaPRUUb70j8u6RreJlUFxYLk
         hIFYevk7Rka3Rqx4l7nEk0LhTKroVjBpRgss/pZOI5PRk0tupdOxQqxwqlIAnC4ujYe4
         ypUp83jLSRaRXa9WOW5SL2wX3aWMaUvJn4oR96jXYZeujHQyQ16M679YtZq3ivvVxVV6
         J7y315prGDAqdbRJmChFB8hrW1Q7vswI6kFZhnkDJYgN6H+OEQWV5Fn/8O7dxmo/PRoR
         k1RQ==
X-Gm-Message-State: AGRZ1gLvCH0sATUMbUTJK0yRROeb/E/ExqSm8RmKHI+wWKG3fO4Ehobf
        YD4u7fsNC2t9jOHa6iYChZ4=
X-Google-Smtp-Source: AJdET5eF4W1O0J/qcTuDqISGpljm9wOunw0XNFh2FFokcIshK4KGHPYgnQ6bpTjKdxfKtvzfKxaxWQ==
X-Received: by 2002:a25:be85:: with SMTP id i5-v6mr1580081ybk.138.1540513036751;
        Thu, 25 Oct 2018 17:17:16 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c091:180::1:9409])
        by smtp.gmail.com with ESMTPSA id q6-v6sm2842056ywh.41.2018.10.25.17.17.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 17:17:15 -0700 (PDT)
Date:   Thu, 25 Oct 2018 17:17:13 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     ast@kernel.org, rick.p.edgecombe@intel.com, eric.dumazet@gmail.com,
        jannh@google.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf] bpf: add bpf_jit_limit knob to restrict unpriv
 allocations
Message-ID: <20181026001711.w55n5au2vx3sepmb@ast-mbp>
References: <20181022231104.3443-1-daniel@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181022231104.3443-1-daniel@iogearbox.net>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 01:11:04AM +0200, Daniel Borkmann wrote:
> Rick reported that the BPF JIT could potentially fill the entire module
> space with BPF programs from unprivileged users which would prevent later
> attempts to load normal kernel modules or privileged BPF programs, for
> example. If JIT was enabled but unsuccessful to generate the image, then
> before commit 290af86629b2 ("bpf: introduce BPF_JIT_ALWAYS_ON config")
> we would always fall back to the BPF interpreter. Nowadays in the case
> where the CONFIG_BPF_JIT_ALWAYS_ON could be set, then the load will abort
> with a failure since the BPF interpreter was compiled out.
> 
> Add a global limit and enforce it for unprivileged users such that in case
> of BPF interpreter compiled out we fail once the limit has been reached
> or we fall back to BPF interpreter earlier w/o using module mem if latter
> was compiled in. In a next step, fair share among unprivileged users can
> be resolved in particular for the case where we would fail hard once limit
> is reached.
> 
> Fixes: 290af86629b2 ("bpf: introduce BPF_JIT_ALWAYS_ON config")
> Fixes: 0a14842f5a3c ("net: filter: Just In Time compiler for x86-64")
> Co-Developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Acked-by: Alexei Starovoitov <ast@kernel.org>
> Cc: Eric Dumazet <eric.dumazet@gmail.com>
> Cc: Jann Horn <jannh@google.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: LKML <linux-kernel@vger.kernel.org>
> ---
>  Hi Rick, I've reworked the original patch into something much simpler
>  which is only focussing on the actual main issue we want to resolve right
>  now as a first step to make some forward progress, that is, limiting usage
>  on the JIT for unprivileged users. Tested the below on x86 and arm64.
>  (Trimmed down massive Cc list as well a bit and Cc'ed people related to
>  commits referenced and netdev where BPF patches are usually discussed.)
>  Thanks a lot!

Applied to bpf tree. Thanks Daniel.

