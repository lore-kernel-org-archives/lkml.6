Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752659AbeDQRyz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 13:54:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34050 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752655AbeDQRyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 13:54:53 -0400
Subject: Re: [PATCH v4 02/15] KVM: s390: reset crypto attributes for all vcpus
To: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        borntraeger@de.ibm.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
References: <1523827345-11600-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1523827345-11600-3-git-send-email-akrowiak@linux.vnet.ibm.com>
 <41496d07-54b3-5cc6-8803-a935f6d821ee@linux.vnet.ibm.com>
 <4dd8242a-4f25-065f-5eea-e53c73130763@linux.vnet.ibm.com>
 <20180417171057.2030e56b.cohuck@redhat.com>
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Tue, 17 Apr 2018 13:54:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180417171057.2030e56b.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18041717-0036-0000-0000-000002E4361F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008872; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01019315; UDB=6.00520005; IPR=6.00798557;
 MB=3.00020619; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-17 17:54:51
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041717-0037-0000-0000-00004404F252
Message-Id: <56792e6f-4fef-4dbc-fe55-aeb8cb28f309@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-17_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804170155
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/17/2018 11:10 AM, Cornelia Huck wrote:
> On Tue, 17 Apr 2018 10:55:30 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>
>> On 04/17/2018 10:29 AM, Halil Pasic wrote:
>>>
>>> On 04/15/2018 11:22 PM, Tony Krowiak wrote:
>>>> Introduces a new function to reset the crypto attributes for all
>>>> vcpus whether they are running or not. Each vcpu in KVM will
>>>> be removed from SIE prior to resetting the crypto attributes in its
>>>> SIE state description. After all vcpus have had their crypto attributes
>>>> reset the vcpus will be restored to SIE.
>>>>
>>>> This function will be used in a later patch to set the ECA.28
>>>> bit in the SIE state description to enable interpretive execution of
>>>> AP instructions. It will also be incorporated into the
>>>> kvm_s390_vm_set_crypto(kvm) function to fix an issue whereby the crypto
>>>> key wrapping attributes could potentially get out of synch for running
>>>> vcpus.
>>>>   
>>> Wasn't this 'issue' reported by me by any chance?
>> Yes it was .... was I supposed to include that fact in the commit message?
> A Reported-by: is usually nice.
I wasn't aware of such a tag.
>
>>> I agree with Connnie, we don't need the forward reference to
>>> ECA.28.
>> I'm not sure that's exactly what she said, but I'd be more than happy
>> to remove it.
> It was kind of implied :)
>
