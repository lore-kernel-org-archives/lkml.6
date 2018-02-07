Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3917310-1518004843-2-4684772074753761587
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='iso-8859-15'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518004842; b=JQN7d/QyqkLNH4ngFJjymT/b1INOSqXEcfiaqh30WFNsiC6
    rowXkq6dI8P49RX7DuJVqrThJG4NnlTNwasgvFYcze8YdiwtdaemzvHe82Ojy5td
    UjvwhRJCUfxSJTKbJ3YykES6kQ6MwIf3Y/ecFzWBCXtDfiWKdNtlsFH+NzXEIVt4
    VTlDY3BbtRZmY3qH2f8sWDqGCS5pWwuIHAkAL5/hghbPXSAsqLy4zS6yu1gVg59S
    1+1JKMZ6ABkejvg4p+A9NYhRodS/y2/5LoWy+fQ0vPb4u7mQiQUEsNis29lyfC9L
    A2eYZXhRR62Yzu032BKsPAN8ZiHpCIX3En1l27Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518004842; bh=UUn7uAQFQYQQJ10RdL5A6BAKlMWEghdlSWMaxCtmcro=; b=k
    NmEpVwxgKf7elMZL8hDLol5Kug9iyzAlKRH14SNkMa4SfkxMMyrJxoayiql/9JpF
    LDMb7jyi6mkQy9XC6HqeUELrDQpTDJ9RZbf/kxc81fuwQMzn++fJP2ylEQjweVJt
    s2mUd9iQv5nu/rHzUz22MqehPJZ/bB9WxfGSD2ywpIYMGqFc5tGOofGsT+sY/Skt
    PtTQPqLbacdBy3dpBJcR9duC+KvItv4Z1cyA4r1+By0v4vNzcnEItUNWIRGAgS7k
    5T9Nr42yNodvCEtMkP9NhJPTpjcDQbT6EzmPDa0WuUlIQQ3L3Wjcp8oSrwBQpD2Q
    4QNBV968aH3FJhE8/7Buw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=cn.fujitsu.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=cn.fujitsu.com header.result=pass header_org.domain=fujitsu.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=cn.fujitsu.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=cn.fujitsu.com header.result=pass header_org.domain=fujitsu.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753745AbeBGMAk (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Feb 2018 07:00:40 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:62898 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753648AbeBGMAi (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Feb 2018 07:00:38 -0500
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="36896652"
Subject: Re: [PATCH 4.14 023/159] mm/sparsemem: Allocate mem_section at
 runtime for CONFIG_SPARSEMEM_EXTREME=y
To: Mike Galbraith <efault@gmx.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
CC: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Young <dyoung@redhat.com>, <kexec@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>, <linux-mm@kvack.org>,
        Vivek Goyal <vgoyal@redhat.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Takao Indoh <indou.takao@jp.fujitsu.com>
References: <20171222084623.668990192@linuxfoundation.org>
 <20171222084625.007160464@linuxfoundation.org>
 <1515302062.6507.18.camel@gmx.de> <20180108160444.2ol4fvgqbxnjmlpg@gmail.com>
 <20180108174653.7muglyihpngxp5tl@black.fi.intel.com>
 <20180109001303.dy73bpixsaegn4ol@node.shutemov.name>
 <1515469448.6766.12.camel@gmx.de>
 <d71ba136-71ba-333a-f99b-b8283e2dc545@cn.fujitsu.com>
 <20180207104111.sljc62bgkggmtio4@node.shutemov.name>
 <1518000336.29698.1.camel@gmx.de>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <cd7e23ce-60a3-08ad-eb5d-21bb91df5937@cn.fujitsu.com>
Date: Wed, 7 Feb 2018 20:00:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1518000336.29698.1.camel@gmx.de>
Content-Type: text/plain; charset="iso-8859-15"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: 6D18D48AE761.AC5BC
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
X-Remote-Spam-Status: No
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Kirill,Mike

At 02/07/2018 06:45 PM, Mike Galbraith wrote:
> On Wed, 2018-02-07 at 13:41 +0300, Kirill A. Shutemov wrote:
>> On Wed, Feb 07, 2018 at 05:25:05PM +0800, Dou Liyang wrote:
>>> Hi All,
>>>
>>> I met the makedumpfile failed in the upstream kernel which contained
>>> this patch. Did I missed something else?
>>
>> None I'm aware of.
>>
>> Is there a reason to suspect that the issue is related to the bug this patch
>> fixed?
> 

I did a contrastive test by my colleagues Indoh's suggestion.

Revert your two commits:

commit 83e3c48729d9ebb7af5a31a504f3fd6aff0348c4
Author: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Date:   Fri Sep 29 17:08:16 2017 +0300

commit 629a359bdb0e0652a8227b4ff3125431995fec6e
Author: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Date:   Tue Nov 7 11:33:37 2017 +0300

...and keep others unchanged, the makedumpfile works well.

> Still works fine for me with .today.  Box is only 16GB desktop box though.
> 
Btw, In the upstream kernel which contained this patch, I did two tests:

  1) use the makedumpfile as core_collector in /etc/kdump.conf, then
trigger the process of kdump by echo 1 >/proc/sysrq-trigger, the
makedumpfile works well and I can get the vmcore file.

      ......It is OK

  2) use cp as core_collector, do the same operation to get the vmcore 
file. then use makedumpfile to do like above:

     [douly@localhost code]$ ./makedumpfile -d 31 --message-level 31 -x
vmlinux_4.15+ vmcore_4.15+_from_cp_command vmcore_4.15+

     ......It causes makedumpfile failed.


Thanks,
	dou.

> 	-Mike
> 
> 
> 
