Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F555C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 14:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 138542081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 14:45:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 138542081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbeKBXwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 19:52:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42858 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726701AbeKBXwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 19:52:33 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA2EcxGR054253
        for <linux-kernel@vger.kernel.org>; Fri, 2 Nov 2018 10:45:12 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ngqfwbgvu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 10:45:12 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Fri, 2 Nov 2018 14:45:11 -0000
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 2 Nov 2018 14:45:08 -0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA2Ej3US14483514
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 2 Nov 2018 14:45:04 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9305C6059;
        Fri,  2 Nov 2018 14:45:03 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2EE95C6057;
        Fri,  2 Nov 2018 14:45:02 +0000 (GMT)
Received: from [9.80.230.50] (unknown [9.80.230.50])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  2 Nov 2018 14:45:01 +0000 (GMT)
Subject: Re: [PATCH v1 1/7] vfio: ap: Add AP Queue Interruption Control
 facility
To:     Pierre Morel <pmorel@linux.ibm.com>, borntraeger@de.ibm.com
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com,
        david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
References: <1541009577-29656-1-git-send-email-pmorel@linux.ibm.com>
 <1541009577-29656-2-git-send-email-pmorel@linux.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Fri, 2 Nov 2018 10:45:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1541009577-29656-2-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18110214-0036-0000-0000-00000A558910
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009972; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01111612; UDB=6.00576084; IPR=6.00891703;
 MB=3.00024005; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-02 14:45:10
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110214-0037-0000-0000-000049812DAB
Message-Id: <5104b04e-5b2c-b8d0-eed5-c83c71cbd5e1@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-02_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811020134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/18 2:12 PM, Pierre Morel wrote:
> AP Queue Interruption Control (AQIC) facility gives
> the guest the possibility to control interruption for
> the Cryptographic Adjunct Processor queues.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>   arch/s390/tools/gen_facilities.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/s390/tools/gen_facilities.c b/arch/s390/tools/gen_facilities.c
> index fd788e0f2e5b..18d317da02f5 100644
> --- a/arch/s390/tools/gen_facilities.c
> +++ b/arch/s390/tools/gen_facilities.c
> @@ -108,6 +108,7 @@ static struct facility_def facility_defs[] = {
>   		.bits = (int[]){
>   			12, /* AP Query Configuration Information */
>   			15, /* AP Facilities Test */
> +			65, /* AP Queue Interruption Control */
>   			156, /* etoken facility */
>   			-1  /* END */
>   		}

Reviewed-by: Tony Krowiak <akrowiak@linux.ibm.com>

> 

