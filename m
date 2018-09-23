Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1603EC433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 05:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD3D820989
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 05:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gz5dlSIj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD3D820989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbeIWLQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 07:16:52 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43740 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbeIWLQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 07:16:52 -0400
Received: by mail-pf1-f193.google.com with SMTP id j26-v6so7670634pfi.10;
        Sat, 22 Sep 2018 22:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RhTJtTmI8/Ay10FGFY/CKc0rIkGlDASoSU8nbP0g8qo=;
        b=Gz5dlSIj5/hxByJpuqJe+1h2OMCcM82qolGplJgdpjNQYB4/6HOgCPzQHE+bwQdTHf
         CwS5uY2oPyJLUf/o3R1SP2zXfiq5FsURJm0p49OSKNPgbK8rMOJ/e7JJotMY/zfPRSIR
         6feGKMBfxubJGaiRok9TCzl6+5B/OqcLCZUyxhUnTHHQm1YdOw8vIeoXNDG3MuxSUsVK
         OV3l9EWrM3tUx1RlyUbWHWH81lzjlUhixJMnAp6MOJPw86DWWh3vL4r/vXs7+Aja3p8I
         S0ho+5RGmOaDTXuz9OS/sPSjmDqxj+k1mHM140aVBakp8p2UW15gZvVzIm0Q55A45vQH
         k1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RhTJtTmI8/Ay10FGFY/CKc0rIkGlDASoSU8nbP0g8qo=;
        b=LRrFm06Yf70rjEPp0YH+s5OdVQjaLRoXVkRuhCLRNINwxpoTrSVBnkuD68Eacks3dD
         90PQmJrLNBlq/FglmmT5fyOY9vAORM15Jay4K8Xi/BuUyaW4I3wmoTExfN8SexNkDIyx
         GcajRmAtY7Iwyf4YXTBeMmA77GMDCPBftZImma0pMQmFd8SXBtbn20uh8j5jLVGwg8bb
         XLO67jbkPkzApIU98U8H+IRpZW9wT1D0FhnmDdTMSgBOUcOpUD7SLBIwHc81l5/h6bM7
         Ui0tGHh0RXmeYBFNkWGyC/2M75++SjBkjN6g39hfa+qqoeX2eE9EjkspW0FvLdsbO8ow
         U6Iw==
X-Gm-Message-State: ABuFfogKwIjkuuGfWMQvKwDVtMCo182usrW2mBqJHWtyMeD/+EIfpnjM
        78Um60KMth8hlsU0N4TVF54=
X-Google-Smtp-Source: ANB0VdYNHCBXNCLQYRrdeeMCJRwCbv0ZeuZf7CNsDy72XwQCRcu2yk2WfB49JTbeOdLOaF6h1MQQvg==
X-Received: by 2002:a63:8e43:: with SMTP id k64-v6mr523494pge.75.1537680042202;
        Sat, 22 Sep 2018 22:20:42 -0700 (PDT)
Received: from Asurada (c-73-231-2-134.hsd1.ca.comcast.net. [73.231.2.134])
        by smtp.gmail.com with ESMTPSA id y86-v6sm44980020pfk.84.2018.09.22.22.20.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 22:20:42 -0700 (PDT)
Date:   Sat, 22 Sep 2018 22:20:36 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        corbet@lwn.net, afd@ti.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 2/2] hwmon: ina3221: Read channel input source info
 from DT
Message-ID: <20180923052036.GA9960@Asurada>
References: <20180923041118.8743-1-nicoleotsuka@gmail.com>
 <20180923041118.8743-3-nicoleotsuka@gmail.com>
 <6f179232-9114-f403-ee35-2495cea73318@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f179232-9114-f403-ee35-2495cea73318@roeck-us.net>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for the quick response!

On Sat, Sep 22, 2018 at 10:11:26PM -0700, Guenter Roeck wrote:
> >+static umode_t ina3221_attr_is_visible(struct kobject *kobj,
> >+				       struct attribute *attr, int n)
> >+{
> >+	const int max_attrs = ARRAY_SIZE(ina3221_attrs) - 1;
> >+	const int num_attrs = max_attrs / INA3221_NUM_CHANNELS;
> >+	struct device *dev = kobj_to_dev(kobj);
> >+	struct ina3221_data *ina = dev_get_drvdata(dev);
> >+	enum ina3221_channels channel = n / num_attrs;
> 
> 	int index = n % num_attrs;
> 
> >+	struct ina3221_input *input = &ina->inputs[channel];
> >+	int i;
> >+
> >+	/* Hide if channel input source is disconnected */
> >+	if (input->disconnected)
> >+		return 0;
> >+
> >+	/* Hide label node if label is not provided */
> 
> 	if (index == 1 && !input->label)
> 		return 0;
> 
> and drop i, ina3221_label_attrs[], and the loop below.

Will do that in v5.

Thanks
Nicolin
