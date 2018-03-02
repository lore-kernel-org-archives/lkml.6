Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1428309AbeCBSDi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 13:03:38 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51880 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1426543AbeCBSDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 13:03:35 -0500
Date: Fri, 2 Mar 2018 20:03:18 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dave Young <dyoung@redhat.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau
        <marcandre.lureau@redhat.com>,
        linux-kernel@vger.kernel.org, arnd@arndb.de, bhe@redhat.com,
        slp@redhat.com, somlo@cmu.edu, xiaolong.ye@intel.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>,
        Tony Luck <tony.luck@intel.com>, Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v16 09/11] crash: export paddr_vmcoreinfo_note()
Message-ID: <20180302200241-mutt-send-email-mst@kernel.org>
References: <20180228150615.17317-1-marcandre.lureau@redhat.com>
 <20180228150615.17317-10-marcandre.lureau@redhat.com>
 <20180302023204.GA2818@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180302023204.GA2818@dhcp-128-65.nay.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 02, 2018 at 10:32:04AM +0800, Dave Young wrote:
> Hi
> 
> On 02/28/18 at 04:06pm, Marc-André Lureau wrote:
> > The following patch is going to use the symbol from the fw_cfg module,
> > to call the function and write the note location details in the
> > vmcoreinfo entry, so qemu can produce dumps with the vmcoreinfo note.
> > 
> > CC: Andrew Morton <akpm@linux-foundation.org>
> > CC: Baoquan He <bhe@redhat.com>
> > CC: Dave Young <dyoung@redhat.com>
> > CC: Dave Young <dyoung@redhat.com>
> 
> Above duplicated a CC, btw, I remember both Baoquan and me acked it
> before, you can find the old email and carry the acked-by.

I fixed it but all this is submitter's job really.

> > CC: Hari Bathini <hbathini@linux.vnet.ibm.com>
> > CC: Tony Luck <tony.luck@intel.com>
> > CC: Vivek Goyal <vgoyal@redhat.com>
> > Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > Acked-by: Gabriel Somlo <somlo@cmu.edu>
> > ---
> >  kernel/crash_core.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> > index 4f63597c824d..a93590cdd9e1 100644
> > --- a/kernel/crash_core.c
> > +++ b/kernel/crash_core.c
> > @@ -376,6 +376,7 @@ phys_addr_t __weak paddr_vmcoreinfo_note(void)
> >  {
> >  	return __pa(vmcoreinfo_note);
> >  }
> > +EXPORT_SYMBOL(paddr_vmcoreinfo_note);
> >  
> >  static int __init crash_save_vmcoreinfo_init(void)
> >  {
> > -- 
> > 2.16.1.73.g5832b7e9f2
> > 
> 
> Thanks
> Dave
