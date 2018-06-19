Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49AEC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 875B22083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="mFGLBY2F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 875B22083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030282AbeFSRDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 13:03:36 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:43989 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966449AbeFSRDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 13:03:30 -0400
Received: by mail-lf0-f66.google.com with SMTP id x13-v6so562879lff.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 10:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9p3o9s3onXhDmRXd24tzo87bzE4P0QuQR/4h0T0p/KI=;
        b=mFGLBY2FdTHSrQhiFcuvNLN99FnGRJKAEkkJ6n67fbS4OQB2T8W0IuvRa4cLjidiWo
         0DWesAD5/kS0gy088oM9JTv1lmhInwzTcjAme+kCp0n1D7U5BNenwOD+vABrHcdWJKEO
         2otHsryW7B9LsuoA6vH3loB5tep9kMmKDQkTo2hvoOrBbG1LPW59Lo7516jhMD8AIxZm
         MSh5KnayEpP1oE0uP5eltnZdk0gSCZDxC/tbtM+9BgQMhx5nQrrzh6gRoaYHneh1vPPk
         Dd0KxszZ9Epq0rjvoX4LG3RNXdygdrQvD/zg1aS3TZ2/MfWIMe63MZdDjTKBtSY5o8ED
         Qzjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9p3o9s3onXhDmRXd24tzo87bzE4P0QuQR/4h0T0p/KI=;
        b=ttlnGP2msZ+iHov2AT4Fqgc1DN+jMizRJ7Y464s0jjJMt6Rp1nLO1x3sq/hi9VCmGV
         uBd5lafiDt8+R+bhOOjZZ2g3uSxdqOEZ938ngsnIfv8ZwEv+HdMaHk0ZdI5rWNIFi4Yi
         r+5jaBKEQJs91sbU/Fj2HqdmgNhXhkZ1kLBJ0wO/SmIb9a0IkAlCSVs9TPlijCxjFP3N
         tXDk8aXNxAWQeA7uX93W8P876exIvoDeX3qM7rPoPMfvHzhxBEtdgFZVNHbXu/oNyb4Q
         anJq9eBBpQkDWCk6yFv685ATo2ikIqb3jQwHnC/1I4KAaIzM4Iq3B32wFxgj+JBjQWP+
         Rgpw==
X-Gm-Message-State: APt69E0/U6vRp5iyH90jJ4hDkyXAK2/yZgvmgjt9Ccq202eIyMLNHGN5
        sV1EMeHXZ86+Wv8N5drQ+X687NwMJeQkPWUrJfGS
X-Google-Smtp-Source: ADUXVKLiZ6Z3QwmqUu5yzkN8Q6QeykcErT5W1W6CIT90yu90MVZqx6E+7f1YMTyVS6BegtI0loeJfeb0HZaaQu2jGnU=
X-Received: by 2002:a2e:4d0e:: with SMTP id a14-v6mr12141128ljb.106.1529427809021;
 Tue, 19 Jun 2018 10:03:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180612080912.7827-1-peter.enderborg@sony.com> <20180612080912.7827-6-peter.enderborg@sony.com>
In-Reply-To: <20180612080912.7827-6-peter.enderborg@sony.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 19 Jun 2018 13:03:18 -0400
Message-ID: <CAHC9VhT+NNUf2dxkz1DxG21Ydz7ygAA2S1b7WfvDUD25EgybuA@mail.gmail.com>
Subject: Re: [PATCH 05/13] selinux: Cleanup printk logging in avtab
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
>  security/selinux/ss/avtab.c | 51 +++++++++++++++++++++++----------------------
>  1 file changed, 26 insertions(+), 25 deletions(-)

Merged, thanks.

> diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
> index a2c9148b0662..c0417cf17fee 100644
> --- a/security/selinux/ss/avtab.c
> +++ b/security/selinux/ss/avtab.c
> @@ -338,7 +338,7 @@ int avtab_alloc(struct avtab *h, u32 nrules)
>         h->nel = 0;
>         h->nslot = nslot;
>         h->mask = mask;
> -       printk(KERN_DEBUG "SELinux: %d avtab hash slots, %d rules.\n",
> +       pr_debug("SELinux: %d avtab hash slots, %d rules.\n",
>                h->nslot, nrules);
>         return 0;
>  }
> @@ -368,7 +368,7 @@ void avtab_hash_eval(struct avtab *h, char *tag)
>                 }
>         }
>
> -       printk(KERN_DEBUG "SELinux: %s:  %d entries and %d/%d buckets used, "
> +       pr_debug("SELinux: %s:  %d entries and %d/%d buckets used, "
>                "longest chain length %d sum of chain length^2 %llu\n",
>                tag, h->nel, slots_used, h->nslot, max_chain_len,
>                chain2_len_sum);
> @@ -407,18 +407,18 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
>         if (vers < POLICYDB_VERSION_AVTAB) {
>                 rc = next_entry(buf32, fp, sizeof(u32));
>                 if (rc) {
> -                       printk(KERN_ERR "SELinux: avtab: truncated entry\n");
> +                       pr_err("SELinux: avtab: truncated entry\n");
>                         return rc;
>                 }
>                 items2 = le32_to_cpu(buf32[0]);
>                 if (items2 > ARRAY_SIZE(buf32)) {
> -                       printk(KERN_ERR "SELinux: avtab: entry overflow\n");
> +                       pr_err("SELinux: avtab: entry overflow\n");
>                         return -EINVAL;
>
>                 }
>                 rc = next_entry(buf32, fp, sizeof(u32)*items2);
>                 if (rc) {
> -                       printk(KERN_ERR "SELinux: avtab: truncated entry\n");
> +                       pr_err("SELinux: avtab: truncated entry\n");
>                         return rc;
>                 }
>                 items = 0;
> @@ -426,19 +426,19 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
>                 val = le32_to_cpu(buf32[items++]);
>                 key.source_type = (u16)val;
>                 if (key.source_type != val) {
> -                       printk(KERN_ERR "SELinux: avtab: truncated source type\n");
> +                       pr_err("SELinux: avtab: truncated source type\n");
>                         return -EINVAL;
>                 }
>                 val = le32_to_cpu(buf32[items++]);
>                 key.target_type = (u16)val;
>                 if (key.target_type != val) {
> -                       printk(KERN_ERR "SELinux: avtab: truncated target type\n");
> +                       pr_err("SELinux: avtab: truncated target type\n");
>                         return -EINVAL;
>                 }
>                 val = le32_to_cpu(buf32[items++]);
>                 key.target_class = (u16)val;
>                 if (key.target_class != val) {
> -                       printk(KERN_ERR "SELinux: avtab: truncated target class\n");
> +                       pr_err("SELinux: avtab: truncated target class\n");
>                         return -EINVAL;
>                 }
>
> @@ -446,16 +446,16 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
>                 enabled = (val & AVTAB_ENABLED_OLD) ? AVTAB_ENABLED : 0;
>
>                 if (!(val & (AVTAB_AV | AVTAB_TYPE))) {
> -                       printk(KERN_ERR "SELinux: avtab: null entry\n");
> +                       pr_err("SELinux: avtab: null entry\n");
>                         return -EINVAL;
>                 }
>                 if ((val & AVTAB_AV) &&
>                     (val & AVTAB_TYPE)) {
> -                       printk(KERN_ERR "SELinux: avtab: entry has both access vectors and types\n");
> +                       pr_err("SELinux: avtab: entry has both access vectors and types\n");
>                         return -EINVAL;
>                 }
>                 if (val & AVTAB_XPERMS) {
> -                       printk(KERN_ERR "SELinux: avtab: entry has extended permissions\n");
> +                       pr_err("SELinux: avtab: entry has extended permissions\n");
>                         return -EINVAL;
>                 }
>
> @@ -470,7 +470,8 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
>                 }
>
>                 if (items != items2) {
> -                       printk(KERN_ERR "SELinux: avtab: entry only had %d items, expected %d\n", items2, items);
> +                       pr_err("SELinux: avtab: entry only had %d items, expected %d\n",
> +                              items2, items);
>                         return -EINVAL;
>                 }
>                 return 0;
> @@ -478,7 +479,7 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
>
>         rc = next_entry(buf16, fp, sizeof(u16)*4);
>         if (rc) {
> -               printk(KERN_ERR "SELinux: avtab: truncated entry\n");
> +               pr_err("SELinux: avtab: truncated entry\n");
>                 return rc;
>         }
>
> @@ -491,7 +492,7 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
>         if (!policydb_type_isvalid(pol, key.source_type) ||
>             !policydb_type_isvalid(pol, key.target_type) ||
>             !policydb_class_isvalid(pol, key.target_class)) {
> -               printk(KERN_ERR "SELinux: avtab: invalid type or class\n");
> +               pr_err("SELinux: avtab: invalid type or class\n");
>                 return -EINVAL;
>         }
>
> @@ -501,13 +502,13 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
>                         set++;
>         }
>         if (!set || set > 1) {
> -               printk(KERN_ERR "SELinux:  avtab:  more than one specifier\n");
> +               pr_err("SELinux:  avtab:  more than one specifier\n");
>                 return -EINVAL;
>         }
>
>         if ((vers < POLICYDB_VERSION_XPERMS_IOCTL) &&
>                         (key.specified & AVTAB_XPERMS)) {
> -               printk(KERN_ERR "SELinux:  avtab:  policy version %u does not "
> +               pr_err("SELinux:  avtab:  policy version %u does not "
>                                 "support extended permissions rules and one "
>                                 "was specified\n", vers);
>                 return -EINVAL;
> @@ -515,17 +516,17 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
>                 memset(&xperms, 0, sizeof(struct avtab_extended_perms));
>                 rc = next_entry(&xperms.specified, fp, sizeof(u8));
>                 if (rc) {
> -                       printk(KERN_ERR "SELinux: avtab: truncated entry\n");
> +                       pr_err("SELinux: avtab: truncated entry\n");
>                         return rc;
>                 }
>                 rc = next_entry(&xperms.driver, fp, sizeof(u8));
>                 if (rc) {
> -                       printk(KERN_ERR "SELinux: avtab: truncated entry\n");
> +                       pr_err("SELinux: avtab: truncated entry\n");
>                         return rc;
>                 }
>                 rc = next_entry(buf32, fp, sizeof(u32)*ARRAY_SIZE(xperms.perms.p));
>                 if (rc) {
> -                       printk(KERN_ERR "SELinux: avtab: truncated entry\n");
> +                       pr_err("SELinux: avtab: truncated entry\n");
>                         return rc;
>                 }
>                 for (i = 0; i < ARRAY_SIZE(xperms.perms.p); i++)
> @@ -534,14 +535,14 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
>         } else {
>                 rc = next_entry(buf32, fp, sizeof(u32));
>                 if (rc) {
> -                       printk(KERN_ERR "SELinux: avtab: truncated entry\n");
> +                       pr_err("SELinux: avtab: truncated entry\n");
>                         return rc;
>                 }
>                 datum.u.data = le32_to_cpu(*buf32);
>         }
>         if ((key.specified & AVTAB_TYPE) &&
>             !policydb_type_isvalid(pol, datum.u.data)) {
> -               printk(KERN_ERR "SELinux: avtab: invalid type\n");
> +               pr_err("SELinux: avtab: invalid type\n");
>                 return -EINVAL;
>         }
>         return insertf(a, &key, &datum, p);
> @@ -562,12 +563,12 @@ int avtab_read(struct avtab *a, void *fp, struct policydb *pol)
>
>         rc = next_entry(buf, fp, sizeof(u32));
>         if (rc < 0) {
> -               printk(KERN_ERR "SELinux: avtab: truncated table\n");
> +               pr_err("SELinux: avtab: truncated table\n");
>                 goto bad;
>         }
>         nel = le32_to_cpu(buf[0]);
>         if (!nel) {
> -               printk(KERN_ERR "SELinux: avtab: table is empty\n");
> +               pr_err("SELinux: avtab: table is empty\n");
>                 rc = -EINVAL;
>                 goto bad;
>         }
> @@ -580,9 +581,9 @@ int avtab_read(struct avtab *a, void *fp, struct policydb *pol)
>                 rc = avtab_read_item(a, fp, pol, avtab_insertf, NULL);
>                 if (rc) {
>                         if (rc == -ENOMEM)
> -                               printk(KERN_ERR "SELinux: avtab: out of memory\n");
> +                               pr_err("SELinux: avtab: out of memory\n");
>                         else if (rc == -EEXIST)
> -                               printk(KERN_ERR "SELinux: avtab: duplicate entry\n");
> +                               pr_err("SELinux: avtab: duplicate entry\n");
>
>                         goto bad;
>                 }
> --
> 2.15.1
>


-- 
paul moore
www.paul-moore.com
