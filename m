Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AB8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF9E1214F1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:01:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF9E1214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732839AbeKVEhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 23:37:16 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53375 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730780AbeKVEhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 23:37:15 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wALHwvMY139063
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 13:01:51 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2nwbjd1rbm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 13:01:51 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 21 Nov 2018 18:01:49 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 21 Nov 2018 18:01:47 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wALI1kqB61276392
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 21 Nov 2018 18:01:46 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0106AA4051;
        Wed, 21 Nov 2018 18:01:46 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 13EBEA4053;
        Wed, 21 Nov 2018 18:01:45 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.207.68])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 21 Nov 2018 18:01:44 +0000 (GMT)
Date:   Wed, 21 Nov 2018 19:01:43 +0100
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Linux API <linux-api@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, adobriyan@gmail.com,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, David Rientjes <rientjes@google.com>
Subject: Re: [RFC PATCH 1/3] mm, proc: be more verbose about unstable VMA
 flags in /proc/<pid>/smaps
References: <20181120103515.25280-1-mhocko@kernel.org>
 <20181120103515.25280-2-mhocko@kernel.org>
 <CAPcyv4j7=Mh9dt3Fv+cEhtYEXXKNDxErv0N9Zt+h+r9QxX_GAw@mail.gmail.com>
 <20181121070500.GB12932@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121070500.GB12932@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18112118-0016-0000-0000-0000022A9CBF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112118-0017-0000-0000-00003282DE84
Message-Id: <20181121180142.GC5704@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-21_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811210156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 08:05:00AM +0100, Michal Hocko wrote:
> On Tue 20-11-18 10:32:07, Dan Williams wrote:
> > On Tue, Nov 20, 2018 at 2:35 AM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > From: Michal Hocko <mhocko@suse.com>
> > >
> > > Even though vma flags exported via /proc/<pid>/smaps are explicitly
> > > documented to be not guaranteed for future compatibility the warning
> > > doesn't go far enough because it doesn't mention semantic changes to
> > > those flags. And they are important as well because these flags are
> > > a deep implementation internal to the MM code and the semantic might
> > > change at any time.
> > >
> > > Let's consider two recent examples:
> > > http://lkml.kernel.org/r/20181002100531.GC4135@quack2.suse.cz
> > > : commit e1fb4a086495 "dax: remove VM_MIXEDMAP for fsdax and device dax" has
> > > : removed VM_MIXEDMAP flag from DAX VMAs. Now our testing shows that in the
> > > : mean time certain customer of ours started poking into /proc/<pid>/smaps
> > > : and looks at VMA flags there and if VM_MIXEDMAP is missing among the VMA
> > > : flags, the application just fails to start complaining that DAX support is
> > > : missing in the kernel.
> > >
> > > http://lkml.kernel.org/r/alpine.DEB.2.21.1809241054050.224429@chino.kir.corp.google.com
> > > : Commit 1860033237d4 ("mm: make PR_SET_THP_DISABLE immediately active")
> > > : introduced a regression in that userspace cannot always determine the set
> > > : of vmas where thp is ineligible.
> > > : Userspace relies on the "nh" flag being emitted as part of /proc/pid/smaps
> > > : to determine if a vma is eligible to be backed by hugepages.
> > > : Previous to this commit, prctl(PR_SET_THP_DISABLE, 1) would cause thp to
> > > : be disabled and emit "nh" as a flag for the corresponding vmas as part of
> > > : /proc/pid/smaps.  After the commit, thp is disabled by means of an mm
> > > : flag and "nh" is not emitted.
> > > : This causes smaps parsing libraries to assume a vma is eligible for thp
> > > : and ends up puzzling the user on why its memory is not backed by thp.
> > >
> > > In both cases userspace was relying on a semantic of a specific VMA
> > > flag. The primary reason why that happened is a lack of a proper
> > > internface. While this has been worked on and it will be fixed properly,
> > > it seems that our wording could see some refinement and be more vocal
> > > about semantic aspect of these flags as well.
> > >
> > > Cc: Jan Kara <jack@suse.cz>
> > > Cc: Dan Williams <dan.j.williams@intel.com>
> > > Cc: David Rientjes <rientjes@google.com>
> > > Signed-off-by: Michal Hocko <mhocko@suse.com>
> > > ---
> > >  Documentation/filesystems/proc.txt | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
> > > index 12a5e6e693b6..b1fda309f067 100644
> > > --- a/Documentation/filesystems/proc.txt
> > > +++ b/Documentation/filesystems/proc.txt
> > > @@ -496,7 +496,9 @@ flags associated with the particular virtual memory area in two letter encoded
> > >
> > >  Note that there is no guarantee that every flag and associated mnemonic will
> > >  be present in all further kernel releases. Things get changed, the flags may
> > > -be vanished or the reverse -- new added.
> > > +be vanished or the reverse -- new added. Interpretatation of their meaning
> > > +might change in future as well. So each consumnent of these flags have to
> > > +follow each specific kernel version for the exact semantic.
> > 
> > Can we start to claw some of this back? Perhaps with a config option
> > to hide the flags to put applications on notice?
> 
> I would love to. My knowledge of CRIU is very minimal, but my
> understanding is that this is the primary consumer of those flags. And
> checkpointing is so close to the specific kernel version that I assume
> that this abuse is somehow justified.

CRIU relies on vmflags to recreate exactly the same address space layout at
restore time.

> We can hide it behind CONFIG_CHECKPOINT_RESTORE but does it going to
> help? I presume that many distro kernels will have the config enabled.

They do :)
 
> > I recall that when I
> > introduced CONFIG_IO_STRICT_DEVMEM it caused enough regressions that
> > distros did not enable it, but now a few years out I'm finding that it
> > is enabled in more places.
> > 
> > In any event,
> > 
> > Acked-by: Dan Williams <dan.j.williams@intel.com>

Forgot that in my previous nit-picking e-mail:

Acked-by: Mike Rapoport <rppt@linux.ibm.com>
 
> Thanks!
> 
> -- 
> Michal Hocko
> SUSE Labs
> 

-- 
Sincerely yours,
Mike.

