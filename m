Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AIpwx49o6GXlDMZRgjtPeqTaaJrMZNUkPiixudpv7x3o7jjO8jhcACa277Av9BRtgDWtLVHAqiVs
ARC-Seal: i=1; a=rsa-sha256; t=1523112347; cv=none;
        d=google.com; s=arc-20160816;
        b=U45elVqqSaT0zETg4DZtZ1qlldxPOlCK8bcpNxDDi2JL/5c5lwAHNL8sy6S4nCuS9R
         32pNER/ny/6VVttJqmTKkwr61zaWwqQSkJqNyJ9hNPSXSIflAb6jdRET+t6f7ONI8gEq
         rNsuqNOaa3dIQcexWGnU6oIAJ7ASUp3bCZKmdL3sPZjrf8kdXRWcRBL1qcIqfs/jQGa/
         NWfLBbjM0flZGGwCO7EDvjrEqfLq5LBN9EDcqEcUSIyG7IIIWrJDqRI86+/SmhuzpTEu
         WUEOmfVwGSscHAzi9H4JccesR7cYzESB1R6iADgpaNqaYRxP4S0mgFnbwvL3XAJI5JiA
         OcQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=9tNeKExtqNI/dkSV0ha4yxFPM5sx5Bsh3yTsq6slxYk=;
        b=lx12iDal58kc5vIWNRFk1fFinIEdiEcAJ/Rbhz26sgrpv+Lk9Nn6VckxGAPLzgmoNW
         FQPYqPUZihqA9twF/XZGBVuoWhrDoL6ORsQSaYCOL7/OGbZO5T2q8927fIwnSPu/Z6dk
         T8sULRChamaOcHf7aVBnBuLVY4gUUZC+o1xBYKe9pQQ1Bv9dIDSdNCNBCsyZfcPQgY3N
         4IjsQ/m5/PZrWu30ATdVy4m/cLVY5+f7cWxbiGklL5w90nmlamEnNkJ9qwuLXGdJ5sUl
         5kTKp+FGIB5c8yt2vn2/G2EdYSA/LX7AYfIXCcdGM5ImRBGIFLqRpBh/dnBQOYHUWvBF
         OpoA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=OL8AstIm;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=OL8AstIm;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
MIME-Version: 1.0
In-Reply-To: <20180406124535.k3qyxjfrlo55d5if@xakep.localdomain>
References: <20180131210300.22963-1-pasha.tatashin@oracle.com>
 <20180131210300.22963-2-pasha.tatashin@oracle.com> <20180313234333.j3i43yxeawx5d67x@sasha-lappy>
 <CAGM2reaPK=ZcLBOnmBiC2-u86DZC6ukOhL1xxZofB2OTW3ozoA@mail.gmail.com>
 <20180314005350.6xdda2uqzuy4n3o6@sasha-lappy> <20180315190430.o3vs7uxlafzdwgzd@xakep.localdomain>
 <20180315204312.n7p4zzrftgg6m7zw@sasha-lappy> <20180404021746.m77czxidkaumkses@xakep.localdomain>
 <20180405134940.2yzx4p7hjed7lfdk@xakep.localdomain> <20180405192256.GQ7561@sasha-vm>
 <20180406124535.k3qyxjfrlo55d5if@xakep.localdomain>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Sat, 7 Apr 2018 10:45:03 -0400
X-Gmail-Original-Message-ID: <CAGM2reYtCb2_czEt1M8KhFz+YxGq=iSGnTskC=FGNM4kXOiS5g@mail.gmail.com>
Message-ID: <CAGM2reYtCb2_czEt1M8KhFz+YxGq=iSGnTskC=FGNM4kXOiS5g@mail.gmail.com>
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
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8855 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804070155
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591143417186287050?=
X-GMAIL-MSGID: =?utf-8?q?1597099053249586225?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> Let me study your trace, perhaps I will able to figure out the issue
> without reproducing it.

Hi Sasha,

I've been studying this problem more. The issue happens in this stack:

...subsys_init...
 topology_init()
  register_one_node(nid)
   link_mem_sections(nid, pgdat->node_start_pfn, pgdat->node_spanned_pages)
    register_mem_sect_under_node(mem_blk, nid)
     get_nid_for_pfn(pfn)
      pfn_to_nid(pfn)
       page_to_nid(page)
        PF_POISONED_CHECK(page)

We are trying to get nid from struct page which has not been
initialized.  My patches add this extra scrutiny to make sure that we
never get invalid nid from a "struct page" by adding
PF_POISONED_CHECK() to page_to_nid(). So, the bug already exists in
Linux where incorrect nid is read. The question is why does happen?

First, I thought, that perhaps struct page is not yet initialized.
But, the initcalls are done after deferred pages are initialized, and
thus every struct page must be initialized by now. Also, if deferred
pages were enabled, we would take a slightly different path and avoid
this bug by getting nid from memblock instead of struct page:

get_nid_for_pfn(pfn)
#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
 if (system_state < SYSTEM_RUNNING)
  return early_pfn_to_nid(pfn);
#endif

I also verified in your config that CONFIG_DEFERRED_STRUCT_PAGE_INIT
is not set. So, one way to fix this issue, is to remove this "#ifdef"
(I have not checked for dependancies), but this is simply addressing
symptom, not fixing the actual issue.

Thus, we have a "struct page" backing memory for this pfn, but we have
not initialized it. For some reason memmap_init_zone() decided to skip
it, and I am not sure why. Looking at the code we skip initializing
if:
!early_pfn_valid(pfn)) aka !pfn_valid(pfn) and if !early_pfn_in_nid(pfn, nid).

I suspect, this has something to do with !pfn_valid(pfn). But, without
having a machine on which I could reproduce this problem, I cannot
study it further to determine exactly why pfn is not valid.

Please replace !pfn_valid_within() with !pfn_valid() in
get_nid_for_pfn() and see if problem still happens. If it does not
happen, lets study the memory map, pgdata's start end, and the value
of this pfn.

Thank you,
Pasha
