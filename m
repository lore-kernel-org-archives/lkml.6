Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3116DC282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 063B820B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbfAaUVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 15:21:04 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40540 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725802AbfAaUVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 15:21:04 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0VKKwa5049034
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 15:21:02 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qc4sk1bha-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 15:21:01 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 31 Jan 2019 20:20:56 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 31 Jan 2019 20:20:52 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0VKKpKK131494
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 31 Jan 2019 20:20:51 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 29D91A404D;
        Thu, 31 Jan 2019 20:20:51 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D371FA4057;
        Thu, 31 Jan 2019 20:20:49 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.107.203])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 31 Jan 2019 20:20:49 +0000 (GMT)
Subject: Re: [PATCH] security: mark expected switch fall-throughs
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Date:   Thu, 31 Jan 2019 15:20:39 -0500
In-Reply-To: <a1cf3a2a-c8ad-fd33-47fb-9a9d8230c24f@embeddedor.com>
References: <20190125025639.GA13946@embeddedor>
         <d30c9427-29bb-4b98-ec71-0663d0f9fa7f@schaufler-ca.com>
         <7b0a0b5b-38ce-a737-6420-2c96cce12527@embeddedor.com>
         <f9ca33c7-2f96-ce1f-4fd2-587b991f2e85@embeddedor.com>
         <1548964731.6107.28.camel@linux.ibm.com>
         <a1cf3a2a-c8ad-fd33-47fb-9a9d8230c24f@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19013120-0028-0000-0000-0000034182C6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19013120-0029-0000-0000-000023FF86C9
Message-Id: <1548966039.6107.29.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-31_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901310150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-01-31 at 14:12 -0600, Gustavo A. R. Silva wrote:
> Mimi,
> 
> On 1/31/19 1:58 PM, Mimi Zohar wrote:
> > [Cc'ing James Morris]
> > 
> > On Thu, 2019-01-24 at 21:47 -0600, Gustavo A. R. Silva wrote:
> > 
> >>>>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> >>>>
> >>>> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> >>>>
> >>
> >> BTW, thanks, Casey.  I'll take this in my tree.
> > 
> > This patch touches multiple LSMs and IMA.  As James has already picked
> > up similar patches, which are in his next-general branch, perhaps he
> > could also pick up an updated version of this one.
> > 
> 
> Yeah.  I can either integrate your recent fix and respin if you don't mind,
> or remove the fall-through comment and wait for James to take both patches,
> yours and mine.
> 
> What do you prefer?

Either way is fine.

Mimi

