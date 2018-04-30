Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754734AbeD3Q2v (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 12:28:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53646 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753334AbeD3Q2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 12:28:50 -0400
Date: Mon, 30 Apr 2018 09:28:23 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, tglx@linutronix.de,
        mpe@ellerman.id.au, akpm@linux-foundation.org, shuah@kernel.org,
        shakeelb@google.com
Subject: Re: [PATCH 0/9] [v3] x86, pkeys: two protection keys bug fixes
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <20180427174527.0031016C@viggo.jf.intel.com>
 <20180428070553.yjlt22sb6ntcaqnc@gmail.com>
 <a176ae33-eb01-d275-f372-a33829e865a7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a176ae33-eb01-d275-f372-a33829e865a7@intel.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-TM-AS-GCONF: 00
x-cbid: 18043016-0044-0000-0000-0000054D8989
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18043016-0045-0000-0000-0000288EA1DB
Message-Id: <20180430162823.GB5666@ram.oc3035372033.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-30_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804300158
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2018 at 08:30:43AM -0700, Dave Hansen wrote:
> On 04/28/2018 12:05 AM, Ingo Molnar wrote:
> > In the above kernel that was missing the PROT_EXEC fix I was repeatedly running 
> > the 64-bit and 32-bit testcases as non-root and as root as well, until I got a 
> > hang in the middle of a 32-bit test running as root:
> > 
> >   test  7 PASSED (iteration 19)
> >   test  8 PASSED (iteration 19)
> >   test  9 PASSED (iteration 19)
> > 
> >   < test just hangs here >
> 
> For the hang, there is a known issue with the use of printf() in the
> signal handler and a resulting deadlock.  I *thought* there was a patch
> merged to fix this from Ram Pai or one of the other IBM folks.

Yes. there is a patch. unfortunately that patch assumes the selftest has
been moved into selftests/vm directory.  One option is --  I merge your
changes in my selftest patchset, and send the entire series for upstream
merge.

Or you can manually massage-in the specific fix.
The patch is "selftests/vm: Fix deadlock in protection_keys.c"
https://patchwork.ozlabs.org/patch/864394/

Let me know,
-- 
Ram Pai
