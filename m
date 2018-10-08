Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F39C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1B7E20858
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="TxBSYfjm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1B7E20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbeJHVHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 17:07:06 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41473 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbeJHVHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 17:07:06 -0400
Received: by mail-wr1-f66.google.com with SMTP id x12-v6so20940725wru.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 06:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o3rL6KIbYioFnwDggds98JBn0aneQcoQd8W3ygd9nv0=;
        b=TxBSYfjm7czmwd7jBZjaH2Fz01qgXwbJYn2gEp2FawBCCdyEldvdgYjdktjY+xid0j
         kjdL8crkW+ercC1lDsFigs8DvoPc3NpyMNDebzAyUsPiIBZBEWJt7T9lZR+9fel5yXgG
         xffX+QB+YU/gInQFoHZbI2pHGybsWsT1LhfdCkueF0VZUs9xgl8JWIR52cMMhBqX6arO
         oflqRhog9jEBl3iLRT4G9898UtfEvIAbY3zH0wQqFk2PaDiJCDrqclJA6tCQyUy37Mq0
         dduZZKtoBTVkbosb4aOscViabbl2H9ALBRPShTt7Xy5RzaH4pra89hGFmnC5482LSZsl
         8FoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o3rL6KIbYioFnwDggds98JBn0aneQcoQd8W3ygd9nv0=;
        b=eFHhgWDXLdCcRSw9cUSZIuDpVNcD/R6FDUeeJCWTDf8U0GFhg7zX855nu/OrlUG/OG
         Jn8+Ng1l9fUQczSDUKVK0K4rN5+TaSWKhGNosdbNNcNNajXaSKQ3DkB0rbHyPRisNWpL
         IY5yJrbTCThxU9jAGCXa9PP+yLvr/HFK58iSo3a7zZZwIY61PZ/objp+/rm197UfmlOk
         nBgrbhX9khpCjYoQ7Qrn5ITTPLSmDu8QRkLLtNkG8bdouhLdsSX52bJTS1IiYHJnhlp4
         VyuBoD/qIvKuTl/yjlF7iUQErTXGJfisOhryz00K60kJVcnBY+fDyshbwi65dUKBUvYk
         GzZQ==
X-Gm-Message-State: ABuFfohOVUnyFMTdaD/Kp5k6DKBD5exE3OKO5k4ZxsVh22Up6tT5abiB
        g7wq4Mhz434vDPbNnoaTWFm9eSEDuw8=
X-Google-Smtp-Source: ACcGV63i9Y7VpsFJOWIIx6hrK3zlo+N8tCsjHT+x1pDA5IXRElzlm6vua6O9OjSWdU+KNMhMsx1eew==
X-Received: by 2002:a05:6000:1105:: with SMTP id z5mr15888511wrw.136.1539006914224;
        Mon, 08 Oct 2018 06:55:14 -0700 (PDT)
Received: from brauner.io (u-086-c052.eap.uni-tuebingen.de. [134.2.86.52])
        by smtp.gmail.com with ESMTPSA id 134-v6sm3220404wmb.13.2018.10.08.06.55.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 06:55:13 -0700 (PDT)
Date:   Mon, 8 Oct 2018 15:55:07 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
        linux-api@vger.kernel.org, containers@lists.linux-foundation.org,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v7 2/6] seccomp: make get_nth_filter available outside of
 CHECKPOINT_RESTORE
Message-ID: <20181008135506.xvee7twtmv263ogr@brauner.io>
References: <20180927151119.9989-1-tycho@tycho.ws>
 <20180927151119.9989-3-tycho@tycho.ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180927151119.9989-3-tycho@tycho.ws>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 09:11:15AM -0600, Tycho Andersen wrote:
> In the next commit we'll use this same mnemonic to get a listener for the
> nth filter, so we need it available outside of CHECKPOINT_RESTORE in the
> USER_NOTIFICATION case as well.
> 
> v2: new in v2
> v3: no changes
> v4: no changes
> v5: switch to CHECKPOINT_RESTORE || USER_NOTIFICATION to avoid warning when
>     only CONFIG_SECCOMP_FILTER is enabled.
> v7: drop USER_NOTIFICATION bits
> 
> Signed-off-by: Tycho Andersen <tycho@tycho.ws>
> CC: Kees Cook <keescook@chromium.org>
> CC: Andy Lutomirski <luto@amacapital.net>
> CC: Oleg Nesterov <oleg@redhat.com>
> CC: Eric W. Biederman <ebiederm@xmission.com>
> CC: "Serge E. Hallyn" <serge@hallyn.com>
> CC: Christian Brauner <christian.brauner@ubuntu.com>
> CC: Tyler Hicks <tyhicks@canonical.com>
> CC: Akihiro Suda <suda.akihiro@lab.ntt.co.jp>

Acked-by: Christian Brauner <christian@brauner.io>

> ---
>  kernel/seccomp.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index fa6fe9756c80..44a31ac8373a 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -1158,7 +1158,7 @@ long prctl_set_seccomp(unsigned long seccomp_mode, char __user *filter)
>  	return do_seccomp(op, 0, uargs);
>  }
>  
> -#if defined(CONFIG_SECCOMP_FILTER) && defined(CONFIG_CHECKPOINT_RESTORE)
> +#if defined(CONFIG_SECCOMP_FILTER)
>  static struct seccomp_filter *get_nth_filter(struct task_struct *task,
>  					     unsigned long filter_off)
>  {
> @@ -1205,6 +1205,7 @@ static struct seccomp_filter *get_nth_filter(struct task_struct *task,
>  	return filter;
>  }
>  
> +#if defined(CONFIG_CHECKPOINT_RESTORE)
>  long seccomp_get_filter(struct task_struct *task, unsigned long filter_off,
>  			void __user *data)
>  {
> @@ -1277,7 +1278,8 @@ long seccomp_get_metadata(struct task_struct *task,
>  	__put_seccomp_filter(filter);
>  	return ret;
>  }
> -#endif
> +#endif /* CONFIG_CHECKPOINT_RESTORE */
> +#endif /* CONFIG_SECCOMP_FILTER */
>  
>  #ifdef CONFIG_SYSCTL
>  
> -- 
> 2.17.1
> 
> _______________________________________________
> Containers mailing list
> Containers@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/containers
