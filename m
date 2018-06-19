Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AF5C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 111C72075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="OKXkuahi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 111C72075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966954AbeFSQo2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:44:28 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:42170 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966514AbeFSQo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:44:26 -0400
Received: by mail-lf0-f66.google.com with SMTP id z207-v6so482903lff.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 09:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jM9B3ylv3CUQ1hDnbqJXVvu6H2shaCXCbTyrYftfLn8=;
        b=OKXkuahi97qOLbFyi8XlL3NKlYseYK1cN9I4PSpSEGxR/n6+zVgROOKvtM62kbiPxu
         sod+cIoASwfavvStjeyMw6ToLSuNmuEGSRo5IVwIGj/TJ/v6z0flnCNaYyhj3+WnAnhE
         oS6szqBpowe/fbSPeNLrG6GarvXVRDNy2xtTMEy7Mth6VReUYg37ydG6DAQcGfiK95Nw
         fWxWPD8A94UQzK/vao/w5lX6kuL1wSf+cY3DwgLDpd/dM23qbkvuG8DTWYLKypNPfalI
         T0blK2ZQFeA2jkQ6z2Z3w9QRuNfuXkoxI/bhnX5VZDc6niBfrN7ZEB+GJg+oG/3URdfS
         x0Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jM9B3ylv3CUQ1hDnbqJXVvu6H2shaCXCbTyrYftfLn8=;
        b=SNvqJqHFZQxTAycEu0OXtG2oVVJ5W8fLaVoIA5ZqcOZUNLocW23k/vNrrn+39KKGtj
         Ub82+bkgf/BX5g6Ys41UULGio9hPGX0nR3dzgeciEQzzjHKGL50yZ29zjTX2HjXA+77u
         WwGCQubexrh18ZFXUzgmMdjY6lzPfxcpr2UzbbaSbGBj1R+rhT9Ch5LoC4PGyfpzwxxj
         3QHyPLrkq2jp6AKlR+nAl+twm5lJVKgYZqaXCBBucjtxMOavWB1x6Xn57MYWiGW20HAm
         qs3Kzkv6WvKa+LzO6xoGdjecYV0m2/H2w9BDSS+i8fXuN3476BqBKnb50807sbnnAZ0z
         L0dA==
X-Gm-Message-State: APt69E0prwKLRsYQGcELd4D111gCMUOwLgcpqDleqTjhyaWk7XsxyOXX
        6zd8XcJFlKXfSL5OJq3SfHTDmMSpZtg0JxGm97Uh
X-Google-Smtp-Source: ADUXVKIu8scTtWAMMgIgEjm8fk4GgGVB+PQGURYJhmHBVC4etOeWiuWfBerSQXetwEhYyyWTpIOctzNsYhj6XiF7ZnI=
X-Received: by 2002:a2e:4d0e:: with SMTP id a14-v6mr12099206ljb.106.1529426664454;
 Tue, 19 Jun 2018 09:44:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180612080912.7827-1-peter.enderborg@sony.com> <20180612080912.7827-5-peter.enderborg@sony.com>
In-Reply-To: <20180612080912.7827-5-peter.enderborg@sony.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 19 Jun 2018 12:44:13 -0400
Message-ID: <CAHC9VhSPHUxnJ84g3urHwTZjvZTEbLKEyhdw_NQauFB9jTy4EQ@mail.gmail.com>
Subject: Re: [PATCH 04/13] selinux: Cleanup printk logging in hooks
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
>  security/selinux/hooks.c | 68 +++++++++++++++++++++++-------------------------
>  1 file changed, 33 insertions(+), 35 deletions(-)

Merged, thank you.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 4cafe6a19167..3ab9687ac4c8 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -531,7 +531,7 @@ static int sb_finish_set_opts(struct super_block *sb)
>                    the first boot of the SELinux kernel before we have
>                    assigned xattr values to the filesystem. */
>                 if (!(root_inode->i_opflags & IOP_XATTR)) {
> -                       printk(KERN_WARNING "SELinux: (dev %s, type %s) has no "
> +                       pr_warn("SELinux: (dev %s, type %s) has no "
>                                "xattr support\n", sb->s_id, sb->s_type->name);
>                         rc = -EOPNOTSUPP;
>                         goto out;
> @@ -540,11 +540,11 @@ static int sb_finish_set_opts(struct super_block *sb)
>                 rc = __vfs_getxattr(root, root_inode, XATTR_NAME_SELINUX, NULL, 0);
>                 if (rc < 0 && rc != -ENODATA) {
>                         if (rc == -EOPNOTSUPP)
> -                               printk(KERN_WARNING "SELinux: (dev %s, type "
> +                               pr_warn("SELinux: (dev %s, type "
>                                        "%s) has no security xattr handler\n",
>                                        sb->s_id, sb->s_type->name);
>                         else
> -                               printk(KERN_WARNING "SELinux: (dev %s, type "
> +                               pr_warn("SELinux: (dev %s, type "
>                                        "%s) getxattr errno %d\n", sb->s_id,
>                                        sb->s_type->name, -rc);
>                         goto out;
> @@ -743,7 +743,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
>                         goto out;
>                 }
>                 rc = -EINVAL;
> -               printk(KERN_WARNING "SELinux: Unable to set superblock options "
> +               pr_warn("SELinux: Unable to set superblock options "
>                         "before the security server is initialized\n");
>                 goto out;
>         }
> @@ -785,7 +785,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
>                                                  mount_options[i], &sid,
>                                                  GFP_KERNEL);
>                 if (rc) {
> -                       printk(KERN_WARNING "SELinux: security_context_str_to_sid"
> +                       pr_warn("SELinux: security_context_str_to_sid"
>                                "(%s) failed for (dev %s, type %s) errno=%d\n",
>                                mount_options[i], sb->s_id, name, rc);
>                         goto out;
> @@ -861,8 +861,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
>                  */
>                 rc = security_fs_use(&selinux_state, sb);
>                 if (rc) {
> -                       printk(KERN_WARNING
> -                               "%s: security_fs_use(%s) returned %d\n",
> +                       pr_warn("%s: security_fs_use(%s) returned %d\n",
>                                         __func__, sb->s_type->name, rc);
>                         goto out;
>                 }
> @@ -948,7 +947,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
>                 if (sbsec->behavior != SECURITY_FS_USE_XATTR &&
>                         sbsec->behavior != SECURITY_FS_USE_NATIVE) {
>                         rc = -EINVAL;
> -                       printk(KERN_WARNING "SELinux: defcontext option is "
> +                       pr_warn("SELinux: defcontext option is "
>                                "invalid for this filesystem type\n");
>                         goto out;
>                 }
> @@ -970,7 +969,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
>         return rc;
>  out_double_mount:
>         rc = -EINVAL;
> -       printk(KERN_WARNING "SELinux: mount invalid.  Same superblock, different "
> +       pr_warn("SELinux: mount invalid.  Same superblock, different "
>                "security settings for (dev %s, type %s)\n", sb->s_id, name);
>         goto out;
>  }
> @@ -999,7 +998,7 @@ static int selinux_cmp_sb_context(const struct super_block *oldsb,
>         }
>         return 0;
>  mismatch:
> -       printk(KERN_WARNING "SELinux: mount invalid.  Same superblock, "
> +       pr_warn("SELinux: mount invalid.  Same superblock, "
>                             "different security settings for (dev %s, "
>                             "type %s)\n", newsb->s_id, newsb->s_type->name);
>         return -EBUSY;
> @@ -1107,7 +1106,7 @@ static int selinux_parse_opts_str(char *options,
>                 case Opt_context:
>                         if (context || defcontext) {
>                                 rc = -EINVAL;
> -                               printk(KERN_WARNING SEL_MOUNT_FAIL_MSG);
> +                               pr_warn(SEL_MOUNT_FAIL_MSG);
>                                 goto out_err;
>                         }
>                         context = match_strdup(&args[0]);
> @@ -1120,7 +1119,7 @@ static int selinux_parse_opts_str(char *options,
>                 case Opt_fscontext:
>                         if (fscontext) {
>                                 rc = -EINVAL;
> -                               printk(KERN_WARNING SEL_MOUNT_FAIL_MSG);
> +                               pr_warn(SEL_MOUNT_FAIL_MSG);
>                                 goto out_err;
>                         }
>                         fscontext = match_strdup(&args[0]);
> @@ -1133,7 +1132,7 @@ static int selinux_parse_opts_str(char *options,
>                 case Opt_rootcontext:
>                         if (rootcontext) {
>                                 rc = -EINVAL;
> -                               printk(KERN_WARNING SEL_MOUNT_FAIL_MSG);
> +                               pr_warn(SEL_MOUNT_FAIL_MSG);
>                                 goto out_err;
>                         }
>                         rootcontext = match_strdup(&args[0]);
> @@ -1146,7 +1145,7 @@ static int selinux_parse_opts_str(char *options,
>                 case Opt_defcontext:
>                         if (context || defcontext) {
>                                 rc = -EINVAL;
> -                               printk(KERN_WARNING SEL_MOUNT_FAIL_MSG);
> +                               pr_warn(SEL_MOUNT_FAIL_MSG);
>                                 goto out_err;
>                         }
>                         defcontext = match_strdup(&args[0]);
> @@ -1159,7 +1158,7 @@ static int selinux_parse_opts_str(char *options,
>                         break;
>                 default:
>                         rc = -EINVAL;
> -                       printk(KERN_WARNING "SELinux:  unknown mount option\n");
> +                       pr_warn("SELinux:  unknown mount option\n");
>                         goto out_err;
>
>                 }
> @@ -1615,7 +1614,7 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
>                 dput(dentry);
>                 if (rc < 0) {
>                         if (rc != -ENODATA) {
> -                               printk(KERN_WARNING "SELinux: %s:  getxattr returned "
> +                               pr_warn("SELinux: %s:  getxattr returned "
>                                        "%d for dev=%s ino=%ld\n", __func__,
>                                        -rc, inode->i_sb->s_id, inode->i_ino);
>                                 kfree(context);
> @@ -1635,11 +1634,11 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
>
>                                 if (rc == -EINVAL) {
>                                         if (printk_ratelimit())
> -                                               printk(KERN_NOTICE "SELinux: inode=%lu on dev=%s was found to have an invalid "
> +                                               pr_notice("SELinux: inode=%lu on dev=%s was found to have an invalid "
>                                                         "context=%s.  This indicates you may need to relabel the inode or the "
>                                                         "filesystem in question.\n", ino, dev, context);
>                                 } else {
> -                                       printk(KERN_WARNING "SELinux: %s:  context_to_sid(%s) "
> +                                       pr_warn("SELinux: %s:  context_to_sid(%s) "
>                                                "returned %d for dev=%s ino=%ld\n",
>                                                __func__, context, -rc, dev, ino);
>                                 }
> @@ -1772,8 +1771,7 @@ static int cred_has_capability(const struct cred *cred,
>                 sclass = initns ? SECCLASS_CAPABILITY2 : SECCLASS_CAP2_USERNS;
>                 break;
>         default:
> -               printk(KERN_ERR
> -                      "SELinux:  out of range capability %d\n", cap);
> +               pr_err("SELinux:  out of range capability %d\n", cap);
>                 BUG();
>                 return -EINVAL;
>         }
> @@ -2016,7 +2014,7 @@ static int may_link(struct inode *dir,
>                 av = DIR__RMDIR;
>                 break;
>         default:
> -               printk(KERN_WARNING "SELinux: %s:  unrecognized kind %d\n",
> +               pr_warn("SELinux: %s:  unrecognized kind %d\n",
>                         __func__, kind);
>                 return 0;
>         }
> @@ -2862,7 +2860,7 @@ static int selinux_sb_remount(struct super_block *sb, void *data)
>                                                  mount_options[i], &sid,
>                                                  GFP_KERNEL);
>                 if (rc) {
> -                       printk(KERN_WARNING "SELinux: security_context_str_to_sid"
> +                       pr_warn("SELinux: security_context_str_to_sid"
>                                "(%s) failed for (dev %s, type %s) errno=%d\n",
>                                mount_options[i], sb->s_id, sb->s_type->name, rc);
>                         goto out_free_opts;
> @@ -2901,7 +2899,7 @@ static int selinux_sb_remount(struct super_block *sb, void *data)
>         free_secdata(secdata);
>         return rc;
>  out_bad_option:
> -       printk(KERN_WARNING "SELinux: unable to change security options "
> +       pr_warn("SELinux: unable to change security options "
>                "during remount (dev %s, type=%s)\n", sb->s_id,
>                sb->s_type->name);
>         goto out_free_opts;
> @@ -3343,7 +3341,7 @@ static void selinux_inode_post_setxattr(struct dentry *dentry, const char *name,
>         rc = security_context_to_sid_force(&selinux_state, value, size,
>                                            &newsid);
>         if (rc) {
> -               printk(KERN_ERR "SELinux:  unable to map context to SID"
> +               pr_err("SELinux:  unable to map context to SID"
>                        "for (%s, %lu), rc=%d\n",
>                        inode->i_sb->s_id, inode->i_ino, -rc);
>                 return;
> @@ -4406,7 +4404,7 @@ static int selinux_parse_skb(struct sk_buff *skb, struct common_audit_data *ad,
>         }
>
>  parse_error:
> -       printk(KERN_WARNING
> +       pr_warn(
>                "SELinux: failure in selinux_parse_skb(),"
>                " unable to parse packet\n");
>         return ret;
> @@ -4449,7 +4447,7 @@ static int selinux_skb_peerlbl_sid(struct sk_buff *skb, u16 family, u32 *sid)
>         err = security_net_peersid_resolve(&selinux_state, nlbl_sid,
>                                            nlbl_type, xfrm_sid, sid);
>         if (unlikely(err)) {
> -               printk(KERN_WARNING
> +               pr_warn(
>                        "SELinux: failure in selinux_skb_peerlbl_sid(),"
>                        " unable to determine packet's peer label\n");
>                 return -EACCES;
> @@ -7091,11 +7089,11 @@ static __init int selinux_init(void)
>         }
>
>         if (!selinux_enabled) {
> -               printk(KERN_INFO "SELinux:  Disabled at boot.\n");
> +               pr_info("SELinux:  Disabled at boot.\n");
>                 return 0;
>         }
>
> -       printk(KERN_INFO "SELinux:  Initializing.\n");
> +       pr_info("SELinux:  Initializing.\n");
>
>         memset(&selinux_state, 0, sizeof(selinux_state));
>         enforcing_set(&selinux_state, selinux_enforcing_boot);
> @@ -7131,9 +7129,9 @@ static __init int selinux_init(void)
>                 panic("SELinux: Unable to register AVC LSM notifier callback\n");
>
>         if (selinux_enforcing_boot)
> -               printk(KERN_DEBUG "SELinux:  Starting in enforcing mode\n");
> +               pr_debug("SELinux:  Starting in enforcing mode\n");
>         else
> -               printk(KERN_DEBUG "SELinux:  Starting in permissive mode\n");
> +               pr_debug("SELinux:  Starting in permissive mode\n");
>
>         return 0;
>  }
> @@ -7145,10 +7143,10 @@ static void delayed_superblock_init(struct super_block *sb, void *unused)
>
>  void selinux_complete_init(void)
>  {
> -       printk(KERN_DEBUG "SELinux:  Completing initialization.\n");
> +       pr_debug("SELinux:  Completing initialization.\n");
>
>         /* Set up any superblocks initialized prior to the policy load. */
> -       printk(KERN_DEBUG "SELinux:  Setting up existing superblocks.\n");
> +       pr_debug("SELinux:  Setting up existing superblocks.\n");
>         iterate_supers(delayed_superblock_init, NULL);
>  }
>
> @@ -7223,7 +7221,7 @@ static int __init selinux_nf_ip_init(void)
>         if (!selinux_enabled)
>                 return 0;
>
> -       printk(KERN_DEBUG "SELinux:  Registering netfilter hooks\n");
> +       pr_debug("SELinux:  Registering netfilter hooks\n");
>
>         err = register_pernet_subsys(&selinux_net_ops);
>         if (err)
> @@ -7236,7 +7234,7 @@ __initcall(selinux_nf_ip_init);
>  #ifdef CONFIG_SECURITY_SELINUX_DISABLE
>  static void selinux_nf_ip_exit(void)
>  {
> -       printk(KERN_DEBUG "SELinux:  Unregistering netfilter hooks\n");
> +       pr_debug("SELinux:  Unregistering netfilter hooks\n");
>
>         unregister_pernet_subsys(&selinux_net_ops);
>  }
> @@ -7265,7 +7263,7 @@ int selinux_disable(struct selinux_state *state)
>
>         state->disabled = 1;
>
> -       printk(KERN_INFO "SELinux:  Disabled at runtime.\n");
> +       pr_info("SELinux:  Disabled at runtime.\n");
>
>         selinux_enabled = 0;
>
> --
> 2.15.1
>


-- 
paul moore
www.paul-moore.com
