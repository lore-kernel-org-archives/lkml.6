Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4D4C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EA0520693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="qMObiqJL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EA0520693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030279AbeFSRkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 13:40:06 -0400
Received: from mail-lf0-f50.google.com ([209.85.215.50]:34204 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966650AbeFSRkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 13:40:05 -0400
Received: by mail-lf0-f50.google.com with SMTP id e13-v6so475112lfc.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 10:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HTymQ1SN1QmY/gWX3TMK1zJIJD4uE+vCN3JHSml0Jhk=;
        b=qMObiqJL04E/VGLIB0S0AU51rdXRRqf5+J2F4PT1dQNjNFhfvmyRoha64nNh9NfOTj
         RmQQVIJqGDGDoazAyTnrs1Z7DD1YQKNbA5hQ3AwIkE3HrYS1xDob/7siEJnnnQ/rMdvZ
         JMjlWFlwo9P3yBBPlRae89vL0YLJ9APjdj6Q/1dV73UOZ2xwJKsLC3njKh0LLxDTBky0
         fTvYpw1aStnmeaSxXKlA2pWVPFhyY7HpFKAXB7q9KHuhm/HMqkzBxuYj5Rxm3Yv/qbIx
         /f/3J/5icummcdQDFDIA1lvaKou/YtHHWcmTLagwih4P/VW2ZbLUFIo/ZUnzKfu3K8PL
         7F/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HTymQ1SN1QmY/gWX3TMK1zJIJD4uE+vCN3JHSml0Jhk=;
        b=b64lowfpkBHROiVEkDyzqHS2JKRbc0HPA7bmpkTIBFyruHyYEzG4lKMynNf6VJ2jsk
         f6ss1z8Ixo2boW8oRRK5cVEI4Oq8nOUJRUaBc9CPQ6zzMowhUa2B1jGVdDXvi9iuCvLZ
         Qto/94fLiLIY0+n+Urmbc1K/Cqi5AKa6kDs7YT4nWPzwIB7eVkACOPPdn8fJZEfEpvFK
         5FiWuJgwvTKBtppX8oaPemoWdD/AF7rOLMks6YrCobL/YclmuO4FSBuYZZj4CdxAUpqJ
         p5iwLN+EGSsaLYRrFPmRYFIF6381Ada+XW8+OPu6965OH66/Twz3ECDGO9HNK1Dg/4t3
         dTzg==
X-Gm-Message-State: APt69E1EBa4j5uYC/1QGk/v0IqXayCtJIMAvlpLjmfoM8rAh5BRIPHnx
        SLryEZsFlBlCLccH/uPMVQpWFkAaK/a56aRs1I/I
X-Google-Smtp-Source: ADUXVKKBzBw6hvryBRGEfPTG2q0uuSGf3n4bhP9Z+tvwrgH7QFvSYPQw8F8RQHYpmyLlic9zqN+JhI7MT+oHrMTQfVs=
X-Received: by 2002:a2e:18b:: with SMTP id f11-v6mr11734477lji.83.1529430003634;
 Tue, 19 Jun 2018 10:40:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180612080912.7827-1-peter.enderborg@sony.com> <20180612080912.7827-10-peter.enderborg@sony.com>
In-Reply-To: <20180612080912.7827-10-peter.enderborg@sony.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 19 Jun 2018 13:39:52 -0400
Message-ID: <CAHC9VhRoWbhTERzcwtEX2GkXQRfPG8itYV+yxkz74qugrotZUw@mail.gmail.com>
Subject: Re: [PATCH 09/13] selinux: Cleanup printk logging in sidtab
To:     peter.enderborg@sony.com
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        James Morris <jmorris@namei.org>, danielj@mellanox.com,
        dledford@redhat.com, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, serge@hallyn.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 4:09 AM Peter Enderborg
<peter.enderborg@sony.com> wrote:
>
> Replace printk with pr_* to avoid checkpatch warnings.
>
> Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
> ---
>  security/selinux/ss/sidtab.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Merged, thanks.

> diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
> index 5be31b7af225..fd75a12fa8fc 100644
> --- a/security/selinux/ss/sidtab.c
> +++ b/security/selinux/ss/sidtab.c
> @@ -214,8 +214,7 @@ int sidtab_context_to_sid(struct sidtab *s,
>                 }
>                 sid = s->next_sid++;
>                 if (context->len)
> -                       printk(KERN_INFO
> -                      "SELinux:  Context %s is not valid (left unmapped).\n",
> +                       pr_info("SELinux:  Context %s is not valid (left unmapped).\n",
>                                context->str);
>                 ret = sidtab_insert(s, sid, context);
>                 if (ret)
> @@ -253,7 +252,7 @@ void sidtab_hash_eval(struct sidtab *h, char *tag)
>                 }
>         }
>
> -       printk(KERN_DEBUG "%s:  %d entries and %d/%d buckets used, longest "
> +       pr_debug("%s:  %d entries and %d/%d buckets used, longest "
>                "chain length %d\n", tag, h->nel, slots_used, SIDTAB_SIZE,
>                max_chain_len);
>  }
> --
> 2.15.1
>


-- 
paul moore
www.paul-moore.com
