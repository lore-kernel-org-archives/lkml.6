Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFCFC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F550206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uh114D5W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730861AbfAJSKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 13:10:07 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45495 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729480AbfAJSKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 13:10:06 -0500
Received: by mail-pg1-f194.google.com with SMTP id y4so5130378pgc.12;
        Thu, 10 Jan 2019 10:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jLMG0vDtb84uvvHlrtK8UwB0f7JvUM6JHpQMA8d3sUM=;
        b=Uh114D5WWm4J/L+Q+gdWG0WTzVwTEctXQZ0jsKkmovGZPwq3LFUo7i6t+fmEsWY4ZN
         daN929NjLAv8vqSVsVwfk3mntvWBnDHXHhaNj1qQK62+Ye4oQUslMfc/f9yLwIsjywXW
         KclXJsDlZkFbhizO4VYE5McUXhu7lHNMG08ntuBQN0DJrawnb+c/l74oUSeFzwX9W2q9
         1LM6P9iT2xGupmfxxRk7bUBcNPKj43HbEKodO06L4/2ne+frz5/AC1vq7OOFwnZXvH5y
         HkHPvSJr8mbsFuq5LHQZfgik67UBBFhpAJ+PtYNxgPXBB1faiByHM106Hllyf8zcy4kE
         XkIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jLMG0vDtb84uvvHlrtK8UwB0f7JvUM6JHpQMA8d3sUM=;
        b=jKNYLdr8u0Pno3ndTYJo5jETaUsnDT4KYdSXq4V81XOev3L252WI35F326m4mmFQV9
         mLRi/rMnUvdmESfLZH23uGH7ztrUmi04UUXslGJ0z1qSsoOqZL5ayuV80UicSmVjB5NN
         3nZCwv4mYL0nAadqpzrAla4kkv9SETC4dQ9hXXzO3DajsY4OCZCp+BPYR1PgOwlHmDIK
         OsIbjrC36aI3Vex9uX/2v8mhUDmIjQ/g77yrAf7OvjXFfWKPM7XXmwifuHNd5lfwt2WT
         YFJVO1hW4W3rqsNDT4yJNsnls1au/yn3uEOidefHqnAZLTaH27n/2M/WS8D+/41qzlk+
         y61g==
X-Gm-Message-State: AJcUuke0Sgh2513J/9rT/lKZ/apxKh/zWroFaotzSVB+DuZR+hWO+Ayh
        P1557GBKc29nHPyeqGOzaAXmi05rGn9Sf+futiQMjmwF
X-Google-Smtp-Source: ALg8bN6tcC/pJq6wf1Frc8lFVBgh39Gd1QhQwrKOa1DF1ZzCZ7BcXuOGvvbvqbHn88UGS5LI6eqYxU+5Gao5r0j/jpQ=
X-Received: by 2002:a65:500c:: with SMTP id f12mr10155368pgo.226.1547143805318;
 Thu, 10 Jan 2019 10:10:05 -0800 (PST)
MIME-Version: 1.0
References: <154693980088.104235.16222977463502002037.stgit@buzz>
In-Reply-To: <154693980088.104235.16222977463502002037.stgit@buzz>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Thu, 10 Jan 2019 10:09:53 -0800
Message-ID: <CAM_iQpX1oiOiGFejO8yKNM_VT2BSMH9aFk-_1nPDjfO=jFmNgQ@mail.gmail.com>
Subject: Re: [PATCH] net/core/neighbour: tell kmemleak about hash tables
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     Linux Kernel Network Developers <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 1:30 AM Konstantin Khlebnikov
<khlebnikov@yandex-team.ru> wrote:
> @@ -443,12 +444,14 @@ static struct neigh_hash_table *neigh_hash_alloc(unsigned int shift)
>         ret = kmalloc(sizeof(*ret), GFP_ATOMIC);
>         if (!ret)
>                 return NULL;
> -       if (size <= PAGE_SIZE)
> +       if (size <= PAGE_SIZE) {
>                 buckets = kzalloc(size, GFP_ATOMIC);
> -       else
> +       } else {
>                 buckets = (struct neighbour __rcu **)
>                           __get_free_pages(GFP_ATOMIC | __GFP_ZERO,
>                                            get_order(size));
> +               kmemleak_alloc(buckets, size, 0, GFP_ATOMIC);

Why min_count is 0 rather than 1 here?
