Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3390871-1521217262-2-17330221875189976214
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521217262; b=GZPC1xHXkxbv0F8/WVije7R3OPhyA9vf09UEgvHoIozo/0H
    4zGih6oUQXNkSty0UwSaTutHCyfSJrjPKZNanzfPHAGg4nKAA8dzsmd9uWkOhsYq
    iIIPnk6c1iPENFkjaHnYAtxRI69MYFS4WSWI7iRG+s4GHdO3sKeIBnr2/Xyc/IoU
    LWBymYro/xb8RuDqLGYw4d3up1GTkjEBu+2pfx5FCkFKzIaHpsdbhzDziRhFRcL+
    QlEwrndtV6J1iYtLw+8vYh0sl/lKmcYzBZRuzSlYOZQ073sHFj02pzrJstDT6z9C
    Ot3USccy7/0M4blXMxDCXl6jAOynNNPEb9M50rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521217262; bh=akORTUsbKZVgDqTW7F1yqBpuLsGBdpFQx75PoM2t0xI=; b=b
    Rg/91vPP2LRk8wQlJR2KrL7C6x13dyl9pZcPBExooZavJKqyOaWeZ77fGCyAjZgr
    CDcBcfjuidbGBMT+52dLVJbeNYrHBvyaQYntsNz1ZW7vMYbiodO133al92Jn2us0
    zSp9fgD/3pImN4CRIyTH2PMWowHEwsM7OhHKuJ2QDEHpe9qSLu48otNvZOikGPYm
    AyFr3GDzsA87ACYMcl4PSoDl2YSPrhTi4bWnGntqWsnQIBFPYWVDH0ZUYe+OdDRW
    HeELs+6pueiW0Ac1yBqBp7rTXvcpWWDCXOp+gdPF7530pu9hOqXCvGpA/VRuka7O
    Lffg7qJOyHz8wXoVPiAsA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=Wt6MeYm3 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=Wt6MeYm3 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754655AbeCPQTf (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 12:19:35 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49202 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754520AbeCPQTc (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 12:19:32 -0400
Subject: Re: [PATCH v3] hugetlbfs: check for pgoff value overflow
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        bugzilla-daemon@bugzilla.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Nic Losby <blurbdust@gmail.com>,
        Yisheng Xie <xieyisheng1@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org
References: <20180306133135.4dc344e478d98f0e29f47698@linux-foundation.org>
 <20180309002726.7248-1-mike.kravetz@oracle.com>
 <20180316101757.GE23100@dhcp22.suse.cz>
From: Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <12826dc6-c81e-c22a-2ec1-8e1cf0f07dfc@oracle.com>
Date: Fri, 16 Mar 2018 09:19:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180316101757.GE23100@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8833 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803160153
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/16/2018 03:17 AM, Michal Hocko wrote:
> On Thu 08-03-18 16:27:26, Mike Kravetz wrote:
> 
> OK, looks good to me. Hairy but seems to be the easiest way around this.
> Acked-by: Michal Hocko <mhocko@suse.com>
> 
<snip>
>> +/*
>> + * Mask used when checking the page offset value passed in via system
>> + * calls.  This value will be converted to a loff_t which is signed.
>> + * Therefore, we want to check the upper PAGE_SHIFT + 1 bits of the
>> + * value.  The extra bit (- 1 in the shift value) is to take the sign
>> + * bit into account.
>> + */
>> +#define PGOFF_LOFFT_MAX (PAGE_MASK << (BITS_PER_LONG - (2 * PAGE_SHIFT) - 1))

Thanks Michal,

However, kbuild found a problem with this definition on certain configs.
Consider a config where,
BITS_PER_LONG = 32 (32bit config)
PAGE_SHIFT = 16 (64K pages)
This results in the negative shift value.
Not something I would not immediately think of, but a valid config.

The definition has been changed to,
#define PGOFF_LOFFT_MAX \
	(((1UL << (PAGE_SHIFT + 1)) - 1) <<  (BITS_PER_LONG - (PAGE_SHIFT + 1)))

as discussed here,
http://lkml.kernel.org/r/432fb2a3-b729-9c3a-7d60-890b8f9b10dd@oracle.com
-- 
Mike Kravetz
