Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9E0C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E661B20658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:40:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E661B20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbeH3TnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:43:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36730 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727449AbeH3TnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:43:21 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7UFdUIx066485
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 11:40:36 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m6k2a12a8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 11:40:36 -0400
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.vnet.ibm.com>;
        Thu, 30 Aug 2018 09:40:35 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e36.co.us.ibm.com (192.168.1.136) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 30 Aug 2018 09:40:31 -0600
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7UFeU1524707316
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 Aug 2018 08:40:30 -0700
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50FD06A06D;
        Thu, 30 Aug 2018 09:40:30 -0600 (MDT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CDA216A047;
        Thu, 30 Aug 2018 09:40:22 -0600 (MDT)
Received: from oc6728276242.ibm.com (unknown [9.85.221.248])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 30 Aug 2018 09:40:22 -0600 (MDT)
Subject: Re: [PATCH 4/4] media: platform: Add Aspeed Video Engine driver
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        andrew@aj.id.au, Mauro Carvalho Chehab <mchehab@kernel.org>,
        joel@jms.id.au, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <1535576973-8067-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1535576973-8067-5-git-send-email-eajames@linux.vnet.ibm.com>
 <CAAEAJfBpmFPLTMAr+Azc-53JXHPkCU4bjtwqE6nDWUvm=J_x-A@mail.gmail.com>
From:   Eddie James <eajames@linux.vnet.ibm.com>
Date:   Thu, 30 Aug 2018 10:40:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAAEAJfBpmFPLTMAr+Azc-53JXHPkCU4bjtwqE6nDWUvm=J_x-A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18083015-0020-0000-0000-00000E5B5E22
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009639; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01081084; UDB=6.00557701; IPR=6.00861068;
 MB=3.00023018; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-30 15:40:35
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18083015-0021-0000-0000-000062DBB5E7
Message-Id: <7cb0c2f0-cc12-81a6-a858-40776ec5904c@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-30_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808300162
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/29/2018 07:52 PM, Ezequiel Garcia wrote:
> Hi Eddie,
>
> On 29 August 2018 at 18:09, Eddie James <eajames@linux.vnet.ibm.com> wrote:
>> The Video Engine (VE) embedded in the Aspeed AST2400 and AST2500 SOCs
>> can capture and compress video data from digital or analog sources. With
>> the Aspeed chip acting a service processor, the Video Engine can capture
>> the host processor graphics output.
>>
>> Add a V4L2 driver to capture video data and compress it to JPEG images,
>> making the data available through a standard read interface.
>>
>> Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
>> ---
>>   drivers/media/platform/Kconfig        |    8 +
>>   drivers/media/platform/Makefile       |    1 +
>>   drivers/media/platform/aspeed-video.c | 1307 +++++++++++++++++++++++++++++++++
>>   3 files changed, 1316 insertions(+)
>>   create mode 100644 drivers/media/platform/aspeed-video.c
>>
>> diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
>> index 94c1fe0..e599245 100644
>> --- a/drivers/media/platform/Kconfig
>> +++ b/drivers/media/platform/Kconfig
>> @@ -32,6 +32,14 @@ source "drivers/media/platform/davinci/Kconfig"
>>
>>   source "drivers/media/platform/omap/Kconfig"
>>
>> +config VIDEO_ASPEED
>> +       tristate "Aspeed AST2400 and AST2500 Video Engine driver"
>> +       depends on VIDEO_V4L2
> It seems you are not using videobuf2. I think it should simplify the read
> I/O part and at the same time expose the other capture methods.

Hi,

Well I'm not sure it would simplify the read interface; it's quite 
simple as it is, both in the driver and to set up in user-space.

I did get streaming I/O working but found the performance significantly 
worse than simple read calls, and therefore not worth the additional 
complexity.

Is it required that I support streaming?

Thanks,
Eddie

>
> There are plenty of examples to follow.
>
> Regards,
> Eze
>

