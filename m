Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A01C6787C
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 02:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 558D920868
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 02:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZNWozwu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 558D920868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbeJMKHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 06:07:03 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38821 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbeJMKHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 06:07:03 -0400
Received: by mail-pl1-f194.google.com with SMTP id q19-v6so3644056pll.5;
        Fri, 12 Oct 2018 19:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZfrBtM5rZl984irl4Xcc+nCf/LTw6boDhHYObfCHvS4=;
        b=dZNWozwuTT0OzYcMzSHS67H27dkEPpkHeh2CVzkfy90W9QoHJrRE6dKFh2ToiFP5WZ
         i8BoJLH9kZ2gtBDOJEPEeRoIJsaUqli/3pM7lfhnPriVnNCNcXhedKAawYgkmKmKZ7Ba
         5qWLialTEmtwbBnOGVQeLtSURrwGTIm/LpuHmmxfpx598J0MfLNT64YDroPCanZ4UHfX
         50wDN9agG8+vi07Np7VR6BgnHE7Tp8e5cauGbt/kJIrJUBzlzLczHJt6qgKjqHoOgp7S
         HuUS7kaqTkxW6qnLuOBVfxUcEaX12Fn0QIYM6DpZJkIAnTjNTDeZybF/xp6V9Jn3nC4x
         pQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZfrBtM5rZl984irl4Xcc+nCf/LTw6boDhHYObfCHvS4=;
        b=bozNtBP7Ggd/Q1Fhy1BcH3O/NezSC4l28zLvWpPXqGWJ42oE7rnigZnlyULDXOpfjg
         18auWl83a+d24p4LneCs/kqYSNytr+3K4O5n9TVx8bfAkmIKpXrulLQ5YLiAx7kEZj8a
         5aq8gFTLZbIimByaFhBUCDYt5HCXYiTe0bUoQZR70rlZT7zusFkib6yX8Ir5sRlCWI3j
         2uOdZo6o/AQLyXgWyoibJJvP/4FJ76VUTgJEtvqMua/AfIyAQOx8eFiZ43ke+MhlFEI7
         Cp7SNQ0vg9RDkU0jLiHP+YYSYD/943BonRhzN77EHKWfFlffXCKFN8jAGIWZvGKr6Bv6
         dGqw==
X-Gm-Message-State: ABuFfojZuvC3ZPdPkNtseZJ8ic3f7z9oPUCZKab5XiR6J5bgmFxvpkdz
        HZBJ7wbFeH0OtUT0GUPMdvM=
X-Google-Smtp-Source: ACcGV61VmXmyp5L6SWX9s4ZkyKrSdKbStqNZfuO2+qU6tg3q8f5YubMKzffxgsdAy+aSw2eKjLKeFw==
X-Received: by 2002:a17:902:b611:: with SMTP id b17-v6mr8216277pls.217.1539397903806;
        Fri, 12 Oct 2018 19:31:43 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::1:4ee2])
        by smtp.gmail.com with ESMTPSA id d197-v6sm3891276pga.1.2018.10.12.19.31.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 19:31:42 -0700 (PDT)
Date:   Fri, 12 Oct 2018 19:31:40 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Daniel Colascione <dancol@google.com>
Cc:     joelaf@google.com, linux-kernel@vger.kernel.org,
        timmurray@google.com, netdev@vger.kernel.org,
        Lorenzo Colitti <lorenzo@google.com>,
        Chenbo Feng <fengc@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH v4] Wait for running BPF programs when updating map-in-map
Message-ID: <20181013023138.m445q6itdmyxdtoc@ast-mbp.dhcp.thefacebook.com>
References: <20180816040145.gqzqicab4s6kcbye@ast-mbp.dhcp.thefacebook.com>
 <20181012105427.243779-1-dancol@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012105427.243779-1-dancol@google.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 03:54:27AM -0700, Daniel Colascione wrote:
> The map-in-map frequently serves as a mechanism for atomic
> snapshotting of state that a BPF program might record.  The current
> implementation is dangerous to use in this way, however, since
> userspace has no way of knowing when all programs that might have
> retrieved the "old" value of the map may have completed.
> 
> This change ensures that map update operations on map-in-map map types
> always wait for all references to the old map to drop before returning
> to userspace.
> 
> Signed-off-by: Daniel Colascione <dancol@google.com>
> ---
>  kernel/bpf/syscall.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 8339d81cba1d..d7c16ae1e85a 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -741,6 +741,18 @@ static int map_lookup_elem(union bpf_attr *attr)
>  	return err;
>  }
>  
> +static void maybe_wait_bpf_programs(struct bpf_map *map)
> +{
> +	/* Wait for any running BPF programs to complete so that
> +	 * userspace, when we return to it, knows that all programs
> +	 * that could be running use the new map value.
> +	 */
> +	if (map->map_type == BPF_MAP_TYPE_HASH_OF_MAPS ||
> +	    map->map_type == BPF_MAP_TYPE_ARRAY_OF_MAPS) {
> +		synchronize_rcu();
> +	}

extra {} were not necessary. I removed them while applying to bpf-next.
Please run checkpatch.pl next time.
Thanks

