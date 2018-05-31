Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1478044-1527772857-2-10845691132662333805
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527772857; b=GtqHSkiLzxzx0M7KEUTsmtd+MMSys470FkJoPQadxIhiqDMkgh
    rTejz3uUVxuxb+xvXwZRSd9Vm6J/R4r3vRZ1Atx8a2X+3fF1NI5IkO2X0GFQ7wj3
    yUigqpwy/4O6z5UM1TmMH+1iovMlmllyEH05eRbRmUs86ZlMvAoQkNLkZBFiEaxl
    Tm93rBKscy7kXOR7tkBDQ5IAR0e9ma/PZjpaUkHRBGnesSwECPXGFlnhAZthQh1G
    YpepO+3vo6Pz7DKizEbE6S5+AtC975bI71WW2+BcGoL0JxGmZLJ5CDSgz0Tx6L4y
    y5U/vR6RiJ5MXuJ2UeKfHBt7iFo06B6XKZQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527772857;
    bh=foYvr6HNAMLkS0zJaMb67soMbUzbV3HSXM8LTL3gzxY=; b=Ndds1LicTOX6
    tFWD/yCPY6x/KKh5go2jSldjkMrGIYIv4SVYkGeqbqZEMaZruI1dtaNNHj3GTFmB
    RWdGkyy1Nx7TMQooaXEfPxI/2cC8jGhST22PBFeUZakHmXD+tL69cGmp2JmSybvV
    V7m6fWgJv1m14iVFiD+NCzg2NYzf0+SAPVPmmtLquBmfdOBebx9xosWDmvjXQnZo
    ZCo7xJ7By8aSAOTb+75VsqvNCj9siBlGTjTN0e1YvEWudtO1LZ82BFAtDWv2VXiC
    PQYj4JovL1Ssi/9ou6UZuR4gEbPbtPrlx4/BlPJJBTB7dtIjJhCmpEex05dZEWGJ
    Q2DaR55kIg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=i-love.sakura.ne.jp;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=i-love.sakura.ne.jp header.result=pass
    header_org.domain=sakura.ne.jp header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-51 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=i-love.sakura.ne.jp;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=i-love.sakura.ne.jp header.result=pass
      header_org.domain=sakura.ne.jp header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-51 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAoYjXuNpsHYPBxRUaBvDb76M750gvsWZtv9fyoFvzC5NHtZyCn+gma5Szf5/lyYsusR9etsaoSRLGFwZACKraizYZ1yl3K20X9FxYJZjV3kEhZ5mpRG
    Q+1eAvzNQtS5DnTGc7Mg01dac+dBRhjf8lBXnKRK7C+cnVlrKWk3mJE0CHSaxLecOndVJ90nXMEwiUA9m0OYXK5YbtsbD4Gs3CWxpzswzo9NyJ27XiaN6jt3
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=edf1wS77AAAA:8 a=axhd-odLBiKEK-BYC_oA:9 a=QEXdDO2ut3YA:10
    a=DcSpbTIhAlouE1Uv7lRv:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755042AbeEaNUw (ORCPT <rfc822;linux@kroah.com>);
        Thu, 31 May 2018 09:20:52 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:57266 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754820AbeEaNUv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 May 2018 09:20:51 -0400
Subject: Re: general protection fault in wb_workfn (2)
To: Jan Kara <jack@suse.cz>
Cc: syzbot <syzbot+4a7438e774b21ddd8eca@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        axboe@kernel.dk, tj@kernel.org, david@fromorbit.com,
        linux-block@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>
References: <000000000000cbd959056d1851ca@google.com>
 <0c7c5dea-7312-8a59-9d1b-5467f69719bf@I-love.SAKURA.ne.jp>
 <20180528133503.awomzj6djozbo5bv@quack2.suse.cz>
 <2dda7a11-3f6b-bdba-a68a-7c0694806cc4@I-love.SAKURA.ne.jp>
 <20180531114228.6zx27xxurmz27pke@quack2.suse.cz>
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <c0fc1c47-0efb-5ded-7f6c-79074ad4deac@i-love.sakura.ne.jp>
Date: Thu, 31 May 2018 22:19:44 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180531114228.6zx27xxurmz27pke@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018/05/31 20:42, Jan Kara wrote:
> On Thu 31-05-18 01:00:08, Tetsuo Handa wrote:
>> So, we have no idea what is happening...
>> Then, what about starting from temporary debug printk() patch shown below?
>>
>> >From 4f70f72ad3c9ae6ce1678024ef740aca4958e5b0 Mon Sep 17 00:00:00 2001
>> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>> Date: Wed, 30 May 2018 09:57:10 +0900
>> Subject: [PATCH] bdi: Add temporary config for debugging wb_workfn() versus
>>  bdi_unregister() race bug.
>>
>> syzbot is hitting NULL pointer dereference at wb_workfn() [1]. But due to
>> limitations that syzbot cannot find reproducer for this bug (frequency is
>> once or twice per a day) nor we can't capture vmcore in the environment
>> which syzbot is using, for now we need to rely on printk() debugging.
>>
>> [1] https://syzkaller.appspot.com/bug?id=e0818ccb7e46190b3f1038b0c794299208ed4206
>>
>> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> 
> Hum a bit ugly solution but if others are fine with this, I can live with
> it for a while as well. Or would it be possible for syzkaller to just test
> some git tree where this patch is included? Then we would not even have to
> have the extra config option...

If syzbot can reproduce this bug that way. While it is possible to add/remove
git trees syzbot tests, frequently adding/removing trees is bothering.

syzbot can enable extra config option. Maybe the config name should be
something like CONFIG_DEBUG_FOR_SYZBOT rather than individual topic.

I think that syzbot is using many VM instances. I don't know how many
instances will be needed for reproducing this bug within reasonable period.
More git trees syzbot tests, (I assume that) longer period will be needed
for reproducing this bug. The most reliable way is to use the shared part
of all trees (i.e. linux.git).

> 
>> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
>> index 471d863..b4dd078 100644
>> --- a/fs/fs-writeback.c
>> +++ b/fs/fs-writeback.c
>> @@ -1934,6 +1934,37 @@ void wb_workfn(struct work_struct *work)
>>  						struct bdi_writeback, dwork);
>>  	long pages_written;
>>  
>> +#ifdef CONFIG_BLK_DEBUG_WB_WORKFN_RACE
>> +	if (!wb->bdi->dev) {
>> +		pr_warn("WARNING: %s: device is NULL\n", __func__);
>> +		pr_warn("wb->state=%lx\n", wb->state);
>> +		pr_warn("list_empty(&wb->work_list)=%u\n",
>> +			list_empty(&wb->work_list));
>> +		if (!wb->bdi)
> 
> This is not possible when we dereferences wb->bdi above...

Oops. I missed it.

> 
>> +			pr_warn("wb->bdi == NULL\n");
>> +		else {
>> +			pr_warn("list_empty(&wb->bdi->bdi_list)=%u\n",
>> +				list_empty(&wb->bdi->bdi_list));
>> +			pr_warn("wb->bdi->wb.state=%lx\n", wb->bdi->wb.state);
>> +		}
> 
> It would be also good to print whether wb == wb->bdi->wb (i.e. it is the
> default writeback structure or one for some cgroup) and also
> wb->bdi->wb.state.
> 

wb->bdi->wb.state is already printed. Updated patch is shown below.
Anything else to print?



>From 3f3346d42b804e59d12caaa525365a8482505f08 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Thu, 31 May 2018 22:07:20 +0900
Subject: [PATCH v2] bdi: Add temporary config for debugging wb_workfn() versus
 bdi_unregister() race bug.

syzbot is hitting NULL pointer dereference at wb_workfn() [1]. But due to
limitations that syzbot cannot find reproducer for this bug (frequency is
once or twice per a day) nor we can't capture vmcore in the environment
which syzbot is using, for now we need to rely on printk() debugging.

[1] https://syzkaller.appspot.com/bug?id=e0818ccb7e46190b3f1038b0c794299208ed4206

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 block/Kconfig     |  7 +++++++
 fs/fs-writeback.c | 28 ++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/block/Kconfig b/block/Kconfig
index 28ec557..fbce13e 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -139,6 +139,13 @@ config BLK_CMDLINE_PARSER
 
 	See Documentation/block/cmdline-partition.txt for more information.
 
+config BLK_DEBUG_WB_WORKFN_RACE
+	bool "Dump upon hitting wb_workfn() versus bdi_unregister() race bug."
+	default n
+	---help---
+	This is a temporary option used for obtaining information for
+	specific bug. This option will be removed after the bug is fixed.
+
 config BLK_WBT
 	bool "Enable support for block device writeback throttling"
 	default n
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 471d863..14ab873 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1934,6 +1934,34 @@ void wb_workfn(struct work_struct *work)
 						struct bdi_writeback, dwork);
 	long pages_written;
 
+#ifdef CONFIG_BLK_DEBUG_WB_WORKFN_RACE
+	if (!wb->bdi->dev) {
+		pr_warn("WARNING: %s: device is NULL\n", __func__);
+		pr_warn("wb->state=%lx\n", wb->state);
+		pr_warn("(wb == &wb->bdi->wb)=%u\n", wb == &wb->bdi->wb);
+		pr_warn("list_empty(&wb->work_list)=%u\n",
+			list_empty(&wb->work_list));
+		pr_warn("list_empty(&wb->bdi->bdi_list)=%u\n",
+			list_empty(&wb->bdi->bdi_list));
+		pr_warn("wb->bdi->wb.state=%lx\n", wb->bdi->wb.state);
+		if (!wb->congested)
+			pr_warn("wb->congested == NULL\n");
+#ifdef CONFIG_CGROUP_WRITEBACK
+		else if (!wb->congested->__bdi)
+			pr_warn("wb->congested->__bdi == NULL\n");
+		else {
+			pr_warn("(wb->congested->__bdi == wb->bdi)=%u\n",
+				wb->congested->__bdi == wb->bdi);
+			pr_warn("list_empty(&wb->congested->__bdi->bdi_list)=%u\n",
+				list_empty(&wb->congested->__bdi->bdi_list));
+			pr_warn("wb->congested->__bdi->wb.state=%lx\n",
+				wb->congested->__bdi->wb.state);
+		}
+#endif
+		/* Will halt shortly due to NULL pointer dereference... */
+	}
+#endif
+
 	set_worker_desc("flush-%s", dev_name(wb->bdi->dev));
 	current->flags |= PF_SWAPWRITE;
 
-- 
1.8.3.1
