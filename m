Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41D0ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66C642087A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:12:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66C642087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=us.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732393AbeITV4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 17:56:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54806 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727229AbeITV4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 17:56:11 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8KG2Hua141266
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 12:11:59 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mmcrgxfm3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 12:11:58 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <linuxram@us.ibm.com>;
        Thu, 20 Sep 2018 17:11:56 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 20 Sep 2018 17:11:53 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8KGBqi859506778
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 Sep 2018 16:11:52 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 130D552054;
        Thu, 20 Sep 2018 19:11:37 +0100 (BST)
Received: from ram.oc3035372033.ibm.com (unknown [9.85.157.177])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id C4AEE5205F;
        Thu, 20 Sep 2018 19:11:35 +0100 (BST)
Date:   Thu, 20 Sep 2018 09:11:47 -0700
From:   Ram Pai <linuxram@us.ibm.com>
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/pkeys: Fix reading of ibm,processor-storage-keys
 property
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <20180920043858.28773-1-bauerman@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20180920043858.28773-1-bauerman@linux.ibm.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-TM-AS-GCONF: 00
x-cbid: 18092016-0016-0000-0000-000002082F95
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092016-0017-0000-0000-0000325F324B
Message-Id: <20180920161147.GE5809@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-20_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809200157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 01:38:58AM -0300, Thiago Jung Bauermann wrote:
> scan_pkey_feature() uses of_property_read_u32_array() to read the
> ibm,processor-storage-keys property and calls be32_to_cpu() on the
> value it gets. The problem is that of_property_read_u32_array() already
> returns the value converted to the CPU byte order.
> 
> The value of pkeys_total ends up more or less sane because there's a min()
> call in pkey_initialize() which reduces pkeys_total to 32. So in practice
> the kernel ignores the fact that the hypervisor reserved one key for
> itself (the device tree advertises 31 keys in my test VM).
> 
> This is wrong, but the effect in practice is that when a process tries to
> allocate the 32nd key, it gets an -EINVAL error instead of -ENOSPC which
> would indicate that there aren't any keys available

Thanks for the fix.

Reviewed-by: Ram Pai <linuxram@us.ibm.com>

> 
> Fixes: cf43d3b26452 ("powerpc: Enable pkey subsystem")
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> ---
>  arch/powerpc/mm/pkeys.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
> index 333b1f80c435..b271b283c785 100644
> --- a/arch/powerpc/mm/pkeys.c
> +++ b/arch/powerpc/mm/pkeys.c
> @@ -45,7 +45,7 @@ static void scan_pkey_feature(void)
>  	 * Since any pkey can be used for data or execute, we will just treat
>  	 * all keys as equal and track them as one entity.
>  	 */
> -	pkeys_total = be32_to_cpu(vals[0]);
> +	pkeys_total = vals[0];
>  	pkeys_devtree_defined = true;
>  }

-- 
Ram Pai

