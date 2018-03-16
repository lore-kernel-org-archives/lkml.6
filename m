Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753629AbeCPKgL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 06:36:11 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43348 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753612AbeCPKgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 06:36:08 -0400
Date: Fri, 16 Mar 2018 13:35:11 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
        SF Markus Elfring <elfring@users.sourceforge.net>,
        linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Borislav Petkov <bp@suse.de>, Brijesh Singh <brijesh.singh@amd.com>,
        Josh Sklar <sklar@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>, Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] powerpc: Use common error handling code in
 setup_new_fdt()
Message-ID: <20180316103511.77hog6scdxg2k7ts@mwanda>
References: <0dd9d938-8d89-f0e0-f05f-9a3e5dc42a57@users.sourceforge.net>
 <87fu52jqtc.fsf@morokweng.localdomain>
 <20180315115753.rjejlkrp3fhdxbyk@mwanda>
 <87bmfofh8y.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bmfofh8y.fsf@concordia.ellerman.id.au>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8833 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803160005
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 09:26:53PM +1100, Michael Ellerman wrote:
> Dan Carpenter <dan.carpenter@oracle.com> writes:
> > On Wed, Mar 14, 2018 at 06:22:07PM -0300, Thiago Jung Bauermann wrote:
> >> SF Markus Elfring <elfring@users.sourceforge.net> writes:
> >> > From: Markus Elfring <elfring@users.sourceforge.net>
> >> > Date: Sun, 11 Mar 2018 09:03:42 +0100
> >> >
> >> > Add a jump target so that a bit of exception handling can be better reused
> >> > at the end of this function.
> >> >
> >> > This issue was detected by using the Coccinelle software.
> >> >
> >> > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> >> > ---
> >> >  arch/powerpc/kernel/machine_kexec_file_64.c | 28 ++++++++++++----------------
> >> >  1 file changed, 12 insertions(+), 16 deletions(-)
> >> 
> >> I liked it. Thanks!
> >> 
> >> Reviewed-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> >
> > You know that compilers already re-use string constants so this doesn't
> > actually save memory?
> 
> Sure, but it's still clearer to only have the string appear once in the
> code.
> 

To me the original was better.

> > Also we should be preserving the error codes
> > instead of always returning -EINVAL.
> 
> The error codes come from libfdt code, so they don't necessarily make
> sense in the kernel. eg. FDT_ERR_NOSPACE == 3 == ESRCH.
> 
> Perhaps we should be trying harder to convert them, but that's a
> criticism of the original code not this patch.

Ah.  You're right.  I look at the patch in context, sorry.

regards,
dan carpenter
