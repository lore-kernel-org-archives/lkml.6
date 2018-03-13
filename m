Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751620AbeCMFnO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 01:43:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57740 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750910AbeCMFnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 01:43:13 -0400
Subject: Re: [PATCH v3] powerpc/kernel/sysfs: Export ldbar spr to sysfs
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        maddy@linux.vnet.ibm.com
References: <1510232445-10869-1-git-send-email-anju@linux.vnet.ibm.com>
 <878tb5foqk.fsf@concordia.ellerman.id.au>
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Date: Tue, 13 Mar 2018 11:13:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <878tb5foqk.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18031305-0036-0000-0000-000002CF41F8
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008664; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.01002295; UDB=6.00509987; IPR=6.00781626;
 MB=3.00020003; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-13 05:43:08
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031305-0037-0000-0000-0000439FDFCE
Message-Id: <dba1f760-2073-f7e0-148f-370f5ead4e76@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-13_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803130070
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On Tuesday 06 March 2018 04:35 PM, Michael Ellerman wrote:
> Anju T Sudhakar <anju@linux.vnet.ibm.com> writes:
>
>> diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
>> index 4437c70..caefb64 100644
>> --- a/arch/powerpc/kernel/sysfs.c
>> +++ b/arch/powerpc/kernel/sysfs.c
>> @@ -757,6 +759,9 @@ static int register_cpu_online(unsigned int cpu)
>>   			device_create_file(s, &pmc_attrs[i]);
>>   
>>   #ifdef CONFIG_PPC64
>> +	if (cpu_has_feature(CPU_FTR_ARCH_300))
>> +		device_create_file(s, &dev_attr_ldbar);
> Is this register readable in supervisor state?

This is a nice catch, thanks. :)
The guest kernel can not access the register, it is only readable in the 
hypervisor state.
I will resend the patch with a condition check so that this spr will not 
get registered for guest kernel.


Regards,
Anju
>
> cheers
>
