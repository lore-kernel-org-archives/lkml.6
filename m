Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F83C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 18:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6DE8206C0
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 18:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbeLaSK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 13:10:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58280 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727311AbeLaSK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 13:10:26 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBVI3cMg106508
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 13:10:25 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pqjry44hs-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 13:10:25 -0500
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <kgold@linux.ibm.com>;
        Mon, 31 Dec 2018 18:10:23 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 31 Dec 2018 18:10:21 -0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBVIAKq013566144
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Dec 2018 18:10:20 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D33C828058;
        Mon, 31 Dec 2018 18:10:20 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A523F2805A;
        Mon, 31 Dec 2018 18:10:20 +0000 (GMT)
Received: from [9.77.128.220] (unknown [9.77.128.220])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 31 Dec 2018 18:10:20 +0000 (GMT)
Subject: Re: tpm_tis TPM2.0 not detected on cold boot
To:     =?UTF-8?Q?Michael_Niew=c3=b6hner?= <linux@mniewoehner.de>,
        linux-integrity@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <ef7e773b01a5e6153b84628f74fc67092a2f9b0e.camel@gmail.com>
 <1f281756bb1f041e55be8dd090670a1a7b1d1c94.camel@mniewoehner.de>
 <1545519232.3940.115.camel@linux.ibm.com>
 <e7ec38d7cade9aa76384aa2781eab307d2cd5a7b.camel@mniewoehner.de>
 <b75fd04643daf5aab5a1fc115e8fbfca9a381f8d.camel@mniewoehner.de>
 <1546140837.4069.81.camel@linux.ibm.com>
 <912668ea1d74f526f78f03f562fdaf17fc06f62c.camel@mniewoehner.de>
From:   Ken Goldman <kgold@linux.ibm.com>
Date:   Mon, 31 Dec 2018 13:10:20 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <912668ea1d74f526f78f03f562fdaf17fc06f62c.camel@mniewoehner.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18123118-0060-0000-0000-000002F0FB0B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010323; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000272; SDB=6.01139813; UDB=6.00593079; IPR=6.00920023;
 MB=3.00024914; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-31 18:10:23
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18123118-0061-0000-0000-000047C05139
Message-Id: <3d57a904-81fc-f898-c9e0-1931da4aed3a@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-31_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812310160
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/30/2018 8:22 AM, Michael Niewöhner wrote:
>> difference is that on a cold boot, the TPM takes longer to initialize.
> Well, as I said. Waiting for 10, 20 or even 60 seconds in the boot manager does
> not solve the problem. So the problem is NOT that the TPM takes longer to
> initialize. Even adding a delay of 20 seconds before TPM init does not solve
> that while that should be more than enough time.
> 

This may be TPM hardware dependent.  As I understand it ...

A TPM is permitted to run it's self tests in the background after an
Init (cold boot) , but it's not required to do so.

A TPM that does not - that waits until one of the self test commands is 
issued - will appear to take longer to initialize.

In fact, it's not taking longer.  It's just waiting for some software
to issue a self test command, and will wait forever.


