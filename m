Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BDBC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 03:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57DD420862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 03:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VDFYmXca"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57DD420862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387434AbeKFM7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 07:59:52 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:48346 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbeKFM7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 07:59:52 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA63Y5K7008115;
        Tue, 6 Nov 2018 03:36:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=UWWBhC0fs6cpi4SUWEnw0gaEksheadVgxnf/0zLcVtU=;
 b=VDFYmXcacbTYGiM3fjYIvCmNhdsNfuVFx5v2qhuN5pa1SxbRHAQLxWeBK5pnNrhJD0P3
 Kek9gQmbRJa/69MgYGC0giQq0YPKYoSPRa/rKQId71/4Qnr0fHpNm1bLjnlRPynKQW8I
 3CPqA+ZeCIcp1oxAkckxNMSB4gO5SsEzb/2sCKwASwmrpooAc6SlH0NZqfN1DOuEr89t
 HBs8/oHN8XyZ7CSvWk7JmIAgWAOaMgtk1UqeOQzaUjZfgzUL9m5xics2HDhEgwLAR6kh
 e1Y/Jb5x0uUAokjZ3o08C6H/Lv6YKY1I3q5Z/Aj0nL8mageNOnG3yWdLKDDQSqr+WA3V Pg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2nh33ttsf8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Nov 2018 03:36:38 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wA63aXIs025811
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Nov 2018 03:36:33 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wA63aWol026866;
        Tue, 6 Nov 2018 03:36:32 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 05 Nov 2018 19:36:32 -0800
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: myrs: only build on little-endian platforms
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20181102154740.2011289-1-arnd@arndb.de>
Date:   Mon, 05 Nov 2018 22:36:30 -0500
In-Reply-To: <20181102154740.2011289-1-arnd@arndb.de> (Arnd Bergmann's message
        of "Fri, 2 Nov 2018 16:47:23 +0100")
Message-ID: <yq14lcu7u81.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9068 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=449
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811060028
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Arnd,

> Reading throught the new driver, I noticed that this cannot work on
> big-endian CPUs, and the old DAC960 had exactly the same behavior.
>
> To document this for the future, add a Kconfig dependency that prevents it
> from being included in big-endian kernels.  Since the hardware is really
> old and we never had a working driver on it for big-endian platforms,
> it's unlikely to make a difference to users.

Applied to 4.20/scsi-fixes. Thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
