Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA2FC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64AC32098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:45:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64AC32098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732462AbeIXWsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 18:48:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33114 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732097AbeIXWsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 18:48:52 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8OGcwUt095918
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 12:45:50 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mq20j55dy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 12:45:50 -0400
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Mon, 24 Sep 2018 10:45:49 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
        by e36.co.us.ibm.com (192.168.1.136) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 24 Sep 2018 10:45:45 -0600
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8OGjg1w50528336
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Sep 2018 09:45:42 -0700
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F401BE04F;
        Mon, 24 Sep 2018 10:45:42 -0600 (MDT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 176ECBE051;
        Mon, 24 Sep 2018 10:45:38 -0600 (MDT)
Received: from oc8043147753.ibm.com (unknown [9.85.130.123])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 24 Sep 2018 10:45:38 -0600 (MDT)
Subject: Re: [PATCH v10 00/26] guest dedicated crypto adapters
To:     Cornelia Huck <cohuck@redhat.com>,
        Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com,
        pbonzini@redhat.com, alex.williamson@redhat.com,
        pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com,
        mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com,
        thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        frankja@linux.ibm.com
References: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180924134931.6c67a3d2.cohuck@redhat.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Mon, 24 Sep 2018 12:45:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180924134931.6c67a3d2.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18092416-0020-0000-0000-00000E6BDC1F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009763; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01093031; UDB=6.00564900; IPR=6.00873069;
 MB=3.00023484; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-24 16:45:47
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092416-0021-0000-0000-0000632478B0
Message-Id: <b44f1714-dc01-441c-67c3-1700c468b69f@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-24_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809240163
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/24/2018 07:49 AM, Cornelia Huck wrote:
> On Wed, 12 Sep 2018 15:42:50 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
> 
>> Abstract:
>> ========
>>
>> On s390, we have cryptographic coprocessor cards, which are modeled on
>> Linux as devices on the AP bus. Each card can be partitioned into domains
>> which can be thought of as a set of hardware registers for processing
>> crypto commands. Crypto commands are sent to a specific domain within a
>> card is via a queue which is identified as a (card,domain) tuple. We model
>> this something like the following (assuming we have access to cards 3 and
>> 4 and domains 1 and 2):
>>
>> AP -> card3 -> queue (3,1)
>>              -> queue (3,2)
>>     -> card4 -> queue (4,1)
>>              -> queue (4,2)
>>
>> If we want to virtualize this, we can use a feature provided by the
>> hardware. We basically attach a satellite control block to our main
>> hardware virtualization control block and the hardware takes care of
>> most of the rest.
>>
>> For this control block, we don't specify explicit tuples, but a list of
>> cards and a list of domains. The guest will get access to the cross
>> product.
>>
>> Because of this, we need to take care that the lists provided to
>> different guests don't overlap; i.e., we need to enforce sane
>> configurations. Otherwise, one guest may get access to things like
>> secret keys for another guest.
>>
>> The idea of this patch set is to introduce a new device, the matrix
>> device. This matrix device hangs off a different root and acts as the
>> parent node for mdev devices.
>>
>> If you now want to give the tuples (4,1) and (4,2), you need to do the
>> following:
>>
>> - Make sure the queues (4,1) and (4,2) belong to vfio_ap (see patches
>>    #5 and #6)
>> - Create the mediated device.
>> - Assign card 4 and domains 1 and 2 to the mediated device
>> - Optionally activate the mediated device.
>>
>> QEMU will now simply consume the mediated device and things should work.
>>
>> For a complete description of the architecture and concepts underlying
>> the design, see the Documentation/s390/vfio-ap.txt file included with this
>> patch set.
> 
> I did not spot anything major, and if v11 addresses the issues raised
> by various reviewers I don't see why it should not be merged (interface
> looks sane). I skipped looking at the vsie stuff, though ;)

I think David has that covered.

> 

