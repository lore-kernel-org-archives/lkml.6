Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35370C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 00:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECDAC218FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 00:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="5pGoZ8yR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388414AbeLUA5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 19:57:11 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:35608 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732145AbeLUA5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 19:57:11 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBL0rZGS117329;
        Fri, 21 Dec 2018 00:56:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=N0RiKFGwwPh4uMrqe21MVvoEH7V26R0d4bsV6EyoWyY=;
 b=5pGoZ8yROxdqzuG+EtsFIIrxS0O4Ofyul+qeBq6PSePbzBwn/FGAim63TFNXgTaE+9Jg
 0kwgAfNrw1YRt/xKd/IcU5QjSb9RFPAzAj3/d8tbM7Cr26eL7elIT19zWqZqkCSl/WmL
 aoiY7sUkUO+C1iIj2674HTYrjDXegAscyCfFEtozhqU5HYqp0he/c7wfyjWalf4pZe6i
 Rn0bXW0aj0VGjUlGTtOIkQkezmQyjPVJEbiPNH/i8lCLNOp8XnXKnrfPdguvo1qgBeMl
 hr7n9l+u4iVS9dPBrYjLQFR4tBnfEE44KHPtwFAJPa37+r/RRQ8c+9JknNGBsaB+bE+m 1A== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2pfh3aa1sy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Dec 2018 00:56:57 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wBL0uv3W025963
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Dec 2018 00:56:57 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wBL0uu90001642;
        Fri, 21 Dec 2018 00:56:56 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Dec 2018 16:56:56 -0800
To:     Artur Paszkiewicz <artur.paszkiewicz@intel.com>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        intel-linux-scu <intel-linux-scu@intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi\@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 17/41] scsi: isci: phy: Mark expected switch fall-through
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <cover.1543374820.git.gustavo@embeddedor.com>
        <ceff1b50e91a4c13b49423b08ec9447b@fmsmsx108.amr.corp.intel.com>
        <cfd08179-b03a-53d6-9765-b1555eaf9719@intel.com>
Date:   Thu, 20 Dec 2018 19:56:53 -0500
In-Reply-To: <cfd08179-b03a-53d6-9765-b1555eaf9719@intel.com> (Artur
        Paszkiewicz's message of "Thu, 20 Dec 2018 09:51:22 +0100")
Message-ID: <yq1muozbstm.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9113 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=847
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812210004
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Artur,

> On 11/28/18 5:29 AM, Gustavo A. R. Silva wrote:
>> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
>> where we are expecting to fall through.
>> 
>> Addresses-Coverity-ID: 703127 ("Missing break in switch")
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>
> Acked-by: Artur Paszkiewicz <artur.paszkiewicz@intel.com>

Applied the 4 isci patches to 4.21/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
