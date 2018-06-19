Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D675C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 566DF20836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="2Q/o9vWA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 566DF20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967112AbeFSRq4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 13:46:56 -0400
Received: from mail-lf0-f46.google.com ([209.85.215.46]:32846 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966650AbeFSRqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 13:46:55 -0400
Received: by mail-lf0-f46.google.com with SMTP id y20-v6so824959lfy.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 10:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sdMe0drgRtpCioWKRZdDc4HRisfnQZ03Ti9KNXMG3Y4=;
        b=2Q/o9vWAbsEypiGIjaeUEinJjIcucUrvUDLKl//g1oC8jo3Hlk5pdwKt5pIKCpFxMf
         Pyod9577zY8msFwUwcxZmUaXNlyK35FswwAoj4CfOE9/JP6oVi5kKreDg924Ft4tugIv
         GMp1dw0aJhN4/LgeUKwW7ZFKtfr5HTZosZ2IUhnB+dv9UiaOqr6uvdn3O7sdqGf6yhXx
         kmmIfZ2PpYzR9EVUdaAMFGJrwA0AeK6KfZs+9exASeIMO6X9ZYzgLeWyPT04qqvoj66c
         Gu0o/QdUp7zKIjlFrZz/opKx3koPBjNNdPOpVDzl3bKbh5GNRBYX1XE7RnYjGKSnVHBP
         7kVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sdMe0drgRtpCioWKRZdDc4HRisfnQZ03Ti9KNXMG3Y4=;
        b=EVlRWv1g3MXC+c3foaKgoZYNIbbC8RCoXVpm/bCXAq31w9tbu9igvsyG/eHY15+zE5
         UyWzJgciAZKObUbGhzBGFRLFJthEWbRd8hzeMgTd2YfytyxohZN5HsUenSyzva1f/If3
         C+PdtkwJGHQWbuiutTLIhTsJWtPlCHwF1B78nCFSRjZLq3uyVlqz1IIjVB9Y4MrogAxc
         M+M9ND3iFH1jboT8bnmqU7Czngr+OEzNcsu/+2hPQR4TSFQCAF7KILkcYE5rGvM7jEMz
         L/ufr9Z5ry7d6CDB513rKJcXT/RVPO23lrynP0vV7Brk3pnjMlyYKrHtJZlhW8NWgpzm
         pbqA==
X-Gm-Message-State: APt69E1jkOcCVXYPO2n0+73gNks4tHB5cSEUgzQA9TrTqWon8CBtwCJW
        QQUme4oTwnO6W76BtiH4kSBfLSJJcZ5JRFbNyfkO
X-Google-Smtp-Source: ADUXVKLaMn5Yy0bhqB2uUDSRzPi5Glgc1+VcVQn9oDNKouXKwxxaSee6tEjc0KlKV1VUinLROwkRVGqvru52TfM+2+o=
X-Received: by 2002:a19:a892:: with SMTP id r140-v6mr10566825lfe.39.1529430413806;
 Tue, 19 Jun 2018 10:46:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180612080912.7827-1-peter.enderborg@sony.com> <20180612080912.7827-12-peter.enderborg@sony.com>
In-Reply-To: <20180612080912.7827-12-peter.enderborg@sony.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 19 Jun 2018 13:46:42 -0400
Message-ID: <CAHC9VhQhvDFMrJVazcsiMzbnf1Nfg5CBaBNF_kiws15j-oBdUw@mail.gmail.com>
Subject: Re: [PATCH 11/13] selinux: Cleanup printk logging in netif
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
>  security/selinux/netif.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)

Merged, thanks.

> diff --git a/security/selinux/netif.c b/security/selinux/netif.c
> index ac65f7417413..8c738c189942 100644
> --- a/security/selinux/netif.c
> +++ b/security/selinux/netif.c
> @@ -145,9 +145,8 @@ static int sel_netif_sid_slow(struct net *ns, int ifindex, u32 *sid)
>
>         dev = dev_get_by_index(ns, ifindex);
>         if (unlikely(dev == NULL)) {
> -               printk(KERN_WARNING
> -                      "SELinux: failure in sel_netif_sid_slow(),"
> -                      " invalid network interface (%d)\n", ifindex);
> +               pr_warn("SELinux: failure in %s(), invalid network interface (%d)\n",
> +                       __func__, ifindex);
>                 return -ENOENT;
>         }
>
> @@ -177,10 +176,8 @@ static int sel_netif_sid_slow(struct net *ns, int ifindex, u32 *sid)
>         spin_unlock_bh(&sel_netif_lock);
>         dev_put(dev);
>         if (unlikely(ret)) {
> -               printk(KERN_WARNING
> -                      "SELinux: failure in sel_netif_sid_slow(),"
> -                      " unable to determine network interface label (%d)\n",
> -                      ifindex);
> +               pr_warn("SELinux: failure in %s(), unable to determine network interface label (%d)\n",
> +                       __func__, ifindex);
>                 kfree(new);
>         }
>         return ret;
> --
> 2.15.1
>


-- 
paul moore
www.paul-moore.com
