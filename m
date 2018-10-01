Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45A0C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 03:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6796D2084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 03:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tu42LR69"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6796D2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbeJAKDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 06:03:55 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42690 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727287AbeJAKDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 06:03:55 -0400
Received: by mail-pg1-f193.google.com with SMTP id i4-v6so7801315pgq.9;
        Sun, 30 Sep 2018 20:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kxBaaWYbk8uXGcWGxYraCagkZvNtzkvoICpOMaJmaLE=;
        b=tu42LR69WX7TGfKHSlLGiIAl0KHbUXDejYKtIXhHyLfJ+45Qv3ZFs2a8QUD9Y4JJ/A
         VJ35dbCRUwycU6r2d56CG/QfW9u8lVQFYojzv3gTzgztHYfs6GM2w7B7Hp2pfCNleF3x
         lagDW5XrpaJAr+TDHiVCvREx/5iepHNDYJssCWOIS0s6PJXOZlMNfxeMfFMqEAqN3U2j
         wdKM0v5OEVokxNSVY8HU5FB9Np9GU6qcT0ug0155/vFlKisXq7ikEALKGn4H/4IIHvBm
         D12LRXwAxz9bMqKAmIrSv9l0aUOxocYteBoeKicVYYw0wUYY0sxr6msEQb9G2DlHn6OJ
         KzNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kxBaaWYbk8uXGcWGxYraCagkZvNtzkvoICpOMaJmaLE=;
        b=FDTEPxm0jWvlhx41kPwJzVY15lF4PhxN6/L7I5JYS/xFSByFkJZ4SByzxGbL+NzXQe
         d13xvb+OniJCHOvK7lY5whq7lcSYsQWv7tKTkPZh6xMOBQSBuPuNBWrGclOFOA/xqY+g
         s8myWxHLYq4v2ncVvI99WA1/dBuENkgEsyqKlzRTXU37xpWtXxc08Y8oTdOygYE8a6vV
         ZnULsAJdNEWzwd8fR5ad8bouLP9HYwIj/RwhJJCw1MKePzZjRSokc8d6DZtzmZkFrMcW
         U5uh48PJ+IaBfT3lnvtIzsOPy2H5QqDb8wpB19Tm5kDZp9e9iTJO3HFUpcXK+pun4Zk9
         VObg==
X-Gm-Message-State: ABuFfojJEk+eV44MpjT8zvyo/DuTYf7yCQQJ3idOWOF5lDiROqVMhcrJ
        /bsQIhyGf0vWmd6nTIH1+/k=
X-Google-Smtp-Source: ACcGV61tWVV2ferK8Pq7qNroecU/lyNyhM0gngSxPuEgYGgpqYj9CHF5xtZL8Cgqk4VB5xWID7bkYg==
X-Received: by 2002:a17:902:710e:: with SMTP id a14-v6mr9843376pll.179.1538364496284;
        Sun, 30 Sep 2018 20:28:16 -0700 (PDT)
Received: from Asurada (c-73-231-2-134.hsd1.ca.comcast.net. [73.231.2.134])
        by smtp.gmail.com with ESMTPSA id r23-v6sm2260961pfh.79.2018.09.30.20.28.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 20:28:15 -0700 (PDT)
Date:   Sun, 30 Sep 2018 20:28:10 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        corbet@lwn.net, afd@ti.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v8 2/2] hwmon: ina3221: Read channel input source info
 from DT
Message-ID: <20181001032809.GB4428@Asurada>
References: <20180929013937.29289-1-nicoleotsuka@gmail.com>
 <20180929013937.29289-3-nicoleotsuka@gmail.com>
 <ab3a36dc-fa5a-4669-2f99-aa55a4083db2@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab3a36dc-fa5a-4669-2f99-aa55a4083db2@roeck-us.net>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 30, 2018 at 01:55:18PM -0700, Guenter Roeck wrote:
> Hi Nicolin,
> 
> On 09/28/2018 06:39 PM, Nicolin Chen wrote:
> >An ina3221 chip has three input ports. Each port is used
> >to measure the voltage and current of its input source.
> >
> >The DT binding now has defined bindings for their input
> >sources, so the driver should read these information and
> >handle accordingly.
> >
> >This patch adds a new structure of input source specific
> >information including input source label, shunt resistor
> >value and its connection status. It exposes these labels
> >via in[123]_label sysfs nodes upon available, and also
> >disables those channels where there are no input source
> >being connected. Meanwhile, it also adds in[123]_enable
> >sysfs nodes for users to get control of three channels,
> >and returns -ENODATA code for any sensor read according
> >to hwmon ABI.
> >
> >Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> 
> [ ... ]
> 
> >+
> >+static ssize_t ina3221_set_enable(struct device *dev,
> >+				  struct device_attribute *attr,
> >+				  const char *buf, size_t count)
> >+{
> >+	struct sensor_device_attribute *sd_attr = to_sensor_dev_attr(attr);
> >+	struct ina3221_data *ina = dev_get_drvdata(dev);
> >+	unsigned int channel = sd_attr->index;
> >+	u16 config = ina->reg_config;
> >+	bool enable;
> >+	int ret;
> >+
> >+	ret = kstrtobool(buf, &enable);
> >+	if (ret)
> >+		return ret;
> >+
> >+	if (enable)
> >+		config |= INA3221_CONFIG_CHx_EN(channel);
> >+	else
> >+		config &= ~INA3221_CONFIG_CHx_EN(channel);
> >+
> >+	ret = regmap_write(ina->regmap, INA3221_CONFIG, config);
> >+	if (ret)
> >+		return ret;
> >+
> >+	ina->reg_config = config;
> >+
> 
> Sorry it too me so long to realize this: The code above is racy.
> There could be multiple threads enabling and disabling a channel.
> Without a mutex, there is no guarantee that the final value of
> reg_config matches the value written into the chip.

Hmm..that's true...glad you found and pointed it out.

> You'll have to introduce a mutex and implement something like
> 	ret = kstrtobool(buf, &enable);
> 	if (ret)
> 		return ret;
> 
> 	mutex_lock(&ina->update_lock);
> 	config = ina->reg_config;
> 	...
> 	ret = regmap_write(ina->regmap, INA3221_CONFIG, config);
> 	if (ret) {
> 		count = ret;
> 		goto error;
> 	}
> 	ina->reg_config = config;
> error:
> 	mutex_unlock(&ina->update_lock);
> 	return count;

I would prefer to just add another regmap_read at the end for
the reg_config sync, and to use regmap_update_bits() for the
bit set/clear. It might not serialize things as the solution
above does but at least the reg_config would get the correct
value eventually. Since regmap has an internal mutex already,
we may get rid of another mutex by doing so.

I will send a v9 tomorrow.

Thanks for the review
Nicolin
