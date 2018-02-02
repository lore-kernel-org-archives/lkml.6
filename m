Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752074AbeBBQek (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 11:34:40 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:41328 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751708AbeBBQec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 11:34:32 -0500
Date: Fri, 2 Feb 2018 19:34:01 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, Nicolas Pitre <nico@linaro.org>,
        Andi Kleen <ak@linux.intel.com>, Jan Beulich <jbeulich@suse.com>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xen: hypercall: fix out-of-bounds memcpy
Message-ID: <20180202163401.zkshusaktxwrs6uj@mwanda>
References: <20180202153240.1190361-1-arnd@arndb.de>
 <20180202155309.2xg2gjcp7wb7bbpe@mwanda>
 <CAK8P3a0Z2PMP-=e2Ga8kw196vWeAz_HC02ABQmDB9W_0Cmmr-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0Z2PMP-=e2Ga8kw196vWeAz_HC02ABQmDB9W_0Cmmr-Q@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8793 signatures=668661
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=695
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802020202
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2018 at 05:11:02PM +0100, Arnd Bergmann wrote:
> On Fri, Feb 2, 2018 at 4:53 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > On Fri, Feb 02, 2018 at 04:32:31PM +0100, Arnd Bergmann wrote:
> >>       switch (cmd) {
> >> +     case EVTCHNOP_bind_interdomain:
> >> +             len = sizeof(struct evtchn_bind_interdomain);
> >> +             break;
> >
> > This was in the original code, but I'm slightly surpprised that we're
> > using a switch statement here instead of a table.  I would have thought
> > this is a fast path but I don't know xen at all.
> 
> I thought about using a table, but figured the switch statement
> had a lower risk of getting something slightly wrong during the
> conversion.
> 
> I would expect gcc to turn this into a table lookup, since all the
> constants are consecutive, but it should not really matter since
> this is only the fallback path for ancient Xen releases. When Xen
> guest support was first merged in 2007, it was already
> deprecated.
> 

Ah.  Ok.  That makes sense.

regards,
dan carpenter
