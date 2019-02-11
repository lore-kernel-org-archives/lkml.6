Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3B3C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 541B82186A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hWinqYJ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388161AbfBKT3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:29:13 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:38973 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732364AbfBKT3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 14:29:13 -0500
Received: by mail-vs1-f65.google.com with SMTP id e16so39833vsq.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 11:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pg6m4puueGSKgxFi2uNwC9kugYg5UTfpjB90FPweV/Y=;
        b=hWinqYJ/c2te/mMDwRkz4RGJ6q9hQd0b9oB5Su5BNgJ1rB5H/5fLVvhH/JNk9EGi3I
         cUYGO6xtpyJQIVlRvwmMIOzI1g9QV1tBJeYO6s//zxjUBEsxfOSKnTrRGWLK7rc0mqqv
         gnhBDMILghoWVTItSD6WU3WZfQx2F7FgO0T7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pg6m4puueGSKgxFi2uNwC9kugYg5UTfpjB90FPweV/Y=;
        b=HUfVGtCVUu4cErOq/x5P58dR43Cs2RcEwMalYlaaSqRbvhTntdfaalOoG5Cfv9Aq2u
         AueUpEcSijHxUP87XWAx/rJwn9XRzF+M5ISQa+sk+Tu3gK29UQfYJtGt7841c+K/50Vq
         DbQFHeC3V+EIIbK4Szp/ZjhyDf1cxScXB6vEnvqva5BGGzv7G3lXzKOPcl3ERKktQOMa
         UNOOw0Z3vfN+4SgHQsi/omgvFW9FG1LSTTm1QDaY8rhjVFbXrOS1ozWhMQPsuMvq7H/7
         zszFv1OU88Rec7KzoISvEkTJKjP2irM8THyM5LwTmnr+wssOiDCdvhxLWYddlsOMETgA
         k33A==
X-Gm-Message-State: AHQUAua7NSknze7qvYwODQREtAdulqM0FpMukEcID+8AOwuhGmY1gtiT
        nNgRED9JQ0O2GVxnAZPLC34eRZHIo7U=
X-Google-Smtp-Source: AHgI3Ia9NuD19p/SbmJrHv676AmYQr6mgr81ec8Wi2FQm7VY4rB7ykwr4Pdr5fl0z39VV9+7aGqbpw==
X-Received: by 2002:a67:fc48:: with SMTP id p8mr8735768vsq.17.1549913351587;
        Mon, 11 Feb 2019 11:29:11 -0800 (PST)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com. [209.85.221.176])
        by smtp.gmail.com with ESMTPSA id p6sm163828uaa.2.2019.02.11.11.29.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 11:29:10 -0800 (PST)
Received: by mail-vk1-f176.google.com with SMTP id v70so13955vkv.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 11:29:09 -0800 (PST)
X-Received: by 2002:a1f:e7c5:: with SMTP id e188mr15096131vkh.92.1549913349277;
 Mon, 11 Feb 2019 11:29:09 -0800 (PST)
MIME-Version: 1.0
References: <cover.1549540487.git.efremov@ispras.ru>
In-Reply-To: <cover.1549540487.git.efremov@ispras.ru>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 11 Feb 2019 11:28:57 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJ8DaoXk4Vt-K_Tgvpe4=wgHZ3Z1Y=D8JzRHU9n=bvgtA@mail.gmail.com>
Message-ID: <CAGXu5jJ8DaoXk4Vt-K_Tgvpe4=wgHZ3Z1Y=D8JzRHU9n=bvgtA@mail.gmail.com>
Subject: Re: [PATCH 00/10] LSM documentation update
To:     Denis Efremov <efremov@ispras.ru>
Cc:     linux-security-module <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Eric Paris <eparis@parisplace.org>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 7, 2019 at 4:45 AM Denis Efremov <efremov@ispras.ru> wrote:
>
> Recent "New LSM Hooks" discussion has led me to the
> thought that it might be a good idea to slightly
> update the current documentation. The patchset adds
> nothing new to the documentation, only fixes the old
> description of hooks to reflect their current state.

Do these fixes silence any warnings during the documentation build?
(i.e. how did you verify the results beyond eyeballing the changes)

-Kees

>
> Denis Efremov (10):
>   security: fix documentation for the sb_copy_data hook
>   security: fix documentation for the syslog hook
>   security: fix documentation for the socket_post_create hook
>   security: fix documentation for the task_setscheduler hook
>   security: fix documentation for the socket_getpeersec_dgram hook
>   security: fix documentation for the path_chmod hook
>   security: fix documentation for the audit_* hooks
>   security: fix documentation for the msg_queue_* hooks
>   security: fix documentation for the sem_* hooks
>   security: fix documentation for the shm_* hooks
>
>  include/linux/lsm_hooks.h | 127 ++++++++++++++++++--------------------
>  1 file changed, 61 insertions(+), 66 deletions(-)
>
> --
> 2.17.2
>


-- 
Kees Cook
