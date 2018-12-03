Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A75AC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8B4E2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXvaeO+i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8B4E2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbeLCW3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 17:29:47 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45741 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbeLCW3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 17:29:46 -0500
Received: by mail-ed1-f66.google.com with SMTP id d39so12170862edb.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 14:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MiQ1Ug+Qk3yyAuP47luLctb2QOhjx4xuSb3MsM+ToFE=;
        b=XXvaeO+ir7ySgBrqdCk62rPv7sVvJGwGUx4+C0oK+0bGpq/8TYxwsJdyDWBwTcHWXX
         QKAFRBuvljwRnmypODwk6DhIN38xNRUEMc7sHGcvSxVZyol2Dig4BSS+sBgsPTyVWMJF
         QfLAGcgnQB16DdQhhi/L+KXYb1cltBGTTwIMByiKDB2JDYvITqgAciU3L8Bpwcq0G7V4
         sEcfGQo+jAj9NPLrfwbiFjbgkGi5uUagR2Qep9y2GQRZXNd32oxNdtlQSbLFhjwh2MrR
         6BD7MReIWm95g//HvN1dUCZ/zcZZcIRHeXn406PgZClrIkdSfNNV8hM9LFUdjbvhFSFa
         0qyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MiQ1Ug+Qk3yyAuP47luLctb2QOhjx4xuSb3MsM+ToFE=;
        b=aL8ILD1heOsehxRJfvYPKpRa7JnQL4Oj5OVs3B5fbGsV14osOUk9tEERv6DoOqXAYg
         occqHqtkT6kx/APW2Esh00A/asKtTzCHH7wbjvJ5KkciSetyxLylA9b3RraKnwJDJF9O
         bXmQS8xaaqvXawOTZxzaRHEhUARxTB9mbtUpHpMpTPh0ndvf3Vq3+wZzEmtkqm9NzxRo
         qYIQtYKrblz5dyXDKedBsIK1BIBJ++ia7baniJCEn1eD97lpVtYrjTIdV/PamAujHbsQ
         s3Oqn5GXw2vIVGyCWHSwJ1yoO/6A3Aud1wpR1nm2BJ8TIPPHUBAtOB5aZX60La8XdFPZ
         Cd/A==
X-Gm-Message-State: AA+aEWaftUT9HR+fnlESUHjNxuOhRidG04XhkbpzTN/m7/VppoBbVOsa
        FonNsLDivklxq1L7VSW/QVo=
X-Google-Smtp-Source: AFSGD/UmqbZONLkx9YNSn9FgXqe967UJIBH9lDf7bYyH+9JZj9pDKIPA6RjINdvg0qhsPdmBSudv1w==
X-Received: by 2002:a50:9ee3:: with SMTP id a90mr16085153edf.283.1543876185100;
        Mon, 03 Dec 2018 14:29:45 -0800 (PST)
Received: from ltop.local ([2a02:a03f:40bc:4d00:6932:2c57:7da2:797e])
        by smtp.gmail.com with ESMTPSA id v9sm4256850edl.3.2018.12.03.14.29.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 14:29:44 -0800 (PST)
Date:   Mon, 3 Dec 2018 23:29:43 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Todd Kjos <tkjos@android.com>
Cc:     tkjos@google.com, gregkh@linuxfoundation.org, arve@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        maco@google.com, joel@joelfernandes.org, kernel-team@android.com
Subject: Re: [PATCH] binder: fix sparse warnings on locking context
Message-ID: <20181203222942.zkvwdws5qmkhfuhw@ltop.local>
References: <20181203202457.228972-1-tkjos@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203202457.228972-1-tkjos@google.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 12:24:54PM -0800, Todd Kjos wrote:
> Add __acquire()/__release() annnotations to fix warnings
> in sparse context checking
> 
> There is one case where the warning was due to a lack of
> a "default:" case in a switch statement where a lock was
> being released in each of the cases, so the default
> case was added.
> 
> Signed-off-by: Todd Kjos <tkjos@google.com>
> ---
>  drivers/android/binder.c       | 43 +++++++++++++++++++++++++++++++++-
>  drivers/android/binder_alloc.c |  1 +
>  2 files changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 9f1000d2a40c7..9f2059d24ae2d 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -751,12 +757,16 @@ _binder_node_unlock(struct binder_node *node, int line)
>  #define binder_node_inner_lock(node) _binder_node_inner_lock(node, __LINE__)
>  static void
>  _binder_node_inner_lock(struct binder_node *node, int line)
> +	__acquires(&node->lock) __acquires(&node->proc->inner_lock)
>  {
>  	binder_debug(BINDER_DEBUG_SPINLOCKS,
>  		     "%s: line=%d\n", __func__, line);
>  	spin_lock(&node->lock);
>  	if (node->proc)
>  		binder_inner_proc_lock(node->proc);
> +	else
> +		/* annotation for sparse */
> +		__acquire(&node->proc->inner_lock);

This one is questionnable because:
1) if !node->proc, then '&node->proc->inner_lock' is not acquired
   since it doesn't even exist.
2) OTOH, the function can't have the annotation 100% right because
   it semantics allows unbalanced locking depending on node->proc
   being null or not.
But I see very well the intent and maybe it's a right solution.
I dunno.

Same for most of the following ones.


Best regards,
-- Luc Van Oostenryck
