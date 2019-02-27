Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E9FC10F0B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 00:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B353B218D8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 00:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="az/Vs4op"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbfB0AJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 19:09:50 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:46982 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728736AbfB0AJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 19:09:50 -0500
Received: by mail-ua1-f66.google.com with SMTP id j8so13641630uae.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 16:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ds0WqW8zu42b+RQJaaWHjZ1tefZnYdq98gy323FUHsk=;
        b=az/Vs4op/y4ME89TBe6RS2WAr04BVnCCONZoLG2ITlsHi+EwWrfGg5um6b1Tya1PcL
         BBVJzTaM2cs523ujbIkl5TBECtsWTnPBF1C41coCWx51OPqWMgNGqZCRsLEuT0UKAuuj
         BwjnozYT4GJGWJDe6HPKig0dBaI3KovotpaLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ds0WqW8zu42b+RQJaaWHjZ1tefZnYdq98gy323FUHsk=;
        b=LNIg2Ctnuu58N271BdyfP6JCn4QfavrU6S0PIqYraLb/eX3VDhTz8qKlbFeZDic2Dl
         a4XWvpZXKFTA8cwkxHAy48acEfUtSrMHaVWf1PlxI0/ZaDzco5CxX3BTv6PvDPez8XF8
         scGofMBxHlsz3XM2u4atC71eB1ozbkvSM8piOU4iRCuyOV7BhE+ch1rR7tyjQ8migo+v
         7kRhVzxB0e/Of7jVjBv9Czfs+XL7oSkW10lAmrfi6vxms/L66VRYbt+FGc7p+2yx8Ut/
         n5wy/oARa+iZ8FJxHiknjl2wmi2ovIj4VPjLwFGVEKEhN84q1dVWF1RvtcpqmI5egEKf
         EgIQ==
X-Gm-Message-State: AHQUAuY9deO2Da0LCS7xyFuZzvh21ue6a4Blpx73nSKbSNo5ui+ZwzGs
        p1sV5RqbMKw+oZxQXz2UbYkjt+pe3G4=
X-Google-Smtp-Source: AHgI3IZhe+JQwV/HrROa6AqsbdgKPg4/VREQRlLJJyKtKlTJUphPq3nMc0zmDpNDWzQ78z+dBl2dGg==
X-Received: by 2002:a67:d91e:: with SMTP id t30mr283013vsj.27.1551226188151;
        Tue, 26 Feb 2019 16:09:48 -0800 (PST)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id q131sm4750236vkh.37.2019.02.26.16.09.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 16:09:47 -0800 (PST)
Received: by mail-ua1-f45.google.com with SMTP id s15so13671932uap.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 16:09:46 -0800 (PST)
X-Received: by 2002:ab0:645:: with SMTP id f63mr478618uaf.106.1551226186505;
 Tue, 26 Feb 2019 16:09:46 -0800 (PST)
MIME-Version: 1.0
References: <cover.1551213058.git.efremov@ispras.ru>
In-Reply-To: <cover.1551213058.git.efremov@ispras.ru>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 26 Feb 2019 16:09:35 -0800
X-Gmail-Original-Message-ID: <CAGXu5jKzDi42Hazh7JsPQpzH-xdQQTQ+oD06Bb1N6tbYzB3uuA@mail.gmail.com>
Message-ID: <CAGXu5jKzDi42Hazh7JsPQpzH-xdQQTQ+oD06Bb1N6tbYzB3uuA@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] LSM documentation update
To:     Denis Efremov <efremov@ispras.ru>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Eric Paris <eparis@parisplace.org>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 12:49 PM Denis Efremov <efremov@ispras.ru> wrote:
> Recent "New LSM Hooks" discussion has led me to the
> thought that it might be a good idea to slightly
> update the current documentation. The patchset adds
> nothing new to the documentation, only fixes the old
> description of hooks to reflect their current state.
>
> V2 adds the clarification on arguments for some hooks.
> The format of the documentation is also slightly updated
> for better html. However, there are still 10 hooks without
> documentation at all. I think that this should be fixed
> separatedly.
>
> Denis Efremov (11):
>   LSM: fix documentation for sb_copy_data hook
>   LSM: fix documentation for the syslog hook
>   LSM: fix documentation for the socket_post_create hook
>   LSM: fix documentation for the task_setscheduler hook
>   LSM: fix documentation for the socket_getpeersec_dgram hook
>   LSM: fix documentation for the path_chmod hook
>   LSM: fix documentation for the audit_* hooks
>   LSM: fix documentation for the msg_queue_* hooks
>   LSM: fix documentation for the sem_* hooks
>   LSM: fix documentation for the shm_* hooks
>   LSM: lsm_hooks.h: fix documentation format
>
>  include/linux/lsm_hooks.h | 170 ++++++++++++++++++--------------------
>  1 file changed, 81 insertions(+), 89 deletions(-)

Awesome; thanks! This fixes several warnings in "make htmldocs":

./include/linux/lsm_hooks.h:1783: warning: Function parameter or
member 'task_setioprio' not described in 'security_list_options'
./include/linux/lsm_hooks.h:1783: warning: Function parameter or
member 'task_getioprio' not described in 'security_list_options'
./include/linux/lsm_hooks.h:1783: warning: Function parameter or
member 'task_movememory' not described in 'security_list_options'
./include/linux/lsm_hooks.h:1783: warning: Function parameter or
member 'secmark_refcount_inc' not described in 'security_list_options'
./include/linux/lsm_hooks.h:1783: warning: Function parameter or
member 'secmark_refcount_dec' not described in 'security_list_options'

So, for the series:

Acked-by: Kees Cook <keescook@chromium.org>

If you want more work, I do notice the following warnings are still present:

./include/linux/lsm_hooks.h:1775: warning: Function parameter or
member 'quotactl' not described in 'security_list_options'
./include/linux/lsm_hooks.h:1775: warning: Function parameter or
member 'quota_on' not described in 'security_list_options'
./include/linux/lsm_hooks.h:1775: warning: Function parameter or
member 'sb_free_mnt_opts' not described in 'security_list_options'
./include/linux/lsm_hooks.h:1775: warning: Function parameter or
member 'sb_eat_lsm_opts' not described in 'security_list_options'
./include/linux/lsm_hooks.h:1775: warning: Function parameter or
member 'sb_kern_mount' not described in 'security_list_options'
./include/linux/lsm_hooks.h:1775: warning: Function parameter or
member 'sb_show_options' not described in 'security_list_options'
./include/linux/lsm_hooks.h:1775: warning: Function parameter or
member 'sb_add_mnt_opt' not described in 'security_list_options'
./include/linux/lsm_hooks.h:1775: warning: Function parameter or
member 'd_instantiate' not described in 'security_list_options'
./include/linux/lsm_hooks.h:1775: warning: Function parameter or
member 'getprocattr' not described in 'security_list_options'
./include/linux/lsm_hooks.h:1775: warning: Function parameter or
member 'setprocattr' not described in 'security_list_options'

:)

-- 
Kees Cook
