Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DB5C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BC612083B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:14:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BC612083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbeH2CHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 22:07:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40778 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727225AbeH2CHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 22:07:51 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7SM9LUF105232
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 18:14:09 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m5cw7ck8j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 18:14:09 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tyreld@linux.vnet.ibm.com>;
        Tue, 28 Aug 2018 18:14:08 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 28 Aug 2018 18:14:03 -0400
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7SME2T325821256
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 Aug 2018 22:14:02 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C22A112065;
        Tue, 28 Aug 2018 18:13:37 -0400 (EDT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B876112063;
        Tue, 28 Aug 2018 18:13:35 -0400 (EDT)
Received: from oc6857751186.ibm.com (unknown [9.85.148.35])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 28 Aug 2018 18:13:35 -0400 (EDT)
Subject: Re: [PATCH] soc: Convert to using %pOFn instead of device_node.name
To:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-soc@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>, david.brown@linaro.org,
        thierry.reding@gmail.com, Santosh Shilimkar <ssantosh@kernel.org>,
        andy.gross@linaro.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Zhao Qiang <qiang.zhao@nxp.com>
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-43-robh@kernel.org>
 <CADRPPNRvRKEuV=ZzH6yq6_7COvFSWy2ibAKoEt4YrzES2m9x2Q@mail.gmail.com>
From:   Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date:   Tue, 28 Aug 2018 15:14:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CADRPPNRvRKEuV=ZzH6yq6_7COvFSWy2ibAKoEt4YrzES2m9x2Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18082822-0052-0000-0000-000003277222
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009629; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080257; UDB=6.00557205; IPR=6.00860241;
 MB=3.00022985; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-28 22:14:06
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082822-0053-0000-0000-00005DE2F78B
Message-Id: <a8594a1c-0d10-74c6-0e40-15d49ff876a3@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-28_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808280215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/28/2018 11:48 AM, Li Yang wrote:
> On Mon, Aug 27, 2018 at 8:57 PM Rob Herring <robh@kernel.org> wrote:
>>
>> In preparation to remove the node name pointer from struct device_node,
>> convert printf users to use the %pOFn format specifier.
> 
> Please forgive my ignorance, but what is this format specifier do
> exactly?   I cannot find anything listed in the printf specification
> matching this.  Is this something newly introduced?
> 
> Leo
> 

From Documentation/core-api/printk-formats.rst:

kobjects
--------

::

        %pOF[fnpPcCF]


For printing kobject based structs (device nodes). Default behaviour is
equivalent to %pOFf.

        - f - device node full_name
        - n - device node name
        - p - device node phandle
        - P - device node path spec (name + @unit)
        - F - device node flags
        - c - major compatible string
        - C - full compatible string


-Tyrel

