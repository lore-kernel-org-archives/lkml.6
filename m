Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BEBC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F39D92087C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbfBDKBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:01:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59984 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728573AbfBDKBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:01:47 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x149t5GA113419
        for <linux-kernel@vger.kernel.org>; Mon, 4 Feb 2019 05:01:46 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qejxx93hy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 05:01:46 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <sebott@linux.ibm.com>;
        Mon, 4 Feb 2019 10:01:44 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 4 Feb 2019 10:01:42 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x14A1fxd3604742
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Feb 2019 10:01:41 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F00BF52069;
        Mon,  4 Feb 2019 10:01:40 +0000 (GMT)
Received: from dyn-9-152-212-110.boeblingen.de.ibm.com (unknown [9.152.212.110])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 976D552054;
        Mon,  4 Feb 2019 10:01:40 +0000 (GMT)
Date:   Mon, 4 Feb 2019 11:01:40 +0100 (CET)
From:   Sebastian Ott <sebott@linux.ibm.com>
X-X-Sender: sebott@schleppi.aag-de.ibmmobiledemo.com
To:     Tony Krowiak <akrowiak@linux.ibm.com>
cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        oberpar@linux.ibm.com, freude@linux.ibm.com, pmorel@linux.ibm.com,
        pasic@linux.ibm.com, cohuck@redhat.com
Subject: Re: [PATCH] zcrypt: handle AP Info notification from CHSC SEI
 command
In-Reply-To: <88b72363-9dca-4653-c326-9c37b6349a32@linux.ibm.com>
References: <1548870526-30595-1-git-send-email-akrowiak@linux.ibm.com> <alpine.LFD.2.21.1901301912380.2372@schleppi> <88b72363-9dca-4653-c326-9c37b6349a32@linux.ibm.com>
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
x-cbid: 19020410-0016-0000-0000-00000250D195
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020410-0017-0000-0000-000032AAD72B
Message-Id: <alpine.LFD.2.21.1902041056190.1862@schleppi.aag-de.ibmmobiledemo.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-04_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=730 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902040080
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2019, Tony Krowiak wrote:
> On 1/30/19 1:32 PM, Sebastian Ott wrote:
> > On Wed, 30 Jan 2019, Tony Krowiak wrote:
> >> +++ b/drivers/s390/cio/chsc.h
> >> @@ -9,6 +9,7 @@
> >>   #include <asm/chsc.h>
> >>   #include <asm/schid.h>
> >>   #include <asm/qdio.h>
> >> +#include <asm/ap.h>
> > 
> > This should be moved to chsc.c
> 
> I can do that, but I'm curious why.

You only need to include ap.h because of the ap_bus_cfg_chg definition and
you only use that in chsc.c . Other users of chsc.h don't call that
function.

Regards,
Sebastian

