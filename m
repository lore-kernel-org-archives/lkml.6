Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752205AbeDGBJc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 21:09:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55842 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751528AbeDGBJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 21:09:31 -0400
Date: Fri, 6 Apr 2018 18:09:19 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, shakeelb@google.com,
        stable@kernel.org, tglx@linutronix.de, mpe@ellerman.id.au,
        mingo@kernel.org, akpm@linux-foundation.org, shuah@kernel.org
Subject: Re: [PATCH 4/9] x86, pkeys: override pkey when moving away from
 PROT_EXEC
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <20180326172721.D5B2CBB4@viggo.jf.intel.com>
 <20180326172727.025EBF16@viggo.jf.intel.com>
 <20180407000943.GA15890@ram.oc3035372033.ibm.com>
 <6e3f8e1c-afed-64de-9815-8478e18532aa@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e3f8e1c-afed-64de-9815-8478e18532aa@intel.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-TM-AS-GCONF: 00
x-cbid: 18040701-0012-0000-0000-000005C802CA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040701-0013-0000-0000-00001944221F
Message-Id: <20180407010919.GB15890@ram.oc3035372033.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-06_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804070011
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 06, 2018 at 05:47:29PM -0700, Dave Hansen wrote:
> On 04/06/2018 05:09 PM, Ram Pai wrote:
> >> -	/*
> >> -	 * Look for a protection-key-drive execute-only mapping
> >> -	 * which is now being given permissions that are not
> >> -	 * execute-only.  Move it back to the default pkey.
> >> -	 */
> >> -	if (vma_is_pkey_exec_only(vma) &&
> >> -	    (prot & (PROT_READ|PROT_WRITE))) {
> >> -		return 0;
> >> -	}
> >> +
> > Dave,
> > 	this can be simply:
> > 
> > 	if ((vma_is_pkey_exec_only(vma) && (prot != PROT_EXEC))
> > 		return ARCH_DEFAULT_PKEY;
> 
> Yes, but we're removing that code entirely. :)

Well :). my point is add this code and delete the other
code that you add later in that function.

RP



-- 
Ram Pai
