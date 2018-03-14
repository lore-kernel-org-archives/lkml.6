Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752043AbeCNSzZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 14:55:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56342 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751700AbeCNSzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 14:55:21 -0400
Date: Wed, 14 Mar 2018 11:54:52 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: mingo@redhat.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        benh@kernel.crashing.org, paulus@samba.org,
        khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
        bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, corbet@lwn.net,
        arnd@arndb.de, fweimer@redhat.com, msuchanek@suse.com
Subject: Re: [PATCH 1/1 v2] x86: pkey-mprotect must allow pkey-0
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1521013574-27041-1-git-send-email-linuxram@us.ibm.com>
 <18b155e3-07e9-5a4b-1f95-e1667078438c@intel.com>
 <20180314171448.GA1060@ram.oc3035372033.ibm.com>
 <5027ca9e-63c8-47ab-960d-a9c4466d7075@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5027ca9e-63c8-47ab-960d-a9c4466d7075@intel.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-TM-AS-GCONF: 00
x-cbid: 18031418-0040-0000-0000-000004208106
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031418-0041-0000-0000-00002623869A
Message-Id: <20180314185452.GB1060@ram.oc3035372033.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-14_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803140206
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 10:51:26AM -0700, Dave Hansen wrote:
> On 03/14/2018 10:14 AM, Ram Pai wrote:
> > I look at key-0 as 'the key'. It has special status. 
> > (a) It always exist.
> 
> Do you mean "is always allocated"?

always allocated and cannot be freed. Hence always exists.

If we let it freed, than yes 'it is always allocated', but
may not 'always exist'.

> 
> > (b) it cannot be freed.
> 
> This is the one I'm questioning.

this is a philosophical question. Should we allow the application 
shoot-its-own-feet or help it from doing so. I tend to
gravitate towards the later.

> 
> > (c) it is assigned by default.
> 
> I agree on this totally. :)

good. we have some common ground :)

> 
> > (d) its permissions cannot be modified.
> 
> Why not?  You could pretty easily get a thread going that had its stack
> covered with another pkey and that was being very careful what it
> accesses.  It could pretty easily set pkey-0's access or write-disable bits.

ok. I see your point. Will not argue against it.

> 
> > (e) it bypasses key-permission checks when assigned.
> 
> I don't think this is necessary.  I think the only rule we *need* is:
> 
> 	pkey-0 is allocated implicitly at execve() time.  You do not
> 	need to call pkey_alloc() to allocate it.

And can be explicitly associated with any address range ?

> 
> > An arch need not necessarily map 'the key-0' to its key-0.  It could
> > internally map it to any of its internal key of its choice, transparent
> > to the application.
> 
> I don't understand what you are saying here.

I was trying to disassociate the notion that "application's key-0 
means hardware's key-0". Nevermind. its not important for this
discussion.

-- 
Ram Pai
