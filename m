Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5E4C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E7F8217B7
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:22:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E7F8217B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389346AbeHGQgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 12:36:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38600 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388569AbeHGQgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 12:36:44 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w77EJ7Id115469
        for <linux-kernel@vger.kernel.org>; Tue, 7 Aug 2018 10:22:10 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kqd2wr46u-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 10:22:10 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bryantly@linux.ibm.com>;
        Tue, 7 Aug 2018 10:22:09 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 7 Aug 2018 10:22:06 -0400
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w77EM5Fs56819730
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Aug 2018 14:22:05 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BCD72AC064;
        Tue,  7 Aug 2018 10:22:38 -0400 (EDT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 870BBAC065;
        Tue,  7 Aug 2018 10:22:38 -0400 (EDT)
Received: from bryants-mbp-4.rchland.ibm.com (unknown [9.10.79.147])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  7 Aug 2018 10:22:38 -0400 (EDT)
Subject: Re: [PATCH] misc: ibmvsm: Fix wrong assignment of return code
To:     Michael Ellerman <michaele@au1.ibm.com>,
        "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
        gregkh@linuxfoundation.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <1533562260-11456-1-git-send-email-bryantly@linux.vnet.ibm.com>
 <87y3dibbt3.fsf@concordia.ellerman.id.au>
From:   "Bryant G. Ly" <bryantly@linux.ibm.com>
Date:   Tue, 7 Aug 2018 09:22:04 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87y3dibbt3.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18080714-0064-0000-0000-00000336B5B0
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009501; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01070655; UDB=6.00551084; IPR=6.00850027;
 MB=3.00022559; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-07 14:22:08
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080714-0065-0000-0000-00003A383E5B
Message-Id: <ff54860b-9e9a-84a2-9f72-cbb0c5b7118d@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-07_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808070146
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/7/18 7:28 AM, Michael Ellerman wrote:

> "Bryant G. Ly" <bryantly@linux.vnet.ibm.com> writes:
>
>> From: "Bryant G. Ly" <bryantly@linux.ibm.com>
>>
>> Currently the assignment is flipped and rc is always 0.
> If you'd left rc uninitialised at the start of the function the compiler
> would have caught it for you.
>
> And what is the consequence of the bug? Nothing, complete system crash,
> subtle data corruption?

The consequence would be that if the CRQ Registration failed the first time
due to not enough resources, it would never try to reset and try again. 

If it fails due to any other error then it would just fail the sending of the
crq init message, thus it would just wait for the client to init, which would
never happen. 

We would also have a memory leak since in the error case DMA would never get
un-mapped and the message queue never gets freed. 

>
> Also this should be tagged:
>
> Fixes: 0eca353e7ae7 ("misc: IBM Virtual Management Channel Driver (VMC)")
>
> cheers
>
Yep, sorry I forgot to add the Fixes:..

-Bryant


