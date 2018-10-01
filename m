Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09762C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE4F72089A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:46:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE4F72089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbeJATYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 15:24:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38632 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729289AbeJATYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 15:24:07 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w91CYbgB006083
        for <linux-kernel@vger.kernel.org>; Mon, 1 Oct 2018 08:46:27 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2muhm95vpy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 08:46:27 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Mon, 1 Oct 2018 13:46:24 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 1 Oct 2018 13:46:20 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w91CkJjD48824392
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 1 Oct 2018 12:46:19 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 64D2842049;
        Mon,  1 Oct 2018 15:46:00 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F2A1242041;
        Mon,  1 Oct 2018 15:45:59 +0100 (BST)
Received: from osiris (unknown [9.152.212.171])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  1 Oct 2018 15:45:59 +0100 (BST)
Date:   Mon, 1 Oct 2018 14:46:17 +0200
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Leonardo =?iso-8859-1?Q?Br=E1s?= <leobras.c@gmail.com>
Cc:     lkcamp@lists.libreplanetbr.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Robert Richter <rric@kernel.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        oprofile-list@lists.sf.net, linux-parisc@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 5/7] drivers: s390: Avoids building drivers if ARCH is
 not s390.
References: <20180928020816.11251-1-leobras.c@gmail.com>
 <20180928020816.11251-6-leobras.c@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20180928020816.11251-6-leobras.c@gmail.com>
X-TM-AS-GCONF: 00
x-cbid: 18100112-0012-0000-0000-000002B0D6D3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100112-0013-0000-0000-000020E503FD
Message-Id: <20181001124617.GA3185@osiris>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-01_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=661 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810010126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 11:08:14PM -0300, Leonardo Brás wrote:
> Avoids building s390 drivers if 'make drivers/s390/' is called but
> ARCH is not s390.
> 
> Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
> ---
>  drivers/s390/Makefile | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/s390/Makefile b/drivers/s390/Makefile
> index a863b0462b43..0575f02dba45 100644
> --- a/drivers/s390/Makefile
> +++ b/drivers/s390/Makefile
> @@ -3,7 +3,7 @@
>  # Makefile for the S/390 specific device drivers
>  #
>  
> -obj-y += cio/ block/ char/ crypto/ net/ scsi/ virtio/
> -
> -drivers-y += drivers/s390/built-in.a
> -
> +ifeq ($(ARCH),s390)
> +	obj-y += cio/ block/ char/ crypto/ net/ scsi/ virtio/
> +	drivers-y += drivers/s390/built-in.a
> +endif

And then somebody wants to build with e.g. "make drivers/s390/cio/" and it
still doesn't work. So _if_ this should be supported then it should work
with all directory levels and all configuration options. Otherwise this is
going to be a never ending story.

