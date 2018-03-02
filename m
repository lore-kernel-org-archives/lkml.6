Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164387AbeCBCcP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 21:32:15 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57360 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1164179AbeCBCcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 21:32:13 -0500
Date: Fri, 2 Mar 2018 10:32:04 +0800
From: Dave Young <dyoung@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, bhe@redhat.com,
        slp@redhat.com, mst@redhat.com, somlo@cmu.edu, xiaolong.ye@intel.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>,
        Tony Luck <tony.luck@intel.com>, Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v16 09/11] crash: export paddr_vmcoreinfo_note()
Message-ID: <20180302023204.GA2818@dhcp-128-65.nay.redhat.com>
References: <20180228150615.17317-1-marcandre.lureau@redhat.com>
 <20180228150615.17317-10-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180228150615.17317-10-marcandre.lureau@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 02/28/18 at 04:06pm, Marc-André Lureau wrote:
> The following patch is going to use the symbol from the fw_cfg module,
> to call the function and write the note location details in the
> vmcoreinfo entry, so qemu can produce dumps with the vmcoreinfo note.
> 
> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: Baoquan He <bhe@redhat.com>
> CC: Dave Young <dyoung@redhat.com>
> CC: Dave Young <dyoung@redhat.com>

Above duplicated a CC, btw, I remember both Baoquan and me acked it
before, you can find the old email and carry the acked-by.

> CC: Hari Bathini <hbathini@linux.vnet.ibm.com>
> CC: Tony Luck <tony.luck@intel.com>
> CC: Vivek Goyal <vgoyal@redhat.com>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Acked-by: Gabriel Somlo <somlo@cmu.edu>
> ---
>  kernel/crash_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 4f63597c824d..a93590cdd9e1 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -376,6 +376,7 @@ phys_addr_t __weak paddr_vmcoreinfo_note(void)
>  {
>  	return __pa(vmcoreinfo_note);
>  }
> +EXPORT_SYMBOL(paddr_vmcoreinfo_note);
>  
>  static int __init crash_save_vmcoreinfo_init(void)
>  {
> -- 
> 2.16.1.73.g5832b7e9f2
> 

Thanks
Dave
