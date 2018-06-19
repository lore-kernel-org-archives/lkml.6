Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB61C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10F2F20661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Pf4IDyTk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10F2F20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966923AbeFSPtZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:49:25 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33863 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966597AbeFSPtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:49:22 -0400
Received: by mail-lf0-f65.google.com with SMTP id v84-v6so268017lfa.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 08:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PYkioP9HWK9UXany/VJq8BSZNE8uC7ACgeTcxVaxsE8=;
        b=Pf4IDyTkZfrGoC8+IMhKDTdrguzrx6iSe+Trt9fhopmkclT2r3+gdx8DQKZKsPR39U
         V4voMKOrExnROGu0tCXd1Pk9YE2mB3yvOtXwS+kTmHmkX45+LXwhzA/WFWiuwBTdKH1x
         04Gs+IhXBK99/ayhPhlaLJWi0+TF1Ks8Jne6ZZvQt6ey9vKBZQA58IN9sfQH76FD1fQc
         QHRIcxvxLuznJwviEJt3vS9vGWX+XKJcKU9D66XC9k3yx80fRVAoTEuQ4wHsGNcGleTU
         U/X+MjyUIsTAnTEmxI/lymrOOgBB0qYQlVz1Wo4cPP3JQ/JUvSUcdQs3ET4ZljUf1z5o
         BtXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PYkioP9HWK9UXany/VJq8BSZNE8uC7ACgeTcxVaxsE8=;
        b=KY0T0pBA/ZyK0BJ51RLAkfsaxPUX3Ve0uEP38wTIddZAIPSi/mxbx0ymsNZgU7yt+b
         KeGEWd8uqKRbFY0OFZamVzOjIHNr9TRFmNteUKJQ/4rv6znQzjeBQODtcWfm8sII2vXC
         PmRVLDwMQ3OvHk6INaFB+bVv352SOukXTOrq1TlEpBIu2VwMf+qXBEt+Plrx/18RLj/v
         Z823FUx4knfwUGCXMjhDVnWqeltumiXMkQaaaxiQIOWnagNk/9o/VIJLyDGLpf08E1IJ
         GS4CWOnSFZmrcB8tktfHdCkFpJz7KggTZ2ZFownJJmJ5o9px8YsttRn+v6bed3ejjCsB
         QlZQ==
X-Gm-Message-State: APt69E3GmJFVyWwFdtEvYC6LpprUC+Qy4ABW5/10kD5GNbdxI5uHGFCl
        ymPs1OJM1GB7falEMvdN26YCAL3nzqiyBTR+ZjOs0bM=
X-Google-Smtp-Source: ADUXVKIHLcA3DD6w2SsufewEo1RLpjP4zr1J+YUZAEfmY7HqpPcb0QnmOEJ509iQmzEQGrmZjNkqGk1HLs5p9qLmNDY=
X-Received: by 2002:a19:d5c7:: with SMTP id m190-v6mr1056772lfg.12.1529423361355;
 Tue, 19 Jun 2018 08:49:21 -0700 (PDT)
MIME-Version: 1.0
References: <20180612080912.7827-1-peter.enderborg@sony.com> <20180612080912.7827-3-peter.enderborg@sony.com>
In-Reply-To: <20180612080912.7827-3-peter.enderborg@sony.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 19 Jun 2018 11:49:10 -0400
Message-ID: <CAHC9VhQezCR-P_5-RV1dGYcoP40k-eCC4GYqUOANvfggzRmV+A@mail.gmail.com>
Subject: Re: [PATCH 02/13] selinux: Cleanup printk logging in ebitmap
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
>  security/selinux/ss/ebitmap.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)

Merged, thanks.

> diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
> index 5ae8c61b75bf..8f624f80055b 100644
> --- a/security/selinux/ss/ebitmap.c
> +++ b/security/selinux/ss/ebitmap.c
> @@ -362,7 +362,7 @@ int ebitmap_read(struct ebitmap *e, void *fp)
>         count = le32_to_cpu(buf[2]);
>
>         if (mapunit != BITS_PER_U64) {
> -               printk(KERN_ERR "SELinux: ebitmap: map size %u does not "
> +               pr_err("SELinux: ebitmap: map size %u does not "
>                        "match my size %zd (high bit was %d)\n",
>                        mapunit, BITS_PER_U64, e->highbit);
>                 goto bad;
> @@ -383,19 +383,19 @@ int ebitmap_read(struct ebitmap *e, void *fp)
>         for (i = 0; i < count; i++) {
>                 rc = next_entry(&startbit, fp, sizeof(u32));
>                 if (rc < 0) {
> -                       printk(KERN_ERR "SELinux: ebitmap: truncated map\n");
> +                       pr_err("SELinux: ebitmap: truncated map\n");
>                         goto bad;
>                 }
>                 startbit = le32_to_cpu(startbit);
>
>                 if (startbit & (mapunit - 1)) {
> -                       printk(KERN_ERR "SELinux: ebitmap start bit (%d) is "
> +                       pr_err("SELinux: ebitmap start bit (%d) is "
>                                "not a multiple of the map unit size (%u)\n",
>                                startbit, mapunit);
>                         goto bad;
>                 }
>                 if (startbit > e->highbit - mapunit) {
> -                       printk(KERN_ERR "SELinux: ebitmap start bit (%d) is "
> +                       pr_err("SELinux: ebitmap start bit (%d) is "
>                                "beyond the end of the bitmap (%u)\n",
>                                startbit, (e->highbit - mapunit));
>                         goto bad;
> @@ -405,8 +405,7 @@ int ebitmap_read(struct ebitmap *e, void *fp)
>                         struct ebitmap_node *tmp;
>                         tmp = kmem_cache_zalloc(ebitmap_node_cachep, GFP_KERNEL);
>                         if (!tmp) {
> -                               printk(KERN_ERR
> -                                      "SELinux: ebitmap: out of memory\n");
> +                               pr_err("SELinux: ebitmap: out of memory\n");
>                                 rc = -ENOMEM;
>                                 goto bad;
>                         }
> @@ -418,7 +417,7 @@ int ebitmap_read(struct ebitmap *e, void *fp)
>                                 e->node = tmp;
>                         n = tmp;
>                 } else if (startbit <= n->startbit) {
> -                       printk(KERN_ERR "SELinux: ebitmap: start bit %d"
> +                       pr_err("SELinux: ebitmap: start bit %d"
>                                " comes after start bit %d\n",
>                                startbit, n->startbit);
>                         goto bad;
> @@ -426,7 +425,7 @@ int ebitmap_read(struct ebitmap *e, void *fp)
>
>                 rc = next_entry(&map, fp, sizeof(u64));
>                 if (rc < 0) {
> -                       printk(KERN_ERR "SELinux: ebitmap: truncated map\n");
> +                       pr_err("SELinux: ebitmap: truncated map\n");
>                         goto bad;
>                 }
>                 map = le64_to_cpu(map);
> --
> 2.15.1
>


-- 
paul moore
www.paul-moore.com
