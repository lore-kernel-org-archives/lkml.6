Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752599AbeEPL3Y (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 07:29:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51458 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752101AbeEPL3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 07:29:23 -0400
Subject: Re: [PATCH v5 04/13] s390: vfio-ap: base implementation of VFIO AP
 device driver
To: pmorel@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com,
        berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
References: <1525705912-12815-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1525705912-12815-5-git-send-email-akrowiak@linux.vnet.ibm.com>
 <9ee148c9-1d3b-860a-32d8-8a1584628233@linux.ibm.com>
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Wed, 16 May 2018 07:29:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <9ee148c9-1d3b-860a-32d8-8a1584628233@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18051611-0020-0000-0000-00000DF18139
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009034; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01033102; UDB=6.00528215; IPR=6.00812233;
 MB=3.00021143; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-16 11:29:21
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051611-0021-0000-0000-00006166B947
Message-Id: <25e6c874-231f-b50b-0389-d76bf44bb40f@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-16_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805160117
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/16/2018 04:21 AM, Pierre Morel wrote:
> On 07/05/2018 17:11, Tony Krowiak wrote:
>> Introduces a new AP device driver. This device driver
>> is built on the VFIO mediated device framework. The framework
>> provides sysfs interfaces that facilitate passthrough
>> access by guests to devices installed on the linux host.
> ...snip...
>> +static int vfio_ap_queue_dev_probe(struct ap_device *apdev)
>> +{
>
> You should take care of the ap devices when they are added or removed
> from the matrix.
> I suggest you add a remove callback to avoid unbinding a queue while
> it is assigned to a guest.

That makes sense, will do.

>
>
>> +    return 0;
>> +}
>> +
>> +static void vfio_ap_matrix_dev_release(struct device *dev)
>> +{
>> +    struct ap_matrix *ap_matrix = dev_get_drvdata(dev);
>> +
>> +    kfree(ap_matrix);
>> +}
> ...snip...
>
