Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751895AbeFEIyw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 04:54:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33984 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751540AbeFEIyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 04:54:49 -0400
Subject: Re: [PATCH v2] cpuidle/powernv : Add Description for cpuidle state
To: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: rjw@rjwysocki.net, daniel.lezcano@linaro.org, paulus@samba.org,
        mpe@ellerman.id.au, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        stewart@linux.vnet.ibm.com
References: <20180604081758.104201-1-huntbag@linux.vnet.ibm.com>
 <0a28154deb468669a59c120a90d4aedc1e1e705b.camel@kernel.crashing.org>
 <20180604114500.3rlpuso5aftesnf5@aksadiga.ibm>
From: Abhishek <huntbag@linux.vnet.ibm.com>
Date: Tue, 5 Jun 2018 14:24:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180604114500.3rlpuso5aftesnf5@aksadiga.ibm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18060508-4275-0000-0000-0000028A478E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060508-4276-0000-0000-000037914A6F
Message-Id: <17cd53ec-6bc1-5814-8824-3c6a4f0b90cd@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-05_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806050108
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/04/2018 05:15 PM, Akshay Adiga wrote:
> On Mon, Jun 04, 2018 at 07:04:14PM +1000, Benjamin Herrenschmidt wrote:
>> Is this a new property ? I'm not fan of adding yet another of those
>> silly arrays.
>>
>> I would say this is the right time now to switch over to a node per
>> state instead, as we discussed with Vaidy.

It is not a new property. Name was being used for description as 
description was not present in device tree. A skiboot patch adding 
description to device tree have been posted. This patch reads those 
description instead of copying name itself into description. And we fall 
back to reading name into description to not break the comaptibility 
with older firmware.

Thanks
Abhishek

> I posted  the node based device tree here :
> skiboot patch :  https://patchwork.ozlabs.org/patch/923120/
> kernel patch : https://lkml.org/lkml/2018/5/30/1146
>
> Do you have any inputs for this design ?
>
>> Additionally, while doing that, we can provide the versioning mechanism
>> I proposed so we can deal with state specific issues and erratas.
>>
>> Cheers,
>> Ben.
>>
