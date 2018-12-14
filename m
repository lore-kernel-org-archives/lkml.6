Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F5CC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 07:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 312072086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 07:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bnE7jKSZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 312072086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbeLNHNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 02:13:11 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:42612 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbeLNHNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 02:13:11 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBE793DG183876;
        Fri, 14 Dec 2018 07:11:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=M7dgWeaFAGjIea2g92ORb3qPkgqKHv74i1KiCFCkIs0=;
 b=bnE7jKSZiBvNjyEjZOiwgLknv7FYJfJUJrl0FB0DnDagiqpdeYzpLjy9jOC/bWYGKSFU
 rbtTftocKUvbBYHAHZFm3LwjH5L6xfEmTzLWKheb+hzVMyHaE6iNZibBuM4xfvmO+KnV
 ArKB/537WJB6rAJzm/J4Pg5EriQXQ1pjAceR2N/ULtdf7smIokjiHLmI605PZC7c9MII
 bO5Sp+LTldjicPYcW+v9XET8maJYQi6aG3ijzvRP+Na19BzSY7kDlxULQhlUjTnkETzO
 Y8KpIq77IAzS0m/3S8H1VYr+xULzpm89lVq8VCVviIpfl2bj7NDxuCnDkLOSD6gpttjH HA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2pb7tf80y4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Dec 2018 07:11:54 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wBE7BsOa002156
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Dec 2018 07:11:54 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wBE7BqGh028112;
        Fri, 14 Dec 2018 07:11:52 GMT
Received: from kadam (/197.157.0.36)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 13 Dec 2018 23:11:50 -0800
Date:   Fri, 14 Dec 2018 10:11:23 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Christian Brauner <christian@brauner.io>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kilobyte@angband.pl,
        darrick.wong@oracle.com, chouryzhou@tencent.com,
        david@fromorbit.com, arve@android.com, joel@joelfernandes.org,
        Martijn Coenen <maco@android.com>, tkjos@google.com
Subject: Re: [PATCH v2] binder: implement binderfs
Message-ID: <20181214071123.GX3116@kadam>
References: <20181213215911.24891-1-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213215911.24891-1-christian@brauner.io>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9106 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812140066
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 10:59:11PM +0100, Christian Brauner wrote:
> +/**
> + * binderfs_new_inode - allocate inode from super block of a binderfs mount
> + * @ref_inode: inode from wich the super block will be taken
> + * @userp:     buffer to copy information about new device for userspace to
> + * @device:    binder device for which the new inode will be allocated
> + * @req:       struct binderfs_device as copied from userspace
> + *
> + * This function will allocate a new inode from the super block of the
> + * filesystem mount and attach a dentry to that inode.
> + * Minor numbers are limited and tracked globally in binderfs_minors.
> + * The function will stash a struct binder_device for the specific binder
> + * device in i_private of the inode.
> + *
> + * Return: 0 on success, negative errno on failure
> + */
> +static int binderfs_new_inode(struct inode *ref_inode,
> +			      struct binder_device *device,
> +			      struct binderfs_device __user *userp,
> +			      struct binderfs_device *req)
> +{
> +	int minor, ret;
> +	struct dentry *dentry, *dup, *root;
> +	size_t name_len = BINDERFS_MAX_NAME + 1;
> +	char *name = NULL;
> +	struct inode *inode = NULL;
> +	struct super_block *sb = ref_inode->i_sb;
> +	struct binderfs_info *info = sb->s_fs_info;
> +
> +	/* Reserve new minor number for the new device. */
> +	mutex_lock(&binderfs_minors_mutex);
> +	minor = ida_alloc_max(&binderfs_minors, BINDERFS_MAX_MINOR, GFP_KERNEL);
> +	mutex_unlock(&binderfs_minors_mutex);
> +	if (minor < 0)
> +		return minor;
> +
> +	ret = -ENOMEM;
> +	inode = new_inode(sb);
> +	if (!inode)
> +		goto err;
> +
> +	inode->i_ino = minor + INODE_OFFSET;
> +	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
> +	init_special_inode(inode, S_IFCHR | 0600,
> +			   MKDEV(MAJOR(binderfs_dev), minor));
> +	inode->i_fop = &binder_fops;
> +	inode->i_uid = info->root_uid;
> +	inode->i_gid = info->root_gid;
> +	inode->i_private = device;
> +
> +	name = kmalloc(name_len, GFP_KERNEL);
> +	if (!name)
> +		goto err;
> +
> +	ret = snprintf(name, name_len, "%s", req->name);
> +	if (ret < 0 || (size_t)ret >= name_len) {

kernel snprintf() doesn't return negatives and the cast isn't required
either.

> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
> +	device->binderfs_inode = inode;
> +	device->context.binder_context_mgr_uid = INVALID_UID;
> +	device->context.name = name;
> +	device->miscdev.name = name;
> +	device->miscdev.minor = minor;
> +	mutex_init(&device->context.context_mgr_node_lock);
> +
> +	req->major = MAJOR(binderfs_dev);
> +	req->minor = minor;
> +
> +	ret = copy_to_user(userp, req, sizeof(*req));
> +	if (ret)
> +		goto err;

copy_to_user() returns the number of bytes remaining.

	ret = -EFAULT;
	if (copy_to_user(userp, req, sizeof(*req)))
		goto err;

Also if this copy_to_user() fails, then does the kfree(name) and the
iput(inode) lead to a double free of name in binderfs_evict_inode()?

> +
> +	root = sb->s_root;
> +	inode_lock(d_inode(root));
> +	dentry = d_alloc_name(root, name);
> +	if (!dentry) {
> +		inode_unlock(d_inode(root));
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +
> +	/* Verify that the name userspace gave us is not already in use. */
> +	dup = d_lookup(root, &dentry->d_name);
> +	if (dup) {
> +		if (d_really_is_positive(dup)) {
> +			dput(dup);
> +			dput(dentry);
> +			inode_unlock(d_inode(root));
> +			/*
> +			 * Prevent double free since iput() calls
> +			 * binderfs_evict_inode().
> +			 */
> +			inode->i_private = NULL;
> +			ret = -EEXIST;
> +			goto err;
> +		}
> +		dput(dup);
> +	}
> +
> +	d_add(dentry, inode);
> +	fsnotify_create(root->d_inode, dentry);
> +	inode_unlock(d_inode(root));
> +
> +	return 0;
> +
> +err:
> +	kfree(name);
> +	mutex_lock(&binderfs_minors_mutex);
> +	ida_free(&binderfs_minors, minor);
> +	mutex_unlock(&binderfs_minors_mutex);
> +	iput(inode);
> +
> +	return ret;
> +}
> +
> +static int binderfs_binder_device_create(struct inode *inode,
> +					 struct binderfs_device __user *userp,
> +					 struct binderfs_device *req)
> +{
> +	struct binder_device *device;
> +	int ret;
> +
> +	device = kzalloc(sizeof(*device), GFP_KERNEL);
> +	if (!device)
> +		return -ENOMEM;

Just move this allocation into binderfs_new_inode() and get rid of this
function.

> +
> +	ret = binderfs_new_inode(inode, device, userp, req);
> +	if (ret < 0) {
> +		kfree(device);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * binderfs_ctl_ioctl - handle binder device node allocation requests
> + *
> + * The request handler for the binder-control device. All requests operate on
> + * the binderfs mount the binder-control device resides in:
> + * - BINDER_CTL_ADD
> + *   Allocate a new binder device.
> + *
> + * Return: 0 on success, negative errno on failure
> + */
> +static long binder_ctl_ioctl(struct file *file, unsigned int cmd,
> +			     unsigned long arg)
> +{
> +	struct binderfs_info *info;
> +	int ret = -EINVAL;
> +	struct inode *inode = file_inode(file);
> +	struct binderfs_device __user *device = (struct binderfs_device __user *)arg;
> +	struct binderfs_device device_req;
> +
> +	info = BINDERFS_I(inode);

info is not used.

> +	switch (cmd) {
> +	case BINDER_CTL_ADD:
> +		ret = copy_from_user(&device_req, device, sizeof(device_req));

if (copy_from_user(&device_req, device, sizeof(device_req))) {
	ret = -EFAULT;
	break;
}

> +		if (ret)
> +			break;
> +
> +		ret = binderfs_binder_device_create(inode, device, &device_req);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static void binderfs_evict_inode(struct inode *inode)
> +{
> +	struct binder_device *device = inode->i_private;
> +
> +	clear_inode(inode);
> +
> +	if (!device)
> +		return;
> +
> +	mutex_lock(&binderfs_minors_mutex);
> +	ida_free(&binderfs_minors, device->miscdev.minor);
> +	mutex_unlock(&binderfs_minors_mutex);
> +
> +	kfree(device->context.name);
> +	kfree(device);
> +}
> +
> +static const struct super_operations binderfs_super_ops = {
> +	.statfs = simple_statfs,
> +	.evict_inode = binderfs_evict_inode,
> +};
> +
> +static int binderfs_rename(struct inode *old_dir, struct dentry *old_dentry,
> +			   struct inode *new_dir, struct dentry *new_dentry,
> +			   unsigned int flags)
> +{
> +	struct inode *inode = d_inode(old_dentry);
> +
> +	/* binderfs doesn't support directories. */
> +	if (d_is_dir(old_dentry))
> +		return -EPERM;
> +
> +	if (flags & ~RENAME_NOREPLACE)
> +		return -EINVAL;
> +
> +	if (!simple_empty(new_dentry))
> +		return -ENOTEMPTY;
> +
> +	if (d_really_is_positive(new_dentry))
> +		simple_unlink(new_dir, new_dentry);
> +
> +	old_dir->i_ctime = old_dir->i_mtime = new_dir->i_ctime =
> +		new_dir->i_mtime = inode->i_ctime = current_time(old_dir);
> +
> +	return 0;
> +}
> +
> +static int binderfs_unlink(struct inode *dir, struct dentry *dentry)
> +{
> +	/*
> +	 * The control dentry is only ever touched during mount so checking it
> +	 * here should not require us to take lock.
> +	 */
> +	if (BINDERFS_I(dir)->control_dentry == dentry)
> +		return -EPERM;
> +
> +	return simple_unlink(dir, dentry);
> +}
> +
> +static const struct file_operations binder_ctl_fops = {
> +	.owner		= THIS_MODULE,
> +	.open		= nonseekable_open,
> +	.unlocked_ioctl	= binder_ctl_ioctl,
> +	.compat_ioctl	= binder_ctl_ioctl,
> +	.llseek		= noop_llseek,
> +};
> +
> +/**
> + * binderfs_binder_ctl_create - create a new binder-control device
> + * @sb: super block of the binderfs mount
> + *
> + * This function creates a new binder-control device node in the binderfs mount
> + * referred to by @sb.
> + *
> + * Return: 0 on success, negative errno on failure
> + */
> +static int binderfs_binder_ctl_create(struct super_block *sb)
> +{
> +	int minor;
> +	struct dentry *dentry;
> +	struct binder_device *device;
> +	int ret = 0;
> +	struct inode *inode = NULL;
> +	struct dentry *root = sb->s_root;
> +	struct binderfs_info *info = sb->s_fs_info;
> +
> +	device = kzalloc(sizeof(*device), GFP_KERNEL);
> +	if (!device)
> +		return -ENOMEM;
> +
> +	inode_lock(d_inode(root));
> +
> +	if (info->control_dentry)
> +		goto out;

I have a private static checker warning for gotos like this where we
don't set the error code before the goto out.  Apparently here this
is a success path.  I'm not an fs dev, so I don't know why this is a
success path.  :(  Maybe you could add a comment?


> +
> +	ret = -ENOMEM;
> +	inode = new_inode(sb);
> +	if (!inode)
> +		goto out;
> +
> +	/* Reserve a new minor number for the new device. */
> +	mutex_lock(&binderfs_minors_mutex);
> +	minor = ida_alloc_max(&binderfs_minors, BINDERFS_MAX_MINOR, GFP_KERNEL);
> +	mutex_unlock(&binderfs_minors_mutex);
> +	if (minor < 0) {
> +		ret = minor;
> +		goto out;
> +	}
> +
> +	inode->i_ino = SECOND_INODE;
> +	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
> +	init_special_inode(inode, S_IFCHR | 0600,
> +			   MKDEV(MAJOR(binderfs_dev), minor));
> +	inode->i_fop = &binder_ctl_fops;
> +	inode->i_uid = info->root_uid;
> +	inode->i_gid = info->root_gid;
> +	inode->i_private = device;
> +
> +	device->binderfs_inode = inode;
> +	device->miscdev.minor = minor;
> +
> +	dentry = d_alloc_name(root, "binder-control");
> +	if (!dentry)
> +		goto out;
> +
> +	info->control_dentry = dentry;
> +	d_add(dentry, inode);
> +	inode_unlock(d_inode(root));
> +
> +	return 0;
> +
> +out:
> +	inode_unlock(d_inode(root));
> +	kfree(device);
> +	if (inode) {
> +		inode->i_private = NULL;
> +		iput(inode);
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct inode_operations binderfs_dir_inode_operations = {
> +	.lookup = simple_lookup,
> +	.rename = binderfs_rename,
> +	.unlink = binderfs_unlink,
> +};
> +
> +static int binderfs_fill_super(struct super_block *sb, void *data, int silent)
> +{
> +	struct binderfs_info *info;
> +	int ret = -ENOMEM;
> +	struct inode *inode = NULL;
> +	struct ipc_namespace *ipc_ns = sb->s_fs_info;
> +
> +	get_ipc_ns(ipc_ns);
> +
> +	sb->s_blocksize = PAGE_SIZE;
> +	sb->s_blocksize_bits = PAGE_SHIFT;
> +
> +	/*
> +	 * The binderfs filesystem can be mounted by userns root in a
> +	 * non-initial userns. By default such mounts have the SB_I_NODEV flag
> +	 * set in s_iflags to prevent security issues where userns root can
> +	 * just create random device nodes via mknod() since it owns the
> +	 * filesystem mount. But binderfs does not allow to create any files
> +	 * including devices nodes. The only way to create binder devices nodes
> +	 * is through the binder-control device which userns root is explicitly
> +	 * allowed to do. So removing the SB_I_NODEV flag from s_iflags is both
> +	 * necessary and safe.
> +	 */
> +	sb->s_iflags &= ~SB_I_NODEV;
> +	sb->s_iflags |= SB_I_NOEXEC;
> +	sb->s_magic = BINDERFS_SUPER_MAGIC;
> +	sb->s_op = &binderfs_super_ops;
> +	sb->s_time_gran = 1;
> +
> +	info = kzalloc(sizeof(struct binderfs_info), GFP_KERNEL);
> +	if (!info)
> +		return ret;

You can't return directly here, you need to goto the put_ipc_ns()
function in the error handling.

> +
> +	info->ipc_ns = ipc_ns;
> +	info->root_gid = make_kgid(sb->s_user_ns, 0);
> +	if (!gid_valid(info->root_gid))
> +		info->root_gid = GLOBAL_ROOT_GID;
> +	info->root_uid = make_kuid(sb->s_user_ns, 0);
> +	if (!uid_valid(info->root_uid))
> +		info->root_uid = GLOBAL_ROOT_UID;
> +
> +	sb->s_fs_info = info;
> +
> +	inode = new_inode(sb);
> +	if (!inode)
> +		goto err_without_dentry;
> +
> +	inode->i_ino = FIRST_INODE;
> +	inode->i_fop = &simple_dir_operations;
> +	inode->i_mode = S_IFDIR | 0755;
> +	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
> +	inode->i_op = &binderfs_dir_inode_operations;
> +	set_nlink(inode, 2);
> +
> +	sb->s_root = d_make_root(inode);
> +	if (!sb->s_root)
> +		goto err_without_dentry;
> +
> +	ret = binderfs_binder_ctl_create(sb);
> +	if (ret)
> +		goto err_with_dentry;
> +
> +	return 0;
> +
> +err_with_dentry:
> +	dput(sb->s_root);
> +	sb->s_root = NULL;
> +
> +err_without_dentry:
> +	if (inode)
> +		iput(inode);

iput accepts NULL pointers.

> +	kfree(info);
> +	put_ipc_ns(ipc_ns);
> +
> +	return ret;
> +}
> +
> +static int binderfs_test_super(struct super_block *sb, void *data)
> +{
> +	struct binderfs_info *info = sb->s_fs_info;
> +
> +	if (info)
> +		return info->ipc_ns == data;
> +
> +	return 0;
> +}
> +
> +static int binderfs_set_super(struct super_block *sb, void *data)
> +{
> +	sb->s_fs_info = data;
> +	return set_anon_super(sb, NULL);
> +}
> +
> +static struct dentry *binderfs_mount(struct file_system_type *fs_type,
> +				     int flags, const char *dev_name,
> +				     void *data)
> +{
> +	struct super_block *sb;
> +	struct ipc_namespace *ipc_ns = current->nsproxy->ipc_ns;
> +
> +	if (!ns_capable(ipc_ns->user_ns, CAP_SYS_ADMIN))
> +		return ERR_PTR(-EPERM);
> +
> +	sb = sget_userns(fs_type, binderfs_test_super, binderfs_set_super,
> +			 flags, ipc_ns->user_ns, ipc_ns);
> +	if (IS_ERR(sb))
> +		return ERR_CAST(sb);
> +
> +	if (!sb->s_root) {
> +		int ret = binderfs_fill_super(sb, data, flags & SB_SILENT ? 1 : 0);
> +		if (ret) {
> +			deactivate_locked_super(sb);
> +			return ERR_PTR(ret);
> +		}
> +
> +		sb->s_flags |= SB_ACTIVE;
> +	}
> +
> +	return dget(sb->s_root);
> +}
> +
> +static void binderfs_kill_super(struct super_block *sb)
> +{
> +	struct binderfs_info *info = sb->s_fs_info;
> +
> +	if (info && info->ipc_ns)
> +		put_ipc_ns(info->ipc_ns);
> +
> +	kfree(info);
> +	kill_litter_super(sb);
> +}
> +
> +static struct file_system_type binder_fs_type = {
> +	.name		= "binder",
> +	.mount		= binderfs_mount,
> +	.kill_sb	= binderfs_kill_super,
> +	.fs_flags	= FS_USERNS_MOUNT,
> +};
> +
> +static int __init init_binderfs(void)
> +{
> +	int ret;
> +
> +	/* Allocate new major number for binderfs. */
> +	ret = alloc_chrdev_region(&binderfs_dev, 0, BINDERFS_MAX_MINOR,
> +				  "binder");
> +	if (ret < 0)
            ^^^^^^^
> +		return ret;
> +
> +	ret = register_filesystem(&binder_fs_type);
> +	if (ret) {
            ^^^
These functions both return negative on error.  From my static checker
perspective it's easiest if everyone checks "if (ret) " but either way
let's make it consistent.

> +		unregister_chrdev_region(binderfs_dev, BINDERFS_MAX_MINOR);
> +		return ret;
> +	}
> +
> +	binderfs_mnt = kern_mount(&binder_fs_type);
> +	if (IS_ERR(binderfs_mnt)) {
> +		ret = PTR_ERR(binderfs_mnt);
> +		binderfs_mnt = NULL;
> +		unregister_filesystem(&binder_fs_type);
> +		unregister_chrdev_region(binderfs_dev, BINDERFS_MAX_MINOR);

Use gotos to unwind.

> +	}
> +
> +	return ret;
> +}

regards,
dan carpenter

