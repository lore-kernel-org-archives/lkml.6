Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B931DC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CCC820844
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbfBEMw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 07:52:26 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60824 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727097AbfBEMw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 07:52:26 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x15CjUSX084992
        for <linux-kernel@vger.kernel.org>; Tue, 5 Feb 2019 07:52:24 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qfapsrg8f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 07:52:24 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <mimu@linux.ibm.com>;
        Tue, 5 Feb 2019 12:52:22 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 5 Feb 2019 12:52:20 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x15CqIis7537012
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Feb 2019 12:52:18 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38AD9AE061;
        Tue,  5 Feb 2019 12:52:18 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C1AEBAE053;
        Tue,  5 Feb 2019 12:52:17 +0000 (GMT)
Received: from [9.152.224.122] (unknown [9.152.224.122])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  5 Feb 2019 12:52:17 +0000 (GMT)
Reply-To: mimu@linux.ibm.com
Subject: Re: [PATCH v7 13/15] KVM: s390: add gib_alert_irq_handler()
To:     pmorel@linux.ibm.com, KVM Mailing List <kvm@vger.kernel.org>
Cc:     Linux-S390 Mailing List <linux-s390@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>
References: <20190131085247.13826-1-mimu@linux.ibm.com>
 <20190131085247.13826-14-mimu@linux.ibm.com>
 <50f05038-f414-50f5-dbe7-e2bcca0b8433@linux.ibm.com>
From:   Michael Mueller <mimu@linux.ibm.com>
Organization: IBM
Date:   Tue, 5 Feb 2019 13:52:17 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <50f05038-f414-50f5-dbe7-e2bcca0b8433@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19020512-0008-0000-0000-000002BC4C48
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020512-0009-0000-0000-000022284E57
Message-Id: <3599eeec-eec1-6326-ba34-5e0f64c45934@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-05_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902050101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05.02.19 12:38, Pierre Morel wrote:
> On 31/01/2019 09:52, Michael Mueller wrote:
>> The patch implements a handler for GIB alert interruptions
>> on the host. Its task is to alert guests that interrupts are
>> pending for them.
>>
>> A GIB alert interrupt statistic counter is added as well:
>>
>> $ cat /proc/interrupts
>>            CPU0       CPU1
>>    ...
>>    GAL:      23         37   [I/O] GIB Alert
>>    ...
>>
>> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
>> Acked-by: Halil Pasic <pasic@linux.ibm.com>
>> ---
> 
> The only thing that bother me is the short timer's expiration value.
> But it is optimization and it is working for me so.
> 
> Reviewed-by: Pierre Morel<pmorel@linux.ibm.com>


Thanks, Pierre.

For completion I want to add that one sees roughly 1 timer
restart per vcpu that gets kicked in my test scenario with
12 AP IRQ guests. The guests have 4 x 1, 4 x 4 and  4 x 8 vcpus
backed by 8 IFLs. Furthermore the 12 guests share 4 CEX5C cards
each configured with 3 AP queues. On the guest runs a single
threaded AP driver that performs RSA decryptions with CRT private
keys with a short 512 bit length to get many ops/s. That
run has no additional cpu load.

./run_ap_load.sh 12
[1] 12:53:09 [SUCCESS] root@ap04
[2] 12:53:09 [SUCCESS] root@ap08
[3] 12:53:10 [SUCCESS] root@ap02
[4] 12:53:10 [SUCCESS] root@ap03
[5] 12:53:10 [SUCCESS] root@ap01
[6] 12:53:10 [SUCCESS] root@ap12
[7] 12:53:10 [SUCCESS] root@ap06
[8] 12:53:10 [SUCCESS] root@ap05
[9] 12:53:10 [SUCCESS] root@ap07
[10] 12:53:10 [SUCCESS] root@ap10
[11] 12:53:10 [SUCCESS] root@ap09
[12] 12:53:10 [SUCCESS] root@ap11
KVM guests:          12
ica_perf threads:    1
stress cpu threads:  0
stress io threads:   0
expected  AP IRQs:   600048
observed  AP IRQs:   600048
observed VAI IRQs:   1311
observed GAL IRQs:   575505


__gal_stats_ipm_dirty = 613762
__gal_stats_timer_active = 0
__gal_stats_timer_no_restart = 600048
__gal_stats_timer_not_active = 600048
__gal_stats_timer_restart = 613762
__gal_stats_vcpus_kicked = 599688


The counters are placed as follows:

@@ -2998,6 +2999,7 @@ static void __airqs_kick_single_vcpu(struct kvm 
*kvm, u8 deliverable_mask)
                         if (test_and_set_bit(vcpu_id, gi->kicked_mask))
                                 return;
                         kvm_s390_vcpu_wakeup(vcpu);
+                       __gal_stats_inc(kvm, vcpus_kicked);
                         return;
                 }
         }
@@ -3013,11 +3015,14 @@ static enum hrtimer_restart 
gisa_vcpu_kicker(struct hrtimer *timer)

         pending_mask = gisa_get_ipm_or_restore_iam(gi);
         if (pending_mask) {
+               __gal_stats_inc(kvm, ipm_dirty);
                 __airqs_kick_single_vcpu(kvm, pending_mask);
                 hrtimer_forward_now(timer, ns_to_ktime(gi->expires));
+               __gal_stats_inc(kvm, timer_restart);
                 return HRTIMER_RESTART;
         };

+       __gal_stats_inc(kvm, timer_no_restart);
         return HRTIMER_NORESTART;
  }


Cheers,
Michael

