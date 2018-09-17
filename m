Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28D7ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E0CC2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:59:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E0CC2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbeIQO0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 10:26:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42694 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbeIQO0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 10:26:25 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 898ADAD2;
        Mon, 17 Sep 2018 08:59:56 +0000 (UTC)
Date:   Mon, 17 Sep 2018 10:59:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     georgi.djakov@linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] interconnect: Fix a GCC compiler warning
Message-ID: <20180917085954.GA23740@kroah.com>
References: <1537108310-2086-1-git-send-email-zhongjiang@huawei.com>
 <5B9F6B8B.7020100@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5B9F6B8B.7020100@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 04:53:31PM +0800, zhong jiang wrote:
> +to Greg and Andrew.
> 
> On 2018/9/16 22:31, zhong jiang wrote:
> > Fix the following compile warning:
> >
> > drivers/interconnect/core.c:26:23: warning: ‘icc_debugfs_dir’ defined but not used [-Wunused-variable]
> >  static struct dentry *icc_debugfs_dir;
> >
> > Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> > ---
> >  drivers/interconnect/core.c | 3 +++

This file is not in a released tree, where are you seeing it?

> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> > index 2740f1a..9ea9959 100644
> > --- a/drivers/interconnect/core.c
> > +++ b/drivers/interconnect/core.c
> > @@ -23,7 +23,10 @@
> >  static DEFINE_IDR(icc_idr);
> >  static LIST_HEAD(icc_provider_list);
> >  static DEFINE_MUTEX(icc_lock);
> > +
> > +#ifdef CONFIG_DEBUG_FS
> >  static struct dentry *icc_debugfs_dir;
> > +#endif

Why not move the variable to where it is used?  It should be able to go
under an existing #ifdef section, right?

thanks,

greg k-h
