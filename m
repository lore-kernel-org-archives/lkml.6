Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11756C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 12:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D127C20831
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 12:14:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D127C20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbeLIMOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 07:14:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37952 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726158AbeLIMOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 07:14:23 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wB9CEJZT124133
        for <linux-kernel@vger.kernel.org>; Sun, 9 Dec 2018 07:14:20 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p8v97td02-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 07:14:20 -0500
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <nayna@linux.ibm.com>;
        Sun, 9 Dec 2018 12:14:19 -0000
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 9 Dec 2018 12:14:16 -0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wB9CEF8M24051868
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 9 Dec 2018 12:14:15 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3AAE4136053;
        Sun,  9 Dec 2018 12:14:15 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B12FA13604F;
        Sun,  9 Dec 2018 12:14:11 +0000 (GMT)
Received: from [9.85.68.82] (unknown [9.85.68.82])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Sun,  9 Dec 2018 12:14:11 +0000 (GMT)
Subject: Re: [PATCH v6 2/7] tpm: add _head suffix to tcg_efi_specid_event and
 tcg_pcr_event2
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        jarkko.sakkinen@linux.intel.com, david.safford@ge.com,
        monty.wiseman@ge.com
Cc:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
References: <20181204082138.24600-1-roberto.sassu@huawei.com>
 <20181204082138.24600-3-roberto.sassu@huawei.com>
From:   Nayna Jain <nayna@linux.ibm.com>
Date:   Sun, 9 Dec 2018 17:40:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20181204082138.24600-3-roberto.sassu@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18120912-8235-0000-0000-00000E35FAF8
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010199; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01129234; UDB=6.00586685; IPR=6.00909365;
 MB=3.00024611; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-09 12:14:18
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120912-8236-0000-0000-000043A47991
Message-Id: <edb2a88c-3f28-59fe-ebc8-4358362c4c3d@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-09_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=635 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812090117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/04/2018 01:51 PM, Roberto Sassu wrote:
> TCG defines two structures, TCG_EfiSpecIDEventStruct and TCG_PCR_EVENT2,
> which contain variable-sized arrays in the middle of the definition.
>
> Since these structures are not suitable for type casting, this patch
> removes structure members after the variable-sized arrays and adds the
> _head suffix to the structure name, to indicate that the renamed structures
> do not contain all fields defined by TCG.
>
> Lastly, given that variable-sized arrays are now in the last position, and
> given that the size of the arrays cannot be determined in advance, this
> patch also sets the size of those arrays to zero and removes the definition
> of TPM2_ACTIVE_PCR_BANKS.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>


Tested-by: Nayna Jain <nayna@linux.ibm.com>

Thanks & Regards,
     - Nayna


