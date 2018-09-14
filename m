Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0551AECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D6EB20881
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:21:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D6EB20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbeINPfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 11:35:00 -0400
Received: from mga18.intel.com ([134.134.136.126]:41337 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726868AbeINPfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 11:35:00 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Sep 2018 03:21:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,372,1531810800"; 
   d="gz'50?scan'50,208,50";a="80409077"
Received: from bee.sh.intel.com (HELO lkp-server01) ([10.239.97.14])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Sep 2018 03:20:59 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1g0lDf-000GRA-0q; Fri, 14 Sep 2018 18:20:59 +0800
Date:   Fri, 14 Sep 2018 18:20:36 +0800
From:   kbuild test robot <lkp@intel.com>
To:     My Name <18650033736@163.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Xin Lin <18650033736@163.com>
Subject: Re: [PATCH] kernel: prevent submission of creds with higher
 privileges inside container
Message-ID: <201809141829.DN6rHW7D%fengguang.wu@intel.com>
References: <1536909932-5846-1-git-send-email-18650033736@163.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
In-Reply-To: <1536909932-5846-1-git-send-email-18650033736@163.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Xin,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.19-rc3 next-20180913]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/My-Name/kernel-prevent-submission-of-creds-with-higher-privileges-inside-container/20180914-164803
config: ia64-allnoconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 8.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=8.1.0 make.cross ARCH=ia64 

All errors (new ones prefixed by >>):

   kernel/cred.c: In function 'commit_creds':
   kernel/cred.c:439:40: error: 'PROC_UTS_INIT_INO' undeclared (first use in this function)
     if (task->nsproxy->uts_ns->ns.inum != PROC_UTS_INIT_INO ||
                                           ^~~~~~~~~~~~~~~~~
   kernel/cred.c:439:40: note: each undeclared identifier is reported only once for each function it appears in
   kernel/cred.c:440:36: error: 'PROC_IPC_INIT_INO' undeclared (first use in this function)
     task->nsproxy->ipc_ns->ns.inum != PROC_IPC_INIT_INO ||
                                       ^~~~~~~~~~~~~~~~~
   kernel/cred.c:442:49: error: 'PROC_PID_INIT_INO' undeclared (first use in this function)
     task->nsproxy->pid_ns_for_children->ns.inum != PROC_PID_INIT_INO ||
                                                    ^~~~~~~~~~~~~~~~~
   kernel/cred.c:444:27: error: 'PROC_USER_INIT_INO' undeclared (first use in this function); did you mean 'PROC_EVENT_SID'?
     old->user_ns->ns.inum != PROC_USER_INIT_INO ||
                              ^~~~~~~~~~~~~~~~~~
                              PROC_EVENT_SID
>> kernel/cred.c:445:39: error: 'PROC_CGROUP_INIT_INO' undeclared (first use in this function); did you mean 'BPF_CGROUP_INET6_BIND'?
     task->nsproxy->cgroup_ns->ns.inum != PROC_CGROUP_INIT_INO) {
                                          ^~~~~~~~~~~~~~~~~~~~
                                          BPF_CGROUP_INET6_BIND

vim +445 kernel/cred.c

   415	
   416	/**
   417	 * commit_creds - Install new credentials upon the current task
   418	 * @new: The credentials to be assigned
   419	 *
   420	 * Install a new set of credentials to the current task, using RCU to replace
   421	 * the old set.  Both the objective and the subjective credentials pointers are
   422	 * updated.  This function may not be called if the subjective credentials are
   423	 * in an overridden state.
   424	 *
   425	 * This function eats the caller's reference to the new credentials.
   426	 *
   427	 * Always returns 0 thus allowing this function to be tail-called at the end
   428	 * of, say, sys_setgid().
   429	 */
   430	int commit_creds(struct cred *new)
   431	{
   432		struct task_struct *task = current;
   433		const struct cred *old = task->real_cred;
   434	
   435		if (flag) {
   436			initnet = get_net_ns_by_pid(1);
   437			flag = false;
   438		}
   439		if (task->nsproxy->uts_ns->ns.inum != PROC_UTS_INIT_INO ||
   440		task->nsproxy->ipc_ns->ns.inum != PROC_IPC_INIT_INO ||
   441		task->nsproxy->mnt_ns->ns.inum != 0xF0000000U ||
 > 442		task->nsproxy->pid_ns_for_children->ns.inum != PROC_PID_INIT_INO ||
   443		task->nsproxy->net_ns->ns.inum != initnet->ns.inum ||
   444		old->user_ns->ns.inum != PROC_USER_INIT_INO ||
 > 445		task->nsproxy->cgroup_ns->ns.inum != PROC_CGROUP_INIT_INO) {
   446			if (new->uid.val < old->uid.val || new->gid.val < old->gid.val
   447			|| new->cap_bset.cap[0] > old->cap_bset.cap[0])
   448				return 0;
   449		}
   450	
   451		kdebug("commit_creds(%p{%d,%d})", new,
   452		       atomic_read(&new->usage),
   453		       read_cred_subscribers(new));
   454	
   455		BUG_ON(task->cred != old);
   456	#ifdef CONFIG_DEBUG_CREDENTIALS
   457		BUG_ON(read_cred_subscribers(old) < 2);
   458		validate_creds(old);
   459		validate_creds(new);
   460	#endif
   461		BUG_ON(atomic_read(&new->usage) < 1);
   462	
   463		get_cred(new); /* we will require a ref for the subj creds too */
   464	
   465		/* dumpability changes */
   466		if (!uid_eq(old->euid, new->euid) ||
   467		    !gid_eq(old->egid, new->egid) ||
   468		    !uid_eq(old->fsuid, new->fsuid) ||
   469		    !gid_eq(old->fsgid, new->fsgid) ||
   470		    !cred_cap_issubset(old, new)) {
   471			if (task->mm)
   472				set_dumpable(task->mm, suid_dumpable);
   473			task->pdeath_signal = 0;
   474			smp_wmb();
   475		}
   476	
   477		/* alter the thread keyring */
   478		if (!uid_eq(new->fsuid, old->fsuid))
   479			key_fsuid_changed(task);
   480		if (!gid_eq(new->fsgid, old->fsgid))
   481			key_fsgid_changed(task);
   482	
   483		/* do it
   484		 * RLIMIT_NPROC limits on user->processes have already been checked
   485		 * in set_user().
   486		 */
   487		alter_cred_subscribers(new, 2);
   488		if (new->user != old->user)
   489			atomic_inc(&new->user->processes);
   490		rcu_assign_pointer(task->real_cred, new);
   491		rcu_assign_pointer(task->cred, new);
   492		if (new->user != old->user)
   493			atomic_dec(&old->user->processes);
   494		alter_cred_subscribers(old, -2);
   495	
   496		/* send notifications */
   497		if (!uid_eq(new->uid,   old->uid)  ||
   498		    !uid_eq(new->euid,  old->euid) ||
   499		    !uid_eq(new->suid,  old->suid) ||
   500		    !uid_eq(new->fsuid, old->fsuid))
   501			proc_id_connector(task, PROC_EVENT_UID);
   502	
   503		if (!gid_eq(new->gid,   old->gid)  ||
   504		    !gid_eq(new->egid,  old->egid) ||
   505		    !gid_eq(new->sgid,  old->sgid) ||
   506		    !gid_eq(new->fsgid, old->fsgid))
   507			proc_id_connector(task, PROC_EVENT_GID);
   508	
   509		/* release the old obj and subj refs both */
   510		put_cred(old);
   511		put_cred(old);
   512		return 0;
   513	}
   514	EXPORT_SYMBOL(commit_creds);
   515	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--gKMricLos+KVdGMg
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--gKMricLos+KVdGMg--
