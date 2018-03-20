Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751832AbeCTG2M (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 02:28:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:53455 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751508AbeCTG2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 02:28:11 -0400
Subject: Re: [PATCH] x86/xen: Delay get_cpu_cap until stack canary is
 established
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Jason Andryuk <jandryuk@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20180319165804.10636-1-jandryuk@gmail.com>
 <0726a193-6ce9-e835-9eef-01c56680d30a@oracle.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <6d73d847-9f33-7dce-2f60-33481bb4776e@suse.com>
Date: Tue, 20 Mar 2018 07:28:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <0726a193-6ce9-e835-9eef-01c56680d30a@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/03/18 23:22, Boris Ostrovsky wrote:
> On 03/19/2018 12:58 PM, Jason Andryuk wrote:
>> Commit 2cc42bac1c79 ("x86-64/Xen: eliminate W+X mappings") introduced a
>> call to get_cpu_cap, which is fstack-protected.  This is works on x86-64
> 
> s/This is works/This works/
> 
> Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> 
> Do we still need 4f277295e54?

I'd rather keep it in order to avoid nasty problems in case something
changes. After all we are trying to do an initialization in C code
which should be done in assembly before entering the C part. Doing this
properly for 32-bit pv-kernels would be rather difficult, but this is no
reason to drop the correct solution for the 64-bit case.


Juergen
