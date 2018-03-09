Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751216AbeCIM4r (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 07:56:47 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:38578 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751086AbeCIM4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 07:56:45 -0500
Subject: Re: [Xen-devel] [PATCH v2] xen/acpi: upload _PSD info for non Dom0
 CPUs too
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org,
        xen-devel@lists.xenproject.org, Len Brown <lenb@kernel.org>,
        Erik Schmauss <erik.schmauss@intel.com>, devel@acpica.org
References: <20180308105751.8176-1-joao.m.martins@oracle.com>
 <4f20689f-552f-b9eb-272d-0035ba2efdd6@oracle.com>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <165abeed-3194-fe35-74f6-e2c68543c92c@oracle.com>
Date: Fri, 9 Mar 2018 12:56:28 +0000
MIME-Version: 1.0
In-Reply-To: <4f20689f-552f-b9eb-272d-0035ba2efdd6@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8826 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=936
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803090165
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/2018 10:33 PM, Boris Ostrovsky wrote:
> On 03/08/2018 05:57 AM, Joao Martins wrote:
> 
>> @@ -372,6 +376,15 @@ read_acpi_id(acpi_handle handle, u32 lvl, void *context, void **rv)
>>   
>>   	pr_debug("ACPI CPU%u w/ PBLK:0x%lx\n", acpi_id, (unsigned long)pblk);
>>   
>> +	/* It has P-state dependencies */
>> +	if (!acpi_processor_get_psd(handle, &acpi_psd[acpi_id])) {
>> +		__set_bit(acpi_id, acpi_id_psd_present);
>> +
>> +		pr_debug("ACPI CPU%u w/ PST:coord_type = %llu domain = %llu\n",
>> +			 acpi_id, acpi_psd[acpi_id].coord_type,
>> +			 acpi_psd[acpi_id].domain);
>> +	}
> 
> 
> I should have noticed this earlier, but do you really need 
> acpi_id_psd_present? Can you just go by acpi_psd[i] != NULL?
>

Oh yes! I was trying to be consistent with the rest of the module, but we surely
don't need that array of longs. Will respin after testing.

> Sorry for missing it in the first patch.
>
Thanks for the feedback!

> -boris
> 
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xenproject.org
> https://lists.xenproject.org/mailman/listinfo/xen-devel
> 
