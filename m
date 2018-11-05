Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50368C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2464920819
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:01:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2464920819
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729581AbeKEWVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 17:21:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41862 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728215AbeKEWVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 17:21:10 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA5CxAoe139728
        for <linux-kernel@vger.kernel.org>; Mon, 5 Nov 2018 08:01:31 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2njm6fe3jx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 08:01:29 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 5 Nov 2018 13:01:25 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 5 Nov 2018 13:01:22 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA5D1LcC5243276
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 5 Nov 2018 13:01:21 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0B68A4057;
        Mon,  5 Nov 2018 13:01:21 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 950B0A4040;
        Mon,  5 Nov 2018 13:01:20 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.105.137])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  5 Nov 2018 13:01:20 +0000 (GMT)
Subject: Re: [PATCH v2 0/2] crypto: streebog - add Streebog hash function
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date:   Mon, 05 Nov 2018 08:01:10 -0500
In-Reply-To: <20181105125537.ux4eehruuncqukli@sole.flsd.net>
References: <20181010121254.12220-1-vt@altlinux.org>
         <20181012061659.mextetc3v7urqkzx@gondor.apana.org.au>
         <20181012064105.bchujbwoaszrcu3l@sole.flsd.net>
         <20181017060851.r5mxvpq3l2ycvpio@gondor.apana.org.au>
         <20181103055145.ndvxd7nbnoqtwrk5@sole.flsd.net>
         <1541422113.21115.44.camel@linux.ibm.com>
         <20181105125537.ux4eehruuncqukli@sole.flsd.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18110513-0008-0000-0000-0000028B86BF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110513-0009-0000-0000-000021F5BB0C
Message-Id: <1541422870.21115.51.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-05_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811050120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-11-05 at 15:55 +0300, Vitaly Chikunov wrote:
> Mimi,
> 
> On Mon, Nov 05, 2018 at 07:48:33AM -0500, Mimi Zohar wrote:
> > On Sat, 2018-11-03 at 08:51 +0300, Vitaly Chikunov wrote:
> > > On Wed, Oct 17, 2018 at 02:08:51PM +0800, Herbert Xu wrote:
> > > > On Fri, Oct 12, 2018 at 09:41:05AM +0300, Vitaly Chikunov wrote:
> > > > >
> > > > > It is the first part of attempts to add to the Integrity subsystem
> > > > > ability of verifying file and module signatures by Russian GOST
> > > > > algorithms.
> > > > 
> > > > It would be better if these patches are posted together.  That
> > > > way we don't end up with a situation where the algorithm goes into
> > > > the kernel but the ultimate user is rejected.
> > > 
> > > IMA does not need any particular patching inside of their subtree to
> > > support new hash, because it is using any hash registered in Hash Info
> > > which is still under crypto subtree. I added appropriate patch into v3
> > > which is already posted a week ago, and tested it to work correctly with
> > > ima_appraise=fix.
> > 
> > That's true, but the target subsystem should be made aware of the new
> > usage.
> 
> Did you mean by re-sending the patch with Cc to linux-integrity? Or
> something more?

Just as future reference.  For now, please feel free to add my
Reviewed-by on the "crypto: streebog - register Streebog in hash info
for IMA" patch.

Mimi

