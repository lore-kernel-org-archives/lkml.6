Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9E2C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B31DC218A3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbfBZSuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 13:50:10 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35917 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727580AbfBZSuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 13:50:10 -0500
Received: by mail-qt1-f195.google.com with SMTP id p25so16175739qtb.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 10:50:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=a8sLJQQ+GhNvebCn2znJiw1HXJG+0r7fno7t8mzGjbI=;
        b=axTFe0jb66JIkEeHViDBLvkJbplkBClFeOIozp5FEbP7CLJnNKlkI2FrMNHb8Ysa9W
         Yo0/KiM0FNb8qS37z0ArXP4ADI+f+6kG2qoNHix03LkJGJOszn54t2YiQ6VmOHthe3gB
         oiYiI0ltF/aI9JthrU+ip1uNLAVwoobuH6ShWzEu2HjIPoRLn/mCSaReRbDvqt9WhBiG
         qLt5MHmjRHhpAkoe/RcxguKUqp0WkjoY2JXyM6zTh1BopIV3ZcTnjcYOaLryTxYLAI8A
         hWn8XLG6mk4g6a3lDHJ28cXCVTksj6dglEY7DzljZD/mucFYjlZtUmizB2Gh3o7BXOLN
         G+4Q==
X-Gm-Message-State: AHQUAuaPZE1hPIzdBMQYHQrzR1HTXxuumwKJat1JMsh7k+vkNKGbbOKN
        47XHMJj4x62NwRwrTM9ePVdCFQ==
X-Google-Smtp-Source: AHgI3IZtrxEikHa82U7Zwd8zwoZigHvD8PzQ8nMH+xKAmOL30tg1Nc+TA0dkocxAZFq/90tvuBVkgg==
X-Received: by 2002:a0c:b90d:: with SMTP id u13mr18701977qvf.66.1551207009204;
        Tue, 26 Feb 2019 10:50:09 -0800 (PST)
Received: from redhat.com ([66.187.232.66])
        by smtp.gmail.com with ESMTPSA id j11sm9517049qtk.26.2019.02.26.10.50.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 10:50:08 -0800 (PST)
Date:   Tue, 26 Feb 2019 13:50:05 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>, somlo@cmu.edu,
        qemu-devel@nongnu.org, linux-kernel@vger.kernel.org
Subject: Re: [Qemu-devel] [PATCH] fw_cfg: use __ATTR_RO_MODE to define rev
 sysfs
Message-ID: <20190226134948-mutt-send-email-mst@kernel.org>
References: <20190226073159.13434-1-richardw.yang@linux.intel.com>
 <20190226110934-mutt-send-email-mst@kernel.org>
 <683d6fc9-bfdc-b2e5-e1b7-cd2d2711268e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <683d6fc9-bfdc-b2e5-e1b7-cd2d2711268e@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 07:47:35PM +0100, Philippe Mathieu-Daudé wrote:
> On 2/26/19 5:10 PM, Michael S. Tsirkin wrote:
> > On Tue, Feb 26, 2019 at 03:31:59PM +0800, Wei Yang wrote:
> >> Leverage __ATTR_RO_MODE to define rev sysfs instead of using open code
> >> to define the attribute.
> >>
> >> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> >> ---
> >>  drivers/firmware/qemu_fw_cfg.c | 13 ++++---------
> >>  1 file changed, 4 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
> >> index 039e0f91dba8..a1293cbd7adb 100644
> >> --- a/drivers/firmware/qemu_fw_cfg.c
> >> +++ b/drivers/firmware/qemu_fw_cfg.c
> >> @@ -296,18 +296,13 @@ static int fw_cfg_do_platform_probe(struct platform_device *pdev)
> >>  	return 0;
> >>  }
> >>  
> >> -static ssize_t fw_cfg_showrev(struct kobject *k, struct attribute *a, char *buf)
> >> +static ssize_t fw_cfg_rev_show(struct kobject *k, struct kobj_attribute *a,
> >> +			       char *buf)
> >>  {
> >>  	return sprintf(buf, "%u\n", fw_cfg_rev);
> >>  }
> >> -
> >> -static const struct {
> >> -	struct attribute attr;
> >> -	ssize_t (*show)(struct kobject *k, struct attribute *a, char *buf);
> >> -} fw_cfg_rev_attr = {
> >> -	.attr = { .name = "rev", .mode = S_IRUSR },
> >> -	.show = fw_cfg_showrev,
> >> -};
> >> +static const struct kobj_attribute fw_cfg_rev_attr =
> >> +	__ATTR_RO_MODE(fw_cfg_rev, 0400);
> >>  
> >>  /* fw_cfg_sysfs_entry type */
> >>  struct fw_cfg_sysfs_entry {
> > 
> > 
> > Looks like this will change the name from "rev" to "fw_cfg_rev".
> > That's a userspace visible change which we should not do lightly.
> 
> We could name the function rev_show but this stay fragile, we'd also
> need a comment "don't rename this".

It's a given that one must not rename attributes.

> >> -- 
> >> 2.19.1
> > 
