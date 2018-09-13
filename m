Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC9DC43143
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 19:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA8321480
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 19:00:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FA8321480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbeINALo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 20:11:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45624 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726839AbeINALo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 20:11:44 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8DIrbr6092057
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 15:00:55 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mfvgh2gf7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 15:00:55 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.vnet.ibm.com>;
        Thu, 13 Sep 2018 15:00:54 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 13 Sep 2018 15:00:49 -0400
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8DJ0m8a42991714
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 Sep 2018 19:00:48 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34C5DAC060;
        Thu, 13 Sep 2018 15:00:31 -0400 (EDT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1696DAC05F;
        Thu, 13 Sep 2018 15:00:24 -0400 (EDT)
Received: from oc6728276242.ibm.com (unknown [9.85.164.21])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 13 Sep 2018 15:00:23 -0400 (EDT)
Subject: Re: [PATCH 4/4] media: platform: Add Aspeed Video Engine driver
To:     Hans Verkuil <hverkuil@xs4all.nl>, linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, andrew@aj.id.au,
        openbmc@lists.ozlabs.org, sboyd@kernel.org,
        mturquette@baylibre.com, robh+dt@kernel.org, mchehab@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-media@vger.kernel.org
References: <1535576973-8067-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1535576973-8067-5-git-send-email-eajames@linux.vnet.ibm.com>
 <77243417-e832-dcfa-0eeb-d45f356dd9e8@xs4all.nl>
From:   Eddie James <eajames@linux.vnet.ibm.com>
Date:   Thu, 13 Sep 2018 14:00:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <77243417-e832-dcfa-0eeb-d45f356dd9e8@xs4all.nl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18091319-0052-0000-0000-000003303BDC
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009715; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01087835; UDB=6.00561768; IPR=6.00867847;
 MB=3.00023274; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-13 19:00:52
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091319-0053-0000-0000-00005E0F98E7
Message-Id: <5cd805fa-31e9-a011-f8cd-32590125f136@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-13_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809130191
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/03/2018 06:40 AM, Hans Verkuil wrote:
> On 08/29/2018 11:09 PM, Eddie James wrote:
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
> Missing MAINTAINERS file update.
>
>>   3 files changed, 1316 insertions(+)
>>   create mode 100644 drivers/media/platform/aspeed-video.c
>> +
>> +static void aspeed_video_init_jpeg_table(u32 *table, bool yuv420)
>> +{
>> +	int i;
>> +	unsigned int base;
>> +
>> +	for (i = 0; i < ASPEED_VIDEO_JPEG_NUM_QUALITIES; i++) {
>> +		int j;
>> +
>> +		base = 256 * i;	/* AST HW requires this header spacing */
>> +
>> +		for (j = 0; j < ASPEED_VIDEO_JPEG_HEADER_SIZE; j++)
>> +			table[base + j] =
>> +				le32_to_cpu(aspeed_video_jpeg_header[j]);
> This doesn't look right. These tables are in cpu format to begin with,
> so le32_to_cpu doesn't make sense.
>
> BTW, what is the endianness of an aspeed SoC?

Hi,

Yes, Aspeed SoCs are LE, it's a standard ARM core. I'll do a simple copy 
instead of converting endianness, since this code can really only run on 
an Aspeed chip anyway.

>
>> +
>> +		base += ASPEED_VIDEO_JPEG_HEADER_SIZE;
>> +		for (j = 0; j < ASPEED_VIDEO_JPEG_DCT_SIZE; j++)
>> +			table[base + j] =
>> +				le32_to_cpu(aspeed_video_jpeg_dct[i][j]);
>> +
>> +		base += ASPEED_VIDEO_JPEG_DCT_SIZE;
>> +		for (j = 0; j < ASPEED_VIDEO_JPEG_QUANT_SIZE; j++)
>> +			table[base + j] =
>> +				le32_to_cpu(aspeed_video_jpeg_quant[j]);
>> +
>> +		if (yuv420)
>> +			table[base + 2] = le32_to_cpu(0x00220103);
>> +	}
>> +}
>> +
>> +
>> +static int aspeed_video_querycap(struct file *file, void *fh,
>> +				 struct v4l2_capability *cap)
>> +{
>> +	struct aspeed_video *video = video_drvdata(file);
>> +
>> +	strncpy(cap->driver, DEVICE_NAME, sizeof(cap->driver));
> Use strlcpy.
>
> Also fill in bus_info ("platform:<foo>").
>
>> +	cap->capabilities = video->vdev.device_caps | V4L2_CAP_DEVICE_CAPS;
> You can drop this, it's filled in for you.
>
>> +
>> +	return 0;
>> +}
>> +
>> +static int aspeed_video_get_format(struct file *file, void *fh,
>> +				   struct v4l2_format *f)
>> +{
>> +	int rc;
>> +	struct aspeed_video *video = video_drvdata(file);
>> +
>> +	if (test_bit(VIDEO_RES_CHANGE, &video->flags)) {
>> +		if (file->f_flags & O_NONBLOCK)
>> +			return -EAGAIN;
>> +
>> +		rc = wait_event_interruptible(video->wait,
>> +					      !test_bit(VIDEO_RES_CHANGE,
>> +							&video->flags));
>> +		if (rc)
>> +			return -EINTR;
> No, get_format should always just return the currently set format,
> not the format that is detected.
>
> Use VIDIOC_QUERY_DV_TIMINGS for that.
>
>> +	}
>> +
>> +	f->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
> Drop this, not needed.
>
>> +	f->fmt.pix = video->fmt;
>> +
>> +	return 0;
>> +}
>> +
>> +static int aspeed_video_set_format(struct file *file, void *fh,
>> +				   struct v4l2_format *f)
>> +{
>> +	struct aspeed_video *video = video_drvdata(file);
>> +
>> +	if (f->fmt.pix.pixelformat == video->fmt.pixelformat)
>> +		return 0;
>> +
>> +	if (f->fmt.pix.pixelformat == V4L2_PIX_FMT_YUV444) {
>> +		video->fmt.pixelformat = V4L2_PIX_FMT_YUV444;
>> +		aspeed_video_init_jpeg_table(video->jpeg.virt, false);
>> +		aspeed_video_update(video, VE_SEQ_CTRL, ~VE_SEQ_CTRL_YUV420,
>> +				    0);
>> +	} else if (f->fmt.pix.pixelformat == V4L2_PIX_FMT_YUV420) {
>> +		video->fmt.pixelformat = V4L2_PIX_FMT_YUV420;
>> +		aspeed_video_init_jpeg_table(video->jpeg.virt, true);
>> +		aspeed_video_update(video, VE_SEQ_CTRL, 0xFFFFFFFF,
>> +				    VE_SEQ_CTRL_YUV420);
> This isn't filling in any of the other fields.
>
>> +	} else {
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int aspeed_video_get_jpegcomp(struct file *file, void *fh,
>> +				     struct v4l2_jpegcompression *a)
>> +{
>> +	struct aspeed_video *video = video_drvdata(file);
>> +
>> +	a->quality = video->jpeg_quality;
>> +
>> +	return 0;
>> +}
>> +
>> +static int aspeed_video_set_jpegcomp(struct file *file, void *fh,
>> +				     const struct v4l2_jpegcompression *a)
>> +{
>> +	u32 comp_ctrl;
>> +	struct aspeed_video *video = video_drvdata(file);
>> +
>> +	if (a->quality < 0 || a->quality > 11)
>> +		return -EINVAL;
>> +
>> +	video->jpeg_quality = a->quality;
>> +	comp_ctrl = FIELD_PREP(VE_COMP_CTRL_DCT_LUM, video->jpeg_quality) |
>> +		FIELD_PREP(VE_COMP_CTRL_DCT_CHR, video->jpeg_quality | 0x10);
>> +
>> +	aspeed_video_update(video, VE_COMP_CTRL,
>> +			    ~(VE_COMP_CTRL_DCT_LUM | VE_COMP_CTRL_DCT_CHR),
>> +			    comp_ctrl);
>> +
>> +	return 0;
>> +}
> As the spec says, the jpegcomp ioctls are deprecated and you should use
> JPEG controls instead.
>
> See: https://hverkuil.home.xs4all.nl/spec/uapi/v4l/vidioc-g-jpegcomp.html
>
> I stop reviewing here, since the first thing you need to do is to run
> v4l2-compliance for your device driver.
>
> See my reply to patch 0/4.
>
> Regards,
>
> 	Hans

Thanks for all the comments! I have addressed these items and will push 
up another patch set.

Thanks,
Eddie

>
>> +
>> +static int aspeed_video_get_parm(struct file *file, void *fh,
>> +				 struct v4l2_streamparm *a)
>> +{
>> +	struct aspeed_video *video = video_drvdata(file);
>> +
>>

