Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753451AbeDAKSL (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 06:18:11 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:39305 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753336AbeDAKSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 06:18:07 -0400
X-Google-Smtp-Source: AIpwx48Tyzx7ZK8DivQyd2QdjkGQeXv2msRdxQvQ9X8zHOYPElgH89lryAz715+1XcsmtTZhd65whA==
Date: Sun, 1 Apr 2018 10:18:04 +0000
From: Sargun Dhillon <sargun@sargun.me>
To: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: penguin-kernel@i-love.sakura.ne.jp, keescook@chromium.org,
        igor.stoppa@huawei.com, casey@schaufler-ca.com, jmorris@namei.org
Subject: [PATCH 3/4] security: Make security_hook_heads use definitions in
 lsm_hook_types.h
Message-ID: <edfd3c00e41be3499f48c478a601faf1fa0b9283.1522577650.git.sargun@sargun.me>
References: <cover.1522577650.git.sargun@sargun.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1522577650.git.sargun@sargun.me>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change makes it so rather than having to duplicate the list
of heads in struct security_hook_heads, the structure is generated
based upon the structured hooks in lsm_hook_types.h.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 include/linux/lsm_hooks.h | 230 +---------------------------------------------
 1 file changed, 5 insertions(+), 225 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 5489f0594f6c..70d7d01467ba 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -37,231 +37,11 @@ union security_list_options {
 };
 
 struct security_hook_heads {
-	struct hlist_head binder_set_context_mgr;
-	struct hlist_head binder_transaction;
-	struct hlist_head binder_transfer_binder;
-	struct hlist_head binder_transfer_file;
-	struct hlist_head ptrace_access_check;
-	struct hlist_head ptrace_traceme;
-	struct hlist_head capget;
-	struct hlist_head capset;
-	struct hlist_head capable;
-	struct hlist_head quotactl;
-	struct hlist_head quota_on;
-	struct hlist_head syslog;
-	struct hlist_head settime;
-	struct hlist_head vm_enough_memory;
-	struct hlist_head bprm_set_creds;
-	struct hlist_head bprm_check_security;
-	struct hlist_head bprm_committing_creds;
-	struct hlist_head bprm_committed_creds;
-	struct hlist_head sb_alloc_security;
-	struct hlist_head sb_free_security;
-	struct hlist_head sb_copy_data;
-	struct hlist_head sb_remount;
-	struct hlist_head sb_kern_mount;
-	struct hlist_head sb_show_options;
-	struct hlist_head sb_statfs;
-	struct hlist_head sb_mount;
-	struct hlist_head sb_umount;
-	struct hlist_head sb_pivotroot;
-	struct hlist_head sb_set_mnt_opts;
-	struct hlist_head sb_clone_mnt_opts;
-	struct hlist_head sb_parse_opts_str;
-	struct hlist_head dentry_init_security;
-	struct hlist_head dentry_create_files_as;
-#ifdef CONFIG_SECURITY_PATH
-	struct hlist_head path_unlink;
-	struct hlist_head path_mkdir;
-	struct hlist_head path_rmdir;
-	struct hlist_head path_mknod;
-	struct hlist_head path_truncate;
-	struct hlist_head path_symlink;
-	struct hlist_head path_link;
-	struct hlist_head path_rename;
-	struct hlist_head path_chmod;
-	struct hlist_head path_chown;
-	struct hlist_head path_chroot;
-#endif
-	struct hlist_head inode_alloc_security;
-	struct hlist_head inode_free_security;
-	struct hlist_head inode_init_security;
-	struct hlist_head inode_create;
-	struct hlist_head inode_link;
-	struct hlist_head inode_unlink;
-	struct hlist_head inode_symlink;
-	struct hlist_head inode_mkdir;
-	struct hlist_head inode_rmdir;
-	struct hlist_head inode_mknod;
-	struct hlist_head inode_rename;
-	struct hlist_head inode_readlink;
-	struct hlist_head inode_follow_link;
-	struct hlist_head inode_permission;
-	struct hlist_head inode_setattr;
-	struct hlist_head inode_getattr;
-	struct hlist_head inode_setxattr;
-	struct hlist_head inode_post_setxattr;
-	struct hlist_head inode_getxattr;
-	struct hlist_head inode_listxattr;
-	struct hlist_head inode_removexattr;
-	struct hlist_head inode_need_killpriv;
-	struct hlist_head inode_killpriv;
-	struct hlist_head inode_getsecurity;
-	struct hlist_head inode_setsecurity;
-	struct hlist_head inode_listsecurity;
-	struct hlist_head inode_getsecid;
-	struct hlist_head inode_copy_up;
-	struct hlist_head inode_copy_up_xattr;
-	struct hlist_head file_permission;
-	struct hlist_head file_alloc_security;
-	struct hlist_head file_free_security;
-	struct hlist_head file_ioctl;
-	struct hlist_head mmap_addr;
-	struct hlist_head mmap_file;
-	struct hlist_head file_mprotect;
-	struct hlist_head file_lock;
-	struct hlist_head file_fcntl;
-	struct hlist_head file_set_fowner;
-	struct hlist_head file_send_sigiotask;
-	struct hlist_head file_receive;
-	struct hlist_head file_open;
-	struct hlist_head task_alloc;
-	struct hlist_head task_free;
-	struct hlist_head cred_alloc_blank;
-	struct hlist_head cred_free;
-	struct hlist_head cred_prepare;
-	struct hlist_head cred_transfer;
-	struct hlist_head kernel_act_as;
-	struct hlist_head kernel_create_files_as;
-	struct hlist_head kernel_read_file;
-	struct hlist_head kernel_post_read_file;
-	struct hlist_head kernel_module_request;
-	struct hlist_head task_fix_setuid;
-	struct hlist_head task_setpgid;
-	struct hlist_head task_getpgid;
-	struct hlist_head task_getsid;
-	struct hlist_head task_getsecid;
-	struct hlist_head task_setnice;
-	struct hlist_head task_setioprio;
-	struct hlist_head task_getioprio;
-	struct hlist_head task_prlimit;
-	struct hlist_head task_setrlimit;
-	struct hlist_head task_setscheduler;
-	struct hlist_head task_getscheduler;
-	struct hlist_head task_movememory;
-	struct hlist_head task_kill;
-	struct hlist_head task_prctl;
-	struct hlist_head task_to_inode;
-	struct hlist_head ipc_permission;
-	struct hlist_head ipc_getsecid;
-	struct hlist_head msg_msg_alloc_security;
-	struct hlist_head msg_msg_free_security;
-	struct hlist_head msg_queue_alloc_security;
-	struct hlist_head msg_queue_free_security;
-	struct hlist_head msg_queue_associate;
-	struct hlist_head msg_queue_msgctl;
-	struct hlist_head msg_queue_msgsnd;
-	struct hlist_head msg_queue_msgrcv;
-	struct hlist_head shm_alloc_security;
-	struct hlist_head shm_free_security;
-	struct hlist_head shm_associate;
-	struct hlist_head shm_shmctl;
-	struct hlist_head shm_shmat;
-	struct hlist_head sem_alloc_security;
-	struct hlist_head sem_free_security;
-	struct hlist_head sem_associate;
-	struct hlist_head sem_semctl;
-	struct hlist_head sem_semop;
-	struct hlist_head netlink_send;
-	struct hlist_head d_instantiate;
-	struct hlist_head getprocattr;
-	struct hlist_head setprocattr;
-	struct hlist_head ismaclabel;
-	struct hlist_head secid_to_secctx;
-	struct hlist_head secctx_to_secid;
-	struct hlist_head release_secctx;
-	struct hlist_head inode_invalidate_secctx;
-	struct hlist_head inode_notifysecctx;
-	struct hlist_head inode_setsecctx;
-	struct hlist_head inode_getsecctx;
-#ifdef CONFIG_SECURITY_NETWORK
-	struct hlist_head unix_stream_connect;
-	struct hlist_head unix_may_send;
-	struct hlist_head socket_create;
-	struct hlist_head socket_post_create;
-	struct hlist_head socket_bind;
-	struct hlist_head socket_connect;
-	struct hlist_head socket_listen;
-	struct hlist_head socket_accept;
-	struct hlist_head socket_sendmsg;
-	struct hlist_head socket_recvmsg;
-	struct hlist_head socket_getsockname;
-	struct hlist_head socket_getpeername;
-	struct hlist_head socket_getsockopt;
-	struct hlist_head socket_setsockopt;
-	struct hlist_head socket_shutdown;
-	struct hlist_head socket_sock_rcv_skb;
-	struct hlist_head socket_getpeersec_stream;
-	struct hlist_head socket_getpeersec_dgram;
-	struct hlist_head sk_alloc_security;
-	struct hlist_head sk_free_security;
-	struct hlist_head sk_clone_security;
-	struct hlist_head sk_getsecid;
-	struct hlist_head sock_graft;
-	struct hlist_head inet_conn_request;
-	struct hlist_head inet_csk_clone;
-	struct hlist_head inet_conn_established;
-	struct hlist_head secmark_relabel_packet;
-	struct hlist_head secmark_refcount_inc;
-	struct hlist_head secmark_refcount_dec;
-	struct hlist_head req_classify_flow;
-	struct hlist_head tun_dev_alloc_security;
-	struct hlist_head tun_dev_free_security;
-	struct hlist_head tun_dev_create;
-	struct hlist_head tun_dev_attach_queue;
-	struct hlist_head tun_dev_attach;
-	struct hlist_head tun_dev_open;
-#endif	/* CONFIG_SECURITY_NETWORK */
-#ifdef CONFIG_SECURITY_INFINIBAND
-	struct hlist_head ib_pkey_access;
-	struct hlist_head ib_endport_manage_subnet;
-	struct hlist_head ib_alloc_security;
-	struct hlist_head ib_free_security;
-#endif	/* CONFIG_SECURITY_INFINIBAND */
-#ifdef CONFIG_SECURITY_NETWORK_XFRM
-	struct hlist_head xfrm_policy_alloc_security;
-	struct hlist_head xfrm_policy_clone_security;
-	struct hlist_head xfrm_policy_free_security;
-	struct hlist_head xfrm_policy_delete_security;
-	struct hlist_head xfrm_state_alloc;
-	struct hlist_head xfrm_state_alloc_acquire;
-	struct hlist_head xfrm_state_free_security;
-	struct hlist_head xfrm_state_delete_security;
-	struct hlist_head xfrm_policy_lookup;
-	struct hlist_head xfrm_state_pol_flow_match;
-	struct hlist_head xfrm_decode_session;
-#endif	/* CONFIG_SECURITY_NETWORK_XFRM */
-#ifdef CONFIG_KEYS
-	struct hlist_head key_alloc;
-	struct hlist_head key_free;
-	struct hlist_head key_permission;
-	struct hlist_head key_getsecurity;
-#endif	/* CONFIG_KEYS */
-#ifdef CONFIG_AUDIT
-	struct hlist_head audit_rule_init;
-	struct hlist_head audit_rule_known;
-	struct hlist_head audit_rule_match;
-	struct hlist_head audit_rule_free;
-#endif /* CONFIG_AUDIT */
-#ifdef CONFIG_BPF_SYSCALL
-	struct hlist_head bpf;
-	struct hlist_head bpf_map;
-	struct hlist_head bpf_prog;
-	struct hlist_head bpf_map_alloc_security;
-	struct hlist_head bpf_map_free_security;
-	struct hlist_head bpf_prog_alloc_security;
-	struct hlist_head bpf_prog_free_security;
-#endif /* CONFIG_BPF_SYSCALL */
+#define INT_HOOK(_hook_name, ...)	struct hlist_head _hook_name
+#define VOID_HOOK(_hook_name, ...)	struct hlist_head _hook_name
+#include <linux/lsm_hook_types.h>
+#undef INT_HOOK
+#undef VOID_HOOK
 } __randomize_layout;
 
 /*
-- 
2.14.1
