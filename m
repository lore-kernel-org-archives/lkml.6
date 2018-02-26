Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752589AbeBZMdC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 07:33:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:38263 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752218AbeBZMdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 07:33:01 -0500
Subject: Re: [Xen-devel] [PATCH] xen: use hvc console for dom0
To: Andrii Anisov <andrii_anisov@epam.com>, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org
Cc: boris.ostrovsky@oracle.com, jbeulich@suse.com,
        Stefano Stabellini <sstabellini@kernel.org>
References: <20180226110822.13787-1-jgross@suse.com>
 <0d8bdda5-faef-41da-344a-644b5c3d6006@epam.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <58e94cc9-9b09-d6b7-3122-fb4c83e97926@suse.com>
Date: Mon, 26 Feb 2018 13:32:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <0d8bdda5-faef-41da-344a-644b5c3d6006@epam.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/02/18 13:06, Andrii Anisov wrote:
> Hello Juergen,
> 
> 
> On 26.02.18 13:08, Juergen Gross wrote:
>> Today the hvc console is added as a preferred console for pv domUs
>> only. As this requires a boot parameter for getting dom0 messages per
>> default add it for dom0, too.
>>
>> Signed-off-by: Juergen Gross <jgross@suse.com>
>> ---
>>   arch/x86/xen/enlighten_pv.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
> Is this something x86 specific? Could it be a generic approach?

In case ARM wants something similar I guess the test for
xen_initial_domain() should be dropped in xen_early_init().

Stefano?


Juergen
