Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757454AbeDXNBn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:01:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44164 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932502AbeDXNBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:01:39 -0400
Subject: Re: [PATCH v4 03/15] KVM: s390: refactor crypto initialization
To: Cornelia Huck <cohuck@redhat.com>
Cc: Harald Freudenberger <FREUDE@de.ibm.com>,
        Pierre Morel <pmorel@linux.vnet.ibm.com>, alex.williamson@redhat.com,
        alifm@linux.vnet.ibm.com, berrange@redhat.com,
        bjsdjshi@linux.vnet.ibm.com, borntrae@linux.ibm.com,
        fiuczy@linux.vnet.ibm.com, heicars2@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, kvm@vger.kernel.org, kwankhede@nvidia.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        mjrosato@linux.vnet.ibm.com, mschwid2@linux.vnet.ibm.com,
        pasic@linux.vnet.ibm.com, pbonzini@redhat.com,
        Reinhard Buendgen <BUENDGEN@de.ibm.com>, thuth@redhat.com
References: <1523827345-11600-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1523827345-11600-4-git-send-email-akrowiak@linux.vnet.ibm.com>
 <4fb50a31-1893-5cfb-0f35-fb2501c2afa8@linux.vnet.ibm.com>
 <OFE3FE11B1.8E1BDDEF-ON00258272.002AEDB1-C1258272.002B06EF@notes.na.collabserv.com>
 <20180417121044.5c8f2182.cohuck@redhat.com>
 <2ac8b862-e2dc-843e-a0b8-906fa32b42f4@linux.vnet.ibm.com>
 <20180417172139.0a2b148b.cohuck@redhat.com>
 <7276785e-2183-3204-ec80-99fba1546364@linux.vnet.ibm.com>
 <20180418094949.0403dcaf.cohuck@redhat.com>
 <470d8af7-b9f6-0ab7-9bfa-351fbeaa079c@linux.vnet.ibm.com>
 <20180423090337.1b8b465a.cohuck@redhat.com>
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Tue, 24 Apr 2018 09:01:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180423090337.1b8b465a.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18042413-0024-0000-0000-0000184722FE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008913; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01022577; UDB=6.00521947; IPR=6.00801811;
 MB=3.00020749; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-24 13:01:20
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042413-0025-0000-0000-00004FA900F2
Message-Id: <192888a1-afc8-8502-5c6f-dbb16625bda2@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-24_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804240126
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/23/2018 03:03 AM, Cornelia Huck wrote:
> On Sun, 22 Apr 2018 10:52:55 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>
>>>>>>> (Not providing a crycb if APXA is not available would be loss of
>>>>>>> functionality, I guess? Deciding not to provide vfio-ap if APXA is not
>>>>>>> available is a different game, of course.)
>>>>>> This would require a change to enabling the CPU model feature for
>>>>>> AP.
>>>>> But would it actually make sense to tie vfio-ap to APXA? This needs to
>>>>> be answered by folks with access to the architecture :)
>>>> I don't see any reason to do that from an architectural perspective.
>>>> One can access AP devices whether APXA is installed or not, it just limits
>>>> the range of devices that can be addressed
>>> So I guess we should not introduce a tie-in then (unless it radically
>>> simplifies the code...)
>> I'm not clear about what you mean by introducing a tie-in. Can you
>> clarify that?
> Making vfio-ap depend on APXA.

I don't think vfio-ap should be dependent upon APXA for the reasons I 
stated above.

>
