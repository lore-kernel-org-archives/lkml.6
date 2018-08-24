Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3E3C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 01:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EE5721557
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 01:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L4/g/ciM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EE5721557
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbeHXFQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 01:16:58 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53738 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725735AbeHXFQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 01:16:57 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7O1iKJ8149346;
        Fri, 24 Aug 2018 01:44:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=Yu1JHN2dY57YRz2EYuOEzZW2z6YXiEqw308gFNkN+/8=;
 b=L4/g/ciMQ/xNy+GlqZhwLxSwD3bI5NCtVj5sZ8ETcL7UX1YauqC6YFF9M2QpqJ23HoHB
 W8Qx4G7uokTZx3hQnmGfO9oNgP3AkUtGVcQwJQ0yJ4HHnsGiKJhw0a72PrHWZO9Epqrr
 ujoGS5IDYyVt3VegIfL3brVIrzi+SnvIdVjn+eXuwodCBLYlLy0Wis1kmkzLDMG95NF7
 320AGQclELMWNp7/5ZhPFqz/gYX8U6oY4J+IXpd9qVF8HVFgjlJg3MJwIetww8rjeePq
 KeRTXsQJBHAKbqnuXSaYmFp1WDna0hFQp/+fmQvrMCaO29cur1dLU83wKR/FRgCiloL6 IA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2kxavu4krw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Aug 2018 01:44:20 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7O1iJ9T007872
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Aug 2018 01:44:20 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7O1iILJ018320;
        Fri, 24 Aug 2018 01:44:19 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 23 Aug 2018 18:44:18 -0700
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Johannes Thumshirn <jthumshirn@suse.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>,
        Ming Lei <ming.lei@redhat.com>,
        John Garry <john.garry@huawei.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: core: Update SCSI_MQ_DEFAULT help text to match default
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180821114407.18393-1-geert+renesas@glider.be>
Date:   Thu, 23 Aug 2018 21:44:16 -0400
In-Reply-To: <20180821114407.18393-1-geert+renesas@glider.be> (Geert
        Uytterhoeven's message of "Tue, 21 Aug 2018 13:44:07 +0200")
Message-ID: <yq1y3cwa68f.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8994 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=651
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808240017
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Geert,

> The default was changed, but the help text was not updated.

Applied to 4.19/scsi-fixes, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
