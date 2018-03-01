Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965956AbeCAIkv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 03:40:51 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48006 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965804AbeCAIkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 03:40:49 -0500
Subject: Re: [PATCH v2 03/15] s390: zcrypt: externalize AP instructions
 available function
To: Cornelia Huck <cohuck@redhat.com>,
        Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
References: <1519741693-17440-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1519741693-17440-4-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180228184155.5b397f76.cohuck@redhat.com>
From: Harald Freudenberger <freude@linux.vnet.ibm.com>
Date: Thu, 1 Mar 2018 09:38:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180228184155.5b397f76.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18030108-0008-0000-0000-000004D65604
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030108-0009-0000-0000-00001E695904
Message-Id: <053311e4-a5a6-0007-4b6a-c24494df48c8@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-01_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803010114
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/28/2018 06:41 PM, Cornelia Huck wrote:
> On Tue, 27 Feb 2018 09:28:01 -0500
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>
>> If the AP instructions are not available on the linux host, then
>> AP devices can not be interpreted by the SIE. The AP bus has a
>> function it uses to determine if the AP instructions are
>> available. This patch provides a new function that wraps the
>> AP bus's function to externalize it for use by KVM.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>> Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
>> ---
>>  arch/s390/include/asm/ap.h   |    7 +++++++
>>  drivers/s390/crypto/ap_bus.c |    6 ++++++
>>  2 files changed, 13 insertions(+), 0 deletions(-)
> While I don't see anything wrong with this patch as it stands, you need
> to be careful to call this only from vfio-ap code (which depends on
> CONFIG_ZCRYPT).
>
> Speaking of which: the ap_bus part cannot be a module, but only
> built-in, right? So we don't get additional module complications?
Right, the AP bus is not available as a module but statically build.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-s390" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
