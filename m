Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id OSsLMBV2GVskEwAAmS7hNA
	; Thu, 07 Jun 2018 18:15:29 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1C35D6074D; Thu,  7 Jun 2018 18:15:29 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFN2/GIZ"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0B52D605A2;
	Thu,  7 Jun 2018 18:15:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0B52D605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936213AbeFGSPZ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 14:15:25 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:44722 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934344AbeFGSPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 14:15:23 -0400
Received: by mail-vk0-f65.google.com with SMTP id x4-v6so6638837vkx.11;
        Thu, 07 Jun 2018 11:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xd0H19TQCkAznlpAVOZt9QNgjHLBIV91r7OwPRJhYeE=;
        b=hFN2/GIZPMj27vnx/1hwfHEyDa+Nj2jnWng/jyA53M3Yu/cMeWW1riAMRCTAv0uS5B
         CONmjbnZNN4gREVVUvzmnSXJ5qNGicTH42ZV9xVO4/qQQiTZAgICCeE1I3qtBl5ljdfA
         nqDcgXVQcMmxq6skG2cHq1BnAWwsnYdOodmz+LBG76gMvwMtSuU8E6mXUDpapOBB4+9E
         4fadyI09SQH9B3RTsbJQVc13vyieMSF83DToo2qCBybtWz11fhUSX38NsuKltRJ2G1cM
         3C2HC4VMtAuAAl40tpZ++9RT2S94edqBXPln27u2prF7eei3nDKe/X8KgN90WHR27jAx
         6p+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xd0H19TQCkAznlpAVOZt9QNgjHLBIV91r7OwPRJhYeE=;
        b=pn2ovjxGBGFtjVUQQjFjCWqChNLKcmN1yBvH82jv0lgyB0XDTAH2R+CjZOefaIXWlY
         5MP1s8UWwiVnBcYkwXMs2x+hpzBmWACmAbByT4sdZ34WfFGbFuV+xWdMltIixhUZGlvP
         gOtWp7bUpH6d4zdFpJVFmsBKMX7wEDfWsDND4YU+EMjUWdvdyXVtgfOPay3QukgNCMBh
         DnYe/HEKSoMX18480Uk9TlvS+jslVD45jhyxpqyDIMnX0uvVWuzU11E55Ur0dKilFsUA
         XkkJZoVRhkg0mLa6PUqkiIbZb2kmgGgbVaJpwBOtsOyccAbtJ4rCbdvRYovpeYDeyS+x
         KGtA==
X-Gm-Message-State: APt69E1yJnrV5E1d4F2Dzd+T4VParSqHXXUKXEdLHjU0FDjRitXSi3rc
        T3kyDtM4D7wTSgjap35qDycTY0G6bjE4FDemRgaj0w==
X-Google-Smtp-Source: ADUXVKLp8lKM5dYdFRb4WbepAsU7suvoTZEoczXLg9JsLI0EBG6SpEByTqQktu4xoAVroUGjmLdNCS5BTsQuCfkPhBY=
X-Received: by 2002:a1f:9d12:: with SMTP id g18-v6mr1853234vke.5.1528395321795;
 Thu, 07 Jun 2018 11:15:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:5494:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 11:14:41 -0700 (PDT)
In-Reply-To: <20180606210939.q3vviyc4b2h6gu3c@gofer.mess.org>
References: <cover.1527419762.git.sean@mess.org> <9f2c54d4956f962f44fcda739a824397ddea132c.1527419762.git.sean@mess.org>
 <20180604174730.sctfoklq7klswebp@camel2.lan> <20180605101629.yffyp64o7adg6hu5@gofer.mess.org>
 <04cc36e7-4597-dc57-4ad7-71afcc17244a@iogearbox.net> <20180606210939.q3vviyc4b2h6gu3c@gofer.mess.org>
From: Y Song <ys114321@gmail.com>
Date: Thu, 7 Jun 2018 11:14:41 -0700
Message-ID: <CAH3MdRXE8=dE25Sj3TPDzVh7ytnvCkUDvCDzZkEZe0N84dy-Zw@mail.gmail.com>
Subject: Re: [PATCH] bpf: attach type BPF_LIRC_MODE2 should not depend on CONFIG_BPF_CGROUP
To: Sean Young <sean@mess.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
        Matthias Reichl <hias@horus.com>, linux-media@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Devin Heitmueller <dheitmueller@kernellabs.com>,
        Quentin Monnet <quentin.monnet@netronome.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 6, 2018 at 2:09 PM, Sean Young <sean@mess.org> wrote:
> Compile bpf_prog_{attach,detach,query} even if CONFIG_BPF_CGROUP is not
> set.

It should be CONFIG_CGROUP_BPF here. The same for subject line.
Today, if CONFIG_CGROUP_BPF is not defined. Users will get an -EINVAL
if they try to attach/detach/query.

I am not sure what is the motivation behind this change. Could you explain more?

>
> Signed-off-by: Sean Young <sean@mess.org>
> ---
>  include/linux/bpf-cgroup.h |  31 +++++++++++
>  kernel/bpf/cgroup.c        | 110 +++++++++++++++++++++++++++++++++++++
>  kernel/bpf/syscall.c       | 105 ++---------------------------------
>  3 files changed, 145 insertions(+), 101 deletions(-)
>
> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> index 975fb4cf1bb7..ee67cd35f426 100644
> --- a/include/linux/bpf-cgroup.h
> +++ b/include/linux/bpf-cgroup.h
> @@ -188,12 +188,43 @@ int __cgroup_bpf_check_dev_permission(short dev_type, u32 major, u32 minor,
>                                                                               \
>         __ret;                                                                \
>  })
> +int sockmap_get_from_fd(const union bpf_attr *attr, int type, bool attach);
> +int cgroup_bpf_prog_attach(const union bpf_attr *attr,
> +                          enum bpf_prog_type ptype);
> +int cgroup_bpf_prog_detach(const union bpf_attr *attr,
> +                          enum bpf_prog_type ptype);
> +int cgroup_bpf_prog_query(const union bpf_attr *attr,
> +                         union bpf_attr __user *uattr);
>  #else
>
>  struct cgroup_bpf {};
>  static inline void cgroup_bpf_put(struct cgroup *cgrp) {}
>  static inline int cgroup_bpf_inherit(struct cgroup *cgrp) { return 0; }
>
> +static inline int sockmap_get_from_fd(const union bpf_attr *attr,
> +                                     int type, bool attach)
> +{
> +       return -EINVAL;
> +}
> +
> +static inline int cgroup_bpf_prog_attach(const union bpf_attr *attr,
> +                                        enum bpf_prog_type ptype)
> +{
> +       return -EINVAL;
> +}
> +
> +static inline int cgroup_bpf_prog_detach(const union bpf_attr *attr,
> +                                        enum bpf_prog_type ptype)
> +{
> +       return -EINVAL;
> +}
> +
> +static inline int cgroup_bpf_prog_query(const union bpf_attr *attr,
> +                                       union bpf_attr __user *uattr)
> +{
> +       return -EINVAL;
> +}
> +
>  #define cgroup_bpf_enabled (0)
>  #define BPF_CGROUP_PRE_CONNECT_ENABLED(sk) (0)
>  #define BPF_CGROUP_RUN_PROG_INET_INGRESS(sk,skb) ({ 0; })
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index f7c00bd6f8e4..d6e18f9dc0c4 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -428,6 +428,116 @@ int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
>         return ret;
>  }
>
> +int bpf_prog_attach_check_attach_type(const struct bpf_prog *prog,
> +                                     enum bpf_attach_type attach_type)
> +{
> +       switch (prog->type) {
> +       case BPF_PROG_TYPE_CGROUP_SOCK:
> +       case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
> +               return attach_type == prog->expected_attach_type ? 0 : -EINVAL;
> +       default:
> +               return 0;
> +       }
> +}
> +
> +int sockmap_get_from_fd(const union bpf_attr *attr, int type, bool attach)
> +{
> +       struct bpf_prog *prog = NULL;
> +       int ufd = attr->target_fd;
> +       struct bpf_map *map;
> +       struct fd f;
> +       int err;
> +
> +       f = fdget(ufd);
> +       map = __bpf_map_get(f);
> +       if (IS_ERR(map))
> +               return PTR_ERR(map);
> +
> +       if (attach) {
> +               prog = bpf_prog_get_type(attr->attach_bpf_fd, type);
> +               if (IS_ERR(prog)) {
> +                       fdput(f);
> +                       return PTR_ERR(prog);
> +               }
> +       }
> +
> +       err = sock_map_prog(map, prog, attr->attach_type);
> +       if (err) {
> +               fdput(f);
> +               if (prog)
> +                       bpf_prog_put(prog);
> +               return err;
> +       }
> +
> +       fdput(f);
> +       return 0;
> +}
> +
> +int cgroup_bpf_prog_attach(const union bpf_attr *attr, enum bpf_prog_type ptype)
> +{
> +       struct bpf_prog *prog;
> +       struct cgroup *cgrp;
> +       int ret;
> +
> +       prog = bpf_prog_get_type(attr->attach_bpf_fd, ptype);
> +       if (IS_ERR(prog))
> +               return PTR_ERR(prog);
> +
> +       if (bpf_prog_attach_check_attach_type(prog, attr->attach_type)) {
> +               bpf_prog_put(prog);
> +               return -EINVAL;
> +       }
> +
> +       cgrp = cgroup_get_from_fd(attr->target_fd);
> +       if (IS_ERR(cgrp)) {
> +               bpf_prog_put(prog);
> +               return PTR_ERR(cgrp);
> +       }
> +
> +       ret = cgroup_bpf_attach(cgrp, prog, attr->attach_type,
> +                               attr->attach_flags);
> +       if (ret)
> +               bpf_prog_put(prog);
> +       cgroup_put(cgrp);
> +
> +       return ret;
> +}
> +
> +int cgroup_bpf_prog_detach(const union bpf_attr *attr, enum bpf_prog_type ptype)
> +{
> +       struct bpf_prog *prog;
> +       struct cgroup *cgrp;
> +       int ret;
> +
> +       cgrp = cgroup_get_from_fd(attr->target_fd);
> +       if (IS_ERR(cgrp))
> +               return PTR_ERR(cgrp);
> +
> +       prog = bpf_prog_get_type(attr->attach_bpf_fd, ptype);
> +       if (IS_ERR(prog))
> +               prog = NULL;
> +
> +       ret = cgroup_bpf_detach(cgrp, prog, attr->attach_type, 0);
> +       if (prog)
> +               bpf_prog_put(prog);
> +       cgroup_put(cgrp);
> +       return ret;
> +}
> +
> +int cgroup_bpf_prog_query(const union bpf_attr *attr,
> +                         union bpf_attr __user *uattr)
> +{
> +       struct cgroup *cgrp;
> +       int ret;
> +
> +       cgrp = cgroup_get_from_fd(attr->query.target_fd);
> +       if (IS_ERR(cgrp))
> +               return PTR_ERR(cgrp);
> +       ret = cgroup_bpf_query(cgrp, attr, uattr);
> +       cgroup_put(cgrp);
> +       return ret;
> +}
> +
>  /**
>   * __cgroup_bpf_run_filter_skb() - Run a program for packet filtering
>   * @sk: The socket sending or receiving traffic
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 0fa20624707f..52fa44856623 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1489,65 +1489,14 @@ static int bpf_raw_tracepoint_open(const union bpf_attr *attr)
>         return err;
>  }
>
> -#ifdef CONFIG_CGROUP_BPF
> -
> -static int bpf_prog_attach_check_attach_type(const struct bpf_prog *prog,
> -                                            enum bpf_attach_type attach_type)
> -{
> -       switch (prog->type) {
> -       case BPF_PROG_TYPE_CGROUP_SOCK:
> -       case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
> -               return attach_type == prog->expected_attach_type ? 0 : -EINVAL;
> -       default:
> -               return 0;
> -       }
> -}
> -
>  #define BPF_PROG_ATTACH_LAST_FIELD attach_flags
>
> -static int sockmap_get_from_fd(const union bpf_attr *attr,
> -                              int type, bool attach)
> -{
> -       struct bpf_prog *prog = NULL;
> -       int ufd = attr->target_fd;
> -       struct bpf_map *map;
> -       struct fd f;
> -       int err;
> -
> -       f = fdget(ufd);
> -       map = __bpf_map_get(f);
> -       if (IS_ERR(map))
> -               return PTR_ERR(map);
> -
> -       if (attach) {
> -               prog = bpf_prog_get_type(attr->attach_bpf_fd, type);
> -               if (IS_ERR(prog)) {
> -                       fdput(f);
> -                       return PTR_ERR(prog);
> -               }
> -       }
> -
> -       err = sock_map_prog(map, prog, attr->attach_type);
> -       if (err) {
> -               fdput(f);
> -               if (prog)
> -                       bpf_prog_put(prog);
> -               return err;
> -       }
> -
> -       fdput(f);
> -       return 0;
> -}
> -
>  #define BPF_F_ATTACH_MASK \
>         (BPF_F_ALLOW_OVERRIDE | BPF_F_ALLOW_MULTI)
>
>  static int bpf_prog_attach(const union bpf_attr *attr)
>  {
>         enum bpf_prog_type ptype;
> -       struct bpf_prog *prog;
> -       struct cgroup *cgrp;
> -       int ret;
>
>         if (!capable(CAP_NET_ADMIN))
>                 return -EPERM;
> @@ -1593,28 +1542,7 @@ static int bpf_prog_attach(const union bpf_attr *attr)
>                 return -EINVAL;
>         }
>
> -       prog = bpf_prog_get_type(attr->attach_bpf_fd, ptype);
> -       if (IS_ERR(prog))
> -               return PTR_ERR(prog);
> -
> -       if (bpf_prog_attach_check_attach_type(prog, attr->attach_type)) {
> -               bpf_prog_put(prog);
> -               return -EINVAL;
> -       }
> -
> -       cgrp = cgroup_get_from_fd(attr->target_fd);
> -       if (IS_ERR(cgrp)) {
> -               bpf_prog_put(prog);
> -               return PTR_ERR(cgrp);
> -       }
> -
> -       ret = cgroup_bpf_attach(cgrp, prog, attr->attach_type,
> -                               attr->attach_flags);
> -       if (ret)
> -               bpf_prog_put(prog);
> -       cgroup_put(cgrp);
> -
> -       return ret;
> +       return cgroup_bpf_prog_attach(attr, ptype);
>  }
>
>  #define BPF_PROG_DETACH_LAST_FIELD attach_type
> @@ -1622,9 +1550,6 @@ static int bpf_prog_attach(const union bpf_attr *attr)
>  static int bpf_prog_detach(const union bpf_attr *attr)
>  {
>         enum bpf_prog_type ptype;
> -       struct bpf_prog *prog;
> -       struct cgroup *cgrp;
> -       int ret;
>
>         if (!capable(CAP_NET_ADMIN))
>                 return -EPERM;
> @@ -1667,19 +1592,7 @@ static int bpf_prog_detach(const union bpf_attr *attr)
>                 return -EINVAL;
>         }
>
> -       cgrp = cgroup_get_from_fd(attr->target_fd);
> -       if (IS_ERR(cgrp))
> -               return PTR_ERR(cgrp);
> -
> -       prog = bpf_prog_get_type(attr->attach_bpf_fd, ptype);
> -       if (IS_ERR(prog))
> -               prog = NULL;
> -
> -       ret = cgroup_bpf_detach(cgrp, prog, attr->attach_type, 0);
> -       if (prog)
> -               bpf_prog_put(prog);
> -       cgroup_put(cgrp);
> -       return ret;
> +       return cgroup_bpf_prog_detach(attr, ptype);
>  }
>
>  #define BPF_PROG_QUERY_LAST_FIELD query.prog_cnt
> @@ -1687,9 +1600,6 @@ static int bpf_prog_detach(const union bpf_attr *attr)
>  static int bpf_prog_query(const union bpf_attr *attr,
>                           union bpf_attr __user *uattr)
>  {
> -       struct cgroup *cgrp;
> -       int ret;
> -
>         if (!capable(CAP_NET_ADMIN))
>                 return -EPERM;
>         if (CHECK_ATTR(BPF_PROG_QUERY))
> @@ -1717,14 +1627,9 @@ static int bpf_prog_query(const union bpf_attr *attr,
>         default:
>                 return -EINVAL;
>         }
> -       cgrp = cgroup_get_from_fd(attr->query.target_fd);
> -       if (IS_ERR(cgrp))
> -               return PTR_ERR(cgrp);
> -       ret = cgroup_bpf_query(cgrp, attr, uattr);
> -       cgroup_put(cgrp);
> -       return ret;
> +
> +       return cgroup_bpf_prog_query(attr, uattr);
>  }
> -#endif /* CONFIG_CGROUP_BPF */
>
>  #define BPF_PROG_TEST_RUN_LAST_FIELD test.duration
>
> @@ -2371,7 +2276,6 @@ SYSCALL_DEFINE3(bpf, int, cmd, union bpf_attr __user *, uattr, unsigned int, siz
>         case BPF_OBJ_GET:
>                 err = bpf_obj_get(&attr);
>                 break;
> -#ifdef CONFIG_CGROUP_BPF
>         case BPF_PROG_ATTACH:
>                 err = bpf_prog_attach(&attr);
>                 break;
> @@ -2381,7 +2285,6 @@ SYSCALL_DEFINE3(bpf, int, cmd, union bpf_attr __user *, uattr, unsigned int, siz
>         case BPF_PROG_QUERY:
>                 err = bpf_prog_query(&attr, uattr);
>                 break;
> -#endif
>         case BPF_PROG_TEST_RUN:
>                 err = bpf_prog_test_run(&attr, uattr);
>                 break;
> --
> 2.17.1
>
