Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0C0C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9DDB218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbfBANF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 08:05:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34076 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728007AbfBANF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 08:05:57 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x11D5Ujm014657
        for <linux-kernel@vger.kernel.org>; Fri, 1 Feb 2019 08:05:56 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qcp22t4t7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 08:05:55 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Fri, 1 Feb 2019 13:05:54 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 1 Feb 2019 13:05:52 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x11D5oqK1900890
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 Feb 2019 13:05:50 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C262A405D;
        Fri,  1 Feb 2019 13:05:50 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D871FA4040;
        Fri,  1 Feb 2019 13:05:49 +0000 (GMT)
Received: from osiris (unknown [9.152.212.95])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri,  1 Feb 2019 13:05:49 +0000 (GMT)
Date:   Fri, 1 Feb 2019 14:05:48 +0100
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>,
        Sebastian Ott <sebott@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        oberpar@linux.ibm.com, freude@linux.ibm.com, pmorel@linux.ibm.com,
        pasic@linux.ibm.com, cohuck@redhat.com
Subject: Re: [PATCH] zcrypt: handle AP Info notification from CHSC SEI command
References: <1548870526-30595-1-git-send-email-akrowiak@linux.ibm.com>
 <alpine.LFD.2.21.1901301912380.2372@schleppi>
 <88b72363-9dca-4653-c326-9c37b6349a32@linux.ibm.com>
 <20190201090159.GC3770@osiris>
MIME-Version: 1.0
In-Reply-To: <20190201090159.GC3770@osiris>
X-TM-AS-GCONF: 00
x-cbid: 19020113-4275-0000-0000-00000308DBC0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020113-4276-0000-0000-00003816E9A7
Message-Id: <20190201130548.GF3770@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-01_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902010099
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 10:01:59AM +0100, Heiko Carstens wrote:
> On Thu, Jan 31, 2019 at 06:28:39PM -0500, Tony Krowiak wrote:
> > On 1/30/19 1:32 PM, Sebastian Ott wrote:
> > >On Wed, 30 Jan 2019, Tony Krowiak wrote:
> > >>+#if IS_ENABLED(CONFIG_ZCRYPT)
> > >>+void ap_bus_cfg_chg(void);
...
> Also the above should be "#ifdef CONFIG_ZCRYPT".

Please ignore that part of my comment.
I always forget the CONFIG_ZCRYPT_MODULE option.

