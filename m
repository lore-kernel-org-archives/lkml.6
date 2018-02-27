Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752577AbeB0J0q (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 04:26:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:33743 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752049AbeB0J0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 04:26:44 -0500
Subject: Re: [PATCH] xen: use hvc console for dom0
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc: jbeulich@suse.com
References: <20180226110822.13787-1-jgross@suse.com>
 <16e21e9e-35d5-81f2-0f90-df5f8ac72446@oracle.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <0bee63f6-6681-5cb1-b763-66cf8304ae84@suse.com>
Date: Tue, 27 Feb 2018 10:26:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <16e21e9e-35d5-81f2-0f90-df5f8ac72446@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/02/18 20:02, Boris Ostrovsky wrote:
> On 02/26/2018 06:08 AM, Juergen Gross wrote:
>> Today the hvc console is added as a preferred console for pv domUs
>> only. As this requires a boot parameter for getting dom0 messages per
>> default add it for dom0, too.
>>
>> Signed-off-by: Juergen Gross <jgross@suse.com>
>> ---
>>  arch/x86/xen/enlighten_pv.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
>> index c047f42552e1..d27740a80c5e 100644
>> --- a/arch/x86/xen/enlighten_pv.c
>> +++ b/arch/x86/xen/enlighten_pv.c
>> @@ -1377,7 +1377,6 @@ asmlinkage __visible void __init xen_start_kernel(void)
>>  	if (!xen_initial_domain()) {
>>  		add_preferred_console("xenboot", 0, NULL);
>>  		add_preferred_console("tty", 0, NULL);
>> -		add_preferred_console("hvc", 0, NULL);
>>  		if (pci_xen)
>>  			x86_init.pci.arch_init = pci_xen_init;
>>  	} else {
>> @@ -1410,6 +1409,9 @@ asmlinkage __visible void __init xen_start_kernel(void)
>>  
>>  		xen_boot_params_init_edd();
>>  	}
>> +
>> +	add_preferred_console("hvc", 0, NULL);
>> +
> 
> Won't this prevent dom0 output from showing up on vga console by default?

Right, we need to add "tty", too.

Will send V2.


Juergen
