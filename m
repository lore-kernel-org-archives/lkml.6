Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4FFC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 21:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6886220841
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 21:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qCgQByCJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6886220841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbeJIFN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 01:13:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42578 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeJIFN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 01:13:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id g15-v6so19743715wru.9;
        Mon, 08 Oct 2018 14:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=qU0eRgmweVkgFEFZ1svtx4VKHMxtBUv/4ycPIHoxpXE=;
        b=qCgQByCJUlU8UHJ5mZgF54T70YF/UO6gy/aNO7joKdSeyzC9Iw5IT2dy+ABq6r11eX
         YAD1eyiGegWxBp5XlwgQNBmnEXCT/o02fS3B09In/e0ID1r89o3hB4KdEYpBgLMFXg7M
         6nhb3Gh+Na0P/Ebz3HRG71VzSe9k8EBBFkK9/DkL0X28wD9mdtEHtg+/hrbbznhHcLnN
         2euzcTUa61nnPPMhJx9IhsIHNg5RRzFgzt7LPbIj+H+FvP51PTskSC46eg5hFUACxG7G
         wtyPWw6cHD0Gnd1Ef9jLzqnPBNETVMOtqYlMI4TLgdcAu1wRcpW8PsY5N8XBG/uzVhUZ
         oCng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=qU0eRgmweVkgFEFZ1svtx4VKHMxtBUv/4ycPIHoxpXE=;
        b=XwkvLNDJjNHPo33fpfBU9CU/smUfRxtpugt4nV1Hwn/SzvQ6Q0b7x3K8v6mt4JH0sz
         8Im7IntlG965eQnYVi7JfcPu6TOhhXb5uPSO6QVPTBPu+oyCU/TImqNRagzNrJhOT5Nv
         4bn9nc/pyk/2KiCiuIniprEDGuoUhDaRUJSlJw5+SBPNeNwHcNBZ26LVYOm11IveMVRW
         UgTolnJ7Wmy/o5G8pV+eZDMoMKymREx9q0KdRcBVyJ5LscFL5d+TE2VU6PuujWx3fJZn
         ppciCuL1xJzpomhBcT35ji+QIf3xfC1sG6jktUKAQdlyTK2PKDVHkVyyj1/UNDWhEPfT
         iXKQ==
X-Gm-Message-State: ABuFfogSMy5sw87CXANUjeRl+zb+u7r9msIm9h2i/z0y5iHvWrHdgRnk
        fW5G835SqOMdMuki84y4288cWG2Z
X-Google-Smtp-Source: ACcGV60eOHOaWybrZ2+NLwM5QYqnPCcR0klNQaG9vsTSRv3RwITGvpTGouGmL7ds2UyyoDFq+SvtsA==
X-Received: by 2002:adf:f785:: with SMTP id q5-v6mr16651004wrp.86.1539035976329;
        Mon, 08 Oct 2018 14:59:36 -0700 (PDT)
Received: from [172.30.1.166] (nat-wv.mentorg.com. [192.94.38.34])
        by smtp.gmail.com with ESMTPSA id e21-v6sm10993073wma.8.2018.10.08.14.59.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 14:59:35 -0700 (PDT)
Subject: Re: [PATCH v4 02/11] gpu: ipu-csi: Swap fields according to
 input/output field types
To:     Philipp Zabel <p.zabel@pengutronix.de>, linux-media@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "open list:DRM DRIVERS FOR FREESCALE IMX" 
        <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>
References: <20181004185401.15751-1-slongerbeam@gmail.com>
 <20181004185401.15751-3-slongerbeam@gmail.com>
 <1538732679.3545.5.camel@pengutronix.de>
From:   Steve Longerbeam <slongerbeam@gmail.com>
Message-ID: <e2ae98c2-a6a3-19b9-bd85-664e5f80c4ab@gmail.com>
Date:   Mon, 8 Oct 2018 14:59:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1538732679.3545.5.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,


On 10/05/2018 02:44 AM, Philipp Zabel wrote:
> Hi Steve,
>
> On Thu, 2018-10-04 at 11:53 -0700, Steve Longerbeam wrote:
>
>
>> +
>> +		/* framelines for NTSC / PAL */
>> +		height = (std & V4L2_STD_525_60) ? 525 : 625;
> I think this is a bit convoluted. Instead of initializing std, then
> possibly changing it, and then comparing to the inital value, and then
> checking it again to determine the new height, why not just:
>
> 		if (width == 720 && height == 480) {
> 			std = V4L2_STD_NTSC;
> 			height = 525;
> 		} else if (width == 720 && height == 576) {
> 			std = V4L2_STD_PAL;
> 			height = 625;
> 		} else {
> 			dev_err(csi->ipu->dev,
> 				"Unsupported interlaced video mode\n");
> 			ret = -EINVAL;
> 			goto out_unlock;
> 		}
>
> ?

Yes that was a bit convoluted, fixed.

>
>>   
>>   	/*
>>   	 * if cycles is set, we need to handle this over multiple cycles as
>>   	 * generic/bayer data
>>   	 */
>> -	if (is_parallel_bus(&priv->upstream_ep) && incc->cycles) {
>> -		if_fmt.width *= incc->cycles;
> If the input format width passed to ipu_csi_init_interface is not
> multiplied by the number of cycles per pixel anymore, width in the
> CSI_SENS_FRM_SIZE register will be set to the unmultiplied value from
> infmt.
> This breaks 779680e2e793 ("media: imx: add support for RGB565_2X8 on
> parallel bus").

Oops, that was a mistake, thanks for catching, fixed.

Steve

