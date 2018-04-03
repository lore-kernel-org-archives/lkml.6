Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753148AbeDCEot (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 00:44:49 -0400
Received: from ozlabs.org ([103.22.144.67]:47067 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750876AbeDCEor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 00:44:47 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 3 Apr 2018 14:43:49 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Sargun Dhillon <sargun@sargun.me>
Subject: linux-next: manual merge of the selinux tree with the security tree
Message-ID: <20180403144349.7db7f5e0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/G3jnmIabAgs3PqNCp9vhP7W"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/G3jnmIabAgs3PqNCp9vhP7W
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Paul,

Today's linux-next merge of the selinux tree got a conflict in:

  include/linux/lsm_hooks.h

between commit:

  22402b0b736d ("security: convert security hooks to use hlist")

from the security tree and commit:

  72e89f50084c ("security: Add support for SCTP security hooks")

from the selinux tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/linux/lsm_hooks.h
index b76897cbc42d,84c0b927ea85..000000000000
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@@ -1736,231 -1763,233 +1769,234 @@@ union security_list_options=20
  };
 =20
  struct security_hook_heads {
 -	struct list_head binder_set_context_mgr;
 -	struct list_head binder_transaction;
 -	struct list_head binder_transfer_binder;
 -	struct list_head binder_transfer_file;
 -	struct list_head ptrace_access_check;
 -	struct list_head ptrace_traceme;
 -	struct list_head capget;
 -	struct list_head capset;
 -	struct list_head capable;
 -	struct list_head quotactl;
 -	struct list_head quota_on;
 -	struct list_head syslog;
 -	struct list_head settime;
 -	struct list_head vm_enough_memory;
 -	struct list_head bprm_set_creds;
 -	struct list_head bprm_check_security;
 -	struct list_head bprm_committing_creds;
 -	struct list_head bprm_committed_creds;
 -	struct list_head sb_alloc_security;
 -	struct list_head sb_free_security;
 -	struct list_head sb_copy_data;
 -	struct list_head sb_remount;
 -	struct list_head sb_kern_mount;
 -	struct list_head sb_show_options;
 -	struct list_head sb_statfs;
 -	struct list_head sb_mount;
 -	struct list_head sb_umount;
 -	struct list_head sb_pivotroot;
 -	struct list_head sb_set_mnt_opts;
 -	struct list_head sb_clone_mnt_opts;
 -	struct list_head sb_parse_opts_str;
 -	struct list_head dentry_init_security;
 -	struct list_head dentry_create_files_as;
 +	struct hlist_head binder_set_context_mgr;
 +	struct hlist_head binder_transaction;
 +	struct hlist_head binder_transfer_binder;
 +	struct hlist_head binder_transfer_file;
 +	struct hlist_head ptrace_access_check;
 +	struct hlist_head ptrace_traceme;
 +	struct hlist_head capget;
 +	struct hlist_head capset;
 +	struct hlist_head capable;
 +	struct hlist_head quotactl;
 +	struct hlist_head quota_on;
 +	struct hlist_head syslog;
 +	struct hlist_head settime;
 +	struct hlist_head vm_enough_memory;
 +	struct hlist_head bprm_set_creds;
 +	struct hlist_head bprm_check_security;
 +	struct hlist_head bprm_committing_creds;
 +	struct hlist_head bprm_committed_creds;
 +	struct hlist_head sb_alloc_security;
 +	struct hlist_head sb_free_security;
 +	struct hlist_head sb_copy_data;
 +	struct hlist_head sb_remount;
 +	struct hlist_head sb_kern_mount;
 +	struct hlist_head sb_show_options;
 +	struct hlist_head sb_statfs;
 +	struct hlist_head sb_mount;
 +	struct hlist_head sb_umount;
 +	struct hlist_head sb_pivotroot;
 +	struct hlist_head sb_set_mnt_opts;
 +	struct hlist_head sb_clone_mnt_opts;
 +	struct hlist_head sb_parse_opts_str;
 +	struct hlist_head dentry_init_security;
 +	struct hlist_head dentry_create_files_as;
  #ifdef CONFIG_SECURITY_PATH
 -	struct list_head path_unlink;
 -	struct list_head path_mkdir;
 -	struct list_head path_rmdir;
 -	struct list_head path_mknod;
 -	struct list_head path_truncate;
 -	struct list_head path_symlink;
 -	struct list_head path_link;
 -	struct list_head path_rename;
 -	struct list_head path_chmod;
 -	struct list_head path_chown;
 -	struct list_head path_chroot;
 +	struct hlist_head path_unlink;
 +	struct hlist_head path_mkdir;
 +	struct hlist_head path_rmdir;
 +	struct hlist_head path_mknod;
 +	struct hlist_head path_truncate;
 +	struct hlist_head path_symlink;
 +	struct hlist_head path_link;
 +	struct hlist_head path_rename;
 +	struct hlist_head path_chmod;
 +	struct hlist_head path_chown;
 +	struct hlist_head path_chroot;
  #endif
 -	struct list_head inode_alloc_security;
 -	struct list_head inode_free_security;
 -	struct list_head inode_init_security;
 -	struct list_head inode_create;
 -	struct list_head inode_link;
 -	struct list_head inode_unlink;
 -	struct list_head inode_symlink;
 -	struct list_head inode_mkdir;
 -	struct list_head inode_rmdir;
 -	struct list_head inode_mknod;
 -	struct list_head inode_rename;
 -	struct list_head inode_readlink;
 -	struct list_head inode_follow_link;
 -	struct list_head inode_permission;
 -	struct list_head inode_setattr;
 -	struct list_head inode_getattr;
 -	struct list_head inode_setxattr;
 -	struct list_head inode_post_setxattr;
 -	struct list_head inode_getxattr;
 -	struct list_head inode_listxattr;
 -	struct list_head inode_removexattr;
 -	struct list_head inode_need_killpriv;
 -	struct list_head inode_killpriv;
 -	struct list_head inode_getsecurity;
 -	struct list_head inode_setsecurity;
 -	struct list_head inode_listsecurity;
 -	struct list_head inode_getsecid;
 -	struct list_head inode_copy_up;
 -	struct list_head inode_copy_up_xattr;
 -	struct list_head file_permission;
 -	struct list_head file_alloc_security;
 -	struct list_head file_free_security;
 -	struct list_head file_ioctl;
 -	struct list_head mmap_addr;
 -	struct list_head mmap_file;
 -	struct list_head file_mprotect;
 -	struct list_head file_lock;
 -	struct list_head file_fcntl;
 -	struct list_head file_set_fowner;
 -	struct list_head file_send_sigiotask;
 -	struct list_head file_receive;
 -	struct list_head file_open;
 -	struct list_head task_alloc;
 -	struct list_head task_free;
 -	struct list_head cred_alloc_blank;
 -	struct list_head cred_free;
 -	struct list_head cred_prepare;
 -	struct list_head cred_transfer;
 -	struct list_head kernel_act_as;
 -	struct list_head kernel_create_files_as;
 -	struct list_head kernel_read_file;
 -	struct list_head kernel_post_read_file;
 -	struct list_head kernel_module_request;
 -	struct list_head task_fix_setuid;
 -	struct list_head task_setpgid;
 -	struct list_head task_getpgid;
 -	struct list_head task_getsid;
 -	struct list_head task_getsecid;
 -	struct list_head task_setnice;
 -	struct list_head task_setioprio;
 -	struct list_head task_getioprio;
 -	struct list_head task_prlimit;
 -	struct list_head task_setrlimit;
 -	struct list_head task_setscheduler;
 -	struct list_head task_getscheduler;
 -	struct list_head task_movememory;
 -	struct list_head task_kill;
 -	struct list_head task_prctl;
 -	struct list_head task_to_inode;
 -	struct list_head ipc_permission;
 -	struct list_head ipc_getsecid;
 -	struct list_head msg_msg_alloc_security;
 -	struct list_head msg_msg_free_security;
 -	struct list_head msg_queue_alloc_security;
 -	struct list_head msg_queue_free_security;
 -	struct list_head msg_queue_associate;
 -	struct list_head msg_queue_msgctl;
 -	struct list_head msg_queue_msgsnd;
 -	struct list_head msg_queue_msgrcv;
 -	struct list_head shm_alloc_security;
 -	struct list_head shm_free_security;
 -	struct list_head shm_associate;
 -	struct list_head shm_shmctl;
 -	struct list_head shm_shmat;
 -	struct list_head sem_alloc_security;
 -	struct list_head sem_free_security;
 -	struct list_head sem_associate;
 -	struct list_head sem_semctl;
 -	struct list_head sem_semop;
 -	struct list_head netlink_send;
 -	struct list_head d_instantiate;
 -	struct list_head getprocattr;
 -	struct list_head setprocattr;
 -	struct list_head ismaclabel;
 -	struct list_head secid_to_secctx;
 -	struct list_head secctx_to_secid;
 -	struct list_head release_secctx;
 -	struct list_head inode_invalidate_secctx;
 -	struct list_head inode_notifysecctx;
 -	struct list_head inode_setsecctx;
 -	struct list_head inode_getsecctx;
 +	struct hlist_head inode_alloc_security;
 +	struct hlist_head inode_free_security;
 +	struct hlist_head inode_init_security;
 +	struct hlist_head inode_create;
 +	struct hlist_head inode_link;
 +	struct hlist_head inode_unlink;
 +	struct hlist_head inode_symlink;
 +	struct hlist_head inode_mkdir;
 +	struct hlist_head inode_rmdir;
 +	struct hlist_head inode_mknod;
 +	struct hlist_head inode_rename;
 +	struct hlist_head inode_readlink;
 +	struct hlist_head inode_follow_link;
 +	struct hlist_head inode_permission;
 +	struct hlist_head inode_setattr;
 +	struct hlist_head inode_getattr;
 +	struct hlist_head inode_setxattr;
 +	struct hlist_head inode_post_setxattr;
 +	struct hlist_head inode_getxattr;
 +	struct hlist_head inode_listxattr;
 +	struct hlist_head inode_removexattr;
 +	struct hlist_head inode_need_killpriv;
 +	struct hlist_head inode_killpriv;
 +	struct hlist_head inode_getsecurity;
 +	struct hlist_head inode_setsecurity;
 +	struct hlist_head inode_listsecurity;
 +	struct hlist_head inode_getsecid;
 +	struct hlist_head inode_copy_up;
 +	struct hlist_head inode_copy_up_xattr;
 +	struct hlist_head file_permission;
 +	struct hlist_head file_alloc_security;
 +	struct hlist_head file_free_security;
 +	struct hlist_head file_ioctl;
 +	struct hlist_head mmap_addr;
 +	struct hlist_head mmap_file;
 +	struct hlist_head file_mprotect;
 +	struct hlist_head file_lock;
 +	struct hlist_head file_fcntl;
 +	struct hlist_head file_set_fowner;
 +	struct hlist_head file_send_sigiotask;
 +	struct hlist_head file_receive;
 +	struct hlist_head file_open;
 +	struct hlist_head task_alloc;
 +	struct hlist_head task_free;
 +	struct hlist_head cred_alloc_blank;
 +	struct hlist_head cred_free;
 +	struct hlist_head cred_prepare;
 +	struct hlist_head cred_transfer;
 +	struct hlist_head cred_getsecid;
 +	struct hlist_head kernel_act_as;
 +	struct hlist_head kernel_create_files_as;
 +	struct hlist_head kernel_read_file;
 +	struct hlist_head kernel_post_read_file;
 +	struct hlist_head kernel_module_request;
 +	struct hlist_head task_fix_setuid;
 +	struct hlist_head task_setpgid;
 +	struct hlist_head task_getpgid;
 +	struct hlist_head task_getsid;
 +	struct hlist_head task_getsecid;
 +	struct hlist_head task_setnice;
 +	struct hlist_head task_setioprio;
 +	struct hlist_head task_getioprio;
 +	struct hlist_head task_prlimit;
 +	struct hlist_head task_setrlimit;
 +	struct hlist_head task_setscheduler;
 +	struct hlist_head task_getscheduler;
 +	struct hlist_head task_movememory;
 +	struct hlist_head task_kill;
 +	struct hlist_head task_prctl;
 +	struct hlist_head task_to_inode;
 +	struct hlist_head ipc_permission;
 +	struct hlist_head ipc_getsecid;
 +	struct hlist_head msg_msg_alloc_security;
 +	struct hlist_head msg_msg_free_security;
 +	struct hlist_head msg_queue_alloc_security;
 +	struct hlist_head msg_queue_free_security;
 +	struct hlist_head msg_queue_associate;
 +	struct hlist_head msg_queue_msgctl;
 +	struct hlist_head msg_queue_msgsnd;
 +	struct hlist_head msg_queue_msgrcv;
 +	struct hlist_head shm_alloc_security;
 +	struct hlist_head shm_free_security;
 +	struct hlist_head shm_associate;
 +	struct hlist_head shm_shmctl;
 +	struct hlist_head shm_shmat;
 +	struct hlist_head sem_alloc_security;
 +	struct hlist_head sem_free_security;
 +	struct hlist_head sem_associate;
 +	struct hlist_head sem_semctl;
 +	struct hlist_head sem_semop;
 +	struct hlist_head netlink_send;
 +	struct hlist_head d_instantiate;
 +	struct hlist_head getprocattr;
 +	struct hlist_head setprocattr;
 +	struct hlist_head ismaclabel;
 +	struct hlist_head secid_to_secctx;
 +	struct hlist_head secctx_to_secid;
 +	struct hlist_head release_secctx;
 +	struct hlist_head inode_invalidate_secctx;
 +	struct hlist_head inode_notifysecctx;
 +	struct hlist_head inode_setsecctx;
 +	struct hlist_head inode_getsecctx;
  #ifdef CONFIG_SECURITY_NETWORK
 -	struct list_head unix_stream_connect;
 -	struct list_head unix_may_send;
 -	struct list_head socket_create;
 -	struct list_head socket_post_create;
 -	struct list_head socket_bind;
 -	struct list_head socket_connect;
 -	struct list_head socket_listen;
 -	struct list_head socket_accept;
 -	struct list_head socket_sendmsg;
 -	struct list_head socket_recvmsg;
 -	struct list_head socket_getsockname;
 -	struct list_head socket_getpeername;
 -	struct list_head socket_getsockopt;
 -	struct list_head socket_setsockopt;
 -	struct list_head socket_shutdown;
 -	struct list_head socket_sock_rcv_skb;
 -	struct list_head socket_getpeersec_stream;
 -	struct list_head socket_getpeersec_dgram;
 -	struct list_head sk_alloc_security;
 -	struct list_head sk_free_security;
 -	struct list_head sk_clone_security;
 -	struct list_head sk_getsecid;
 -	struct list_head sock_graft;
 -	struct list_head inet_conn_request;
 -	struct list_head inet_csk_clone;
 -	struct list_head inet_conn_established;
 -	struct list_head secmark_relabel_packet;
 -	struct list_head secmark_refcount_inc;
 -	struct list_head secmark_refcount_dec;
 -	struct list_head req_classify_flow;
 -	struct list_head tun_dev_alloc_security;
 -	struct list_head tun_dev_free_security;
 -	struct list_head tun_dev_create;
 -	struct list_head tun_dev_attach_queue;
 -	struct list_head tun_dev_attach;
 -	struct list_head tun_dev_open;
 -	struct list_head sctp_assoc_request;
 -	struct list_head sctp_bind_connect;
 -	struct list_head sctp_sk_clone;
 +	struct hlist_head unix_stream_connect;
 +	struct hlist_head unix_may_send;
 +	struct hlist_head socket_create;
 +	struct hlist_head socket_post_create;
 +	struct hlist_head socket_bind;
 +	struct hlist_head socket_connect;
 +	struct hlist_head socket_listen;
 +	struct hlist_head socket_accept;
 +	struct hlist_head socket_sendmsg;
 +	struct hlist_head socket_recvmsg;
 +	struct hlist_head socket_getsockname;
 +	struct hlist_head socket_getpeername;
 +	struct hlist_head socket_getsockopt;
 +	struct hlist_head socket_setsockopt;
 +	struct hlist_head socket_shutdown;
 +	struct hlist_head socket_sock_rcv_skb;
 +	struct hlist_head socket_getpeersec_stream;
 +	struct hlist_head socket_getpeersec_dgram;
 +	struct hlist_head sk_alloc_security;
 +	struct hlist_head sk_free_security;
 +	struct hlist_head sk_clone_security;
 +	struct hlist_head sk_getsecid;
 +	struct hlist_head sock_graft;
 +	struct hlist_head inet_conn_request;
 +	struct hlist_head inet_csk_clone;
 +	struct hlist_head inet_conn_established;
 +	struct hlist_head secmark_relabel_packet;
 +	struct hlist_head secmark_refcount_inc;
 +	struct hlist_head secmark_refcount_dec;
 +	struct hlist_head req_classify_flow;
 +	struct hlist_head tun_dev_alloc_security;
 +	struct hlist_head tun_dev_free_security;
 +	struct hlist_head tun_dev_create;
 +	struct hlist_head tun_dev_attach_queue;
 +	struct hlist_head tun_dev_attach;
 +	struct hlist_head tun_dev_open;
++	struct hlist_head sctp_assoc_request;
++	struct hlist_head sctp_bind_connect;
++	struct hlist_head sctp_sk_clone;
  #endif	/* CONFIG_SECURITY_NETWORK */
  #ifdef CONFIG_SECURITY_INFINIBAND
 -	struct list_head ib_pkey_access;
 -	struct list_head ib_endport_manage_subnet;
 -	struct list_head ib_alloc_security;
 -	struct list_head ib_free_security;
 +	struct hlist_head ib_pkey_access;
 +	struct hlist_head ib_endport_manage_subnet;
 +	struct hlist_head ib_alloc_security;
 +	struct hlist_head ib_free_security;
  #endif	/* CONFIG_SECURITY_INFINIBAND */
  #ifdef CONFIG_SECURITY_NETWORK_XFRM
 -	struct list_head xfrm_policy_alloc_security;
 -	struct list_head xfrm_policy_clone_security;
 -	struct list_head xfrm_policy_free_security;
 -	struct list_head xfrm_policy_delete_security;
 -	struct list_head xfrm_state_alloc;
 -	struct list_head xfrm_state_alloc_acquire;
 -	struct list_head xfrm_state_free_security;
 -	struct list_head xfrm_state_delete_security;
 -	struct list_head xfrm_policy_lookup;
 -	struct list_head xfrm_state_pol_flow_match;
 -	struct list_head xfrm_decode_session;
 +	struct hlist_head xfrm_policy_alloc_security;
 +	struct hlist_head xfrm_policy_clone_security;
 +	struct hlist_head xfrm_policy_free_security;
 +	struct hlist_head xfrm_policy_delete_security;
 +	struct hlist_head xfrm_state_alloc;
 +	struct hlist_head xfrm_state_alloc_acquire;
 +	struct hlist_head xfrm_state_free_security;
 +	struct hlist_head xfrm_state_delete_security;
 +	struct hlist_head xfrm_policy_lookup;
 +	struct hlist_head xfrm_state_pol_flow_match;
 +	struct hlist_head xfrm_decode_session;
  #endif	/* CONFIG_SECURITY_NETWORK_XFRM */
  #ifdef CONFIG_KEYS
 -	struct list_head key_alloc;
 -	struct list_head key_free;
 -	struct list_head key_permission;
 -	struct list_head key_getsecurity;
 +	struct hlist_head key_alloc;
 +	struct hlist_head key_free;
 +	struct hlist_head key_permission;
 +	struct hlist_head key_getsecurity;
  #endif	/* CONFIG_KEYS */
  #ifdef CONFIG_AUDIT
 -	struct list_head audit_rule_init;
 -	struct list_head audit_rule_known;
 -	struct list_head audit_rule_match;
 -	struct list_head audit_rule_free;
 +	struct hlist_head audit_rule_init;
 +	struct hlist_head audit_rule_known;
 +	struct hlist_head audit_rule_match;
 +	struct hlist_head audit_rule_free;
  #endif /* CONFIG_AUDIT */
  #ifdef CONFIG_BPF_SYSCALL
 -	struct list_head bpf;
 -	struct list_head bpf_map;
 -	struct list_head bpf_prog;
 -	struct list_head bpf_map_alloc_security;
 -	struct list_head bpf_map_free_security;
 -	struct list_head bpf_prog_alloc_security;
 -	struct list_head bpf_prog_free_security;
 +	struct hlist_head bpf;
 +	struct hlist_head bpf_map;
 +	struct hlist_head bpf_prog;
 +	struct hlist_head bpf_map_alloc_security;
 +	struct hlist_head bpf_map_free_security;
 +	struct hlist_head bpf_prog_alloc_security;
 +	struct hlist_head bpf_prog_free_security;
  #endif /* CONFIG_BPF_SYSCALL */
  } __randomize_layout;
 =20

--Sig_/G3jnmIabAgs3PqNCp9vhP7W
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrDBoUACgkQAVBC80lX
0GzrFwf8CObKok8sOAipY1Oi9qkV9ziKaWXN+yGzLSSAuhO4eQzyXTd/JnCd6+88
aGLzQt8nyY233KuDoZEsp029GSRiV1mYH9KIJsDkEvs5YU2Nmg8K7qUJNRtBcLeW
7imhvTRhsy4TRJzkHNl825qGXR9KT6Y2HZx0q38z9XvCn9W1xzxBjCGHZ1VQEKcx
2nIcfJ/ZRt9YhBUFshZT3NGx6QQpykTcugC+YZX2Ca4vsuCE6HI/eNLUvikDqXYD
7m9jrcbv6WRNQbnIXGD7st3Qz6KWjcnhdQbvCuU/0U2lkh4WuKYgup/q91X6Xfft
uh02nBFCzH4XezsDMc1xLeG10iYmFg==
=b9q+
-----END PGP SIGNATURE-----

--Sig_/G3jnmIabAgs3PqNCp9vhP7W--
