Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BF5ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 19:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDDA82082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 19:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rLGcVyGc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDDA82082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbeJYDrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 23:47:07 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35093 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbeJYDrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 23:47:06 -0400
Received: by mail-wm1-f67.google.com with SMTP id w186-v6so6534185wmf.0;
        Wed, 24 Oct 2018 12:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Q8zOjvMiK8/bOLwVa9U7++VeEizO+UZSi5VI4W5nnDE=;
        b=rLGcVyGcb1Fely2FXLFJhu++TuRTMZRf4y+Y/+zOcdw/q7zm7KmdHmaVEsaYXS+bPO
         Mo2e9swFh3qvSQ5Qhs7PGxH11fHXiAMS0YqV7EGGsuY1OTjb/N3b3/yIdvyS9p6sBFNW
         sjMCeAeLCRjoWmqupwS+73kwjpsgisWF/rSpcJYA01Cg548jx0hxk6GvoW0zjGYys54A
         4LxzpnV3Au5pT2fHgZfPIFS/Z78J5iwDBy1z9CyAlxd4nby+JEYmwjpYlj/Eg0V6s8IH
         JkIjH5y+CcZOWCUpvkbHgEZStAkTMWBl2NimJsLglRv3P6BFntSV4pt+C0oC3HJY0usr
         y2xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Q8zOjvMiK8/bOLwVa9U7++VeEizO+UZSi5VI4W5nnDE=;
        b=MvLJWPYv3KdyFDUCGpMFSuRAtmwrsTprav2VLI7XtQ+6Ni9T0xxuDLR7+ivLRyaL5+
         XIa43Hd9fhl93wQm6QyFeihTVfwPOrXbfqla4R4ta+yvBhHUI/0sypQwau9xS2643JIQ
         2PWGuYVUFNtkNMkCXBvEAxwkWus2bridi6mxliy//91sIS+Ns82Sz7liQwxrNFOAk1m2
         n1Xofh6Z9dPfp2T3mds1E6ERYh/kK8VzwYj4BB9BVlgdlIsGp+yarWskAWzFHJ4Q/em4
         jiiknC8V+SQkK5bB5Ofaaxt01AsXvVuaT+zDR0VCGislxMjwz1yywD7GuacYv1wvYtfJ
         wnKw==
X-Gm-Message-State: AGRZ1gLKDqi3DRjiNJX1jUaZ9QxfI0fKvuiCFsv3pihSwyPhcUixs7LD
        sFeBEIRP8Log+4bTffmFvxRzo7ZPGG0=
X-Google-Smtp-Source: AJdET5e3VmpM1WksMXE8YRrWaUXRYXbTj5Qp74pH4UehfCOgw1iLN8JT0AuXy1IU5nn0QYTtRViOsQ==
X-Received: by 2002:a1c:ef15:: with SMTP id n21-v6mr3705362wmh.151.1540408667551;
        Wed, 24 Oct 2018 12:17:47 -0700 (PDT)
Received: from sch.bme.hu (p200300C0DF1CEA00F68C50FFFE53CB63.dip0.t-ipconnect.de. [2003:c0:df1c:ea00:f68c:50ff:fe53:cb63])
        by smtp.gmail.com with ESMTPSA id q17-v6sm5168177wrw.19.2018.10.24.12.17.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 12:17:46 -0700 (PDT)
Date:   Wed, 24 Oct 2018 21:17:45 +0200
From:   =?utf-8?B?TcOhdMOp?= Eckl <ecklm94@gmail.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     pablo@netfilter.org, kadlec@blackhole.kfki.hu, fw@strlen.de,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfilter: bridge: define INT_MIN & INT_MAX in userspace
Message-ID: <20181024191745.jboas22he7ot7utd@sch.bme.hu>
References: <20181024115403.3938-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181024115403.3938-1-jslaby@suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 01:54:03PM +0200, Jiri Slaby wrote:
> With 4.19, programs like ebtables fail to build when they include
> "linux/netfilter_bridge.h". It is caused by commit 94276fa8a2a4 which
> added a use of INT_MIN and INT_MAX to the header:
> : In file included from /usr/include/linux/netfilter_bridge/ebtables.h:18,
> :                  from include/ebtables_u.h:28,
> :                  from communication.c:23:
> : /usr/include/linux/netfilter_bridge.h:30:20: error: 'INT_MIN' undeclared here (not in a function)
> :   NF_BR_PRI_FIRST = INT_MIN,
> :                     ^~~~~~~
> 
> Define these constants by including "limits.h" when !__KERNEL__ (the
> same way as for other netfilter_* headers).

Indeed I didn't think of this solution.

Thanks for the fix Jiri!

> 
> Fixes: 94276fa8a2a4 ("netfilter: bridge: Expose nf_tables bridge hook priorities through uapi")
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Máté Eckl <ecklm94@gmail.com>
> Cc: Pablo Neira Ayuso <pablo@netfilter.org>

Acked-by: Máté Eckl <ecklm94@gmail.com>

> ---
>  include/uapi/linux/netfilter_bridge.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/uapi/linux/netfilter_bridge.h b/include/uapi/linux/netfilter_bridge.h
> index 156ccd089df1..1610fdbab98d 100644
> --- a/include/uapi/linux/netfilter_bridge.h
> +++ b/include/uapi/linux/netfilter_bridge.h
> @@ -11,6 +11,10 @@
>  #include <linux/if_vlan.h>
>  #include <linux/if_pppox.h>
>  
> +#ifndef __KERNEL__
> +#include <limits.h> /* for INT_MIN, INT_MAX */
> +#endif
> +
>  /* Bridge Hooks */
>  /* After promisc drops, checksum checks. */
>  #define NF_BR_PRE_ROUTING	0
> -- 
> 2.19.1
> 
