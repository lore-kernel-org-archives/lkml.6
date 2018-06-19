Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2D0C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7711B2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="VBHy//SN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7711B2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030216AbeFSQlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:41:15 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:44146 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966551AbeFSQlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:41:14 -0400
Received: by mail-lf0-f67.google.com with SMTP id p23-v6so460757lfh.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 09:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l0GwPvlnUBXG3qjRRxdFWUywqowjLazGdtZW3Ert+DM=;
        b=VBHy//SNhd4PIbRabbJGJvj88VZ0yrhWD8A2NdklA9RqKbus+O7K6+PODAKjRuO8HL
         VwFhZMunficRVkGgAHC0ptf6CUSUw5NPuTugqhp9ReH6TSuqkih+YTAj0pdx8Y684LLP
         Fhc6lMT0oW3/V6fZ0t6rjRwSIK5DhqZl9mwb2TIpuviEVruSz+p1d0AoO1VSPMHhuarW
         NgraUJ49F7FcCcsImKfkMiaFKxuMJtBWORbXpvw3FQAi4RfiBWNqxYiJ5gvV92Ws8DXq
         1tXpcisjQUX0ARVNuiBPl3f+8may8I+xGY7yMHQLXTcco8r8hjtmM46VbvhpFTJSIbzK
         d6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l0GwPvlnUBXG3qjRRxdFWUywqowjLazGdtZW3Ert+DM=;
        b=aCAkbx43VRAVG4K2X+YAzsLyEkc5KK5TQye6elwtvx1+VHUIQiSrXhKln8Q5ol5E2l
         t+bj0uhBUfTZ/JwiTszU4fiMaVo1EI8d+4Z5fC5c2H+gRWeVtFg7iJ3EEjKfoWf68Ao6
         FbciXwJ6MyRzU+XnqP5j1RqVqocf2ZM++72D7dmgJKvQuHNgzO2w1RUPzZJeRYGWyJ4b
         T8fn8tY0ZxUO0xSE+b2zu0h+e1QC+tlp0Oqn/XdHsvOZuFkMClU6s7gtvxYK+D9ptPsO
         BglF1TIWW760cI/4+Em80WYIksQ1xXTlP8rwrGNgI1CgalX7igUQtWSbiGJwATUc+xcH
         AbIg==
X-Gm-Message-State: APt69E0+LwP7DHtRugX4R8kTG99hTSQCSbPMvTGNpKgeiuUQgEwd6rCm
        NVVE4uLfhUYUiNSV7VWH7wUHba/lN22eQntpK9DZ
X-Google-Smtp-Source: ADUXVKLZnjxX/uVEa6tZcZkCP2ndpqEaKAjZUKSU4HHeXEYo8xmeiCfvLBHaFYG2zxWPlWkeaKMyyGX272W+yS2yyX4=
X-Received: by 2002:a19:5c12:: with SMTP id q18-v6mr8976077lfb.145.1529426471913;
 Tue, 19 Jun 2018 09:41:11 -0700 (PDT)
MIME-Version: 1.0
References: <20180612080912.7827-1-peter.enderborg@sony.com> <20180612080912.7827-4-peter.enderborg@sony.com>
In-Reply-To: <20180612080912.7827-4-peter.enderborg@sony.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 19 Jun 2018 12:41:00 -0400
Message-ID: <CAHC9VhTULXGAjbRSeriXm6g=aQbaG6XcfXtROVoJr632yis=Gw@mail.gmail.com>
Subject: Re: [PATCH 03/13] selinux: Cleanup printk logging in policydb
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
> Replace printk with pr_* to avoid checkpatch warnings and
> replace KERN_CONT with 2 longer prints.
>
> Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
> ---
>  security/selinux/ss/policydb.c | 91 +++++++++++++++++++++---------------------
>  1 file changed, 46 insertions(+), 45 deletions(-)

Merged, thank you.  While removing the separate KERN_CONT message
introduces some duplication, I think that's the right thing to do.

> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 6e8c8056d7ad..4e82c5fcd1a1 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -504,7 +504,7 @@ static void hash_eval(struct hashtab *h, const char *hash_name)
>         struct hashtab_info info;
>
>         hashtab_stat(h, &info);
> -       printk(KERN_DEBUG "SELinux: %s:  %d entries and %d/%d buckets used, "
> +       pr_debug("SELinux: %s:  %d entries and %d/%d buckets used, "
>                "longest chain length %d\n", hash_name, h->nel,
>                info.slots_used, h->size, info.max_chain_len);
>  }
> @@ -533,15 +533,17 @@ static int policydb_index(struct policydb *p)
>  {
>         int i, rc;
>
> -       printk(KERN_DEBUG "SELinux:  %d users, %d roles, %d types, %d bools",
> -              p->p_users.nprim, p->p_roles.nprim, p->p_types.nprim, p->p_bools.nprim);
>         if (p->mls_enabled)
> -               printk(KERN_CONT ", %d sens, %d cats", p->p_levels.nprim,
> -                      p->p_cats.nprim);
> -       printk(KERN_CONT "\n");
> +               pr_debug("SELinux:  %d users, %d roles, %d types, %d bools, %d sens, %d cats",
> +                        p->p_users.nprim, p->p_roles.nprim, p->p_types.nprim,
> +                        p->p_bools.nprim, p->p_levels.nprim, p->p_cats.nprim);
> +       else
> +               pr_debug("SELinux:  %d users, %d roles, %d types, %d bools",
> +                        p->p_users.nprim, p->p_roles.nprim, p->p_types.nprim,
> +                        p->p_bools.nprim);
>
> -       printk(KERN_DEBUG "SELinux:  %d classes, %d rules\n",
> -              p->p_classes.nprim, p->te_avtab.nel);
> +       pr_debug("SELinux:  %d classes, %d rules\n",
> +                p->p_classes.nprim, p->te_avtab.nel);
>
>  #ifdef DEBUG_HASHES
>         avtab_hash_eval(&p->te_avtab, "rules");
> @@ -897,7 +899,7 @@ int policydb_load_isids(struct policydb *p, struct sidtab *s)
>
>         rc = sidtab_init(s);
>         if (rc) {
> -               printk(KERN_ERR "SELinux:  out of memory on SID table init\n");
> +               pr_err("SELinux:  out of memory on SID table init\n");
>                 goto out;
>         }
>
> @@ -905,14 +907,14 @@ int policydb_load_isids(struct policydb *p, struct sidtab *s)
>         for (c = head; c; c = c->next) {
>                 rc = -EINVAL;
>                 if (!c->context[0].user) {
> -                       printk(KERN_ERR "SELinux:  SID %s was never defined.\n",
> +                       pr_err("SELinux:  SID %s was never defined.\n",
>                                 c->u.name);
>                         goto out;
>                 }
>
>                 rc = sidtab_insert(s, c->sid[0], &c->context[0]);
>                 if (rc) {
> -                       printk(KERN_ERR "SELinux:  unable to load initial SID %s.\n",
> +                       pr_err("SELinux:  unable to load initial SID %s.\n",
>                                 c->u.name);
>                         goto out;
>                 }
> @@ -1005,13 +1007,13 @@ static int mls_read_range_helper(struct mls_range *r, void *fp)
>         rc = -EINVAL;
>         items = le32_to_cpu(buf[0]);
>         if (items > ARRAY_SIZE(buf)) {
> -               printk(KERN_ERR "SELinux: mls:  range overflow\n");
> +               pr_err("SELinux: mls:  range overflow\n");
>                 goto out;
>         }
>
>         rc = next_entry(buf, fp, sizeof(u32) * items);
>         if (rc) {
> -               printk(KERN_ERR "SELinux: mls:  truncated range\n");
> +               pr_err("SELinux: mls:  truncated range\n");
>                 goto out;
>         }
>
> @@ -1023,19 +1025,19 @@ static int mls_read_range_helper(struct mls_range *r, void *fp)
>
>         rc = ebitmap_read(&r->level[0].cat, fp);
>         if (rc) {
> -               printk(KERN_ERR "SELinux: mls:  error reading low categories\n");
> +               pr_err("SELinux: mls:  error reading low categories\n");
>                 goto out;
>         }
>         if (items > 1) {
>                 rc = ebitmap_read(&r->level[1].cat, fp);
>                 if (rc) {
> -                       printk(KERN_ERR "SELinux: mls:  error reading high categories\n");
> +                       pr_err("SELinux: mls:  error reading high categories\n");
>                         goto bad_high;
>                 }
>         } else {
>                 rc = ebitmap_cpy(&r->level[1].cat, &r->level[0].cat);
>                 if (rc) {
> -                       printk(KERN_ERR "SELinux: mls:  out of memory\n");
> +                       pr_err("SELinux: mls:  out of memory\n");
>                         goto bad_high;
>                 }
>         }
> @@ -1060,7 +1062,7 @@ static int context_read_and_validate(struct context *c,
>
>         rc = next_entry(buf, fp, sizeof buf);
>         if (rc) {
> -               printk(KERN_ERR "SELinux: context truncated\n");
> +               pr_err("SELinux: context truncated\n");
>                 goto out;
>         }
>         c->user = le32_to_cpu(buf[0]);
> @@ -1069,14 +1071,14 @@ static int context_read_and_validate(struct context *c,
>         if (p->policyvers >= POLICYDB_VERSION_MLS) {
>                 rc = mls_read_range_helper(&c->range, fp);
>                 if (rc) {
> -                       printk(KERN_ERR "SELinux: error reading MLS range of context\n");
> +                       pr_err("SELinux: error reading MLS range of context\n");
>                         goto out;
>                 }
>         }
>
>         rc = -EINVAL;
>         if (!policydb_context_isvalid(p, c)) {
> -               printk(KERN_ERR "SELinux:  invalid security context\n");
> +               pr_err("SELinux:  invalid security context\n");
>                 context_destroy(c);
>                 goto out;
>         }
> @@ -1352,7 +1354,8 @@ static int class_read(struct policydb *p, struct hashtab *h, void *fp)
>                 rc = -EINVAL;
>                 cladatum->comdatum = hashtab_search(p->p_commons.table, cladatum->comkey);
>                 if (!cladatum->comdatum) {
> -                       printk(KERN_ERR "SELinux:  unknown common %s\n", cladatum->comkey);
> +                       pr_err("SELinux:  unknown common %s\n",
> +                              cladatum->comkey);
>                         goto bad;
>                 }
>         }
> @@ -1444,7 +1447,7 @@ static int role_read(struct policydb *p, struct hashtab *h, void *fp)
>         if (strcmp(key, OBJECT_R) == 0) {
>                 rc = -EINVAL;
>                 if (role->value != OBJECT_R_VAL) {
> -                       printk(KERN_ERR "SELinux: Role %s has wrong value %d\n",
> +                       pr_err("SELinux: Role %s has wrong value %d\n",
>                                OBJECT_R, role->value);
>                         goto bad;
>                 }
> @@ -1522,14 +1525,14 @@ static int mls_read_level(struct mls_level *lp, void *fp)
>
>         rc = next_entry(buf, fp, sizeof buf);
>         if (rc) {
> -               printk(KERN_ERR "SELinux: mls: truncated level\n");
> +               pr_err("SELinux: mls: truncated level\n");
>                 return rc;
>         }
>         lp->sens = le32_to_cpu(buf[0]);
>
>         rc = ebitmap_read(&lp->cat, fp);
>         if (rc) {
> -               printk(KERN_ERR "SELinux: mls:  error reading level categories\n");
> +               pr_err("SELinux: mls:  error reading level categories\n");
>                 return rc;
>         }
>         return 0;
> @@ -1683,7 +1686,7 @@ static int user_bounds_sanity_check(void *key, void *datum, void *datap)
>                 unsigned long bit;
>
>                 if (++depth == POLICYDB_BOUNDS_MAXDEPTH) {
> -                       printk(KERN_ERR "SELinux: user %s: "
> +                       pr_err("SELinux: user %s: "
>                                "too deep or looped boundary",
>                                (char *) key);
>                         return -EINVAL;
> @@ -1694,8 +1697,7 @@ static int user_bounds_sanity_check(void *key, void *datum, void *datap)
>                         if (ebitmap_get_bit(&upper->roles, bit))
>                                 continue;
>
> -                       printk(KERN_ERR
> -                              "SELinux: boundary violated policy: "
> +                       pr_err("SELinux: boundary violated policy: "
>                                "user=%s role=%s bounds=%s\n",
>                                sym_name(p, SYM_USERS, user->value - 1),
>                                sym_name(p, SYM_ROLES, bit),
> @@ -1720,7 +1722,7 @@ static int role_bounds_sanity_check(void *key, void *datum, void *datap)
>                 unsigned long bit;
>
>                 if (++depth == POLICYDB_BOUNDS_MAXDEPTH) {
> -                       printk(KERN_ERR "SELinux: role %s: "
> +                       pr_err("SELinux: role %s: "
>                                "too deep or looped bounds\n",
>                                (char *) key);
>                         return -EINVAL;
> @@ -1731,8 +1733,7 @@ static int role_bounds_sanity_check(void *key, void *datum, void *datap)
>                         if (ebitmap_get_bit(&upper->types, bit))
>                                 continue;
>
> -                       printk(KERN_ERR
> -                              "SELinux: boundary violated policy: "
> +                       pr_err("SELinux: boundary violated policy: "
>                                "role=%s type=%s bounds=%s\n",
>                                sym_name(p, SYM_ROLES, role->value - 1),
>                                sym_name(p, SYM_TYPES, bit),
> @@ -1754,7 +1755,7 @@ static int type_bounds_sanity_check(void *key, void *datum, void *datap)
>         upper = datum;
>         while (upper->bounds) {
>                 if (++depth == POLICYDB_BOUNDS_MAXDEPTH) {
> -                       printk(KERN_ERR "SELinux: type %s: "
> +                       pr_err("SELinux: type %s: "
>                                "too deep or looped boundary\n",
>                                (char *) key);
>                         return -EINVAL;
> @@ -1765,7 +1766,7 @@ static int type_bounds_sanity_check(void *key, void *datum, void *datap)
>                 BUG_ON(!upper);
>
>                 if (upper->attribute) {
> -                       printk(KERN_ERR "SELinux: type %s: "
> +                       pr_err("SELinux: type %s: "
>                                "bounded by attribute %s",
>                                (char *) key,
>                                sym_name(p, SYM_TYPES, upper->value - 1));
> @@ -1888,7 +1889,7 @@ static int range_read(struct policydb *p, void *fp)
>
>                 rc = -EINVAL;
>                 if (!mls_range_isvalid(p, r)) {
> -                       printk(KERN_WARNING "SELinux:  rangetrans:  invalid range\n");
> +                       pr_warn("SELinux:  rangetrans:  invalid range\n");
>                         goto out;
>                 }
>
> @@ -2023,7 +2024,7 @@ static int genfs_read(struct policydb *p, void *fp)
>                      genfs_p = genfs, genfs = genfs->next) {
>                         rc = -EINVAL;
>                         if (strcmp(newgenfs->fstype, genfs->fstype) == 0) {
> -                               printk(KERN_ERR "SELinux:  dup genfs fstype %s\n",
> +                               pr_err("SELinux:  dup genfs fstype %s\n",
>                                        newgenfs->fstype);
>                                 goto out;
>                         }
> @@ -2073,7 +2074,7 @@ static int genfs_read(struct policydb *p, void *fp)
>                                 if (!strcmp(newc->u.name, c->u.name) &&
>                                     (!c->v.sclass || !newc->v.sclass ||
>                                      newc->v.sclass == c->v.sclass)) {
> -                                       printk(KERN_ERR "SELinux:  dup genfs entry (%s,%s)\n",
> +                                       pr_err("SELinux:  dup genfs entry (%s,%s)\n",
>                                                genfs->fstype, c->u.name);
>                                         goto out;
>                                 }
> @@ -2295,7 +2296,7 @@ int policydb_read(struct policydb *p, void *fp)
>
>         rc = -EINVAL;
>         if (le32_to_cpu(buf[0]) != POLICYDB_MAGIC) {
> -               printk(KERN_ERR "SELinux:  policydb magic number 0x%x does "
> +               pr_err("SELinux:  policydb magic number 0x%x does "
>                        "not match expected magic number 0x%x\n",
>                        le32_to_cpu(buf[0]), POLICYDB_MAGIC);
>                 goto bad;
> @@ -2304,7 +2305,7 @@ int policydb_read(struct policydb *p, void *fp)
>         rc = -EINVAL;
>         len = le32_to_cpu(buf[1]);
>         if (len != strlen(POLICYDB_STRING)) {
> -               printk(KERN_ERR "SELinux:  policydb string length %d does not "
> +               pr_err("SELinux:  policydb string length %d does not "
>                        "match expected length %zu\n",
>                        len, strlen(POLICYDB_STRING));
>                 goto bad;
> @@ -2313,14 +2314,14 @@ int policydb_read(struct policydb *p, void *fp)
>         rc = -ENOMEM;
>         policydb_str = kmalloc(len + 1, GFP_KERNEL);
>         if (!policydb_str) {
> -               printk(KERN_ERR "SELinux:  unable to allocate memory for policydb "
> +               pr_err("SELinux:  unable to allocate memory for policydb "
>                        "string of length %d\n", len);
>                 goto bad;
>         }
>
>         rc = next_entry(policydb_str, fp, len);
>         if (rc) {
> -               printk(KERN_ERR "SELinux:  truncated policydb string identifier\n");
> +               pr_err("SELinux:  truncated policydb string identifier\n");
>                 kfree(policydb_str);
>                 goto bad;
>         }
> @@ -2328,7 +2329,7 @@ int policydb_read(struct policydb *p, void *fp)
>         rc = -EINVAL;
>         policydb_str[len] = '\0';
>         if (strcmp(policydb_str, POLICYDB_STRING)) {
> -               printk(KERN_ERR "SELinux:  policydb string %s does not match "
> +               pr_err("SELinux:  policydb string %s does not match "
>                        "my string %s\n", policydb_str, POLICYDB_STRING);
>                 kfree(policydb_str);
>                 goto bad;
> @@ -2346,7 +2347,7 @@ int policydb_read(struct policydb *p, void *fp)
>         p->policyvers = le32_to_cpu(buf[0]);
>         if (p->policyvers < POLICYDB_VERSION_MIN ||
>             p->policyvers > POLICYDB_VERSION_MAX) {
> -               printk(KERN_ERR "SELinux:  policydb version %d does not match "
> +               pr_err("SELinux:  policydb version %d does not match "
>                        "my version range %d-%d\n",
>                        le32_to_cpu(buf[0]), POLICYDB_VERSION_MIN, POLICYDB_VERSION_MAX);
>                 goto bad;
> @@ -2357,7 +2358,7 @@ int policydb_read(struct policydb *p, void *fp)
>
>                 rc = -EINVAL;
>                 if (p->policyvers < POLICYDB_VERSION_MLS) {
> -                       printk(KERN_ERR "SELinux: security policydb version %d "
> +                       pr_err("SELinux: security policydb version %d "
>                                 "(MLS) not backwards compatible\n",
>                                 p->policyvers);
>                         goto bad;
> @@ -2381,7 +2382,7 @@ int policydb_read(struct policydb *p, void *fp)
>         rc = -EINVAL;
>         info = policydb_lookup_compat(p->policyvers);
>         if (!info) {
> -               printk(KERN_ERR "SELinux:  unable to find policy compat info "
> +               pr_err("SELinux:  unable to find policy compat info "
>                        "for version %d\n", p->policyvers);
>                 goto bad;
>         }
> @@ -2389,7 +2390,7 @@ int policydb_read(struct policydb *p, void *fp)
>         rc = -EINVAL;
>         if (le32_to_cpu(buf[2]) != info->sym_num ||
>                 le32_to_cpu(buf[3]) != info->ocon_num) {
> -               printk(KERN_ERR "SELinux:  policydb table sizes (%d,%d) do "
> +               pr_err("SELinux:  policydb table sizes (%d,%d) do "
>                        "not match mine (%d,%d)\n", le32_to_cpu(buf[2]),
>                         le32_to_cpu(buf[3]),
>                        info->sym_num, info->ocon_num);
> @@ -3417,7 +3418,7 @@ int policydb_write(struct policydb *p, void *fp)
>          * careful if you ever try to remove this restriction
>          */
>         if (p->policyvers < POLICYDB_VERSION_AVTAB) {
> -               printk(KERN_ERR "SELinux: refusing to write policy version %d."
> +               pr_err("SELinux: refusing to write policy version %d."
>                        "  Because it is less than version %d\n", p->policyvers,
>                        POLICYDB_VERSION_AVTAB);
>                 return -EINVAL;
> @@ -3446,7 +3447,7 @@ int policydb_write(struct policydb *p, void *fp)
>         /* Write the version, config, and table sizes. */
>         info = policydb_lookup_compat(p->policyvers);
>         if (!info) {
> -               printk(KERN_ERR "SELinux: compatibility lookup failed for policy "
> +               pr_err("SELinux: compatibility lookup failed for policy "
>                     "version %d", p->policyvers);
>                 return -EINVAL;
>         }
> --
> 2.15.1
>


-- 
paul moore
www.paul-moore.com
