Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE784C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73C6F20875
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:37:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73C6F20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932504AbeGIIhy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:37:54 -0400
Received: from www62.your-server.de ([213.133.104.62]:57305 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754412AbeGIIht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:37:49 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fcRg2-00019X-Hv; Mon, 09 Jul 2018 10:37:46 +0200
Received: from [62.203.87.61] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1fcRg2-0007RZ-Cq; Mon, 09 Jul 2018 10:37:46 +0200
Subject: Re: [PATCH v2 bpf-next 02/14] bpf: introduce cgroup storage maps
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Roman Gushchin <guro@fb.com>
Cc:     netdev@vger.kernel.org, kbuild-all@01.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, tj@kernel.org,
        Alexei Starovoitov <ast@kernel.org>, Sean Young <sean@mess.org>
References: <20180705205139.3462-3-guro@fb.com>
 <201807062214.O8pQxWve%fengguang.wu@intel.com>
 <20180706215229.GA27634@castle.DHCP.thefacebook.com>
 <20180707223532.k5i4h5xp4lj2pf77@ast-mbp.dhcp.thefacebook.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <54d9f3b6-a449-b5ee-a55b-c2cd983c11d0@iogearbox.net>
Date:   Mon, 9 Jul 2018 10:37:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180707223532.k5i4h5xp4lj2pf77@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.0/24736/Mon Jul  9 06:41:36 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/2018 12:35 AM, Alexei Starovoitov wrote:
> On Fri, Jul 06, 2018 at 02:52:32PM -0700, Roman Gushchin wrote:
>> On Fri, Jul 06, 2018 at 10:42:39PM +0800, kbuild test robot wrote:
>>> Hi Roman,
>>>
>>> Thank you for the patch! Yet something to improve:
>>>
>>> [auto build test ERROR on bpf-next/master]
>>>
>>> url:    https://github.com/0day-ci/linux/commits/Roman-Gushchin/bpf-cgroup-local-storage/20180706-055938
>>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
>>> config: s390-performance_defconfig (attached as .config)
>>> compiler: s390x-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
>>> reproduce:
>>>         wget https://urldefense.proofpoint.com/v2/url?u=https-3A__raw.githubusercontent.com_intel_lkp-2Dtests_master_sbin_make.cross&d=DwIBAg&c=5VD0RTtNlTh3ycd41b3MUw&r=jJYgtDM7QT-W-Fz_d29HYQ&m=ImwiAAR6DVyf5JEcIc5VLF9xY4lfFxVuk8_4BN6I03g&s=r0S7gFQPOZVZagshsK0pL3eU8_GRpD1ywrvYfXJ4yBQ&e= -O ~/bin/make.cross
>>>         chmod +x ~/bin/make.cross
>>>         # save the attached .config to linux build tree
>>>         GCC_VERSION=7.2.0 make.cross ARCH=s390 
>>>
>>> All errors (new ones prefixed by >>):
>>>
>>>    In file included from kernel//bpf/local_storage.c:2:0:
>>>    include/linux/bpf-cgroup.h: In function 'cgroup_bpf_prog_attach':
>>>>> include/linux/bpf-cgroup.h:237:10: error: 'EINVAL' undeclared (first use in this function)
>>>      return -EINVAL;
>>>              ^~~~~~
>>>    include/linux/bpf-cgroup.h:237:10: note: each undeclared identifier is reported only once for each function it appears in
>>>    include/linux/bpf-cgroup.h: In function 'cgroup_bpf_prog_detach':
>>>    include/linux/bpf-cgroup.h:243:10: error: 'EINVAL' undeclared (first use in this function)
>>>      return -EINVAL;
>>>              ^~~~~~
>>>    include/linux/bpf-cgroup.h: In function 'cgroup_bpf_prog_query':
>>>    include/linux/bpf-cgroup.h:249:10: error: 'EINVAL' undeclared (first use in this function)
>>>      return -EINVAL;
>>>              ^~~~~~
>>>
>>> vim +/EINVAL +237 include/linux/bpf-cgroup.h
>>>
>>> 30070984 Daniel Mack 2016-11-23  232  
>>> fdb5c453 Sean Young  2018-06-19  233  static inline int cgroup_bpf_prog_attach(const union bpf_attr *attr,
>>> fdb5c453 Sean Young  2018-06-19  234  					 enum bpf_prog_type ptype,
>>> fdb5c453 Sean Young  2018-06-19  235  					 struct bpf_prog *prog)
>>> fdb5c453 Sean Young  2018-06-19  236  {
>>> fdb5c453 Sean Young  2018-06-19 @237  	return -EINVAL;
>>> fdb5c453 Sean Young  2018-06-19  238  }
>>> fdb5c453 Sean Young  2018-06-19  239  
>>>
>>> :::::: The code at line 237 was first introduced by commit
>>> :::::: fdb5c4531c1e0e50e609df83f736b6f3a02896e2 bpf: fix attach type BPF_LIRC_MODE2 dependency wrt CONFIG_CGROUP_BPF
>>>
>>> :::::: TO: Sean Young <sean@mess.org>
>>> :::::: CC: Daniel Borkmann <daniel@iogearbox.net>
>>
>> These errors have nothing to do with the cgroup local storage patchset.
>> They do exist in the current bpf-next tree.
>> Here is the fix.
>>
>> Thanks!
>>
>> --
>>
>> From c0cd59b969e060765514224e31595763213e40f9 Mon Sep 17 00:00:00 2001
>> From: Roman Gushchin <guro@fb.com>
>> Date: Fri, 6 Jul 2018 14:34:29 -0700
>> Subject: [PATCH bpf-next] bpf: include errno.h from bpf-cgroup.h
>>
>> Commit fdb5c4531c1e ("bpf: fix attach type BPF_LIRC_MODE2 dependency
>> wrt CONFIG_CGROUP_BPF") caused some build issues, detected by 0-DAY
>> kernel test infrastructure.
>>
>> The problem is that cgroup_bpf_prog_attach/detach/query() functions
>> can return -EINVAL error code, which is not defined. Fix this adding
>> errno.h to includes.
>>
>> Fixes: fdb5c4531c1e ("bpf: fix attach type BPF_LIRC_MODE2 dependency
>> wrt CONFIG_CGROUP_BPF")
>> Signed-off-by: Roman Gushchin <guro@fb.com>
>> Cc: Sean Young <sean@mess.org>
>> Cc: Daniel Borkmann <daniel@iogearbox.net>
>> Cc: Alexei Starovoitov <ast@kernel.org>
>> ---
>>  include/linux/bpf-cgroup.h | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
>> index 79795c5fa7c3..d50c2f0a655a 100644
>> --- a/include/linux/bpf-cgroup.h
>> +++ b/include/linux/bpf-cgroup.h
>> @@ -2,6 +2,7 @@
>>  #ifndef _BPF_CGROUP_H
>>  #define _BPF_CGROUP_H
>>  
>> +#include <linux/errno.h>
>>  #include <linux/jump_label.h>
>>  #include <uapi/linux/bpf.h>
> 
> good catch, but please resend it as a proper patch,
> since patchwork didn't pick it up.
> Also the subj should say 'bpf' instead of 'bpf-next', right?

Yes, this needs to go to bpf tree, since the affected commit went
there as well.

I just applied the above fix into bpf tree, thanks.

Cheers,
Daniel
