Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754654AbeDVPxi (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 11:53:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39332 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754251AbeDVPxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 11:53:34 -0400
Subject: Re: [PATCH] KVM: s390: reset crypto attributes for all vcpus
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, pmorel@linux.vnet.ibm.com,
        pasic@linux.vnet.ibm.com, pbonzini@redhat.com, rkrcmar@redhat.com
References: <1524172432-26211-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <d7ed9844-0753-6d7a-ccd8-48e89992a34e@redhat.com>
 <d6e8e85b-525e-906a-3c17-ea5faef143cb@linux.vnet.ibm.com>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Sun, 22 Apr 2018 17:53:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <d6e8e85b-525e-906a-3c17-ea5faef143cb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18042215-0040-0000-0000-00000431B1A6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042215-0041-0000-0000-00002635D393
Message-Id: <28eacee1-eafe-dc95-c008-61bc656b931c@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-22_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804220180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/22/2018 05:06 PM, Tony Krowiak wrote:
> On 04/20/2018 08:26 AM, David Hildenbrand wrote:
>> On 19.04.2018 23:13, Tony Krowiak wrote:
>>> Introduces a new function to reset the crypto attributes for all
>>> vcpus whether they are running or not. Each vcpu in KVM will
>>> be removed from SIE prior to resetting the crypto attributes in its
>>> SIE state description. After all vcpus have had their crypto attributes
>>> reset the vcpus will be restored to SIE.
>>>
>>> This function is incorporated into the kvm_s390_vm_set_crypto(kvm)
>>> function to fix a reported issue whereby the crypto key wrapping
>>> attributes could potentially get out of synch for running vcpus.
>>>
>>> Reported-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>> A reported-by for a code refactoring is strange.
> 
> I was asked to include this.

Is this a refactoring or a fix? I the message you state that you are
fixing an issue (aka bug). If you are not, fixing an issue, but indeed
just refactoring, Suggested-by would be more appropriate.

Regards,
Halil
