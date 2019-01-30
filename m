Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44EDC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A8412087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733066AbfA3SdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 13:33:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58006 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733006AbfA3SdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 13:33:03 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0UISskF032568
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 13:33:02 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qbgr9hmv3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 13:33:02 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <sebott@linux.ibm.com>;
        Wed, 30 Jan 2019 18:33:00 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 30 Jan 2019 18:32:57 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0UIWtSL58065082
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Jan 2019 18:32:55 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B42A24C044;
        Wed, 30 Jan 2019 18:32:55 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 412FE4C04A;
        Wed, 30 Jan 2019 18:32:55 +0000 (GMT)
Received: from sig-9-145-48-166.uk.ibm.com (unknown [9.145.48.166])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 30 Jan 2019 18:32:55 +0000 (GMT)
Date:   Wed, 30 Jan 2019 19:32:53 +0100 (CET)
From:   Sebastian Ott <sebott@linux.ibm.com>
X-X-Sender: sebott@schleppi
To:     Tony Krowiak <akrowiak@linux.ibm.com>
cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        oberpar@linux.ibm.com, freude@linux.ibm.com, pmorel@linux.ibm.com,
        pasic@linux.ibm.com, cohuck@redhat.com
Subject: Re: [PATCH] zcrypt: handle AP Info notification from CHSC SEI
 command
In-Reply-To: <1548870526-30595-1-git-send-email-akrowiak@linux.ibm.com>
References: <1548870526-30595-1-git-send-email-akrowiak@linux.ibm.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
Organization: =?ISO-8859-15?Q?=22IBM_Deutschland_Research_&_Development_GmbH?=
 =?ISO-8859-15?Q?_=2F_Vorsitzende_des_Aufsichtsrats=3A_Matthias?=
 =?ISO-8859-15?Q?_Hartmann_Gesch=E4ftsf=FChrung=3A_Dirk_Wittkopp?=
 =?ISO-8859-15?Q?_Sitz_der_Gesellschaft=3A_B=F6blingen_=2F_Reg?=
 =?ISO-8859-15?Q?istergericht=3A_Amtsgericht_Stuttgart=2C_HRB_2432?=
 =?ISO-8859-15?Q?94=22?=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
x-cbid: 19013018-0012-0000-0000-000002EF138B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19013018-0013-0000-0000-000021265BDF
Message-Id: <alpine.LFD.2.21.1901301912380.2372@schleppi>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-30_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=988 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901300140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2019, Tony Krowiak wrote:
> +#if IS_ENABLED(CONFIG_ZCRYPT)
> +void ap_bus_cfg_chg(void);
> +#else
> +#error "no CONFIG_ZCRYPT"
   ^
I don't think that's the right thing to do here.


> +++ b/drivers/s390/cio/chsc.h
> @@ -9,6 +9,7 @@
>  #include <asm/chsc.h>
>  #include <asm/schid.h>
>  #include <asm/qdio.h>
> +#include <asm/ap.h>

This should be moved to chsc.c


> +++ b/drivers/s390/crypto/ap_bus.c
> @@ -35,6 +35,7 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/debugfs.h>
>  #include <linux/ctype.h>
> +#include <asm/crw.h>

This is not needed here.


>  /*
> +* A config change has happened, Force an ap bus rescan.
> +*/
> +void ap_bus_cfg_chg(void)
> +{
> +	AP_DBF(DBF_INFO, "%s config change, forcing bus rescan\n", __func__);
> +
> +	ap_bus_force_rescan();
> +}
> +EXPORT_SYMBOL(ap_bus_cfg_chg);

There is no need for the export symbol - you don't call that function
from module code.
As an unrelated question, just to be sure: ap_bus.c is compiled as
built-in even with ZCRYPT=m, right?

Reviewed-by: Sebastian Ott <sebott@linux.ibm.com>

Regards,
Sebastian

