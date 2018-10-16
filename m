Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287A8C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDD1C208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p9oVgXYr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDD1C208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbeJQAOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 20:14:00 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46927 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbeJQAOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 20:14:00 -0400
Received: by mail-pf1-f194.google.com with SMTP id r64-v6so11693806pfb.13;
        Tue, 16 Oct 2018 09:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4+Am3Woz+OQpAeezaC3qB91PSXKIiVFf3LTIQ7YASpw=;
        b=p9oVgXYro32tqjGkd8ZMlAr4pDItWQ4VE0U3NRf02GQqnl1q7CjPaMmXPwXg+mNZxg
         HvlU6siDn42XfPLBbaP4tkWMjzBOxMagqSaAy4xO4yFVTiogG5tWdFLQzHuJsECW6TEk
         SC0KxWHopq4ids+uXyjzYQb83pKOzq91rbr/5OJdih7pJvSQA3jcKewpjz7qznj1vudh
         vWA6VN3wDzG7qwRPuoXnIlfLZ16VRHAz5JPs3tTlLDi8ef8Cjsp9Cs4E8ceWsUytDX+B
         ZN089t5zfb51EMpW9CSjfDnrGxAGfT45HT/hagvVWvBnCgsDSFdQ0w+IoDIcs20dMVgN
         pitg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4+Am3Woz+OQpAeezaC3qB91PSXKIiVFf3LTIQ7YASpw=;
        b=uEDKoQzIBqCCHo/NGQ/LANQLFcF01pBnV9yepCmyFJlTr2h94883CDjuGBk3mmILwi
         w62j9m/4OQqwxA4qpEwZajxIgSqs1YfvdYPyak2NoD6w7L8P0zRcHCyHWo7gREK2Dqvv
         5GyjJ7GZ2Jupviqn3qGVyJ0k1M43A5yzkBDw4YgUO1zjJeJEdUTaHqVhrnpWxUYX0hrj
         K2G0XdD9W0qCBgPJbweB2KjLpCoWY06G5JNp1jwd/lth+JLW8MBfqbUvdaoD1DWuSp2T
         UtesqxWuEn0J3+j9wCZONf6k/elZWzd0Go3yJdvMjjDmi66AnnPNrvUVaIfJ2s/2jYp9
         rpbA==
X-Gm-Message-State: ABuFfohdHH1ipFWV9HHG2a7svZBmVSae7pO9zK7GjNWi105zcjv0iCZQ
        lzTHPrslF+uZ4aKawgOMuPQ=
X-Google-Smtp-Source: ACcGV63JSugbmsOcPqSgvVS8OAgLaCZY5kTgdbXQjyZvPIipIQAI4ZCiHtE/mttc+r1frcKBuXYfKg==
X-Received: by 2002:a63:de05:: with SMTP id f5-v6mr20589240pgg.292.1539706968843;
        Tue, 16 Oct 2018 09:22:48 -0700 (PDT)
Received: from gmail.com ([2620:0:1008:fd00:78b4:3a07:980a:287b])
        by smtp.gmail.com with ESMTPSA id h88-v6sm35292927pfa.184.2018.10.16.09.22.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 09:22:48 -0700 (PDT)
Date:   Tue, 16 Oct 2018 09:22:46 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Laurent Vivier <laurent@vivier.eu>
Cc:     linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        containers@lists.linux-foundation.org,
        Dmitry Safonov <dima@arista.com>
Subject: Re: [PATCH v6 1/1] ns: add binfmt_misc to the user namespace
Message-ID: <20181016162245.GA7697@gmail.com>
References: <20181010161430.11633-1-laurent@vivier.eu>
 <20181010161430.11633-2-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20181010161430.11633-2-laurent@vivier.eu>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 06:14:30PM +0200, Laurent Vivier wrote:
> This patch allows to have a different binfmt_misc configuration
> for each new user namespace. By default, the binfmt_misc configuration
> is the one of the previous level, but if the binfmt_misc filesystem is
> mounted in the new namespace a new empty binfmt instance is created and
> used in this namespace.
> 
> For instance, using "unshare" we can start a chroot of another
> architecture and configure the binfmt_misc interpreter without being root
> to run the binaries in this chroot.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

Acked-by: Andrei Vagin <avagin@gmail.com>

Thanks,
Andrei

> ---
>  fs/binfmt_misc.c               | 111 ++++++++++++++++++++++++---------
>  include/linux/user_namespace.h |  15 +++++
>  kernel/user.c                  |  14 +++++
>  kernel/user_namespace.c        |   3 +
>  4 files changed, 115 insertions(+), 28 deletions(-)
> 
> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> index aa4a7a23ff99..df9dc3248b7b 100644
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -38,9 +38,6 @@ enum {
>  	VERBOSE_STATUS = 1 /* make it zero to save 400 bytes kernel memory */
>  };
>  
> -static LIST_HEAD(entries);
> -static int enabled = 1;
> -
>  enum {Enabled, Magic};
>  #define MISC_FMT_PRESERVE_ARGV0 (1 << 31)
>  #define MISC_FMT_OPEN_BINARY (1 << 30)
> @@ -60,10 +57,7 @@ typedef struct {
>  	struct file *interp_file;
>  } Node;
>  
> -static DEFINE_RWLOCK(entries_lock);
>  static struct file_system_type bm_fs_type;
> -static struct vfsmount *bm_mnt;
> -static int entry_count;
>  
>  /*
>   * Max length of the register string.  Determined by:
> @@ -80,18 +74,37 @@ static int entry_count;
>   */
>  #define MAX_REGISTER_LENGTH 1920
>  
> +static struct binfmt_namespace *binfmt_ns(struct user_namespace *ns)
> +{
> +	struct binfmt_namespace *b_ns;
> +
> +	while (ns) {
> +		b_ns = READ_ONCE(ns->binfmt_ns);
> +		if (b_ns)
> +			return b_ns;
> +		ns = ns->parent;
> +	}
> +	/* as the first user namespace is initialized with
> +	 * &init_binfmt_ns we should never come here
> +	 * but we try to stay safe by logging a warning
> +	 * and returning a sane value
> +	 */
> +	WARN_ON_ONCE(1);
> +	return &init_binfmt_ns;
> +}
> +
>  /*
>   * Check if we support the binfmt
>   * if we do, return the node, else NULL
>   * locking is done in load_misc_binary
>   */
> -static Node *check_file(struct linux_binprm *bprm)
> +static Node *check_file(struct binfmt_namespace *ns, struct linux_binprm *bprm)
>  {
>  	char *p = strrchr(bprm->interp, '.');
>  	struct list_head *l;
>  
>  	/* Walk all the registered handlers. */
> -	list_for_each(l, &entries) {
> +	list_for_each(l, &ns->entries) {
>  		Node *e = list_entry(l, Node, list);
>  		char *s;
>  		int j;
> @@ -133,17 +146,18 @@ static int load_misc_binary(struct linux_binprm *bprm)
>  	struct file *interp_file = NULL;
>  	int retval;
>  	int fd_binary = -1;
> +	struct binfmt_namespace *ns = binfmt_ns(current_user_ns());
>  
>  	retval = -ENOEXEC;
> -	if (!enabled)
> +	if (!ns->enabled)
>  		return retval;
>  
>  	/* to keep locking time low, we copy the interpreter string */
> -	read_lock(&entries_lock);
> -	fmt = check_file(bprm);
> +	read_lock(&ns->entries_lock);
> +	fmt = check_file(ns, bprm);
>  	if (fmt)
>  		dget(fmt->dentry);
> -	read_unlock(&entries_lock);
> +	read_unlock(&ns->entries_lock);
>  	if (!fmt)
>  		return retval;
>  
> @@ -609,19 +623,19 @@ static void bm_evict_inode(struct inode *inode)
>  	kfree(e);
>  }
>  
> -static void kill_node(Node *e)
> +static void kill_node(struct binfmt_namespace *ns, Node *e)
>  {
>  	struct dentry *dentry;
>  
> -	write_lock(&entries_lock);
> +	write_lock(&ns->entries_lock);
>  	list_del_init(&e->list);
> -	write_unlock(&entries_lock);
> +	write_unlock(&ns->entries_lock);
>  
>  	dentry = e->dentry;
>  	drop_nlink(d_inode(dentry));
>  	d_drop(dentry);
>  	dput(dentry);
> -	simple_release_fs(&bm_mnt, &entry_count);
> +	simple_release_fs(&ns->bm_mnt, &ns->entry_count);
>  }
>  
>  /* /<entry> */
> @@ -651,6 +665,9 @@ static ssize_t bm_entry_write(struct file *file, const char __user *buffer,
>  	struct dentry *root;
>  	Node *e = file_inode(file)->i_private;
>  	int res = parse_command(buffer, count);
> +	struct binfmt_namespace *ns;
> +
> +	ns = binfmt_ns(file->f_path.dentry->d_sb->s_user_ns);
>  
>  	switch (res) {
>  	case 1:
> @@ -667,7 +684,7 @@ static ssize_t bm_entry_write(struct file *file, const char __user *buffer,
>  		inode_lock(d_inode(root));
>  
>  		if (!list_empty(&e->list))
> -			kill_node(e);
> +			kill_node(ns, e);
>  
>  		inode_unlock(d_inode(root));
>  		break;
> @@ -693,6 +710,7 @@ static ssize_t bm_register_write(struct file *file, const char __user *buffer,
>  	struct inode *inode;
>  	struct super_block *sb = file_inode(file)->i_sb;
>  	struct dentry *root = sb->s_root, *dentry;
> +	struct binfmt_namespace *ns;
>  	int err = 0;
>  
>  	e = create_entry(buffer, count);
> @@ -716,7 +734,9 @@ static ssize_t bm_register_write(struct file *file, const char __user *buffer,
>  	if (!inode)
>  		goto out2;
>  
> -	err = simple_pin_fs(&bm_fs_type, &bm_mnt, &entry_count);
> +	ns = binfmt_ns(file->f_path.dentry->d_sb->s_user_ns);
> +	err = simple_pin_fs(&bm_fs_type, &ns->bm_mnt,
> +			    &ns->entry_count);
>  	if (err) {
>  		iput(inode);
>  		inode = NULL;
> @@ -725,12 +745,16 @@ static ssize_t bm_register_write(struct file *file, const char __user *buffer,
>  
>  	if (e->flags & MISC_FMT_OPEN_FILE) {
>  		struct file *f;
> +		const struct cred *old_cred;
>  
> +		old_cred = override_creds(file->f_cred);
>  		f = open_exec(e->interpreter);
> +		revert_creds(old_cred);
>  		if (IS_ERR(f)) {
>  			err = PTR_ERR(f);
>  			pr_notice("register: failed to install interpreter file %s\n", e->interpreter);
> -			simple_release_fs(&bm_mnt, &entry_count);
> +			simple_release_fs(&ns->bm_mnt,
> +					  &ns->entry_count);
>  			iput(inode);
>  			inode = NULL;
>  			goto out2;
> @@ -743,9 +767,9 @@ static ssize_t bm_register_write(struct file *file, const char __user *buffer,
>  	inode->i_fop = &bm_entry_operations;
>  
>  	d_instantiate(dentry, inode);
> -	write_lock(&entries_lock);
> -	list_add(&e->list, &entries);
> -	write_unlock(&entries_lock);
> +	write_lock(&ns->entries_lock);
> +	list_add(&e->list, &ns->entries);
> +	write_unlock(&ns->entries_lock);
>  
>  	err = 0;
>  out2:
> @@ -770,7 +794,9 @@ static const struct file_operations bm_register_operations = {
>  static ssize_t
>  bm_status_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
>  {
> -	char *s = enabled ? "enabled\n" : "disabled\n";
> +	struct binfmt_namespace *ns =
> +				binfmt_ns(file->f_path.dentry->d_sb->s_user_ns);
> +	char *s = ns->enabled ? "enabled\n" : "disabled\n";
>  
>  	return simple_read_from_buffer(buf, nbytes, ppos, s, strlen(s));
>  }
> @@ -778,25 +804,28 @@ bm_status_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
>  static ssize_t bm_status_write(struct file *file, const char __user *buffer,
>  		size_t count, loff_t *ppos)
>  {
> +	struct binfmt_namespace *ns;
>  	int res = parse_command(buffer, count);
>  	struct dentry *root;
>  
> +	ns = binfmt_ns(file->f_path.dentry->d_sb->s_user_ns);
>  	switch (res) {
>  	case 1:
>  		/* Disable all handlers. */
> -		enabled = 0;
> +		ns->enabled = 0;
>  		break;
>  	case 2:
>  		/* Enable all handlers. */
> -		enabled = 1;
> +		ns->enabled = 1;
>  		break;
>  	case 3:
>  		/* Delete all handlers. */
>  		root = file_inode(file)->i_sb->s_root;
>  		inode_lock(d_inode(root));
>  
> -		while (!list_empty(&entries))
> -			kill_node(list_first_entry(&entries, Node, list));
> +		while (!list_empty(&ns->entries))
> +			kill_node(ns, list_first_entry(&ns->entries,
> +						       Node, list));
>  
>  		inode_unlock(d_inode(root));
>  		break;
> @@ -823,12 +852,34 @@ static const struct super_operations s_ops = {
>  static int bm_fill_super(struct super_block *sb, void *data, int silent)
>  {
>  	int err;
> +	struct user_namespace *ns = sb->s_user_ns;
>  	static const struct tree_descr bm_files[] = {
>  		[2] = {"status", &bm_status_operations, S_IWUSR|S_IRUGO},
>  		[3] = {"register", &bm_register_operations, S_IWUSR},
>  		/* last one */ {""}
>  	};
>  
> +	/* create a new binfmt namespace
> +	 * if we are not in the first user namespace
> +	 * but the binfmt namespace is the first one
> +	 */
> +	if (READ_ONCE(ns->binfmt_ns) == NULL) {
> +		struct binfmt_namespace *new_ns;
> +
> +		new_ns = kmalloc(sizeof(struct binfmt_namespace),
> +				 GFP_KERNEL);
> +		if (new_ns == NULL)
> +			return -ENOMEM;
> +		INIT_LIST_HEAD(&new_ns->entries);
> +		new_ns->enabled = 1;
> +		rwlock_init(&new_ns->entries_lock);
> +		new_ns->bm_mnt = NULL;
> +		new_ns->entry_count = 0;
> +		/* ensure new_ns is completely initialized before sharing it */
> +		smp_wmb();
> +		WRITE_ONCE(ns->binfmt_ns, new_ns);
> +	}
> +
>  	err = simple_fill_super(sb, BINFMTFS_MAGIC, bm_files);
>  	if (!err)
>  		sb->s_op = &s_ops;
> @@ -838,7 +889,10 @@ static int bm_fill_super(struct super_block *sb, void *data, int silent)
>  static struct dentry *bm_mount(struct file_system_type *fs_type,
>  	int flags, const char *dev_name, void *data)
>  {
> -	return mount_single(fs_type, flags, data, bm_fill_super);
> +	struct user_namespace *ns = current_user_ns();
> +
> +	return mount_ns(fs_type, flags, data, ns, ns,
> +			bm_fill_super);
>  }
>  
>  static struct linux_binfmt misc_format = {
> @@ -849,6 +903,7 @@ static struct linux_binfmt misc_format = {
>  static struct file_system_type bm_fs_type = {
>  	.owner		= THIS_MODULE,
>  	.name		= "binfmt_misc",
> +	.fs_flags	= FS_USERNS_MOUNT,
>  	.mount		= bm_mount,
>  	.kill_sb	= kill_litter_super,
>  };
> diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
> index d6b74b91096b..319141da5315 100644
> --- a/include/linux/user_namespace.h
> +++ b/include/linux/user_namespace.h
> @@ -52,6 +52,18 @@ enum ucount_type {
>  	UCOUNT_COUNTS,
>  };
>  
> +#if IS_ENABLED(CONFIG_BINFMT_MISC)
> +struct binfmt_namespace {
> +	struct list_head entries;
> +	rwlock_t entries_lock;
> +	int enabled;
> +	struct vfsmount *bm_mnt;
> +	int entry_count;
> +} __randomize_layout;
> +
> +extern struct binfmt_namespace init_binfmt_ns;
> +#endif
> +
>  struct user_namespace {
>  	struct uid_gid_map	uid_map;
>  	struct uid_gid_map	gid_map;
> @@ -76,6 +88,9 @@ struct user_namespace {
>  #endif
>  	struct ucounts		*ucounts;
>  	int ucount_max[UCOUNT_COUNTS];
> +#if IS_ENABLED(CONFIG_BINFMT_MISC)
> +	struct binfmt_namespace *binfmt_ns;
> +#endif
>  } __randomize_layout;
>  
>  struct ucounts {
> diff --git a/kernel/user.c b/kernel/user.c
> index 0df9b1640b2a..220ab2053d44 100644
> --- a/kernel/user.c
> +++ b/kernel/user.c
> @@ -19,6 +19,17 @@
>  #include <linux/user_namespace.h>
>  #include <linux/proc_ns.h>
>  
> +#if IS_ENABLED(CONFIG_BINFMT_MISC)
> +struct binfmt_namespace init_binfmt_ns = {
> +	.entries = LIST_HEAD_INIT(init_binfmt_ns.entries),
> +	.enabled = 1,
> +	.entries_lock = __RW_LOCK_UNLOCKED(init_binfmt_ns.entries_lock),
> +	.bm_mnt = NULL,
> +	.entry_count = 0,
> +};
> +EXPORT_SYMBOL_GPL(init_binfmt_ns);
> +#endif
> +
>  /*
>   * userns count is 1 for root user, 1 for init_uts_ns,
>   * and 1 for... ?
> @@ -66,6 +77,9 @@ struct user_namespace init_user_ns = {
>  	.persistent_keyring_register_sem =
>  	__RWSEM_INITIALIZER(init_user_ns.persistent_keyring_register_sem),
>  #endif
> +#if IS_ENABLED(CONFIG_BINFMT_MISC)
> +	.binfmt_ns = &init_binfmt_ns,
> +#endif
>  };
>  EXPORT_SYMBOL_GPL(init_user_ns);
>  
> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> index e5222b5fb4fe..990cf5950a89 100644
> --- a/kernel/user_namespace.c
> +++ b/kernel/user_namespace.c
> @@ -195,6 +195,9 @@ static void free_user_ns(struct work_struct *work)
>  			kfree(ns->projid_map.forward);
>  			kfree(ns->projid_map.reverse);
>  		}
> +#if IS_ENABLED(CONFIG_BINFMT_MISC)
> +		kfree(ns->binfmt_ns);
> +#endif
>  		retire_userns_sysctls(ns);
>  #ifdef CONFIG_PERSISTENT_KEYRINGS
>  		key_put(ns->persistent_keyring_register);
> -- 
> 2.17.1
> 
