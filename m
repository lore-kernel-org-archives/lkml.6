Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2952C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 19:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AD4420855
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 19:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbfBHT1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 14:27:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52128 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727144AbfBHT1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 14:27:40 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x18JIoH3088861
        for <linux-kernel@vger.kernel.org>; Fri, 8 Feb 2019 14:27:38 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qhd38fsup-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 14:27:37 -0500
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <stefanb@linux.ibm.com>;
        Fri, 8 Feb 2019 19:27:37 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 8 Feb 2019 19:27:32 -0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x18JRV9Q23396414
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Feb 2019 19:27:31 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C5630AC05B;
        Fri,  8 Feb 2019 19:27:31 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A6058AC05F;
        Fri,  8 Feb 2019 19:27:31 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  8 Feb 2019 19:27:31 +0000 (GMT)
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_v4_1/2=5d_tpm=3a_Unify_the_send_callback_b?=
 =?UTF-8?Q?ehaviour=c3=a4?=
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Peter Huewe <PeterHuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        stable@vger.kernel.org
References: <20190208180857.12330-1-jarkko.sakkinen@linux.intel.com>
 <20190208180857.12330-2-jarkko.sakkinen@linux.intel.com>
 <4072b2b6-0f95-be50-0772-7e2869c2c24e@linux.ibm.com>
 <20190208190057.GA3439@linux.intel.com>
 <20190208191710.GA30645@linux.intel.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Date:   Fri, 8 Feb 2019 14:27:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20190208191710.GA30645@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-MW
X-TM-AS-GCONF: 00
x-cbid: 19020819-0068-0000-0000-0000039125DA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010560; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000279; SDB=6.01158206; UDB=6.00604308; IPR=6.00938739;
 MB=3.00025496; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-08 19:27:35
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020819-0069-0000-0000-0000476FE0F4
Message-Id: <6a86e3e8-e311-7a0f-585d-3f0435b0143a@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-08_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=778 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902080132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/19 2:17 PM, Jarkko Sakkinen wrote:
>
>   */
> if (rc > 0) {
> 	dev_warn(&chip->dev,
> 		 "%s: send(): invalid value %d\n", __func__, rc);
> 	rc = 0;
> }
>
> Should be fairly safe play now.

Unfortuantely it isn't. You seemed to have lost the 
EXPORT_SYMBOL_GPL(tpm_chip_start/stop) and the tpm_chip_start/stop 
around the tpm2_shutdown()...


>
> /Jarkko
>

