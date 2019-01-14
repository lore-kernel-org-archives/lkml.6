Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13EDFC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A65C20659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AT6YllU0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfANILT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 03:11:19 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:53006 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfANILT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 03:11:19 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0E88xde041383;
        Mon, 14 Jan 2019 08:10:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2018-07-02;
 bh=Be+P6SguDy10UImQc/GmPkyoQtAFP0sZhmiIXsbzRkU=;
 b=AT6YllU0SbThd6aN7zQfgWJ1ge4hSx0Q0kOGzv8Ey6ma6Xj8Js8lPQ5Al8Z59vXpNJ3J
 +8GUjxXE5GQdoJ7QVachWwYEcmw+fGv3QDfuxv4V7b5gNEZqnlQkL7TBF/c0EWtMR42J
 oLNJXR2Tsu1xnirmlUBBGmMmf2WsPllpr4ovIegCsLhOFvRTnASw02K6avvzLsCfVqqn
 znDArUEs1Frp9qv6gCB4MP39FN4mj9ezAD0/mlF6TEqFngpse+w88x6m6WnLtIrCdp3l
 psLCS2gHEHsFk7uCHmx5il6OYC0bhhafHOP925GEV21vcIgASdE4ny6S+hMmDLDYPq+c 0g== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2pybkc3xrf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Jan 2019 08:10:04 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0E8A361026737
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Jan 2019 08:10:04 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0E8A2KE015016;
        Mon, 14 Jan 2019 08:10:02 GMT
Received: from kadam (/197.157.34.163)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 14 Jan 2019 00:10:00 -0800
Date:   Mon, 14 Jan 2019 11:09:51 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@01.org, Todd Kjos <tkjos@android.com>
Cc:     kbuild-all@01.org, tkjos@google.com, gregkh@linuxfoundation.org,
        arve@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, maco@google.com,
        joel@joelfernandes.org, kernel-team@android.com
Subject: Re: [PATCH] binder: create node flag to request sender's security
 context
Message-ID: <20190114080951.GB4504@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190110182100.186199-1-tkjos@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9135 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901140071
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Todd,

url:    https://github.com/0day-ci/linux/commits/Todd-Kjos/binder-create-node-flag-to-request-sender-s-security-context/20190111-095225

New smatch warnings:
drivers/android/binder.c:4364 binder_thread_read() warn: check that 'tr.secctx' doesn't leak information

# https://github.com/0day-ci/linux/commit/17c44224a75b813d0f0e29430f77576e8453d174
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 17c44224a75b813d0f0e29430f77576e8453d174
vim +4364 drivers/android/binder.c

44d8047f1 drivers/android/binder.c         Todd Kjos          2018-08-28  4022  
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4023  static int binder_thread_read(struct binder_proc *proc,
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4024  			      struct binder_thread *thread,
da49889de drivers/staging/android/binder.c Arve Hjønnevåg     2014-02-21  4025  			      binder_uintptr_t binder_buffer, size_t size,
da49889de drivers/staging/android/binder.c Arve Hjønnevåg     2014-02-21  4026  			      binder_size_t *consumed, int non_block)
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4027  {
da49889de drivers/staging/android/binder.c Arve Hjønnevåg     2014-02-21  4028  	void __user *buffer = (void __user *)(uintptr_t)binder_buffer;
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4029  	void __user *ptr = buffer + *consumed;
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4030  	void __user *end = buffer + size;
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4031  
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4032  	int ret = 0;
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4033  	int wait_for_proc_work;
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4034  
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4035  	if (*consumed == 0) {
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4036  		if (put_user(BR_NOOP, (uint32_t __user *)ptr))
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4037  			return -EFAULT;
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4038  		ptr += sizeof(uint32_t);
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4039  	}
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4040  
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4041  retry:
0b89d69a9 drivers/android/binder.c         Martijn Coenen     2017-06-29  4042  	binder_inner_proc_lock(proc);
1b77e9dcc drivers/android/binder.c         Martijn Coenen     2017-08-31  4043  	wait_for_proc_work = binder_available_for_proc_work_ilocked(thread);
0b89d69a9 drivers/android/binder.c         Martijn Coenen     2017-06-29  4044  	binder_inner_proc_unlock(proc);
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4045  
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4046  	thread->looper |= BINDER_LOOPER_STATE_WAITING;
975a1ac9a drivers/staging/android/binder.c Arve Hjønnevåg     2012-10-16  4047  
975a1ac9a drivers/staging/android/binder.c Arve Hjønnevåg     2012-10-16  4048  	trace_binder_wait_for_work(wait_for_proc_work,
975a1ac9a drivers/staging/android/binder.c Arve Hjønnevåg     2012-10-16  4049  				   !!thread->transaction_stack,
72196393a drivers/android/binder.c         Todd Kjos          2017-06-29  4050  				   !binder_worklist_empty(proc, &thread->todo));
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4051  	if (wait_for_proc_work) {
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4052  		if (!(thread->looper & (BINDER_LOOPER_STATE_REGISTERED |
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4053  					BINDER_LOOPER_STATE_ENTERED))) {
56b468fc7 drivers/staging/android/binder.c Anmol Sarma        2012-10-30  4054  			binder_user_error("%d:%d ERROR: Thread waiting for process work before calling BC_REGISTER_LOOPER or BC_ENTER_LOOPER (state %x)\n",
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4055  				proc->pid, thread->pid, thread->looper);
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4056  			wait_event_interruptible(binder_user_error_wait,
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4057  						 binder_stop_on_user_error < 2);
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4058  		}
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4059  		binder_set_nice(proc->default_priority);
1b77e9dcc drivers/android/binder.c         Martijn Coenen     2017-08-31  4060  	}
1b77e9dcc drivers/android/binder.c         Martijn Coenen     2017-08-31  4061  
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4062  	if (non_block) {
1b77e9dcc drivers/android/binder.c         Martijn Coenen     2017-08-31  4063  		if (!binder_has_work(thread, wait_for_proc_work))
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4064  			ret = -EAGAIN;
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4065  	} else {
1b77e9dcc drivers/android/binder.c         Martijn Coenen     2017-08-31  4066  		ret = binder_wait_for_work(thread, wait_for_proc_work);
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4067  	}
975a1ac9a drivers/staging/android/binder.c Arve Hjønnevåg     2012-10-16  4068  
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4069  	thread->looper &= ~BINDER_LOOPER_STATE_WAITING;
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4070  
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4071  	if (ret)
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4072  		return ret;
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4073  
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4074  	while (1) {
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4075  		uint32_t cmd;
17c44224a drivers/android/binder.c         Todd Kjos          2019-01-10  4076  		struct binder_transaction_data_secctx tr;
17c44224a drivers/android/binder.c         Todd Kjos          2019-01-10  4077  		struct binder_transaction_data *trd = &tr.transaction_data;
72196393a drivers/android/binder.c         Todd Kjos          2017-06-29  4078  		struct binder_work *w = NULL;
72196393a drivers/android/binder.c         Todd Kjos          2017-06-29  4079  		struct list_head *list = NULL;
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4080  		struct binder_transaction *t = NULL;
7a4408c6b drivers/android/binder.c         Todd Kjos          2017-06-29  4081  		struct binder_thread *t_from;
17c44224a drivers/android/binder.c         Todd Kjos          2019-01-10  4082  		size_t trsize = sizeof(*trd);
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4083  
ed29721e2 drivers/android/binder.c         Todd Kjos          2017-06-29  4084  		binder_inner_proc_lock(proc);
72196393a drivers/android/binder.c         Todd Kjos          2017-06-29  4085  		if (!binder_worklist_empty_ilocked(&thread->todo))
72196393a drivers/android/binder.c         Todd Kjos          2017-06-29  4086  			list = &thread->todo;
72196393a drivers/android/binder.c         Todd Kjos          2017-06-29  4087  		else if (!binder_worklist_empty_ilocked(&proc->todo) &&
72196393a drivers/android/binder.c         Todd Kjos          2017-06-29  4088  			   wait_for_proc_work)
72196393a drivers/android/binder.c         Todd Kjos          2017-06-29  4089  			list = &proc->todo;
72196393a drivers/android/binder.c         Todd Kjos          2017-06-29  4090  		else {
72196393a drivers/android/binder.c         Todd Kjos          2017-06-29  4091  			binder_inner_proc_unlock(proc);
72196393a drivers/android/binder.c         Todd Kjos          2017-06-29  4092  
395262a9e drivers/staging/android/binder.c Dmitry Voytik      2014-09-08  4093  			/* no data added */
08dabceef drivers/android/binder.c         Todd Kjos          2017-06-29  4094  			if (ptr - buffer == 4 && !thread->looper_need_return)
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4095  				goto retry;
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4096  			break;
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4097  		}
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4098  
ed29721e2 drivers/android/binder.c         Todd Kjos          2017-06-29  4099  		if (end - ptr < sizeof(tr) + 4) {
ed29721e2 drivers/android/binder.c         Todd Kjos          2017-06-29  4100  			binder_inner_proc_unlock(proc);
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4101  			break;
ed29721e2 drivers/android/binder.c         Todd Kjos          2017-06-29  4102  		}
72196393a drivers/android/binder.c         Todd Kjos          2017-06-29  4103  		w = binder_dequeue_work_head_ilocked(list);
148ade2c4 drivers/android/binder.c         Martijn Coenen     2017-11-15  4104  		if (binder_worklist_empty_ilocked(&thread->todo))
148ade2c4 drivers/android/binder.c         Martijn Coenen     2017-11-15  4105  			thread->process_todo = false;
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4106  
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4107  		switch (w->type) {
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4108  		case BINDER_WORK_TRANSACTION: {
ed29721e2 drivers/android/binder.c         Todd Kjos          2017-06-29  4109  			binder_inner_proc_unlock(proc);
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4110  			t = container_of(w, struct binder_transaction, work);
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4111  		} break;
26549d177 drivers/android/binder.c         Todd Kjos          2017-06-29  4112  		case BINDER_WORK_RETURN_ERROR: {
26549d177 drivers/android/binder.c         Todd Kjos          2017-06-29  4113  			struct binder_error *e = container_of(
26549d177 drivers/android/binder.c         Todd Kjos          2017-06-29  4114  					w, struct binder_error, work);
26549d177 drivers/android/binder.c         Todd Kjos          2017-06-29  4115  
26549d177 drivers/android/binder.c         Todd Kjos          2017-06-29  4116  			WARN_ON(e->cmd == BR_OK);
ed29721e2 drivers/android/binder.c         Todd Kjos          2017-06-29  4117  			binder_inner_proc_unlock(proc);
26549d177 drivers/android/binder.c         Todd Kjos          2017-06-29  4118  			if (put_user(e->cmd, (uint32_t __user *)ptr))
26549d177 drivers/android/binder.c         Todd Kjos          2017-06-29  4119  				return -EFAULT;
838d55656 drivers/android/binder.c         宋金时             2018-05-10  4120  			cmd = e->cmd;
26549d177 drivers/android/binder.c         Todd Kjos          2017-06-29  4121  			e->cmd = BR_OK;
26549d177 drivers/android/binder.c         Todd Kjos          2017-06-29  4122  			ptr += sizeof(uint32_t);
26549d177 drivers/android/binder.c         Todd Kjos          2017-06-29  4123  
838d55656 drivers/android/binder.c         宋金时             2018-05-10  4124  			binder_stat_br(proc, thread, cmd);
26549d177 drivers/android/binder.c         Todd Kjos          2017-06-29  4125  		} break;
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4126  		case BINDER_WORK_TRANSACTION_COMPLETE: {
ed29721e2 drivers/android/binder.c         Todd Kjos          2017-06-29  4127  			binder_inner_proc_unlock(proc);
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4128  			cmd = BR_TRANSACTION_COMPLETE;
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4129  			if (put_user(cmd, (uint32_t __user *)ptr))
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4130  				return -EFAULT;
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4131  			ptr += sizeof(uint32_t);
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4132  
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4133  			binder_stat_br(proc, thread, cmd);
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4134  			binder_debug(BINDER_DEBUG_TRANSACTION_COMPLETE,
56b468fc7 drivers/staging/android/binder.c Anmol Sarma        2012-10-30  4135  				     "%d:%d BR_TRANSACTION_COMPLETE\n",
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4136  				     proc->pid, thread->pid);
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4137  			kfree(w);
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4138  			binder_stats_deleted(BINDER_STAT_TRANSACTION_COMPLETE);
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4139  		} break;
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4140  		case BINDER_WORK_NODE: {
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4141  			struct binder_node *node = container_of(w, struct binder_node, work);
26b47d8a1 drivers/android/binder.c         Todd Kjos          2017-06-29  4142  			int strong, weak;
26b47d8a1 drivers/android/binder.c         Todd Kjos          2017-06-29  4143  			binder_uintptr_t node_ptr = node->ptr;
26b47d8a1 drivers/android/binder.c         Todd Kjos          2017-06-29  4144  			binder_uintptr_t node_cookie = node->cookie;
26b47d8a1 drivers/android/binder.c         Todd Kjos          2017-06-29  4145  			int node_debug_id = node->debug_id;
26b47d8a1 drivers/android/binder.c         Todd Kjos          2017-06-29  4146  			int has_weak_ref;
26b47d8a1 drivers/android/binder.c         Todd Kjos          2017-06-29  4147  			int has_strong_ref;
26b47d8a1 drivers/android/binder.c         Todd Kjos          2017-06-29  4148  			void __user *orig_ptr = ptr;
26b47d8a1 drivers/android/binder.c         Todd Kjos          2017-06-29  4149  
26b47d8a1 drivers/android/binder.c         Todd Kjos          2017-06-29  4150  			BUG_ON(proc != node->proc);
26b47d8a1 drivers/android/binder.c         Todd Kjos          2017-06-29  4151  			strong = node->internal_strong_refs ||
26b47d8a1 drivers/android/binder.c         Todd Kjos          2017-06-29  4152  					node->local_strong_refs;
26b47d8a1 drivers/android/binder.c         Todd Kjos          2017-06-29  4153  			weak = !hlist_empty(&node->refs) ||
adc188422 drivers/android/binder.c         Todd Kjos          2017-06-29  4154  					node->local_weak_refs ||
adc188422 drivers/android/binder.c         Todd Kjos          2017-06-29  4155  					node->tmp_refs || strong;
26b47d8a1 drivers/android/binder.c         Todd Kjos          2017-06-29  4156  			has_strong_ref = node->has_strong_ref;
26b47d8a1 drivers/android/binder.c         Todd Kjos          2017-06-29  4157  			has_weak_ref = node->has_weak_ref;
26b47d8a1 drivers/android/binder.c         Todd Kjos          2017-06-29  4158  
26b47d8a1 drivers/android/binder.c         Todd Kjos          2017-06-29  4159  			if (weak && !has_weak_ref) {
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4160  				node->has_weak_ref = 1;
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4161  				node->pending_weak_ref = 1;
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4162  				node->local_weak_refs++;
26b47d8a1 drivers/android/binder.c         Todd Kjos          2017-06-29  4163  			}
26b47d8a1 drivers/android/binder.c         Todd Kjos          2017-06-29  4164  			if (strong && !has_strong_ref) {
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4165  				node->has_strong_ref = 1;
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4166  				node->pending_strong_ref = 1;
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4167  				node->local_strong_refs++;
26b47d8a1 drivers/android/binder.c         Todd Kjos          2017-06-29  4168  			}
26b47d8a1 drivers/android/binder.c         Todd Kjos          2017-06-29  4169  			if (!strong && has_strong_ref)
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4170  				node->has_strong_ref = 0;
26b47d8a1 drivers/android/binder.c         Todd Kjos          2017-06-29  4171  			if (!weak && has_weak_ref)
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4172  				node->has_weak_ref = 0;
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4173  			if (!weak && !strong) {
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4174  				binder_debug(BINDER_DEBUG_INTERNAL_REFS,
da49889de drivers/staging/android/binder.c Arve Hjønnevåg     2014-02-21  4175  					     "%d:%d node %d u%016llx c%016llx deleted\n",
da49889de drivers/staging/android/binder.c Arve Hjønnevåg     2014-02-21  4176  					     proc->pid, thread->pid,
26b47d8a1 drivers/android/binder.c         Todd Kjos          2017-06-29  4177  					     node_debug_id,
26b47d8a1 drivers/android/binder.c         Todd Kjos          2017-06-29  4178  					     (u64)node_ptr,
26b47d8a1 drivers/android/binder.c         Todd Kjos          2017-06-29  4179  					     (u64)node_cookie);
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4180  				rb_erase(&node->rb_node, &proc->nodes);
ed29721e2 drivers/android/binder.c         Todd Kjos          2017-06-29  4181  				binder_inner_proc_unlock(proc);
673068eee drivers/android/binder.c         Todd Kjos          2017-06-29  4182  				binder_node_lock(node);
673068eee drivers/android/binder.c         Todd Kjos          2017-06-29  4183  				/*
673068eee drivers/android/binder.c         Todd Kjos          2017-06-29  4184  				 * Acquire the node lock before freeing the
673068eee drivers/android/binder.c         Todd Kjos          2017-06-29  4185  				 * node to serialize with other threads that
673068eee drivers/android/binder.c         Todd Kjos          2017-06-29  4186  				 * may have been holding the node lock while
673068eee drivers/android/binder.c         Todd Kjos          2017-06-29  4187  				 * decrementing this node (avoids race where
673068eee drivers/android/binder.c         Todd Kjos          2017-06-29  4188  				 * this thread frees while the other thread
673068eee drivers/android/binder.c         Todd Kjos          2017-06-29  4189  				 * is unlocking the node after the final
673068eee drivers/android/binder.c         Todd Kjos          2017-06-29  4190  				 * decrement)
673068eee drivers/android/binder.c         Todd Kjos          2017-06-29  4191  				 */
673068eee drivers/android/binder.c         Todd Kjos          2017-06-29  4192  				binder_node_unlock(node);
ed29721e2 drivers/android/binder.c         Todd Kjos          2017-06-29  4193  				binder_free_node(node);
ed29721e2 drivers/android/binder.c         Todd Kjos          2017-06-29  4194  			} else
ed29721e2 drivers/android/binder.c         Todd Kjos          2017-06-29  4195  				binder_inner_proc_unlock(proc);
ed29721e2 drivers/android/binder.c         Todd Kjos          2017-06-29  4196  
26b47d8a1 drivers/android/binder.c         Todd Kjos          2017-06-29  4197  			if (weak && !has_weak_ref)
26b47d8a1 drivers/android/binder.c         Todd Kjos          2017-06-29  4198  				ret = binder_put_node_cmd(
26b47d8a1 drivers/android/binder.c         Todd Kjos          2017-06-29  4199  						proc, thread, &ptr, node_ptr,
26b47d8a1 drivers/android/binder.c         Todd Kjos          2017-06-29  4200  						node_cookie, node_debug_id,
26b47d8a1 drivers/android/binder.c         Todd Kjos          2017-06-29  4201  						BR_INCREFS, "BR_INCREFS");
26b47d8a1 drivers/android/binder.c         Todd Kjos          2017-06-29  4202  			if (!ret && strong && !has_strong_ref)
26b47d8a1 drivers/android/binder.c         Todd Kjos          2017-06-29  4203  				ret = binder_put_node_cmd(
26b47d8a1 drivers/android/binder.c         Todd Kjos          2017-06-29  4204  						proc, thread, &ptr, node_ptr,
26b47d8a1 drivers/android/binder.c         Todd Kjos          2017-06-29  4205  						node_cookie, node_debug_id,
26b47d8a1 drivers/android/binder.c         Todd Kjos          2017-06-29  4206  						BR_ACQUIRE, "BR_ACQUIRE");
26b47d8a1 drivers/android/binder.c         Todd Kjos          2017-06-29  4207  			if (!ret && !strong && has_strong_ref)
26b47d8a1 drivers/android/binder.c         Todd Kjos          2017-06-29  4208  				ret = binder_put_node_cmd(
26b47d8a1 drivers/android/binder.c         Todd Kjos          2017-06-29  4209  						proc, thread, &ptr, node_ptr,
26b47d8a1 drivers/android/binder.c         Todd Kjos          2017-06-29  4210  						node_cookie, node_debug_id,
26b47d8a1 drivers/android/binder.c         Todd Kjos          2017-06-29  4211  						BR_RELEASE, "BR_RELEASE");
26b47d8a1 drivers/android/binder.c         Todd Kjos          2017-06-29  4212  			if (!ret && !weak && has_weak_ref)
26b47d8a1 drivers/android/binder.c         Todd Kjos          2017-06-29  4213  				ret = binder_put_node_cmd(
26b47d8a1 drivers/android/binder.c         Todd Kjos          2017-06-29  4214  						proc, thread, &ptr, node_ptr,
26b47d8a1 drivers/android/binder.c         Todd Kjos          2017-06-29  4215  						node_cookie, node_debug_id,
26b47d8a1 drivers/android/binder.c         Todd Kjos          2017-06-29  4216  						BR_DECREFS, "BR_DECREFS");
26b47d8a1 drivers/android/binder.c         Todd Kjos          2017-06-29  4217  			if (orig_ptr == ptr)
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4218  				binder_debug(BINDER_DEBUG_INTERNAL_REFS,
da49889de drivers/staging/android/binder.c Arve Hjønnevåg     2014-02-21  4219  					     "%d:%d node %d u%016llx c%016llx state unchanged\n",
da49889de drivers/staging/android/binder.c Arve Hjønnevåg     2014-02-21  4220  					     proc->pid, thread->pid,
26b47d8a1 drivers/android/binder.c         Todd Kjos          2017-06-29  4221  					     node_debug_id,
26b47d8a1 drivers/android/binder.c         Todd Kjos          2017-06-29  4222  					     (u64)node_ptr,
26b47d8a1 drivers/android/binder.c         Todd Kjos          2017-06-29  4223  					     (u64)node_cookie);
26b47d8a1 drivers/android/binder.c         Todd Kjos          2017-06-29  4224  			if (ret)
26b47d8a1 drivers/android/binder.c         Todd Kjos          2017-06-29  4225  				return ret;
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4226  		} break;
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4227  		case BINDER_WORK_DEAD_BINDER:
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4228  		case BINDER_WORK_DEAD_BINDER_AND_CLEAR:
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4229  		case BINDER_WORK_CLEAR_DEATH_NOTIFICATION: {
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4230  			struct binder_ref_death *death;
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4231  			uint32_t cmd;
ab51ec6bd drivers/android/binder.c         Martijn Coenen     2017-06-29  4232  			binder_uintptr_t cookie;
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4233  
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4234  			death = container_of(w, struct binder_ref_death, work);
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4235  			if (w->type == BINDER_WORK_CLEAR_DEATH_NOTIFICATION)
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4236  				cmd = BR_CLEAR_DEATH_NOTIFICATION_DONE;
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4237  			else
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4238  				cmd = BR_DEAD_BINDER;
ab51ec6bd drivers/android/binder.c         Martijn Coenen     2017-06-29  4239  			cookie = death->cookie;
ab51ec6bd drivers/android/binder.c         Martijn Coenen     2017-06-29  4240  
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4241  			binder_debug(BINDER_DEBUG_DEATH_NOTIFICATION,
da49889de drivers/staging/android/binder.c Arve Hjønnevåg     2014-02-21  4242  				     "%d:%d %s %016llx\n",
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4243  				      proc->pid, thread->pid,
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4244  				      cmd == BR_DEAD_BINDER ?
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4245  				      "BR_DEAD_BINDER" :
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4246  				      "BR_CLEAR_DEATH_NOTIFICATION_DONE",
ab51ec6bd drivers/android/binder.c         Martijn Coenen     2017-06-29  4247  				      (u64)cookie);
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4248  			if (w->type == BINDER_WORK_CLEAR_DEATH_NOTIFICATION) {
ab51ec6bd drivers/android/binder.c         Martijn Coenen     2017-06-29  4249  				binder_inner_proc_unlock(proc);
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4250  				kfree(death);
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4251  				binder_stats_deleted(BINDER_STAT_DEATH);
ed29721e2 drivers/android/binder.c         Todd Kjos          2017-06-29  4252  			} else {
72196393a drivers/android/binder.c         Todd Kjos          2017-06-29  4253  				binder_enqueue_work_ilocked(
72196393a drivers/android/binder.c         Todd Kjos          2017-06-29  4254  						w, &proc->delivered_death);
ed29721e2 drivers/android/binder.c         Todd Kjos          2017-06-29  4255  				binder_inner_proc_unlock(proc);
ed29721e2 drivers/android/binder.c         Todd Kjos          2017-06-29  4256  			}
ab51ec6bd drivers/android/binder.c         Martijn Coenen     2017-06-29  4257  			if (put_user(cmd, (uint32_t __user *)ptr))
ab51ec6bd drivers/android/binder.c         Martijn Coenen     2017-06-29  4258  				return -EFAULT;
ab51ec6bd drivers/android/binder.c         Martijn Coenen     2017-06-29  4259  			ptr += sizeof(uint32_t);
ab51ec6bd drivers/android/binder.c         Martijn Coenen     2017-06-29  4260  			if (put_user(cookie,
ab51ec6bd drivers/android/binder.c         Martijn Coenen     2017-06-29  4261  				     (binder_uintptr_t __user *)ptr))
ab51ec6bd drivers/android/binder.c         Martijn Coenen     2017-06-29  4262  				return -EFAULT;
ab51ec6bd drivers/android/binder.c         Martijn Coenen     2017-06-29  4263  			ptr += sizeof(binder_uintptr_t);
ab51ec6bd drivers/android/binder.c         Martijn Coenen     2017-06-29  4264  			binder_stat_br(proc, thread, cmd);
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4265  			if (cmd == BR_DEAD_BINDER)
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4266  				goto done; /* DEAD_BINDER notifications can cause transactions */
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4267  		} break;
324fa64cf drivers/android/binder.c         Todd Kjos          2018-11-06  4268  		default:
324fa64cf drivers/android/binder.c         Todd Kjos          2018-11-06  4269  			binder_inner_proc_unlock(proc);
324fa64cf drivers/android/binder.c         Todd Kjos          2018-11-06  4270  			pr_err("%d:%d: bad work type %d\n",
324fa64cf drivers/android/binder.c         Todd Kjos          2018-11-06  4271  			       proc->pid, thread->pid, w->type);
324fa64cf drivers/android/binder.c         Todd Kjos          2018-11-06  4272  			break;
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4273  		}
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4274  
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4275  		if (!t)
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4276  			continue;
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4277  
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4278  		BUG_ON(t->buffer == NULL);
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4279  		if (t->buffer->target_node) {
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4280  			struct binder_node *target_node = t->buffer->target_node;
10f62861b drivers/staging/android/binder.c Seunghun Lee       2014-05-01  4281  
17c44224a drivers/android/binder.c         Todd Kjos          2019-01-10  4282  			trd->target.ptr = target_node->ptr;
17c44224a drivers/android/binder.c         Todd Kjos          2019-01-10  4283  			trd->cookie =  target_node->cookie;
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4284  			t->saved_priority = task_nice(current);
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4285  			if (t->priority < target_node->min_priority &&
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4286  			    !(t->flags & TF_ONE_WAY))
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4287  				binder_set_nice(t->priority);
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4288  			else if (!(t->flags & TF_ONE_WAY) ||
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4289  				 t->saved_priority > target_node->min_priority)
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4290  				binder_set_nice(target_node->min_priority);
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4291  			cmd = BR_TRANSACTION;
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4292  		} else {
17c44224a drivers/android/binder.c         Todd Kjos          2019-01-10  4293  			trd->target.ptr = 0;
17c44224a drivers/android/binder.c         Todd Kjos          2019-01-10  4294  			trd->cookie = 0;
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4295  			cmd = BR_REPLY;
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4296  		}
17c44224a drivers/android/binder.c         Todd Kjos          2019-01-10  4297  		trd->code = t->code;
17c44224a drivers/android/binder.c         Todd Kjos          2019-01-10  4298  		trd->flags = t->flags;
17c44224a drivers/android/binder.c         Todd Kjos          2019-01-10  4299  		trd->sender_euid = from_kuid(current_user_ns(), t->sender_euid);
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4300  
7a4408c6b drivers/android/binder.c         Todd Kjos          2017-06-29  4301  		t_from = binder_get_txn_from(t);
7a4408c6b drivers/android/binder.c         Todd Kjos          2017-06-29  4302  		if (t_from) {
7a4408c6b drivers/android/binder.c         Todd Kjos          2017-06-29  4303  			struct task_struct *sender = t_from->proc->tsk;
10f62861b drivers/staging/android/binder.c Seunghun Lee       2014-05-01  4304  
17c44224a drivers/android/binder.c         Todd Kjos          2019-01-10  4305  			trd->sender_pid =
17c44224a drivers/android/binder.c         Todd Kjos          2019-01-10  4306  				task_tgid_nr_ns(sender,
17cf22c33 drivers/staging/android/binder.c Eric W. Biederman  2010-03-02  4307  						task_active_pid_ns(current));
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4308  		} else {
17c44224a drivers/android/binder.c         Todd Kjos          2019-01-10  4309  			trd->sender_pid = 0;
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4310  		}
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4311  
44d8047f1 drivers/android/binder.c         Todd Kjos          2018-08-28  4312  		ret = binder_apply_fd_fixups(t);
44d8047f1 drivers/android/binder.c         Todd Kjos          2018-08-28  4313  		if (ret) {
44d8047f1 drivers/android/binder.c         Todd Kjos          2018-08-28  4314  			struct binder_buffer *buffer = t->buffer;
44d8047f1 drivers/android/binder.c         Todd Kjos          2018-08-28  4315  			bool oneway = !!(t->flags & TF_ONE_WAY);
44d8047f1 drivers/android/binder.c         Todd Kjos          2018-08-28  4316  			int tid = t->debug_id;
44d8047f1 drivers/android/binder.c         Todd Kjos          2018-08-28  4317  
44d8047f1 drivers/android/binder.c         Todd Kjos          2018-08-28  4318  			if (t_from)
44d8047f1 drivers/android/binder.c         Todd Kjos          2018-08-28  4319  				binder_thread_dec_tmpref(t_from);
44d8047f1 drivers/android/binder.c         Todd Kjos          2018-08-28  4320  			buffer->transaction = NULL;
44d8047f1 drivers/android/binder.c         Todd Kjos          2018-08-28  4321  			binder_cleanup_transaction(t, "fd fixups failed",
44d8047f1 drivers/android/binder.c         Todd Kjos          2018-08-28  4322  						   BR_FAILED_REPLY);
44d8047f1 drivers/android/binder.c         Todd Kjos          2018-08-28  4323  			binder_free_buf(proc, buffer);
44d8047f1 drivers/android/binder.c         Todd Kjos          2018-08-28  4324  			binder_debug(BINDER_DEBUG_FAILED_TRANSACTION,
44d8047f1 drivers/android/binder.c         Todd Kjos          2018-08-28  4325  				     "%d:%d %stransaction %d fd fixups failed %d/%d, line %d\n",
44d8047f1 drivers/android/binder.c         Todd Kjos          2018-08-28  4326  				     proc->pid, thread->pid,
44d8047f1 drivers/android/binder.c         Todd Kjos          2018-08-28  4327  				     oneway ? "async " :
44d8047f1 drivers/android/binder.c         Todd Kjos          2018-08-28  4328  					(cmd == BR_REPLY ? "reply " : ""),
44d8047f1 drivers/android/binder.c         Todd Kjos          2018-08-28  4329  				     tid, BR_FAILED_REPLY, ret, __LINE__);
44d8047f1 drivers/android/binder.c         Todd Kjos          2018-08-28  4330  			if (cmd == BR_REPLY) {
44d8047f1 drivers/android/binder.c         Todd Kjos          2018-08-28  4331  				cmd = BR_FAILED_REPLY;
44d8047f1 drivers/android/binder.c         Todd Kjos          2018-08-28  4332  				if (put_user(cmd, (uint32_t __user *)ptr))
44d8047f1 drivers/android/binder.c         Todd Kjos          2018-08-28  4333  					return -EFAULT;
44d8047f1 drivers/android/binder.c         Todd Kjos          2018-08-28  4334  				ptr += sizeof(uint32_t);
44d8047f1 drivers/android/binder.c         Todd Kjos          2018-08-28  4335  				binder_stat_br(proc, thread, cmd);
44d8047f1 drivers/android/binder.c         Todd Kjos          2018-08-28  4336  				break;
44d8047f1 drivers/android/binder.c         Todd Kjos          2018-08-28  4337  			}
44d8047f1 drivers/android/binder.c         Todd Kjos          2018-08-28  4338  			continue;
44d8047f1 drivers/android/binder.c         Todd Kjos          2018-08-28  4339  		}
17c44224a drivers/android/binder.c         Todd Kjos          2019-01-10  4340  		trd->data_size = t->buffer->data_size;
17c44224a drivers/android/binder.c         Todd Kjos          2019-01-10  4341  		trd->offsets_size = t->buffer->offsets_size;
17c44224a drivers/android/binder.c         Todd Kjos          2019-01-10  4342  		trd->data.ptr.buffer = (binder_uintptr_t)
19c987241 drivers/android/binder.c         Todd Kjos          2017-06-29  4343  			((uintptr_t)t->buffer->data +
19c987241 drivers/android/binder.c         Todd Kjos          2017-06-29  4344  			binder_alloc_get_user_buffer_offset(&proc->alloc));
17c44224a drivers/android/binder.c         Todd Kjos          2019-01-10  4345  		trd->data.ptr.offsets = trd->data.ptr.buffer +
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4346  					ALIGN(t->buffer->data_size,
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4347  					    sizeof(void *));
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4348  
17c44224a drivers/android/binder.c         Todd Kjos          2019-01-10  4349  		if (t->security_ctx) {
17c44224a drivers/android/binder.c         Todd Kjos          2019-01-10  4350  			cmd = BR_TRANSACTION_SEC_CTX;
17c44224a drivers/android/binder.c         Todd Kjos          2019-01-10  4351  			tr.secctx = t->security_ctx;
17c44224a drivers/android/binder.c         Todd Kjos          2019-01-10  4352  			trsize = sizeof(tr);
17c44224a drivers/android/binder.c         Todd Kjos          2019-01-10  4353  		}
7a4408c6b drivers/android/binder.c         Todd Kjos          2017-06-29  4354  		if (put_user(cmd, (uint32_t __user *)ptr)) {
7a4408c6b drivers/android/binder.c         Todd Kjos          2017-06-29  4355  			if (t_from)
7a4408c6b drivers/android/binder.c         Todd Kjos          2017-06-29  4356  				binder_thread_dec_tmpref(t_from);
fb2c44527 drivers/android/binder.c         Martijn Coenen     2017-11-13  4357  
fb2c44527 drivers/android/binder.c         Martijn Coenen     2017-11-13  4358  			binder_cleanup_transaction(t, "put_user failed",
fb2c44527 drivers/android/binder.c         Martijn Coenen     2017-11-13  4359  						   BR_FAILED_REPLY);
fb2c44527 drivers/android/binder.c         Martijn Coenen     2017-11-13  4360  
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4361  			return -EFAULT;
7a4408c6b drivers/android/binder.c         Todd Kjos          2017-06-29  4362  		}
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4363  		ptr += sizeof(uint32_t);
17c44224a drivers/android/binder.c         Todd Kjos          2019-01-10 @4364  		if (copy_to_user(ptr, &tr, trsize)) {
7a4408c6b drivers/android/binder.c         Todd Kjos          2017-06-29  4365  			if (t_from)
7a4408c6b drivers/android/binder.c         Todd Kjos          2017-06-29  4366  				binder_thread_dec_tmpref(t_from);
fb2c44527 drivers/android/binder.c         Martijn Coenen     2017-11-13  4367  
fb2c44527 drivers/android/binder.c         Martijn Coenen     2017-11-13  4368  			binder_cleanup_transaction(t, "copy_to_user failed",
fb2c44527 drivers/android/binder.c         Martijn Coenen     2017-11-13  4369  						   BR_FAILED_REPLY);
fb2c44527 drivers/android/binder.c         Martijn Coenen     2017-11-13  4370  
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4371  			return -EFAULT;
7a4408c6b drivers/android/binder.c         Todd Kjos          2017-06-29  4372  		}
17c44224a drivers/android/binder.c         Todd Kjos          2019-01-10  4373  		ptr += trsize;
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4374  
975a1ac9a drivers/staging/android/binder.c Arve Hjønnevåg     2012-10-16  4375  		trace_binder_transaction_received(t);
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4376  		binder_stat_br(proc, thread, cmd);
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4377  		binder_debug(BINDER_DEBUG_TRANSACTION,
da49889de drivers/staging/android/binder.c Arve Hjønnevåg     2014-02-21  4378  			     "%d:%d %s %d %d:%d, cmd %d size %zd-%zd ptr %016llx-%016llx\n",
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4379  			     proc->pid, thread->pid,
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4380  			     (cmd == BR_TRANSACTION) ? "BR_TRANSACTION" :
17c44224a drivers/android/binder.c         Todd Kjos          2019-01-10  4381  				(cmd == BR_TRANSACTION_SEC_CTX) ?
17c44224a drivers/android/binder.c         Todd Kjos          2019-01-10  4382  				     "BR_TRANSACTION_SEC_CTX" : "BR_REPLY",
7a4408c6b drivers/android/binder.c         Todd Kjos          2017-06-29  4383  			     t->debug_id, t_from ? t_from->proc->pid : 0,
7a4408c6b drivers/android/binder.c         Todd Kjos          2017-06-29  4384  			     t_from ? t_from->pid : 0, cmd,
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4385  			     t->buffer->data_size, t->buffer->offsets_size,
17c44224a drivers/android/binder.c         Todd Kjos          2019-01-10  4386  			     (u64)trd->data.ptr.buffer,
17c44224a drivers/android/binder.c         Todd Kjos          2019-01-10  4387  			     (u64)trd->data.ptr.offsets);
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4388  
7a4408c6b drivers/android/binder.c         Todd Kjos          2017-06-29  4389  		if (t_from)
7a4408c6b drivers/android/binder.c         Todd Kjos          2017-06-29  4390  			binder_thread_dec_tmpref(t_from);
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4391  		t->buffer->allow_user_free = 1;
17c44224a drivers/android/binder.c         Todd Kjos          2019-01-10  4392  		if (cmd != BR_REPLY && !(t->flags & TF_ONE_WAY)) {
0b89d69a9 drivers/android/binder.c         Martijn Coenen     2017-06-29  4393  			binder_inner_proc_lock(thread->proc);
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4394  			t->to_parent = thread->transaction_stack;
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4395  			t->to_thread = thread;
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4396  			thread->transaction_stack = t;
0b89d69a9 drivers/android/binder.c         Martijn Coenen     2017-06-29  4397  			binder_inner_proc_unlock(thread->proc);
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4398  		} else {
b6d282cea drivers/android/binder.c         Todd Kjos          2017-06-29  4399  			binder_free_transaction(t);
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4400  		}
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4401  		break;
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4402  	}
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4403  
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4404  done:
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4405  
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4406  	*consumed = ptr - buffer;
b3e686128 drivers/android/binder.c         Todd Kjos          2017-06-29  4407  	binder_inner_proc_lock(proc);
1b77e9dcc drivers/android/binder.c         Martijn Coenen     2017-08-31  4408  	if (proc->requested_threads == 0 &&
1b77e9dcc drivers/android/binder.c         Martijn Coenen     2017-08-31  4409  	    list_empty(&thread->proc->waiting_threads) &&
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4410  	    proc->requested_threads_started < proc->max_threads &&
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4411  	    (thread->looper & (BINDER_LOOPER_STATE_REGISTERED |
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4412  	     BINDER_LOOPER_STATE_ENTERED)) /* the user-space code fails to */
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4413  	     /*spawn a new thread if we leave this out */) {
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4414  		proc->requested_threads++;
b3e686128 drivers/android/binder.c         Todd Kjos          2017-06-29  4415  		binder_inner_proc_unlock(proc);
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4416  		binder_debug(BINDER_DEBUG_THREADS,
56b468fc7 drivers/staging/android/binder.c Anmol Sarma        2012-10-30  4417  			     "%d:%d BR_SPAWN_LOOPER\n",
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4418  			     proc->pid, thread->pid);
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4419  		if (put_user(BR_SPAWN_LOOPER, (uint32_t __user *)buffer))
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4420  			return -EFAULT;
89334ab4d drivers/staging/android/binder.c Arve Hjønnevåg     2012-10-16  4421  		binder_stat_br(proc, thread, BR_SPAWN_LOOPER);
b3e686128 drivers/android/binder.c         Todd Kjos          2017-06-29  4422  	} else
b3e686128 drivers/android/binder.c         Todd Kjos          2017-06-29  4423  		binder_inner_proc_unlock(proc);
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4424  	return 0;
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4425  }
355b0502f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4426  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
