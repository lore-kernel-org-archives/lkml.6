Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9DEECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 19:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 775902154C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 19:39:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 775902154C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391355AbeIVBaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 21:30:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37960 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391335AbeIVBaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 21:30:10 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8LJdVFK111648
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 15:44:06 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mn3m88ccy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 15:44:05 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.vnet.ibm.com>;
        Fri, 21 Sep 2018 15:39:47 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 21 Sep 2018 15:39:44 -0400
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8LJdh7X852276
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 Sep 2018 19:39:43 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0FB23112065;
        Fri, 21 Sep 2018 15:39:11 -0400 (EDT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 29EC3112061;
        Fri, 21 Sep 2018 15:39:10 -0400 (EDT)
Received: from [9.41.179.222] (unknown [9.41.179.222])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 21 Sep 2018 15:39:10 -0400 (EDT)
Subject: Re: [PATCH v2 2/2] media: platform: Add Aspeed Video Engine driver
To:     Hans Verkuil <hverkuil@xs4all.nl>, linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, andrew@aj.id.au,
        openbmc@lists.ozlabs.org, robh+dt@kernel.org, mchehab@kernel.org,
        linux-media@vger.kernel.org
References: <1536866964-71593-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1536866964-71593-3-git-send-email-eajames@linux.vnet.ibm.com>
 <d1d58122-976b-b1dd-e4b4-bcc475219925@xs4all.nl>
 <cf333297-cc02-51c7-14a0-4d35bc1f8f07@linux.vnet.ibm.com>
 <66a5fbcf-2b41-ffd5-ad32-f26af47f3cea@xs4all.nl>
From:   Eddie James <eajames@linux.vnet.ibm.com>
Date:   Fri, 21 Sep 2018 14:39:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <66a5fbcf-2b41-ffd5-ad32-f26af47f3cea@xs4all.nl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18092119-0052-0000-0000-00000335128F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009747; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01091666; UDB=6.00564073; IPR=6.00871691;
 MB=3.00023439; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-21 19:39:47
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092119-0053-0000-0000-00005E2766DF
Message-Id: <f1847a48-ca7c-e9e9-c85c-860166cebcbc@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-21_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809210189
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/14/2018 12:31 PM, Hans Verkuil wrote:
> On 09/14/2018 05:22 PM, Eddie James wrote:
>>>> +static int aspeed_video_allocate_cma(struct aspeed_video *video)
>>>>
<snip>
>>>> +	if (rc) {
>>>> +		v4l2_device_unregister(v4l2_dev);
>>>> +		dev_err(video->dev, "Failed to register video device\n");
>>>> +		return rc;
>>>> +	}
>>>> +
>>>> +	video->v4l2_fmt.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
>>>> +	video->v4l2_fmt.fmt.pix.pixelformat = V4L2_PIX_FMT_JPEG;
>>>> +	video->v4l2_fmt.fmt.pix.field = V4L2_FIELD_NONE;
>>>> +	video->v4l2_fmt.fmt.pix.colorspace = V4L2_COLORSPACE_JPEG;
>>> COLORSPACE_JPEG is deprecated. Use V4L2_COLORSPACE_SRGB for pix.colorspace
>>> and set pix.quantization to V4L2_QUANTIZATION_FULL_RANGE.

FYI I'm getting a v4l2-compliance failure using your suggestion:

Format ioctls:
         test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
         test VIDIOC_G/S_PARM: OK
         test VIDIOC_G_FBUF: OK (Not Supported)
         fail: 
../../../v4l-utils-1.12.3/utils/v4l2-compliance/v4l2-test-formats.cpp(331): 
pixelformat == V4L2_PIX_FMT_JPEG && colorspace != V4L2_COLORSPACE_JPEG
         fail: 
../../../v4l-utils-1.12.3/utils/v4l2-compliance/v4l2-test-formats.cpp(436): 
testColorspace(pix.pixelformat, pix.colorspace, pix.ycbcr_enc, 
pix.quantization)
         test VIDIOC_G_FMT: FAIL

This is with v4l-utils commit d977e20a45a03543c4bdfeb3aef5211446de7398.

>>>
>>>> +
>>>> +	/* Don't fail the probe if controls init fails */
>>>> +	v4l2_ctrl_handler_init(&video->v4l2_ctrl, 2);
>>>> +
<snip>
>>>> ve,
>>>> +};
>>>> +
>>>> +module_platform_driver(aspeed_video_driver);
>>>> +
>>>> +MODULE_DESCRIPTION("ASPEED Video Engine Driver");
>>>> +MODULE_AUTHOR("Eddie James");
>>>> +MODULE_LICENSE("GPL v2");
>>>>
>>> I don't like the read() API here. It is not a real read() either since it assumes
>>> userspace reads full frames at a time. But if you read e.g. one byte at a time,
>>> then each byte is just the first byte of a different frame.
>> Yea...
>>
>>> I think we need to figure out how to make the stream I/O version just as fast
>>> if not faster as the read() API.

I do have the streaming API working with good performance now. Will get 
another patch set up soon.

Thanks,
Eddie

>> OK, I'll see what I can do.
>>
>> Thanks for the review!
>> Eddie
>>
>>> Regards,
>>>
>>> 	Hans
>>>
> Regards,
>
> 	Hans
>

