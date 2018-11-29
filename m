Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355F7C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF726208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gvDqCdVZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF726208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbeK3BPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:15:40 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:51200 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbeK3BPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:15:39 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wATE8aVA055346;
        Thu, 29 Nov 2018 14:09:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=y1bXiMDNjwfx2ZwyTDpQVJTp++PW02bcS0AwrLLC0Dk=;
 b=gvDqCdVZ1rkYgZNr+gBlabFpr8Ciz7xOlErdnSnPxWPFKQi9yKb+FrbMqeAUitSYX1zj
 KOK7dFlKsuQqO2VpXnzI5AZJRcvsbdDm5GrAjB1mSKcxUaG0duJtZg/nVAoh8XoZZbY4
 22TWb1oOVYWf0zxbB5d3HK/0ezIfichSGQICbq6oIDFN59yNVpaBeuBg/03zY+H/iYjH
 At3iRUlnYVRz9/w3HwkQD5iWdhDnZ3AzzwVvyqUqdkZI0cpaFReUYy53JmqYf/4F6fzI
 7w+0+laDPbT3DWj10c4s0kDBU0+81eZPeDOMp878i0a6+LP6jh3zt/TK7quNtb5gq1hw 8A== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2nxx2ugdnd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Nov 2018 14:09:59 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wATE9w4S023399
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Nov 2018 14:09:58 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wATE9vRa026167;
        Thu, 29 Nov 2018 14:09:57 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 29 Nov 2018 06:09:57 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] sysctl: clean up nr_pdflush_threads leftover
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20181128152407.19062-1-aquini@redhat.com>
Date:   Thu, 29 Nov 2018 07:09:56 -0700
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        davem@davemloft.net, virgile@acceis.fr, linux-mm@kvack.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <867FB7CF-C7CC-454F-8845-5026FC3D5BEA@oracle.com>
References: <20181128152407.19062-1-aquini@redhat.com>
To:     Rafael Aquini <aquini@redhat.com>
X-Mailer: Apple Mail (2.3445.102.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9091 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811290119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 28, 2018, at 8:24 AM, Rafael Aquini <aquini@redhat.com> wrote:
>=20
> nr_pdflush_threads has been long deprecated and
> removed, but a remnant of its glorious past is
> still around in CTL_VM names enum. This patch
> is a minor clean-up to that case.
>=20
> Signed-off-by: Rafael Aquini <aquini@redhat.com>
> ---
> include/uapi/linux/sysctl.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/uapi/linux/sysctl.h b/include/uapi/linux/sysctl.h
> index d71013fffaf6..dad5a8f93343 100644
> --- a/include/uapi/linux/sysctl.h
> +++ b/include/uapi/linux/sysctl.h
> @@ -174,7 +174,7 @@ enum
> 	VM_DIRTY_RATIO=3D12,	/* dirty_ratio */
> 	VM_DIRTY_WB_CS=3D13,	/* dirty_writeback_centisecs */
> 	VM_DIRTY_EXPIRE_CS=3D14,	/* dirty_expire_centisecs */
> -	VM_NR_PDFLUSH_THREADS=3D15, /* nr_pdflush_threads */
> +	VM_UNUSED15=3D15,		/* was: int nr_pdflush_threads =
*/
> 	VM_OVERCOMMIT_RATIO=3D16, /* percent of RAM to allow overcommit =
in */
> 	VM_PAGEBUF=3D17,		/* struct: Control pagebuf =
parameters */
> 	VM_HUGETLB_PAGES=3D18,	/* int: Number of available Huge Pages =
*/
> --=20
> 2.17.2
>=20

Please reword the comment to add a colon after the word "int" to match =
earlier
comments in the enum:

+	VM_UNUSED15=3D15,		/* was: int: nr_pdflush_threads =
*/

Also, as long as you're changing this file, please fix the typo earlier =
in the
same enum:

-	VM_UNUSED2=3D2,		/* was; int: Linear or sqrt() swapout =
for hogs */
+	VM_UNUSED2=3D2,		/* was: int: Linear or sqrt() swapout =
for hogs */


Reviewed-by: William Kucharski <william.kucharski@oracle.com>=
