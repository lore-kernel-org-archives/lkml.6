Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D03AC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDFC321476
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:05:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDFC321476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbeJSBG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 21:06:58 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36792 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727294AbeJSBG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 21:06:57 -0400
Received: by mail-oi1-f194.google.com with SMTP id p125-v6so24605233oic.3;
        Thu, 18 Oct 2018 10:05:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6M+qZS7XzLqQ84XTnjeDXwncE2T8D23MD4m/VgPQ9Qs=;
        b=Q1wYl2N1V61v8noKXxtOw9NJk/KBiVdycxCxfBCL+/sS9rl4ZwTVX5LxGrZ3PxHpet
         zlNGcNm34ScdC+kKjdTo429QxYDGdu1uVJ2SIFSxXDESLjUPUiO7PVnqZKptdRfIF/9S
         OnMlJvYQNduHp0h+zEAUwwH+KmwTOWyIz1EGLdOWqpTAZhj7RHlHeLN6B35HM09WuyTr
         FMrEenJxKre8wCIS0KaKxM+hJWHw6QPIQ+iQhLpMsY8Wonwj3OoqX5EAKVpKATAwuHPp
         RWplUAaZCdC5dN0ulILNWW3RmPQm/80tKufXw1Npv6hbkok05Y5za5PffGa8DqrWdrmP
         HQPg==
X-Gm-Message-State: ABuFfoirJxWAbKf9KIyUDs35I0gDs9T+IICJnFqSsMZlhyGXKLVarKva
        A3oUAMFDF0uhH8Ob6eSRpg==
X-Google-Smtp-Source: ACcGV61L8O77Qw7iX+T0760BVD9y+cMb61QydYzzRTtD8HB9t5+RhMmw9PLMZBPKq8uE+Z7rR01adA==
X-Received: by 2002:aca:7288:: with SMTP id p130-v6mr15463816oic.252.1539882303891;
        Thu, 18 Oct 2018 10:05:03 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x65-v6sm6540284oix.47.2018.10.18.10.05.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 10:05:03 -0700 (PDT)
Date:   Thu, 18 Oct 2018 12:05:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     frowand.list@gmail.com
Cc:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: Re: [PATCH v4 02/18] of: overlay: add missing of_node_put() after
 add new node to changeset
Message-ID: <20181018170502.GB15557@bogus>
References: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
 <1539657458-24401-3-git-send-email-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539657458-24401-3-git-send-email-frowand.list@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 07:37:22PM -0700, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> The refcount of a newly added overlay node decrements to one
> (instead of zero) when the overlay changeset is destroyed.  This
> change will cause the final decrement be to zero.
> 
> After applying this patch, new validation warnings will be
> reported from the devicetree unittest during boot due to
> a pre-existing devicetree bug.  The warnings will be similar to:
> 
>   OF: ERROR: memory leak of_node_release() overlay node /testcase-data/overlay-node/test-bus/test-unittest4 before free overlay changeset

Same comment on formatting.

> 
> This pre-existing devicetree bug will also trigger a WARN_ONCE() from
> refcount_sub_and_test_checked() when an overlay changeset is
> destroyed without having first been applied.  This scenario occurs
> when an error in the overlay is detected during the overlay changeset
> creation:
> 
>   WARNING: CPU: 0 PID: 1 at lib/refcount.c:187 refcount_sub_and_test_checked+0xa8/0xbc
>   refcount_t: underflow; use-after-free.
> 
>   (unwind_backtrace) from (show_stack+0x10/0x14)
>   (show_stack) from (dump_stack+0x6c/0x8c)
>   (dump_stack) from (__warn+0xdc/0x104)
>   (__warn) from (warn_slowpath_fmt+0x44/0x6c)
>   (warn_slowpath_fmt) from (refcount_sub_and_test_checked+0xa8/0xbc)
>   (refcount_sub_and_test_checked) from (kobject_put+0x24/0x208)
>   (kobject_put) from (of_changeset_destroy+0x2c/0xb4)
>   (of_changeset_destroy) from (free_overlay_changeset+0x1c/0x9c)
>   (free_overlay_changeset) from (of_overlay_remove+0x284/0x2cc)
>   (of_overlay_remove) from (of_unittest_apply_revert_overlay_check.constprop.4+0xf8/0x1e8)
>   (of_unittest_apply_revert_overlay_check.constprop.4) from (of_unittest_overlay+0x960/0xed8)
>   (of_unittest_overlay) from (of_unittest+0x1cc4/0x2138)
>   (of_unittest) from (do_one_initcall+0x4c/0x28c)
>   (do_one_initcall) from (kernel_init_freeable+0x29c/0x378)
>   (kernel_init_freeable) from (kernel_init+0x8/0x110)
>   (kernel_init) from (ret_from_fork+0x14/0x2c)
> 
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
>  drivers/of/overlay.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
> index 1176cb4b6e4e..32cfee68f2e3 100644
> --- a/drivers/of/overlay.c
> +++ b/drivers/of/overlay.c
> @@ -379,7 +379,9 @@ static int add_changeset_node(struct overlay_changeset *ovcs,
>  		if (ret)
>  			return ret;
>  
> -		return build_changeset_next_level(ovcs, tchild, node);
> +		ret = build_changeset_next_level(ovcs, tchild, node);
> +		of_node_put(tchild);
> +		return ret;
>  	}
>  
>  	if (node->phandle && tchild->phandle)
> -- 
> Frank Rowand <frank.rowand@sony.com>
> 
