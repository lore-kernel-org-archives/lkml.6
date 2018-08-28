Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05770C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A48B72087A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:46:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A48B72087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbeH2Cki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 22:40:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49088 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727067AbeH2Cki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 22:40:38 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7SMiA34111833
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 18:46:49 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m5e4xjfyj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 18:46:48 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tyreld@linux.vnet.ibm.com>;
        Tue, 28 Aug 2018 18:46:47 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 28 Aug 2018 18:46:44 -0400
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7SMkhIf25428026
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 Aug 2018 22:46:43 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C0E09112063;
        Tue, 28 Aug 2018 18:46:17 -0400 (EDT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1562B112064;
        Tue, 28 Aug 2018 18:46:16 -0400 (EDT)
Received: from oc6857751186.ibm.com (unknown [9.85.148.35])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 28 Aug 2018 18:46:15 -0400 (EDT)
Subject: Re: [PATCH] soc: Convert to using %pOFn instead of device_node.name
To:     Li Yang <leoyang.li@nxp.com>
Cc:     Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        linux-soc@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        David Brown <david.brown@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Zhao Qiang <qiang.zhao@nxp.com>
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-43-robh@kernel.org>
 <CADRPPNRvRKEuV=ZzH6yq6_7COvFSWy2ibAKoEt4YrzES2m9x2Q@mail.gmail.com>
 <a8594a1c-0d10-74c6-0e40-15d49ff876a3@linux.vnet.ibm.com>
 <CADRPPNSoP5K79wCr5QdJ-OR_W9aZrEkBiPqCXU7EWCfZsvaeuQ@mail.gmail.com>
From:   Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date:   Tue, 28 Aug 2018 15:46:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CADRPPNSoP5K79wCr5QdJ-OR_W9aZrEkBiPqCXU7EWCfZsvaeuQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18082822-0072-0000-0000-00000398BFF6
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009629; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080268; UDB=6.00557211; IPR=6.00860252;
 MB=3.00022985; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-28 22:46:47
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082822-0073-0000-0000-0000493BC0A3
Message-Id: <9587f8a2-3130-033c-6394-9110b0d399da@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-28_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808280220
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/28/2018 03:29 PM, Li Yang wrote:
> On Tue, Aug 28, 2018 at 5:16 PM Tyrel Datwyler
> <tyreld@linux.vnet.ibm.com> wrote:
>>
>> On 08/28/2018 11:48 AM, Li Yang wrote:
>>> On Mon, Aug 27, 2018 at 8:57 PM Rob Herring <robh@kernel.org> wrote:
>>>>
>>>> In preparation to remove the node name pointer from struct device_node,
>>>> convert printf users to use the %pOFn format specifier.
>>>
>>> Please forgive my ignorance, but what is this format specifier do
>>> exactly?   I cannot find anything listed in the printf specification
>>> matching this.  Is this something newly introduced?
>>>
>>> Leo
>>>
>>
>> From Documentation/core-api/printk-formats.rst:
> 
> I was trying to find it in the standard c format specifier.  :(
> Thanks a lot for the pointer.
> 

No problem. Its worth a look through. The usual integer types are at the top, but that is followed by the pointer types which the kernel provides quite a few for a variety of things.

>>
>> kobjects
>> --------
>>
>> ::
>>
>>         %pOF[fnpPcCF]
>>
>>
>> For printing kobject based structs (device nodes). Default behaviour is
>> equivalent to %pOFf.
>>
>>         - f - device node full_name
>>         - n - device node name
>>         - p - device node phandle
>>         - P - device node path spec (name + @unit)
>>         - F - device node flags
>>         - c - major compatible string
>>         - C - full compatible string
>>
>>
>> -Tyrel
>>
> 

