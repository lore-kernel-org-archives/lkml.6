Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7122EC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 22:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4811821908
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 22:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbfBHWGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 17:06:41 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39258 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726977AbfBHWGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 17:06:40 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x18Lx213012229
        for <linux-kernel@vger.kernel.org>; Fri, 8 Feb 2019 17:06:39 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qhdyujfdh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 17:06:38 -0500
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <stefanb@linux.ibm.com>;
        Fri, 8 Feb 2019 22:06:38 -0000
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 8 Feb 2019 22:06:34 -0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x18M6XAg22544416
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Feb 2019 22:06:34 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6B3BAC08F;
        Fri,  8 Feb 2019 22:06:33 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C609EAC089;
        Fri,  8 Feb 2019 22:06:33 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  8 Feb 2019 22:06:33 +0000 (GMT)
Subject: Re: [PATCH 0/5] Extend TPM PPI interface to support revision 1.3
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     "Safford, David (GE Global Research)" <david.safford@ge.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190109221103.1897677-1-stefanb@linux.vnet.ibm.com>
 <BCA04D5D9A3B764C9B7405BBA4D4A3C0151A3125@ALPMBAPA12.e2k.ad.ge.com>
 <20190118150011.GF4080@linux.intel.com>
 <cb86f5b6-8084-1e12-ce60-19418539b581@linux.ibm.com>
 <20190208220025.GB13567@linux.intel.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Date:   Fri, 8 Feb 2019 17:06:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20190208220025.GB13567@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-MW
X-TM-AS-GCONF: 00
x-cbid: 19020822-0072-0000-0000-000003F75C0E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010561; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000279; SDB=6.01158259; UDB=6.00604340; IPR=6.00938792;
 MB=3.00025497; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-08 22:06:36
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020822-0073-0000-0000-00004B1CBA75
Message-Id: <d34dd6ec-248e-b7f8-edb0-367f1f4f9356@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-08_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902080150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/19 5:00 PM, Jarkko Sakkinen wrote:
> On Fri, Feb 08, 2019 at 04:21:02PM -0500, Stefan Berger wrote:
> I still think that in 5/5 branching could be better but is not a biggie
> for me (does not make the implementation as whole any kind of mess) and
> since it is now peer tested I rather would not modify it right now.
>
> Applied to master and next!


5/5 may cause a complaint about the scanf'ing of a single value in an 
existing line. Let's see...

    Thanks.

       Stefan


