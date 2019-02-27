Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48D6C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0F9A213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NzhqPGsK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730480AbfB0Ohu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 09:37:50 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:54424 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbfB0Ohu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 09:37:50 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1REYSh4126390;
        Wed, 27 Feb 2019 14:37:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=tqip4vpAp4nPT/43ACcxYbE6fLCwpDYw5lEEB+Ft5gM=;
 b=NzhqPGsKBfa17DvvNzPvrKi4l71KX+W9cRprfU2gDHVDRKfALdAW7CP/NsRxPCuGlhfE
 ChWTSRGsL87XFI+4QFUIYC0J33KcTfpF8RVZ5F+TgVoy41X8tiJ7UtuKbgU15wWzOCmT
 yuJMNPu+9WAwgvaqsUTXE7DV5M9iEA6QUZDLKoGuitSFHVZP0o0DrZWW8YFjz6YYmJye
 ZNDI+sc+SmG4J7t0XbNEBneUbHRc5wE2kgZFiDvllOq9ihzP7x0uPCz+c+Kcl71p1ffK
 NL8nhue0PlB0qNwJLY4wvT5cp29/kTAZJHfcXWZOfB4OqqRVXfR+C6EfZfgyo2IQ2rmS Bw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2qtupebd30-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Feb 2019 14:37:33 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1REbWQl023347
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Feb 2019 14:37:33 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1REbW3G015154;
        Wed, 27 Feb 2019 14:37:32 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 27 Feb 2019 06:37:32 -0800
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] scsi: mpt3sas: Add missing breaks in switch statements
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190215215414.GA10944@embeddedor>
Date:   Wed, 27 Feb 2019 09:37:29 -0500
In-Reply-To: <20190215215414.GA10944@embeddedor> (Gustavo A. R. Silva's
        message of "Fri, 15 Feb 2019 15:54:14 -0600")
Message-ID: <yq1lg219u1i.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9179 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=930 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902270099
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Gustavo,

> Fix the following warnings by adding the proper missing breaks:
>
> drivers/scsi/mpt3sas/mpt3sas_base.c: In function =E2=80=98_base_display_O=
EMs_branding=E2=80=99:
> drivers/scsi/mpt3sas/mpt3sas_base.c:3548:4: warning: this statement may f=
all thr

Applied to 5.1/scsi-queue, thanks.

--=20
Martin K. Petersen	Oracle Linux Engineering
