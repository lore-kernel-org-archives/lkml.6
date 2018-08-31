Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86ED9C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 19:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F6782083C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 19:30:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F6782083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbeHaXjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 19:39:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39484 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726869AbeHaXjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 19:39:08 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7VJSvCc129552
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 15:30:11 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m7aqj2e7j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 15:30:11 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.vnet.ibm.com>;
        Fri, 31 Aug 2018 15:30:11 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 31 Aug 2018 15:30:06 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7VJU4wn28639314
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 31 Aug 2018 19:30:04 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC291B206B;
        Fri, 31 Aug 2018 15:28:57 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D697B2067;
        Fri, 31 Aug 2018 15:28:56 -0400 (EDT)
Received: from [9.41.179.222] (unknown [9.41.179.222])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 31 Aug 2018 15:28:56 -0400 (EDT)
Subject: Re: [PATCH 0/4] media: platform: Add Aspeed Video Engine driver
To:     Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Cc:     linux-media@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, andrew@aj.id.au, mchehab@kernel.org,
        joel@jms.id.au, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        mturquette@baylibre.com, linux-arm-kernel@lists.infradead.org
References: <1535576973-8067-1-git-send-email-eajames@linux.vnet.ibm.com>
 <153573819126.93865.1884182656081956202@swboyd.mtv.corp.google.com>
From:   Eddie James <eajames@linux.vnet.ibm.com>
Date:   Fri, 31 Aug 2018 14:30:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <153573819126.93865.1884182656081956202@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18083119-2213-0000-0000-000002E64037
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009646; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01081639; UDB=6.00558036; IPR=6.00861625;
 MB=3.00023040; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-31 19:30:10
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18083119-2214-0000-0000-00005B65A1E9
Message-Id: <a959a032-6817-dcb4-2c5f-b4bd17fc1c8b@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-31_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808310196
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/31/2018 12:56 PM, Stephen Boyd wrote:
> Quoting Eddie James (2018-08-29 14:09:29)
>> The Video Engine (VE) embedded in the Aspeed AST2400 and AST2500 SOCs
>> can capture and compress video data from digital or analog sources. With
>> the Aspeed chip acting as a service processor, the Video Engine can
>> capture the host processor graphics output.
>>
>> This series adds a V4L2 driver for the VE, providing a read() interface
>> only. The driver triggers the hardware to capture the host graphics output
>> and compress it to JPEG format.
>>
>> Testing on an AST2500 determined that the videobuf/streaming/mmap interface
>> was significantly slower than the simple read() interface, so I have not
>> included the streaming part.
>>
>> It's also possible to use an automatic mode for the VE such that
>> re-triggering the HW every frame isn't necessary. However this wasn't
>> reliable on the AST2400, and probably used more CPU anyway due to excessive
>> interrupts. It was approximately 15% faster.
>>
>> The series also adds the necessary parent clock definitions to the Aspeed
>> clock driver, with both a mux and clock divider.
> Please let me know your merge strategy here. I can ack the clk patches
> because they look fine from high-level clk driver perspective (maybe
> Joel can take a closer look) or I can merge the patches into clk-next
> and get them into next release while the video driver gets reviewed.

Thanks for taking a look! Probably preferable to get the clk patches 
into clk-next first (though Joel reviewing would be great). I just put 
everything in the same set for the sake of explaining the necessity of 
the clk changes.

Thanks,
Eddie

>

