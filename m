Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AG47ELs8OXY0gdXU2ARuyHERqNSjGVKA5/83IsIQ2oiOl0y04gPph/BCDJhp+mZq3ghn8u1uYuMi
ARC-Seal: i=1; a=rsa-sha256; t=1520989416; cv=none;
        d=google.com; s=arc-20160816;
        b=MAEDMGx6t26fZc4Pl5drIBczuVarQqiCgYng7vqgGUugV7ku4V2nkdRVfEJXkGdo1L
         3+9RV3okjmWaIdRXCsY89hZa7zH/0pfZZfKg5dnVb0OCLRvh53+IJTKteyfEZEBrpvhf
         qWdHg06nDZXMLRlD9fd7vV90/ijtx/6uPtrjFwMPiizAy5Nun3EbTGdXrQdf+cF74KD8
         OwF+M18voango5bW73wCF5ETa5eRZ4hU2c+HQdL/9C2UL0AujOYWJB/TOVlPwVilQMoU
         UFR9X0FCgI9wL+jr3qJpDT6ZqfGItC5rL9yEQlIxFXh5OoD/VOfJBup8XysHsU4Qqkbo
         sYnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=AM/mWKxz+utpXTKgblrXSJmRHTdK/KSqSOoc5NX5P4U=;
        b=bMjVev8DU4rHQyigUYli0GUFO4P7gdegDkSof5MxeEFaVVp/y4H/DhSgrfoXH85HBH
         svTv0mW5f0ybc2Y7Pd0E4G8kvhZ9aptJf4fZn+lpMo0Mznmemx4PIgFSCH33/fZpDCjU
         6amX+A9EVJjzntoTnKXeFt46d8JoVSpMTvtqP6X7hIhswYKoRVWiBGtyjqB7kqYeZe/c
         Dg7BNfzAvRF5O4V78ibo/dkRf3FaEkmpte/WUr+2uJNKAibkaQbdhNKRFkz6ct7We+m/
         8YHq106yD90VQhHBYtzPGUW4nAq7Y381Z2DYNj6fGPKRb8sfoWLKnfO8rEgZyg2LZfxR
         hphA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=LUhGRKmc;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=LUhGRKmc;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
MIME-Version: 1.0
In-Reply-To: <20180314005350.6xdda2uqzuy4n3o6@sasha-lappy>
References: <20180131210300.22963-1-pasha.tatashin@oracle.com>
 <20180131210300.22963-2-pasha.tatashin@oracle.com> <20180313234333.j3i43yxeawx5d67x@sasha-lappy>
 <CAGM2reaPK=ZcLBOnmBiC2-u86DZC6ukOhL1xxZofB2OTW3ozoA@mail.gmail.com> <20180314005350.6xdda2uqzuy4n3o6@sasha-lappy>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Tue, 13 Mar 2018 21:02:53 -0400
X-Gmail-Original-Message-ID: <CAGM2reYo2EbH0W70rJGSGWRBAO=upcNDanBoCQgve+eQ_94C8A@mail.gmail.com>
Message-ID: <CAGM2reYo2EbH0W70rJGSGWRBAO=upcNDanBoCQgve+eQ_94C8A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm: uninitialized struct page poisoning sanity checking
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: "steven.sistare@oracle.com" <steven.sistare@oracle.com>,
        "daniel.m.jordan@oracle.com" <daniel.m.jordan@oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "bharata@linux.vnet.ibm.com" <bharata@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8831 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803140008
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591143417186287050?=
X-GMAIL-MSGID: =?utf-8?q?1594872998527235472?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 13, 2018 at 8:53 PM, Sasha Levin
<Alexander.Levin@microsoft.com> wrote:
> On Tue, Mar 13, 2018 at 08:38:57PM -0400, Pavel Tatashin wrote:
>>Hi Sasha,
>>
>>It seems the patch is doing the right thing, and it catches bugs. Here
>>we access uninitialized struct page. The question is why this happens?
>
> Not completely; note that we die on an invalid reference rather than
> assertion failure.

I think that invalid reference happens within assertion failure, as
far as I can tell, it is dump_page() where we get the invalid
reference, but to get to dump_page() from get_nid_for_pfn() we must
have triggered the assertion.

>
>>register_mem_sect_under_node(struct memory_block *mem_blk, int nid)
>>   page_nid = get_nid_for_pfn(pfn);
>>
>>node id is stored in page flags, and since struct page is poisoned,
>>and the pattern is recognized, the panic is triggered.
>>
>>Do you have config file? Also, instructions how to reproduce it?
>
> Attached the config. It just happens on boot.

Thanks, I will try in qemu.

Pasha
