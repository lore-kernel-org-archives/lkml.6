Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA51C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F0FC20666
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:25:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F0FC20666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbeJBDFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 23:05:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59552 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726027AbeJBDFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 23:05:18 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w91KNUF2080441
        for <linux-kernel@vger.kernel.org>; Mon, 1 Oct 2018 16:25:46 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mus42unsv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 16:25:46 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Mon, 1 Oct 2018 21:25:44 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 1 Oct 2018 21:25:41 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w91KPej762652500
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 1 Oct 2018 20:25:40 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5211D4C04A;
        Mon,  1 Oct 2018 23:25:21 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D97774C044;
        Mon,  1 Oct 2018 23:25:20 +0100 (BST)
Received: from osiris (unknown [9.145.190.119])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  1 Oct 2018 23:25:20 +0100 (BST)
Date:   Mon, 1 Oct 2018 22:25:38 +0200
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@roeck-us.net, Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@redhat.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Jessica Yu <jeyu@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] s390: vmlinux.lds: move JUMP_TABLE_DATA into output
 section
References: <20180930164950.3841-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20180930164950.3841-1-ard.biesheuvel@linaro.org>
X-TM-AS-GCONF: 00
x-cbid: 18100120-0028-0000-0000-00000300FFF7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100120-0029-0000-0000-000023BB2F1E
Message-Id: <20181001202538.GB4958@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-01_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810010195
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 30, 2018 at 06:49:50PM +0200, Ard Biesheuvel wrote:
> Commit e872267b8bcbb179 ("jump_table: move entries into ro_after_init
> region") moved the __jump_table input section into the __ro_after_init
> output section, but inadvertently put the macro in the wrong place in
> the s390 linker script. Let's fix that.
> 
> Fixes: e872267b8bcbb179 ("jump_table: move entries into ro_after_init region")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Jessica Yu <jeyu@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/s390/kernel/vmlinux.lds.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>

I don't think this is very obvious, but this fixes current build breakage
in linux-next and I assume Thomas should pick this up.

> diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
> index 4042bbf3f9ad..457713f48734 100644
> --- a/arch/s390/kernel/vmlinux.lds.S
> +++ b/arch/s390/kernel/vmlinux.lds.S
> @@ -64,9 +64,9 @@ SECTIONS
>  	__start_ro_after_init = .;
>  	.data..ro_after_init : {
>  		 *(.data..ro_after_init)
> +		JUMP_TABLE_DATA
>  	}
>  	EXCEPTION_TABLE(16)
> -	JUMP_TABLE_DATA
>  	. = ALIGN(PAGE_SIZE);
>  	__end_ro_after_init = .;
> 
> -- 
> 2.17.1
> 

