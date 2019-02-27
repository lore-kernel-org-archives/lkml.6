Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0502CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDCA420C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730413AbfB0NzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 08:55:03 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45780 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbfB0NzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 08:55:02 -0500
Received: by mail-qt1-f194.google.com with SMTP id d18so19154551qtg.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 05:55:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lXTT7v/OcaGCd8kGckOpuXMVZJdiwMInqsH8yOcDNpY=;
        b=MSsTjAmIKObUy/EJkCnNMCpkS4e7veUe6uN1nkiXlT4GE3hmrYjZ+DTKOUy735lgS/
         //WIfQ8xjjYjATYn53heKr5ekK/uVPLOyi5vJTibEAoU44H5PIGBh6f77rKJcZzIhe1J
         ff385ysrGvYH3TT+12Nei48CsdfCyYMYbK/n6dtCygiK4tqLt+D1SLdubYsENurCN1GW
         KcTXzXdg0aNkLx/YSryG2pzrMPEtkxtYM3kufwQ7+VSYx1fpivpZu+oSGk1DVLz7Y+Dy
         fJxjKttdXh3sK4DuWuhaKnQpDAdBffhMlIUQrSZQ+5C8YP27di0YBbeEo+N0Y+WFRzZj
         8s9Q==
X-Gm-Message-State: APjAAAVBdrEBaNo+b0+BIpwNNYJ8rpWL2T0PggyK1umQbOpyoMIDJ+tm
        jUr0dW5C8NsCQMW/raH0Go5g7R9ZRjdwgQ==
X-Google-Smtp-Source: APXvYqx4QPYkS/0aXhBYEmnYIQ+xQEQ7YIcUFClY52WS6S8F6V9Rz+H1k2zozYh0KBNxSQH7jsFssg==
X-Received: by 2002:a0c:9804:: with SMTP id c4mr1989890qvd.120.1551275701487;
        Wed, 27 Feb 2019 05:55:01 -0800 (PST)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id v31sm12052554qtc.62.2019.02.27.05.55.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Feb 2019 05:55:00 -0800 (PST)
Date:   Wed, 27 Feb 2019 08:54:58 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
        qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, somlo@cmu.edu
Subject: Re: [Qemu-devel] [PATCH] fw_cfg: use __ATTR_RO_MODE to define rev
 sysfs
Message-ID: <20190227085442-mutt-send-email-mst@kernel.org>
References: <20190226073159.13434-1-richardw.yang@linux.intel.com>
 <bf6ad77d-6514-57b3-141b-530f46500b57@redhat.com>
 <20190227030715.GA5449@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190227030715.GA5449@richard>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 11:07:16AM +0800, Wei Yang wrote:
> On Tue, Feb 26, 2019 at 07:45:46PM +0100, Philippe Mathieu-Daudé wrote:
> >Hi Wei,
> >
> >On 2/26/19 8:31 AM, Wei Yang wrote:
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
> >
> >Why not keep S_IRUSR?
> >
> 
> Because scripts/checkpatch.pl suggest not use S_IRUSR :-)
> 
> I am not sure about the particular reason.

Oh yea.

http://lkml.kernel.org/r/CA+55aFw5v23T-zvDZp-MmD_EYxF8WbafwwB59934FV7g21uMGQ@mail.gmail.com

maybe mention this in the commit log.

> >>  
> >>  /* fw_cfg_sysfs_entry type */
> >>  struct fw_cfg_sysfs_entry {
> >> 
> 
> -- 
> Wei Yang
> Help you, Help me
