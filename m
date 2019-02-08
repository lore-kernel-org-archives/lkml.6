Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0F2C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5555C2177B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfBHMFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:05:33 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38802 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726456AbfBHMFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 07:05:33 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x18C1IIB110653
        for <linux-kernel@vger.kernel.org>; Fri, 8 Feb 2019 07:05:31 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qh7fs5j6f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 07:05:31 -0500
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <stefanb@linux.ibm.com>;
        Fri, 8 Feb 2019 12:05:30 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 8 Feb 2019 12:05:28 -0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x18C5RVX10879124
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Feb 2019 12:05:27 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F148712405A;
        Fri,  8 Feb 2019 12:05:26 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E8BCC124053;
        Fri,  8 Feb 2019 12:05:26 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  8 Feb 2019 12:05:26 +0000 (GMT)
Subject: Re: [PATCH v11 00/16] Remove nested TPM operations
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Alexander Steffen <Alexander.Steffen@infineon.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Peter Huewe <PeterHuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>
References: <20190205224723.19671-1-jarkko.sakkinen@linux.intel.com>
 <20190206120634.GA4680@linux.intel.com>
 <3d6fdcc1-8221-2137-fc82-596377cc2fdc@infineon.com>
 <20190207212912.GD23906@linux.intel.com>
 <0af40351-91d5-d0a7-2965-0a9c6505af79@linux.ibm.com>
 <20190208003314.GB7202@linux.intel.com>
 <1fbd29ad-1005-8450-4c39-00974468183b@linux.ibm.com>
 <20190208111442.GA11755@linux.intel.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Date:   Fri, 8 Feb 2019 07:05:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20190208111442.GA11755@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-MW
X-TM-AS-GCONF: 00
x-cbid: 19020812-0064-0000-0000-000003A50D14
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010558; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000279; SDB=6.01158059; UDB=6.00604220; IPR=6.00938591;
 MB=3.00025493; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-08 12:05:30
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020812-0065-0000-0000-00003C56CCC5
Message-Id: <06473b24-7c59-9405-bbe0-8d30b3450391@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-08_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=797 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902080087
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/19 6:14 AM, Jarkko Sakkinen wrote:
> On Thu, Feb 07, 2019 at 08:51:15PM -0500, Stefan Berger wrote:
>>>> +    rc = 0;
>>>>        if (chip->flags & TPM_CHIP_FLAG_IRQ)
>>>>            goto out_recv;
>>> What why?
>>
>> This fix seems to only be necessary when bisecting. You may want to apply
>> it!
> I don't want to apply it because I don't understand why it would
> be needed. Can you give a short explanation?


See my comment on [PATCH v11 08/16]. It needs to be added in that patch 
since otherwise rc holds a non-zero value on function exit, which is 
wrong at that point.


>
> /Jarkko
>

