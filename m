Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93378C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 08:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EF3E20843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 08:15:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EF3E20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbeIDMjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 08:39:15 -0400
Received: from mga12.intel.com ([192.55.52.136]:29314 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbeIDMjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 08:39:14 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2018 01:15:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,328,1531810800"; 
   d="scan'208";a="77796418"
Received: from dbxu-mobl.ccr.corp.intel.com (HELO wfg-t570.sh.intel.com) ([10.254.212.218])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Sep 2018 01:15:08 -0700
Received: from wfg by wfg-t570.sh.intel.com with local (Exim 4.89)
        (envelope-from <fengguang.wu@intel.com>)
        id 1fx6UL-0006AX-UG; Tue, 04 Sep 2018 16:15:05 +0800
Date:   Tue, 4 Sep 2018 16:15:05 +0800
From:   Fengguang Wu <fengguang.wu@intel.com>
To:     "Peng, DongX" <dongx.peng@intel.com>
Cc:     Nikita Leshenko <nikita.leshchenko@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "Liu, Jingqi" <jingqi.liu@intel.com>,
        "Dong, Eddie" <eddie.dong@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Brendan Gregg <bgregg@netflix.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH 3/5] [PATCH 3/5] kvm-ept-idle: HVA indexed EPT read
Message-ID: <20180904081505.4vu4rx6ksdnp5nk4@wfg-t540p.sh.intel.com>
References: <20180901112818.126790961@intel.com>
 <20180901124811.591511876@intel.com>
 <37B30FD3-7955-4C0B-AAB5-544359F4D157@oracle.com>
 <5249147EF0246348BBCB3713DC3757BF8D0D0C@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <5249147EF0246348BBCB3713DC3757BF8D0D0C@shsmsx102.ccr.corp.intel.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yeah thanks! Currently we are restructuring the related functions,
will add these calls when sorted out the walk order and hole issues.

Thanks,
Fengguang

On Tue, Sep 04, 2018 at 04:12:00PM +0800, Peng Dong wrote:
>kvm_get_kvm() kvm_put_kvm()
>
>-----Original Message-----
>From: Nikita Leshenko [mailto:nikita.leshchenko@oracle.com]
>Sent: Tuesday, September 4, 2018 3:57 PM
>To: Wu, Fengguang <fengguang.wu@intel.com>
>Cc: Andrew Morton <akpm@linux-foundation.org>; Linux Memory Management List <linux-mm@kvack.org>; Peng, DongX <dongx.peng@intel.com>; Liu, Jingqi <jingqi.liu@intel.com>; Dong, Eddie <eddie.dong@intel.com>; Hansen, Dave <dave.hansen@intel.com>; Huang, Ying <ying.huang@intel.com>; Brendan Gregg <bgregg@netflix.com>; kvm@vger.kernel.org; LKML <linux-kernel@vger.kernel.org>
>Subject: Re: [RFC][PATCH 3/5] [PATCH 3/5] kvm-ept-idle: HVA indexed EPT read
>
>On 1 Sep 2018, at 13:28, Fengguang Wu <fengguang.wu@intel.com> wrote:
>> +static ssize_t ept_idle_read(struct file *file, char *buf,
>> +			     size_t count, loff_t *ppos)
>> +{
>> +	struct task_struct *task = file->private_data;
>> +	struct ept_idle_ctrl *eic;
>> +	unsigned long hva_start = *ppos << BITMAP_BYTE2PVA_SHIFT;
>> +	unsigned long hva_end = hva_start + (count << BITMAP_BYTE2PVA_SHIFT);
>> +	int ret;
>> +
>> +	if (*ppos % IDLE_BITMAP_CHUNK_SIZE ||
>> +	    count % IDLE_BITMAP_CHUNK_SIZE)
>> +		return -EINVAL;
>> +
>> +	eic = kzalloc(sizeof(*eic), GFP_KERNEL);
>> +	if (!eic)
>> +		return -EBUSY;
>> +
>> +	eic->buf = buf;
>> +	eic->buf_size = count;
>> +	eic->kvm = task_kvm(task);
>> +	if (!eic->kvm) {
>> +		ret = -EINVAL;
>> +		goto out_free;
>> +	}
>I think you need to increment the refcount while using kvm, otherwise kvm can be destroyed from another thread while you're walking it.
>
>-Nikita
>> +
>> +	ret = ept_idle_walk_hva_range(eic, hva_start, hva_end);
>> +	if (ret)
>> +		goto out_free;
>> +
>> +	ret = eic->bytes_copied;
>> +	*ppos += ret;
>> +out_free:
>> +	kfree(eic);
>> +
>> +	return ret;
>> +}
>
