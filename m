Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1732752-1527156141-2-9855131617843101075
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527156141; b=MaDORr51tYzZF2LBQ+F+u8NciUB8Alu2AyE0s2LI2Sgstmptur
    qDAqeOvPNEEIjn/eSMaIeH8MjcsNkRtZkdlAgDE5A3LWV31+wmY5kf8+u8LkwY4+
    xkZYEMy9u6956PL5xYdIUVKNYhCIyAzBW5OkdjGHylWWH+DsakmkJx+8DQETUGGD
    /MUVKoppCMx1teL2Uusl0pUxMA/xvILXKrh3BfpvzYPPdZ+XO6t7Sx0eEiuQ5myQ
    R54Rhd2rHPiDAsd9kNYRPej8EFHOW+9piTd2ZlgZPidK39QXerWNM/AV6YXaojOs
    8v2Skw+qE5V/7+tcG6xWNpSfaw67NCm7JR4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527156141; bh=OdR19075Aes9nO5CDpwg1SJI3/i6PY
    Ov9ESHxNM6E2k=; b=ZgY3FQT59b2cDwXWxcFncy9gN5uGLwFPMWonCrA/u2Vb7j
    2cSk/NRyla6jqxY4hABTnDUzMMpDNt3WP8rMrQjPt2t0G9jrVAAtGiY59iyXVXRt
    1yzLApMYYnEuAUk+041dDtvDlCnefWF/lQ9SEF7Pc1Mm2KEl7G4YzL3l8V4QS4ia
    iGEPYIzYace+gggRddfr0vJqy4rDi94F65spp69X1pveyFlw8/+Lm51n9bZftEEw
    CCRbSQopETmh7SuoT0I83r2hFBXTWncURMF/uPA32eCHdeUcbh/4wMKfprrg9l9l
    2vYZmI8y3xAICP6EFWz/t+Jd39Lryms9ABnhThHA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=HNw7SHgp x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=HNw7SHgp x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLtZBR4nvB2ucVZ6kApmPhwYwymvw9jKTnbZHf8LOG8U8xB+pQoOf7+sVJqbUyJlJMpkdHtu/EvZeczXeqZ/Ue01UYKPjbGl1X+TmfGqXhgz5Jz5O3n9
    76i349ABl/wRlhOPU8ftmnlCWA1dzD5sWnpdoy552ZNMY0AAR5uy3v8TMZQIBbbDYFIu7bwEJV5+1+lWuqNWDaKrxRug2DCOuEELHRjWNdOtd/m3oHbEXn77
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=JX2Zv6e58hTcoUBVBSsA:9
    a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030703AbeEXKCR (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:02:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:48532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031073AbeEXKCN (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 06:02:13 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 076/161] usb: gadget: ffs: Execute copy_to_user() with USER_DS set
Date: Thu, 24 May 2018 11:38:21 +0200
Message-Id: <20180524093027.645208181@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lars-Peter Clausen <lars@metafoo.de>

[ Upstream commit 4058ebf33cb0be88ca516f968eda24ab7b6b93e4 ]

When using a AIO read() operation on the function FS gadget driver a URB is
submitted asynchronously and on URB completion the received data is copied
to the userspace buffer associated with the read operation.

This is done from a kernel worker thread invoking copy_to_user() (through
copy_to_iter()). And while the user space process memory is made available
to the kernel thread using use_mm(), some architecture require in addition
to this that the operation runs with USER_DS set. Otherwise the userspace
memory access will fail.

For example on ARM64 with Privileged Access Never (PAN) and User Access
Override (UAO) enabled the following crash occurs.

	Internal error: Accessing user space memory with fs=KERNEL_DS: 9600004f [#1] SMP
	Modules linked in:
	CPU: 2 PID: 1636 Comm: kworker/2:1 Not tainted 4.9.0-04081-g8ab2dfb-dirty #487
	Hardware name: ZynqMP ZCU102 Rev1.0 (DT)
	Workqueue: events ffs_user_copy_worker
	task: ffffffc87afc8080 task.stack: ffffffc87a00c000
	PC is at __arch_copy_to_user+0x190/0x220
	LR is at copy_to_iter+0x78/0x3c8
	[...]
	[<ffffff800847b790>] __arch_copy_to_user+0x190/0x220
	[<ffffff80086f25d8>] ffs_user_copy_worker+0x70/0x130
	[<ffffff80080b8c64>] process_one_work+0x1dc/0x460
	[<ffffff80080b8f38>] worker_thread+0x50/0x4b0
	[<ffffff80080bf5a0>] kthread+0xd8/0xf0
	[<ffffff8008083680>] ret_from_fork+0x10/0x50

Address this by placing a set_fs(USER_DS) before of the copy operation
and revert it again once the copy operation has finished.

This patch is analogous to commit d7ffde35e31a ("vhost: use USER_DS in
vhost_worker thread") which addresses the same underlying issue.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/function/f_fs.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -758,9 +758,13 @@ static void ffs_user_copy_worker(struct
 	bool kiocb_has_eventfd = io_data->kiocb->ki_flags & IOCB_EVENTFD;
 
 	if (io_data->read && ret > 0) {
+		mm_segment_t oldfs = get_fs();
+
+		set_fs(USER_DS);
 		use_mm(io_data->mm);
 		ret = ffs_copy_to_iter(io_data->buf, ret, &io_data->data);
 		unuse_mm(io_data->mm);
+		set_fs(oldfs);
 	}
 
 	io_data->kiocb->ki_complete(io_data->kiocb, ret, ret);
