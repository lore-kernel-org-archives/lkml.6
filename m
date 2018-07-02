Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A462C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 23:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B24BC2087A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 23:10:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B24BC2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753415AbeGBXKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 19:10:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49276 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752985AbeGBXKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 19:10:45 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w62N9J0x093815
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 19:10:45 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jyr5eurbv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 19:10:45 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Tue, 3 Jul 2018 00:10:42 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 3 Jul 2018 00:10:37 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w62NAaEe40632378
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Jul 2018 23:10:36 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 881EAA4055;
        Tue,  3 Jul 2018 00:10:18 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D509A4040;
        Tue,  3 Jul 2018 00:10:17 +0100 (BST)
Received: from oc3836556865.ibm.com (unknown [9.145.148.122])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  3 Jul 2018 00:10:17 +0100 (BST)
Subject: Re: [PATCH v6 21/21] s390: doc: detailed specifications for AP
 virtualization
To:     Tony Krowiak <akrowiak@linux.vnet.ibm.com>,
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
From:   Halil Pasic <pasic@linux.ibm.com>
Date:   Tue, 3 Jul 2018 01:10:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1530306683-7270-22-git-send-email-akrowiak@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18070223-0012-0000-0000-00000286059D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070223-0013-0000-0000-000020B77EC0
Message-Id: <753c5e17-c241-580d-6e3a-a3c3159d44a8@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-02_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807020257
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/29/2018 11:11 PM, Tony Krowiak wrote:
> This patch provides documentation describing the AP architecture and
> design concepts behind the virtualization of AP devices. It also
> includes an example of how to configure AP devices for exclusive
> use of KVM guests.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>

I don't like the design of external interfaces except for:
* cpu model features, and
* reset handling.

In particular:

1) The architecture is such that authorizing access (via APM, AQM and ADM)
to an AP queue that is currently not configured (e.g. the card not physically
plugged, or just configured off). That seems to be a perfectly normal use
case.

Your assign operations however enforce that the resource is bound to your
driver, and thus the existence of the resource in the host.

It is clear: we need to avoid passing trough resources to guests that are not
dedicated for this purpose (e.g. a queue utilized by zcrypt). But IMHO
we need a different mechanism.

2) I see no benefit in deferring the exclusivity check to vfio_ap_mdev_open().
The downside is however pretty obvious: management software is notified about
a 'bad configuration' only at an attempted guest start-up. And your current QEMU
patches are not very helpful in conveying this piece of information.

I've talked with Boris, and AFAIR he said this is not acceptable to him (@Boris
can you confirm).

3) We indicate the reason for failure due to a configuration problem (exclusivity
or resource allocation) via pr_err() that is  via kernel messages. I don't think
this is very tooling/management software friendly, and I hope we don't expect admins
to work with the sysfs interface long term. I mean the effects of the admin actions
are not very persistent. Thus if the interface is a painful one, we are talking
about potentially frequent pain.

4) If I were to act out the role of the administrator, I would prefer to think of
specifying or changing the access controls of a guest in respect to AP (that is
setting the AP matrix) as a single atomic operation -- which either succeeds or fails.

The operation should succeed for any valid configuration, and fail for any invalid
on.

The current piecemeal approach seems even less fitting if we consider changing the
access controls of a running guest. AFAIK changing access controls for a running
guest is possible, and I don't see a reason why should we artificially prohibit this.

I think the current sysfs interface for manipulating the matrix is good for
manual playing around, but I would prefer having an interface that is better
suited for programs (e.g. ioctl).

Regards,
Halil

