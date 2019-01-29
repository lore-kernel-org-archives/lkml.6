Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8BCC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 05:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C879A2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 05:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xsM2R2p1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbfA2Fhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 00:37:54 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:57684 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfA2Fhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 00:37:53 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0T5Yd9k101941;
        Tue, 29 Jan 2019 05:37:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=hbBlGtW6t2WmFFa0bfskKNTLE08jAfObxXnuXKrPx0I=;
 b=xsM2R2p1ywzbXg2i1YQo2Ir8hwp1kCexEdigxh5YsBnZDJd1XcRze7A/+T+uU2NgY075
 UwuC32KOuPyorkLE/VsHa/LGwh93BAjI/kQ8J3UmhTHF3Eg61jn+9wDvRYGtHbRCgPIy
 HW7Ehi5paUju5nwonT7iFyDlZGuZGzCVUfUPWr0AD8hj8poBcxNoAVRI8P2QvMsaXtpf
 sFBr2PYkifdtqyPysMDzsXYQmr0tW0dG3d+ZVBsj8yXnUK4wEf1bJ2Zg8+NybwNn+hJi
 D73X2qi+Zg/Fq7ro0PiAGwFnFgp3KIJZmWU76mrz2I/aFsz5uV7EMXomxUKSQVpP6ySD CA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2q8eyua6k5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jan 2019 05:37:50 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0T5bn9a021333
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jan 2019 05:37:49 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0T5bn3b011908;
        Tue, 29 Jan 2019 05:37:49 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 28 Jan 2019 21:37:49 -0800
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        Martin Petersen <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 0/7] SCSI: cleanup debugfs usage
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190122150906.12470-1-gregkh@linuxfoundation.org>
Date:   Tue, 29 Jan 2019 00:37:47 -0500
In-Reply-To: <20190122150906.12470-1-gregkh@linuxfoundation.org> (Greg
        Kroah-Hartman's message of "Tue, 22 Jan 2019 16:08:59 +0100")
Message-ID: <yq1zhrkdnx0.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9150 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=970
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901290041
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Greg,

> When calling debugfs code, there is no need to ever check the return
> value of the call, as no logic should ever change if a call works
> properly or not.  Fix up a bunch of x86-specific code to not care
> about the results of debugfs.

Applied to 5.1/scsi-queue, thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
