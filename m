Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932330AbeCORkU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 13:40:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39546 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752152AbeCORkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 13:40:18 -0400
Date: Thu, 15 Mar 2018 10:39:59 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        benh@kernel.crashing.org, paulus@samba.org,
        khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
        bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, corbet@lwn.net,
        arnd@arndb.de, fweimer@redhat.com, msuchanek@suse.com,
        Ulrich.Weigand@de.ibm.com
Subject: Re: [PATCH v3] x86: treat pkey-0 special
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1521061214-22385-1-git-send-email-linuxram@us.ibm.com>
 <alpine.DEB.2.21.1803151039430.1525@nanos.tec.linutronix.de>
 <f5ef79ef-122a-e0a3-9b8e-d49c33f4a417@intel.com>
 <20180315172129.GD1060@ram.oc3035372033.ibm.com>
 <2bf8e659-5a8d-a2d5-ea52-e4d395ea2201@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bf8e659-5a8d-a2d5-ea52-e4d395ea2201@intel.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-TM-AS-GCONF: 00
x-cbid: 18031517-0040-0000-0000-000004216384
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031517-0041-0000-0000-000026246DE3
Message-Id: <20180315173959.GE1060@ram.oc3035372033.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-15_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803150193
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 10:31:51AM -0700, Dave Hansen wrote:
> On 03/15/2018 10:21 AM, Ram Pai wrote:
> > On Thu, Mar 15, 2018 at 08:55:31AM -0700, Dave Hansen wrote:
> >> On 03/15/2018 02:46 AM, Thomas Gleixner wrote:
> >>>> +	if (!pkey || !mm_pkey_is_allocated(mm, pkey))
> >>> Why this extra check? mm_pkey_is_allocated(mm, 0) should not return true
> >>> ever. If it does, then this wants to be fixed.
> >> I was thinking that we _do_ actually want it to seem allocated.  It just
> >> get "allocated" implicitly when an mm is created.  I think that will
> >> simplify the code if we avoid treating it specially in as many places as
> >> possible.
> > I think, the logic that makes pkey-0 special must to go
> > in arch-neutral code.   How about checking for pkey-0 in sys_pkey_free()
> > itself?
> 
> This is for protection against shooting yourself in the foot?  Yes, that
> can go in sys_pkey_free().
> 
> Does this need manpage and/or selftests updates?

Yes. it needs selftest, manpage and documentation updates too.

Unfortunately I am not getting enough reviewed-by for my selftests
and documentation changes. :-(  Need help!


-- 
Ram Pai
