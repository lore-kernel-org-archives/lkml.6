Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EC1C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 21:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E05F217D8
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 21:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbfBHVVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 16:21:08 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50128 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727045AbfBHVVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 16:21:08 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x18LDbnd036618
        for <linux-kernel@vger.kernel.org>; Fri, 8 Feb 2019 16:21:07 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qheny788c-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 16:21:07 -0500
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <stefanb@linux.ibm.com>;
        Fri, 8 Feb 2019 21:21:05 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 8 Feb 2019 21:21:03 -0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x18LL29m23593018
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Feb 2019 21:21:02 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4973AAC059;
        Fri,  8 Feb 2019 21:21:02 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 37D84AC060;
        Fri,  8 Feb 2019 21:21:02 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  8 Feb 2019 21:21:02 +0000 (GMT)
Subject: Re: [PATCH 0/5] Extend TPM PPI interface to support revision 1.3
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        "Safford, David (GE Global Research)" <david.safford@ge.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190109221103.1897677-1-stefanb@linux.vnet.ibm.com>
 <BCA04D5D9A3B764C9B7405BBA4D4A3C0151A3125@ALPMBAPA12.e2k.ad.ge.com>
 <20190118150011.GF4080@linux.intel.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Date:   Fri, 8 Feb 2019 16:21:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20190118150011.GF4080@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-MW
X-TM-AS-GCONF: 00
x-cbid: 19020821-0072-0000-0000-000003F75823
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010560; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000279; SDB=6.01158244; UDB=6.00604331; IPR=6.00938777;
 MB=3.00025497; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-08 21:21:05
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020821-0073-0000-0000-00004B1C9FF0
Message-Id: <cb86f5b6-8084-1e12-ce60-19418539b581@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-08_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=868 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902080145
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/19 10:00 AM, Jarkko Sakkinen wrote:
> On Fri, Jan 11, 2019 at 08:28:00PM +0000, Safford, David (GE Global Research) wrote:
>> You might mention that this is an important feature, as on at least some
>> systems, ppi function 23 is the only way to enable/disable PCR banks.
>>
>> I have tested this patch set on my HP Spectre laptop, and I am finally
>> able to turn the sha-1 bank on and off. Much appreciated!
>>
>> Tested-by: David Safford <david.safford@ge.com>
> Great thanks David.


While we are at it and for the grand finale of the day :-)

+All you people, keep yourself alive!
+Keep yourself alive!
+Keep yourself alive!
+C'mon, give me your reviewed's
+to keep me satisfied!
+Give me your signed-off's                       (1)
+to keep me satisfied!
+Keep yourself alive!
+A few test-by's will keep me satisfied!
+Keep yourself alive!
+Check-in!                                                (2)
+
+[In the style of Queen]


Jarrko, do (1) and (2) to keep me satisfied :-)

