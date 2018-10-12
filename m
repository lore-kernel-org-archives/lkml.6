Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0802BC6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 20:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABE04206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 20:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NMqITDD3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABE04206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbeJME2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 00:28:49 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43685 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbeJME2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 00:28:48 -0400
Received: by mail-pl1-f193.google.com with SMTP id 30-v6so6441459plb.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 13:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rqdu3rt+5zvIPF2L2ugSweeyTSFTri9Kybi6S1s2K7g=;
        b=NMqITDD3r3VDxvgZPXokM2X2iQ0vipZPrkhsglyl9s31bEVvSHtXIDUmlkInAD0RrN
         OOybxfyIJL8iWGEcA3FHHMB1gnlLUwUGt6vUz388Z7LNM7q/UV6CZiUpq0iAEfzbQqwG
         7s07NniObseN6o5lt5WrBmQKOGf5Or8AJlyqft2YzXKR4pDMFW/sf1FhT87HFojlTMFy
         rsbCAAaxu/DeLDGU/e2UnuAcbSq/heblxqxf9zawx69vqobdykjK0QycFsUXLo3kRod9
         zitfWqlM75c3pUQbHd62/DuH4NFwsiYsippmjtruoAXneXcdnkoofjvJVjnTlJcb9GnC
         n/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rqdu3rt+5zvIPF2L2ugSweeyTSFTri9Kybi6S1s2K7g=;
        b=JwmZficfSaMhazc99WogSw3lHv6foFosqgHXEiXNByQR3dokFEh0oy+0keeh6d4nB+
         axNhivuewyGrAQ4XxapUIFmALgok3UrdbkjH+xpsMb/SZO2udS8DA70eBo+rgcUMw2Qt
         1kB8qzarghrcB9qtt3ZruYldjdCBCC2XzpMZDquXzMW/V1pwvlN24GDFGrWf0u/yzAgQ
         oF2gsPIXRo0sxO56XOSajMB9zCP+1HyZ2L2g96auk+7Pqox1tCQVZ/nKWiJt6RHs3JM0
         txyvhWiUC5+NAW4kW/wnrHLKG9kqfinnvJjAQUG5ZEPi3zdNjqhQvAcVhXM76tZ2TNBP
         bZuQ==
X-Gm-Message-State: ABuFfogjcc9c8bDgtaV8VU1BzTNtaPksAu1WIroRG7h/4hqm8ktdzvzN
        Vf+9I+glpoAPKn7kgUpsGMluNQz1oXtz4Q==
X-Google-Smtp-Source: ACcGV615So4clz/GWUkfI6O0IJ5RcMXyQTkGSe+Qj5IVQTAzs3MgBWmaoe6wMR9VYPtQCbyIZqz6+w==
X-Received: by 2002:a17:902:5a4d:: with SMTP id f13-v6mr837670plm.114.1539377670379;
        Fri, 12 Oct 2018 13:54:30 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id p62-v6sm3586240pfp.111.2018.10.12.13.54.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 13:54:29 -0700 (PDT)
Date:   Fri, 12 Oct 2018 13:54:28 -0700
From:   Joel Fernandes <joelaf@google.com>
To:     Daniel Colascione <dancol@google.com>
Cc:     linux-kernel@vger.kernel.org, timmurray@google.com,
        netdev@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Lorenzo Colitti <lorenzo@google.com>,
        Chenbo Feng <fengc@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@android.com
Subject: Re: [PATCH v4] Wait for running BPF programs when updating map-in-map
Message-ID: <20181012205428.GA32209@joelaf.mtv.corp.google.com>
References: <20180816040145.gqzqicab4s6kcbye@ast-mbp.dhcp.thefacebook.com>
 <20181012105427.243779-1-dancol@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012105427.243779-1-dancol@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
> +}
> +
>  #define BPF_MAP_UPDATE_ELEM_LAST_FIELD flags
>  
>  static int map_update_elem(union bpf_attr *attr)
> @@ -831,6 +843,7 @@ static int map_update_elem(union bpf_attr *attr)
>  	}
>  	__this_cpu_dec(bpf_prog_active);
>  	preempt_enable();
> +	maybe_wait_bpf_programs(map);
>  out:
>  free_value:
>  	kfree(value);
> @@ -883,6 +896,7 @@ static int map_delete_elem(union bpf_attr *attr)
>  	rcu_read_unlock();
>  	__this_cpu_dec(bpf_prog_active);
>  	preempt_enable();
> +	maybe_wait_bpf_programs(map);

Looks good to me,

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Also I believe that those rcu_read_lock() and rcu_read_unlock() calls in the
existing code are useless. preempt_disable()d code is already an RCU
read-side section, and synchronize_rcu and friends work on those type of
read-side sections as well (as of recent kernel releases) however removing it
may make lockdep unhappy, unless we also replace all rcu_dereference() usages
with rcu_dereference_sched(), so lets leave that alone for now I guess.

thanks,

- Joel
