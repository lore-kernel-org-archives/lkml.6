Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4DAC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 22:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1CCC208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 22:44:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1CCC208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbeK0Jke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 04:40:34 -0500
Received: from mga14.intel.com ([192.55.52.115]:39562 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbeK0Jke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 04:40:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2018 14:44:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,284,1539673200"; 
   d="scan'208";a="284128160"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.24.14.87]) ([10.24.14.87])
  by fmsmga005.fm.intel.com with ESMTP; 26 Nov 2018 14:44:53 -0800
Subject: Re: [PATCH v9 10/13] x86/resctrl: Fix the messages in
 rdt_last_cmd_printf and rdt_last_cmd_puts
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Moger, Babu" <Babu.Moger@amd.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "qianyue.zj@alibaba-inc.com" <qianyue.zj@alibaba-inc.com>,
        "xiaochen.shen@intel.com" <xiaochen.shen@intel.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Hurwitz, Sherry" <sherry.hurwitz@amd.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "jannh@google.com" <jannh@google.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "rian@alum.mit.edu" <rian@alum.mit.edu>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
References: <20181121202811.4492-1-babu.moger@amd.com>
 <20181121202811.4492-11-babu.moger@amd.com>
 <fe5c4f4b-e233-875c-1f33-f22c5986b041@intel.com>
 <20181126222800.GR4843@zn.tnic>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <22dcf61a-fddf-3a7a-4e28-25d27e9482ad@intel.com>
Date:   Mon, 26 Nov 2018 14:44:49 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181126222800.GR4843@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Borislav,

On 11/26/2018 2:28 PM, Borislav Petkov wrote:
> On Mon, Nov 26, 2018 at 02:16:24PM -0800, Reinette Chatre wrote:
>> Hi Babu and Borislav,
>>
>> Two typos seemed to have slipped through into the merged commit ...
>>
>> On 11/21/2018 12:28 PM, Moger, Babu wrote:
>>> @@ -163,14 +163,14 @@ int parse_cbm(struct rdt_parse_data *data, struct rdt_resource *r,
>>>  	 * either is exclusive.
>>>  	 */
>>>  	if (rdtgroup_cbm_overlaps(r, d, cbm_val, rdtgrp->closid, true)) {
>>> -		rdt_last_cmd_printf("overlaps with exclusive group\n");
>>> +		rdt_last_cmd_printf("Overlaps with exclusive group\n");
>>>  		return -EINVAL;
>>>  	}
>>>  
>>>  	if (rdtgroup_cbm_overlaps(r, d, cbm_val, rdtgrp->closid, false)) {
>>>  		if (rdtgrp->mode == RDT_MODE_EXCLUSIVE ||
>>>  		    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
>>> -			rdt_last_cmd_printf("overlaps with other group\n");
>>> +			rdt_last_cmd_printf("0verlaps with other group\n");
>>>  			return -EINVAL;
>>>  		}
>>>  	}
>>
>> There is a zero instead of O used in second "Overlaps".
> 
> LOL!
> 
> That's so l337 :-)
> 
>>> @@ -1235,7 +1235,7 @@ static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
>>>  			goto out;
>>>  		rdtgrp->mode = RDT_MODE_PSEUDO_LOCKSETUP;
>>>  	} else {
>>> -		rdt_last_cmd_printf("unknown/unsupported mode\n");
>>> +		rdt_last_cmd_printf("Unknown orunsupported mode\n");
>>>  		ret = -EINVAL;
>>>  	}
>>
>> Missing a space.
> 
> Whoops, nice catch. Can you send a fix pls?

Will do. Since there is overlap here I am planning for the fix to also
include changing rdt_last_cmd_printf() instances like the above to use
rdt_last_cmd_puts() instead.

Reinette


