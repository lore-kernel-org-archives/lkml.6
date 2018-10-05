Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B55C65BBE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C0E020875
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:03:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C0E020875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbeJFDDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 23:03:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52334 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728160AbeJFDDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 23:03:34 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w95K1k98138078
        for <linux-kernel@vger.kernel.org>; Fri, 5 Oct 2018 16:03:17 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mxedmgjmd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 16:03:17 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.vnet.ibm.com>;
        Fri, 5 Oct 2018 16:03:16 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 5 Oct 2018 16:03:14 -0400
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w95K3D2w2032104
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 Oct 2018 20:03:13 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0FD542805E;
        Fri,  5 Oct 2018 16:00:48 -0400 (EDT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3445C28058;
        Fri,  5 Oct 2018 16:00:47 -0400 (EDT)
Received: from [9.41.179.222] (unknown [9.41.179.222])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  5 Oct 2018 16:00:47 -0400 (EDT)
Subject: Re: [PATCH v3 2/2] media: platform: Add Aspeed Video Engine driver
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Eddie James <eajames@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, andrew@aj.id.au,
        openbmc@lists.ozlabs.org, robh+dt@kernel.org, mchehab@kernel.org,
        linux-media@vger.kernel.org
References: <1537903629-14003-1-git-send-email-eajames@linux.ibm.com>
 <1537903629-14003-3-git-send-email-eajames@linux.ibm.com>
 <a78d4c7a-ac58-c23d-a683-23dce54be993@xs4all.nl>
 <ca4757b9-0825-bbbf-b388-0295fd13bad7@linux.vnet.ibm.com>
 <373d2ca3-a6cd-8d87-2bbc-613d65305170@xs4all.nl>
From:   Eddie James <eajames@linux.vnet.ibm.com>
Date:   Fri, 5 Oct 2018 15:03:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <373d2ca3-a6cd-8d87-2bbc-613d65305170@xs4all.nl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18100520-0040-0000-0000-0000047BE17A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009825; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01098370; UDB=6.00568107; IPR=6.00878411;
 MB=3.00023633; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-05 20:03:16
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100520-0041-0000-0000-00000883EE81
Message-Id: <8476027d-80d5-2787-944b-eb3f5af717c3@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-05_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810050191
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/04/2018 08:12 AM, Hans Verkuil wrote:
> On 10/03/18 22:43, Eddie James wrote:
>>
>> On 09/28/2018 06:30 AM, Hans Verkuil wrote:
>>> On 09/25/2018 09:27 PM, Eddie James wrote:
>>>> The Video Engine (VE) embedded in the Aspeed AST2400 and AST2500 SOCs
>>>> can capture and compress video data from digital or analog sources. With
>>>> the Aspeed chip acting a service processor, the Video Engine can capture
>>>> the host processor graphics output.
>>>>
>>>> Add a V4L2 driver to capture video data and compress it to JPEG images.
>>>> Make the video frames available through the V4L2 streaming interface.
>>>>
>>>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>>>> +	}
>>>> +
>>>> +	video->height = (bottom - top) + 1;
>>>> +	video->width = (right - left) + 1;
>>>> +	size = video->height * video->width;
>>> It looks like you can actually determine the blanking width/height and
>>> possibly even more detailed information that would be very useful to
>>> show with the DV_TIMINGS ioctls.
>> Hmm. This information is related to the video signal captured from the
>> host. That information has nothing to do with the buffer that is
>> compressed and grabbed by the driver and ultimately provided to
>> userspace. Isn't the timing information meaningless for JPEG frames?
> It helps in debugging. Basically you are implementing a receiver for a
> video signal. So if for some reason you cannot support the video timings
> that the host sends, then it is very useful to have QUERY_DV_TIMINGS report
> as much information about the signal as possible.
>
> BTW, out of curiosity, how are the host video signals connected to the
> aspeed? Is it still a VGA video signal?
>
> Looking at product briefs it appears that it is VGA. So I guess the aspeed
> 'sniffs' the VGA signals from the host and can capture the video that way.
> Is that correct?

I believe it is a VGA signal from the host, but the Aspeed Video Engine 
somewhat abstracts that away; not all the signal information that the 
engine is receiving is available to the BMC interface. I did add the 
timing information I could access to the latest patch set. As you say, 
it could be useful for debugging if weird things are happening.

Thanks!
Eddie

>
> If so, then this driver is a VGA receiver and should act like that.
> The host can configure its VGA transmitter to invalid timings, or weird
> values, and you need to be able to handle that in your driver.
>
>> Forgot to include this question in my previous reply, sorry for the
>> additional mail.
> No problem! Happy to help.
>
> Regards,
>
> 	Hans
>

