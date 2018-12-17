Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A042C43612
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72BAB214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731776AbeLQWha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 17:37:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48610 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731529AbeLQWha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 17:37:30 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBHMYdGL110707
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 17:37:29 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pek7tuy70-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 17:37:29 -0500
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Mon, 17 Dec 2018 22:37:28 -0000
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 17 Dec 2018 22:37:26 -0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBHMbPtf18284566
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Dec 2018 22:37:25 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 12B6DAE068;
        Mon, 17 Dec 2018 22:37:25 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0BB58AE060;
        Mon, 17 Dec 2018 22:37:23 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.85.196.235])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTPS;
        Mon, 17 Dec 2018 22:37:22 +0000 (GMT)
References: <20181213013909.25737-1-bauerman@linux.ibm.com> <alpine.LRH.2.21.1812180633290.29218@namei.org> <1545077031.10804.8.camel@linux.ibm.com> <alpine.LRH.2.21.1812180911040.6212@namei.org>
User-agent: mu4e 1.0; emacs 26.1
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     James Morris <jmorris@namei.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        linux-security-module@vger.kernel.org,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] integrity: Remove references to module keyring
In-reply-to: <alpine.LRH.2.21.1812180911040.6212@namei.org>
Date:   Mon, 17 Dec 2018 20:37:20 -0200
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 18121722-0052-0000-0000-00000368C6AD
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010241; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000271; SDB=6.01133232; UDB=6.00589103; IPR=6.00913400;
 MB=3.00024724; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-17 22:37:27
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121722-0053-0000-0000-00005F24893B
Message-Id: <87o99jaifz.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-17_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812170197
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


James Morris <jmorris@namei.org> writes:

> On Mon, 17 Dec 2018, Mimi Zohar wrote:
>
>> On Tue, 2018-12-18 at 06:33 +1100, James Morris wrote:
>> > On Wed, 12 Dec 2018, Thiago Jung Bauermann wrote:
>> > 
>> > > >From what I can tell, it has never been used.
>> 
>> This was introduced prior to Rusty's decision to use appended
>> signatures for kernel modules.
>> 
>> > > 
>> > > Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>> > 
>> > Mimi, can I add your acked-by?
>> 
>> Acked-by: Mimi Zohar <zohar@linux.ibm.com>
>
> Applied to
> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-integrity
> and next-testing

Thanks!

-- 
Thiago Jung Bauermann
IBM Linux Technology Center

