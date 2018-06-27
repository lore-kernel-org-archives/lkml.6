Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBD2C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 13:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 287E620877
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 13:53:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 287E620877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754530AbeF0Nxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 09:53:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35542 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753229AbeF0Nxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 09:53:34 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5RDoCUV064809
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 09:53:33 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jv9ube1tg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 09:53:33 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.vnet.ibm.com>;
        Wed, 27 Jun 2018 07:53:32 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 27 Jun 2018 07:53:29 -0600
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5RDrSmd4325762
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Jun 2018 06:53:28 -0700
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 62E2B136068;
        Wed, 27 Jun 2018 07:53:28 -0600 (MDT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D512136065;
        Wed, 27 Jun 2018 07:53:27 -0600 (MDT)
Received: from [9.41.102.69] (unknown [9.41.102.69])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 27 Jun 2018 07:53:27 -0600 (MDT)
Subject: Re: [PATCH v10 0/7] i2c: Add FSI-attached I2C master algorithm
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        benh@kernel.crashing.org, joel@jms.id.au, mark.rutland@arm.com,
        gregkh@linuxfoundation.org, rdunlap@infradead.org,
        andy.shevchenko@gmail.com, peda@axentia.se
References: <1528918579-27602-1-git-send-email-eajames@linux.vnet.ibm.com>
 <20180626023940.zn4zin6idrgcf2zx@ninjato>
From:   Eddie James <eajames@linux.vnet.ibm.com>
Date:   Wed, 27 Jun 2018 08:53:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180626023940.zn4zin6idrgcf2zx@ninjato>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18062713-0016-0000-0000-00000900172B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009263; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01053083; UDB=6.00539917; IPR=6.00831007;
 MB=3.00021878; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-27 13:53:32
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062713-0017-0000-0000-00003F6DC24D
Message-Id: <f7d0da3d-9bbd-2417-00eb-56b3a40025e2@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-27_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=649 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806270152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/25/2018 09:39 PM, Wolfram Sang wrote:
> On Wed, Jun 13, 2018 at 02:36:12PM -0500, Eddie James wrote:
>> This series adds an algorithm for an I2C master physically located on an FSI
>> slave device. The I2C master has multiple ports, each of which may be connected
>> to an I2C slave. Access to the I2C master registers is achieved over FSI bus.
>>
>> Due to the multi-port nature of the I2C master, the driver instantiates a new
>> I2C adapter for each port connected to a slave. The connected ports should be
>> defined in the device tree under the I2C master device.
> Thanks for this series and your patience.
>
> While I can see why it also helps reviewing to send it as a series of
> multiple patches, I consider applying the driver itself as just one
> hunk. I am not decided on this yet.
>
> I have a few comments, especially about recovery. I replied to the
> relevant patches with more detail.
>
> Also, are you (or someone from your company) willing to maintain the
> driver? Then, an addition to MAINTAINERS would be much appreciated.

Thanks for the review Wolfram! I addressed your comments about recovery, 
please let me know what you think. I will fix the email for the dt patch 
and make an addition to MAINTAINERS for the next version.

Thanks,
Eddie

>
> Thanks,
>
>     Wolfram
>

