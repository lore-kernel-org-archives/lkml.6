Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751794AbeBZTGq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 14:06:46 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:57222 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750941AbeBZTGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 14:06:45 -0500
Subject: Re: [PATCH] xen: use hvc console for dom0
To: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org
Cc: jbeulich@suse.com
References: <20180226110822.13787-1-jgross@suse.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <16e21e9e-35d5-81f2-0f90-df5f8ac72446@oracle.com>
Date: Mon, 26 Feb 2018 14:02:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180226110822.13787-1-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8816 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802260244
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/26/2018 06:08 AM, Juergen Gross wrote:
> Today the hvc console is added as a preferred console for pv domUs
> only. As this requires a boot parameter for getting dom0 messages per
> default add it for dom0, too.
>
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  arch/x86/xen/enlighten_pv.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
> index c047f42552e1..d27740a80c5e 100644
> --- a/arch/x86/xen/enlighten_pv.c
> +++ b/arch/x86/xen/enlighten_pv.c
> @@ -1377,7 +1377,6 @@ asmlinkage __visible void __init xen_start_kernel(void)
>  	if (!xen_initial_domain()) {
>  		add_preferred_console("xenboot", 0, NULL);
>  		add_preferred_console("tty", 0, NULL);
> -		add_preferred_console("hvc", 0, NULL);
>  		if (pci_xen)
>  			x86_init.pci.arch_init = pci_xen_init;
>  	} else {
> @@ -1410,6 +1409,9 @@ asmlinkage __visible void __init xen_start_kernel(void)
>  
>  		xen_boot_params_init_edd();
>  	}
> +
> +	add_preferred_console("hvc", 0, NULL);
> +

Won't this prevent dom0 output from showing up on vga console by default?

-boris

>  #ifdef CONFIG_PCI
>  	/* PCI BIOS service won't work from a PV guest. */
>  	pci_probe &= ~PCI_PROBE_BIOS;
