Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA82EC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 930FC20854
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:04:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 930FC20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932998AbeGIJED (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 05:04:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51818 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754403AbeGIJC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 05:02:57 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w698xKdT012001
        for <linux-kernel@vger.kernel.org>; Mon, 9 Jul 2018 05:02:56 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k44jy8hre-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 05:02:56 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Mon, 9 Jul 2018 10:02:54 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 9 Jul 2018 10:02:51 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6992nEF39583962
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Jul 2018 09:02:49 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 957CF42049;
        Mon,  9 Jul 2018 12:03:12 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C56FD42047;
        Mon,  9 Jul 2018 12:03:11 +0100 (BST)
Received: from [9.152.224.92] (unknown [9.152.224.92])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  9 Jul 2018 12:03:11 +0100 (BST)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v6 21/21] s390: doc: detailed specifications for AP
 virtualization
To:     Harald Freudenberger <freude@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.vnet.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com,
        pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        Tony Krowiak <akrowiak@linux.ibm.com>
References: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1530306683-7270-22-git-send-email-akrowiak@linux.vnet.ibm.com>
 <f3bba295-f854-fc9e-c4eb-47846178df12@linux.ibm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Mon, 9 Jul 2018 11:02:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <f3bba295-f854-fc9e-c4eb-47846178df12@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18070909-0020-0000-0000-000002A47DEC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070909-0021-0000-0000-000020F0B5E0
Message-Id: <9e84e47e-1022-0b87-7567-24b562086abb@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-09_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807090107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/2018 10:10, Harald Freudenberger wrote:
> On 29.06.2018 23:11, Tony Krowiak wrote:
...snip...
> +The process for reserving an AP queue for use by a KVM guest is:
> +
> +* The vfio-ap driver during its initialization will perform the following:
> +  * Create the 'vfio_ap' root device - /sys/devices/vfio_ap
> +  * Create the 'matrix' device in the 'vfio_ap' root
> +  * Register the matrix device with the device core
> +* Register with the ap_bus for AP queue devices of type 10 devices (CEX4 and
> +  newer) and to provide the vfio_ap driver's probe and remove callback
> +  interfaces. The reason why older devices are not supported is because there
> +  are no systems available on which to test.
> This is simple not true. The reason is this is a design decision. The older
> cards are simple somewhat more complicated and we don't want to
> add even more complexity to the ap virtualization implementation.
> We also said several times that APXA is a requirement not a feature.

I understand your point of view as maintainer of the cryptographic driver
but I do not see the point concerning virtualization.
The SIE allows to work fine without APXA.
Is there any reason to add a restrictions here?

If there is a good reason then  the problem should be treated when 
detecting the presence
of APXA. AFAIR we do not do this.

>> +* The admin unbinds queue cc.qqqq from the cex4queue device driver. This results
>> +  in the ap_bus calling the the device driver's remove interface which
>> +  unbinds the cc.qqqq queue device from the driver.
>> +* The admin binds the cc.qqqq queue to the vfio_ap device driver. This results
>> +  in the ap_bus calling the device vfio_ap driver's probe interface to bind
>> +  queue cc.qqqq to the driver. The vfio_ap device driver will store the APQN for
>> +  the queue in the matrix device
...snip...
>> +
>> +Guest2
>> +------
>> +CARD.DOMAIN TYPE  MODE
>> +------------------------------
>> +05          CEX5A Accelerator
>> +05.0047     CEX5A Accelerator
>> +05.00ff     CEX5A Accelerator
> Btw: this is an excellent example about thinking beyond the current design.
> We don't want to dedicate Accelerators to guests. Accelerators should be
> shared, CCA and EP11 Coprocessors should be dedicated. So maybe
> change the example to use EP11 and CCA Coprocessors .... and think
> about how shared Accelerators could be handled.

Shouldn't this problematic be let to the administrator?
Using the SIE for virtualization is independent of the kind of
card.
Why, again, see above, should we take the type of card into account
at this level?

>> +
>> +These are the steps:
...snip...

>> +   echo 1 > remove
>> +
>> +   This will remove all of the mdev matrix device's sysfs structures. To
>> +   recreate and reconfigure the mdev matrix device, all of the steps starting
>> +   with step 4 will have to be performed again.
>> +
>> +   It is not necessary to remove an mdev matrix device, but one may want to
>> +   remove it if no guest will use it during the lifetime of the linux host. If
>> +   the mdev matrix device is removed, one may want to unbind the AP queues the
>> +   guest was using from the vfio_ap device driver and bind them back to the
>> +   default driver. Alternatively, the AP queues can be configured for another
> Please note: you can't just 'bind them back to the default driver'. You need
> to unbind and then call dev_reprobe() which triggers the default way of
> assigning a driver to a device and give the ap bus a chance to handle this.

Are you saying that the administrator can not unbind a AP device
and bind it to another AP driver?
I am surprised. can you explain?

Best regards,

Pierre


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

