Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E20DC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 099BC20652
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="0tu4ol+X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 099BC20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030301AbeFSRfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 13:35:07 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:46965 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966368AbeFSRfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 13:35:06 -0400
Received: by mail-lf0-f66.google.com with SMTP id u5-v6so698916lff.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 10:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WNXaBMQn6qfeHdJKtptboIB2c1+H4hoNlxVm0MEo0KE=;
        b=0tu4ol+X9wgKwV3C69W5Gmov8h319Og/xMkzvouQUoASXKiL+h7R98etN+yjZD2W+Q
         QflkZ3MeGPcVNAssL+hzZUrqRBv6c4bgsm5/lwUpEntujzPvGzKkm0epKOh3cu9zmrSw
         3ygUlr58TybL5Y1tgTgmzYMgQzpg2LWKu4jCtuvKeOKCxJa2ZjPDBnNEo7dYTa96GkI8
         VgBeS/n+9mJDbfKR9Qos/wKUs/5R/qVoAziy7H6zZEVUoZAq1XSOSba3xhJ99MTV5Jjv
         nfT+GFG7Q+xBZL4M3dg++N3ID3gO48jAlLbmE+KlOhnqHs7xBgTkGIYCgDb8bQOM/uga
         7L0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WNXaBMQn6qfeHdJKtptboIB2c1+H4hoNlxVm0MEo0KE=;
        b=XNGo0nNeqOxKAxwS8DYn95lxLOb9pHvuRFlvmWCDtPIUSJX3L559v+jdQEMqCUD2uK
         qbD/pG4ers9HPTmc8Gn516myxGaqj/2w0JCeYQj7LdkmcAVdOZUDJcS9jxcZ9p2eQPsr
         3SqaGGbQCGSYshDpP/Wi0WbBunIbVr8P3rgLsQJgMXCmassCp/vz27aA0R/bBv21ughs
         zeEtnI5gyXGIY3xaL3OI23r5LfwvNFLaKGkBSKcDCnP5Q3jwBVl1sRHi3mBYkljY9B1E
         5cuHm+NGwsMuEsLHs8ansUT8Dz0/9qsflTswA7qRiWqKCm+9NjEXYNKNZNyKD48S7ppg
         gKoQ==
X-Gm-Message-State: APt69E3h3+FU95C0ZfK9I3Ajy6vVd/gDBLDK6pLwOwBA0+50X/XYLyTy
        amSEyQHrGl7TJDFnsL2We9p5JBJsfaJL9jtaO4ld
X-Google-Smtp-Source: ADUXVKIyUGDQ+HIjKiOceSO8kxpIPntBeZm+vgFlTWlp40Ede/oNhMr7za1MxZ04hZ5X0HLHasjGbR7jNEbBk0Opn78=
X-Received: by 2002:a2e:741:: with SMTP id i1-v6mr11423892ljd.87.1529429704722;
 Tue, 19 Jun 2018 10:35:04 -0700 (PDT)
MIME-Version: 1.0
References: <20180612080912.7827-1-peter.enderborg@sony.com> <20180612080912.7827-9-peter.enderborg@sony.com>
In-Reply-To: <20180612080912.7827-9-peter.enderborg@sony.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 19 Jun 2018 13:34:53 -0400
Message-ID: <CAHC9VhQQ5KQW6Ee+4-NZtJRTC1wNDFPe=ZO7R1t8=-2CTG=pqw@mail.gmail.com>
Subject: Re: [PATCH 08/13] selinux: Cleanup printk logging in netlink
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
>  security/selinux/netlink.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged, thanks.

> diff --git a/security/selinux/netlink.c b/security/selinux/netlink.c
> index 828fb6a4e941..8a8a72507437 100644
> --- a/security/selinux/netlink.c
> +++ b/security/selinux/netlink.c
> @@ -94,7 +94,7 @@ static void selnl_notify(int msgtype, void *data)
>  out_kfree_skb:
>         kfree_skb(skb);
>  oom:
> -       printk(KERN_ERR "SELinux:  OOM in %s\n", __func__);
> +       pr_err("SELinux:  OOM in %s\n", __func__);
>         goto out;
>  }
>
> --
> 2.15.1
>


-- 
paul moore
www.paul-moore.com
