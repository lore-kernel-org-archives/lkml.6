Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC3AC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B23B20675
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730772AbfACMQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 07:16:37 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35158 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729618AbfACMQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 07:16:37 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x03CACxj019671
        for <linux-kernel@vger.kernel.org>; Thu, 3 Jan 2019 07:16:36 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2psj368f5k-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 07:16:36 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Thu, 3 Jan 2019 12:16:34 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 3 Jan 2019 12:16:30 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x03CGTUU46333962
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Jan 2019 12:16:29 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7FCD452050;
        Thu,  3 Jan 2019 12:16:29 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.224.202])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3733A52052;
        Thu,  3 Jan 2019 12:16:29 +0000 (GMT)
Date:   Thu, 3 Jan 2019 13:16:28 +0100
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        mst@redhat.com, cohuck@redhat.com, borntraeger@de.ibm.com,
        pbonzini@redhat.com, dgilbert@redhat.com
Subject: Re: [PATCH v1 1/2] virtio-balloon: tweak config_changed
 implementation
In-Reply-To: <1546493462-32244-2-git-send-email-wei.w.wang@intel.com>
References: <1546493462-32244-1-git-send-email-wei.w.wang@intel.com>
        <1546493462-32244-2-git-send-email-wei.w.wang@intel.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19010312-0008-0000-0000-000002A975BE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010312-0009-0000-0000-000022158D7E
Message-Id: <20190103131628.3674a50d@oc2783563651>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-03_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901030109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  3 Jan 2019 13:31:01 +0800
Wei Wang <wei.w.wang@intel.com> wrote:

> virtio-ccw has deadlock issues with reading config registers inside the
> interrupt context

I would say something like 'virtio-ccw does not support using
virtio_config_ops from an atomic context' as the limitation is not
limited to read config (aka. get()). But I'm fine with your formulation
as well.

> , so we tweak the virtballoon_changed implementation
> by moving the config read operations into the related workqueue contexts.
> 
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>


Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

[..]

