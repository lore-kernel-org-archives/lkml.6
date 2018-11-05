Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E0FC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B2FD20862
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:48:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B2FD20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729767AbeKEWI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 17:08:29 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42004 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729674AbeKEWI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 17:08:28 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA5CkMjK051043
        for <linux-kernel@vger.kernel.org>; Mon, 5 Nov 2018 07:48:52 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2njk9vqynj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 07:48:52 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 5 Nov 2018 12:48:49 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 5 Nov 2018 12:48:46 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA5Cmjiq5439964
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 5 Nov 2018 12:48:45 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B2D8BAE055;
        Mon,  5 Nov 2018 12:48:45 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0E08AE045;
        Mon,  5 Nov 2018 12:48:44 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.105.137])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  5 Nov 2018 12:48:44 +0000 (GMT)
Subject: Re: [PATCH v2 0/2] crypto: streebog - add Streebog hash function
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date:   Mon, 05 Nov 2018 07:48:33 -0500
In-Reply-To: <20181103055145.ndvxd7nbnoqtwrk5@sole.flsd.net>
References: <20181010121254.12220-1-vt@altlinux.org>
         <20181012061659.mextetc3v7urqkzx@gondor.apana.org.au>
         <20181012064105.bchujbwoaszrcu3l@sole.flsd.net>
         <20181017060851.r5mxvpq3l2ycvpio@gondor.apana.org.au>
         <20181103055145.ndvxd7nbnoqtwrk5@sole.flsd.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18110512-0012-0000-0000-000002C39034
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110512-0013-0000-0000-000020F7CEBD
Message-Id: <1541422113.21115.44.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-05_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811050118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-11-03 at 08:51 +0300, Vitaly Chikunov wrote:
> Herbert,
> 
> On Wed, Oct 17, 2018 at 02:08:51PM +0800, Herbert Xu wrote:
> > On Fri, Oct 12, 2018 at 09:41:05AM +0300, Vitaly Chikunov wrote:
> > >
> > > It is the first part of attempts to add to the Integrity subsystem
> > > ability of verifying file and module signatures by Russian GOST
> > > algorithms.
> > 
> > It would be better if these patches are posted together.  That
> > way we don't end up with a situation where the algorithm goes into
> > the kernel but the ultimate user is rejected.
> 
> IMA does not need any particular patching inside of their subtree to
> support new hash, because it is using any hash registered in Hash Info
> which is still under crypto subtree. I added appropriate patch into v3
> which is already posted a week ago, and tested it to work correctly with
> ima_appraise=fix.

That's true, but the target subsystem should be made aware of the new
usage.

Thanks, Herbert.

Mimi

