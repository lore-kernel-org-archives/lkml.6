Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CAD9C282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 469BB20844
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbfBHQOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 11:14:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38674 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727127AbfBHQOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 11:14:49 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x18GDlNB056547
        for <linux-kernel@vger.kernel.org>; Fri, 8 Feb 2019 11:14:48 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qhcqpsa20-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 11:14:47 -0500
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <stefanb@linux.ibm.com>;
        Fri, 8 Feb 2019 16:14:46 -0000
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 8 Feb 2019 16:14:43 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x18GEgNw21495954
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Feb 2019 16:14:42 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A330B2067;
        Fri,  8 Feb 2019 16:14:42 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 835B0B2066;
        Fri,  8 Feb 2019 16:14:42 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  8 Feb 2019 16:14:42 +0000 (GMT)
Subject: Re: [PATCH v2 0/2] tpm: Unify send() callbacks
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Peter Huewe <PeterHuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Alexander Steffen <Alexander.Steffen@infineon.com>
References: <20190208160328.18715-1-jarkko.sakkinen@linux.intel.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Date:   Fri, 8 Feb 2019 11:14:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20190208160328.18715-1-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-MW
X-TM-AS-GCONF: 00
x-cbid: 19020816-0040-0000-0000-000004BEC6E9
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010559; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000279; SDB=6.01158142; UDB=6.00604226; IPR=6.00938675;
 MB=3.00025495; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-08 16:14:45
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020816-0041-0000-0000-000008C9E34A
Message-Id: <b0469b08-18fd-847b-0f0b-6223c732b346@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-08_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902080113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/19 11:03 AM, Jarkko Sakkinen wrote:
> A portion of send() callbacks have returned length, in many cases just
> returning back what was given as an argument, and tpm_crb has returned 0 on
> success. This patch set fixes and unifies the behaviour.
>
> v2:
> The drivers tpm_nsc and tpm_infineon were forgotten. For this version I
> checked both with find and command and from Kconfig that everything that is
> supposed to be a driver directly interfacing with the TPM core, is included
> (e.g. discluding tpm_tis_spi).


:-( st33zp24/i2c.c ends up calling i2c_master_send, which returns number 
of bytes written:

https://elixir.bootlin.com/linux/latest/source/include/linux/i2c.h#L108


>
> Jarkko Sakkinen (2):
>    tpm: Unify the send callback behaviour
>    tpm/tpm_i2c_atmel: Return -E2BIG when the transfer is incomplete
>
>   drivers/char/tpm/st33zp24/st33zp24.c |  2 +-
>   drivers/char/tpm/tpm_atmel.c         |  2 +-
>   drivers/char/tpm/tpm_i2c_atmel.c     | 10 +++++++++-
>   drivers/char/tpm/tpm_i2c_infineon.c  |  2 +-
>   drivers/char/tpm/tpm_i2c_nuvoton.c   |  2 +-
>   drivers/char/tpm/tpm_ibmvtpm.c       |  2 +-
>   drivers/char/tpm/tpm_infineon.c      |  2 +-
>   drivers/char/tpm/tpm_nsc.c           |  2 +-
>   drivers/char/tpm/tpm_vtpm_proxy.c    |  3 +--
>   drivers/char/tpm/xen-tpmfront.c      |  2 +-
>   10 files changed, 18 insertions(+), 11 deletions(-)
>

