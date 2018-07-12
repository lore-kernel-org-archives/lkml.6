Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41489C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06FB520BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:47:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06FB520BF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732510AbeGLN5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 09:57:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41100 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732247AbeGLN5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 09:57:03 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6CDiO6w110323
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 09:47:24 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k65jwg8ew-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 09:47:23 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <brueckner@linux.ibm.com>;
        Thu, 12 Jul 2018 14:47:22 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 12 Jul 2018 14:47:19 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6CDlJCK24838314
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Jul 2018 13:47:19 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C55552052;
        Thu, 12 Jul 2018 16:47:40 +0100 (BST)
Received: from lynx.boeblingen.de.ibm.com (unknown [9.145.10.223])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 30E8852050;
        Thu, 12 Jul 2018 16:47:40 +0100 (BST)
Received: from brueckh by lynx.boeblingen.de.ibm.com with local (Exim 4.90_1)
        (envelope-from <brueckner@linux.ibm.com>)
        id 1fdbwD-00027G-Nj; Thu, 12 Jul 2018 15:47:17 +0200
Date:   Thu, 12 Jul 2018 15:47:17 +0200
From:   Hendrik Brueckner <brueckner@linux.ibm.com>
To:     Adrian Reber <adrian@lisas.de>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Andrei Vagin <avagin@virtuozzo.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        alice@linux.ibm.com
Subject: Re: [PATCH] kconfig: remove EXPERT from CHECKPOINT_RESTORE
References: <20180712130733.11510-1-adrian@lisas.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712130733.11510-1-adrian@lisas.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18071213-0008-0000-0000-000002526603
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071213-0009-0000-0000-000021B89F8C
Message-Id: <20180712134717.GB4676@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-12_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807120145
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 03:07:33PM +0200, Adrian Reber wrote:
> The CHECKPOINT_RESTORE configuration option was introduced in 2012 and
> combined with EXPERT. CHECKPOINT_RESTORE is already enabled in many
> distribution kernels and also part of the defconfigs of various
> architectures.
> 
> To make it easier for distributions to enable CHECKPOINT_RESTORE this
> removes EXPERT and moves the configuration option out of the EXPERT
> block.
> 
> Signed-off-by: Adrian Reber <adrian@lisas.de>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Pavel Emelyanov <xemul@virtuozzo.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Andrei Vagin <avagin@virtuozzo.com>
> Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
> ---
>  init/Kconfig | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/init/Kconfig b/init/Kconfig
> index 041f3a022122..9c529c763326 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -932,6 +932,18 @@ config NET_NS
> 
>  endif # NAMESPACES
> 
> +config CHECKPOINT_RESTORE
> +	bool "Checkpoint/restore support"
> +	select PROC_CHILDREN
> +	default n
> +	help
> +	  Enables additional kernel features in a sake of checkpoint/restore.
> +	  In particular it adds auxiliary prctl codes to setup process text,
> +	  data and heap segment sizes, and a few additional /proc filesystem
> +	  entries.
> +
> +	  If unsure, say N here.
> +
>  config SCHED_AUTOGROUP
>  	bool "Automatic process group scheduling"
>  	select CGROUPS
> @@ -1348,18 +1360,6 @@ config MEMBARRIER
> 
>  	  If unsure, say Y.
> 
> -config CHECKPOINT_RESTORE
> -	bool "Checkpoint/restore support" if EXPERT
> -	select PROC_CHILDREN
> -	default n
> -	help
> -	  Enables additional kernel features in a sake of checkpoint/restore.
> -	  In particular it adds auxiliary prctl codes to setup process text,
> -	  data and heap segment sizes, and a few additional /proc filesystem
> -	  entries.
> -
> -	  If unsure, say N here.
> -
>  config KALLSYMS
>  	 bool "Load all symbols for debugging/ksymoops" if EXPERT
>  	 default y

Thanks!

Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>

