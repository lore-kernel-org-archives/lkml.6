Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752722AbeB0LO1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 06:14:27 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33524 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752130AbeB0LO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 06:14:26 -0500
Subject: Re: [Xen-devel] [PATCH] xen: use hvc console for dom0
To: Juergen Gross <jgross@suse.com>,
        Andrii Anisov <andrii_anisov@epam.com>, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org
Cc: boris.ostrovsky@oracle.com,
        Stefano Stabellini <sstabellini@kernel.org>, jbeulich@suse.com
References: <20180226110822.13787-1-jgross@suse.com>
 <0d8bdda5-faef-41da-344a-644b5c3d6006@epam.com>
 <58e94cc9-9b09-d6b7-3122-fb4c83e97926@suse.com>
From: Julien Grall <julien.grall@arm.com>
Message-ID: <b57092b4-e740-e1f8-3885-a817bb7d4e70@arm.com>
Date: Tue, 27 Feb 2018 11:14:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <58e94cc9-9b09-d6b7-3122-fb4c83e97926@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 26/02/18 12:32, Juergen Gross wrote:
> On 26/02/18 13:06, Andrii Anisov wrote:
>> Hello Juergen,
>>
>>
>> On 26.02.18 13:08, Juergen Gross wrote:
>>> Today the hvc console is added as a preferred console for pv domUs
>>> only. As this requires a boot parameter for getting dom0 messages per
>>> default add it for dom0, too.
>>>
>>> Signed-off-by: Juergen Gross <jgross@suse.com>
>>> ---
>>>    arch/x86/xen/enlighten_pv.c | 4 +++-
>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
>> Is this something x86 specific? Could it be a generic approach?
> 
> In case ARM wants something similar I guess the test for
> xen_initial_domain() should be dropped in xen_early_init().
I am pretty sure we discussed to remove !xen_initial_domain() for Arm in 
the past. But I don't remember why the patch was not sent to remove it.

Anyway, I guess this should be fine to have hvc as a preferred console 
for the initial domain as well.

Cheers,

-- 
Julien Grall
