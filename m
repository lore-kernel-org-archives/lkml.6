Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AH8x226pxRnMIaOSTHI3TMmdnjlMZo8j/n6mkgEw8HUC94DWkH4RAGEO+8exwcc8OuB9XE43ZJ+Q
ARC-Seal: i=1; a=rsa-sha256; t=1518707178; cv=none;
        d=google.com; s=arc-20160816;
        b=qYPyAjrNNwM6/kAggDCYGtw3i/RNcnqvfMd28sx2Bikt4URqpKMm1nLtYYe8SZOJIo
         fNZH4DwQxn3tzWP0cNlYWR8gih2NooRxne6TurfJ0wnZfs9/sqQ5MnUnPU6VRDuq4CRt
         ZweqUojoziBTxR0Y/01PcaID3HHUX2UX32q9ID2mreRssLM/dE+76k0a8KxGE5pHzyrJ
         dt7cWRr/Cro9VTcmvSuQIyJIZ5T0BOs1jrc98PJV6CWYgZEH6IAwpDwjWEv40sBNNCH5
         htl1VASl9/+8msP4pKzkyigiIlHYOTPoLL2utveWF4WQJHPIVsCsf3ktoBUcFOEpB2Cm
         KYBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=VFcFe2sQm3vqFTKPESz1GYzhnePmORisPyLLFTFSy7c=;
        b=TpOVMcDKTH7zYqpeV0XfAT9Pw9liAtNMptWv8mcMi7cLMXV9gRsekx/0bfJKd9yWSs
         BZiSXt2gJA6+cn+uNaiuznnzT0S0vCC3+jM3MRsLsbX9ZLEMBPulcu9qpqQnShD4Xmfj
         INmX14AWW2ooehU909rEFsuRZwTIl3nsjIEZTOtIl2VDDnw7oPrQyf+pUOI+xbwg4BUs
         A/RYBwTRJ+HDKMIx5kBijfLMrsqWKZ/he5asWJDgLEyNJeeewitodpSeYXV5BET34rzx
         ZMlIX+GM8Kb6kw2oKcLvj8ctLcDJ9DMBrvz3MgmelRDIYDxQSlo6Cg5NFI+nlaFp4h9J
         PgOw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=Cb30Xqtz;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=Cb30Xqtz;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Subject: Re: [PATCH v3 1/4] mm/memory_hotplug: enforce block size aligned
 range check
To: Michal Hocko <mhocko@kernel.org>
Cc: Steve Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Bharata B Rao
 <bharata@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, dan.j.williams@intel.com,
        kirill.shutemov@linux.intel.com, bhe@redhat.com
References: <20180213193159.14606-1-pasha.tatashin@oracle.com>
 <20180213193159.14606-2-pasha.tatashin@oracle.com>
 <20180215113407.GB7275@dhcp22.suse.cz>
 <CAOAebxvF6mxDb4Ub02F0B9TEMRJUG0UGrKJ6ypaMGcje80cy6w@mail.gmail.com>
 <20180215144011.GF7275@dhcp22.suse.cz>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Message-ID: <6b02e1f4-a68f-787d-fbde-ec081ebba058@oracle.com>
Date: Thu, 15 Feb 2018 10:05:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180215144011.GF7275@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8805 signatures=668671
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802150186
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592315509448855886?=
X-GMAIL-MSGID: =?utf-8?q?1592479898888230298?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> No, not really. I just think the alignment shouldn't really matter. Each
> memory block should simply represent a hotplugable entitity with a well
> defined pfn start and size (in multiples of section size). This is in
> fact what we do internally anyway. One problem might be that an existing
> userspace might depend on the existing size restrictions so we might not
> be able to have variable block sizes. But block size alignment should be
> fixable.
> 
Hi Michal,

I see what you mean, and I agree Linux should simply honor reasonable 
requests from HW/HV.

On x86 qemu hotplugable entity is 128M, on sun4v SPARC it is 256M, with 
current scheme we still would end up with huge number of memory devices 
in sysfs if block size is fixed and equal to minimum hotplugable 
entitity. Just as an example, SPARC sun4v may have logical domains up-to 
32T, with 256M granularity that is 131K files in 
/sys/devices/system/memory/!

But, if it is variable, I am not sure how to solve it. The whole 
interface must be redefined. Because even if we hotplugged a highly 
aligned large chunk of memory and created only one memory device for it, 
we should have a way to remove just a small piece of that memory if 
underlying HV/HW requested.

/sys/devices/system/memory/block_size_bytes

Would have to be moved into memory block

echo offline > /sys/devices/system/memory/memoryXXX/state

This would need to be redefined somehow to work only on part of the block.

I am not really sure what a good solution would be without breaking the 
userspace.

Thank you,
Pavel
