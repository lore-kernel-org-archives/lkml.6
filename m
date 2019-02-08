Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BB2C282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 08:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D82F21917
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 08:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfBHIiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 03:38:16 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40378 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727328AbfBHIiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 03:38:16 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x188NpTW067230
        for <linux-kernel@vger.kernel.org>; Fri, 8 Feb 2019 03:38:15 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qh3ax7hj6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 03:38:15 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Fri, 8 Feb 2019 08:38:13 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 8 Feb 2019 08:38:11 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x188cApL59310258
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Feb 2019 08:38:10 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B0085204E;
        Fri,  8 Feb 2019 08:38:10 +0000 (GMT)
Received: from osiris (unknown [9.152.212.95])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id D8F495204F;
        Fri,  8 Feb 2019 08:38:09 +0000 (GMT)
Date:   Fri, 8 Feb 2019 09:38:08 +0100
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Allen <allen.lkml@gmail.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use ARRAY_SIZE instead of dividing sizeof array with
 sizeof an element.
References: <20190208024110.8021-1-allen.lkml@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20190208024110.8021-1-allen.lkml@gmail.com>
X-TM-AS-GCONF: 00
x-cbid: 19020808-0020-0000-0000-000003145409
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020808-0021-0000-0000-0000216561A3
Message-Id: <20190208083808.GB2803@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-08_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=757 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902080062
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 08:11:10AM +0530, Allen wrote:
> From: Allen Pais <allen.lkml@gmail.com>
> 
> This issue was detected with the help of Coccinelle.
> 
> Signed-off-by: Allen Pais <allen.lkml@gmail.com>
> ---
>  arch/s390/tools/gen_opcode_table.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/tools/gen_opcode_table.c b/arch/s390/tools/gen_opcode_table.c
> index a1bc02b29c81..468b70c85f62 100644
> --- a/arch/s390/tools/gen_opcode_table.c
> +++ b/arch/s390/tools/gen_opcode_table.c
> @@ -138,7 +138,7 @@ static struct insn_type *insn_format_to_type(char *format)
>  	strcpy(tmp, format);
>  	base_format = tmp;
>  	base_format = strsep(&base_format, "_");
> -	for (i = 0; i < sizeof(insn_type_table) / sizeof(insn_type_table[0]); i++) {
> +	for (i = 0; i < ARRAY_SIZE(insn_type_table); i++) {

This does not compile.

