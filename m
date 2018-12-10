Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D73C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 968C520821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:01:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 968C520821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbeLJUBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 15:01:42 -0500
Received: from mail5.windriver.com ([192.103.53.11]:36084 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727340AbeLJUBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 15:01:42 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id wBAK0fGS006780
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Mon, 10 Dec 2018 12:00:57 -0800
Received: from yow-pgortmak-d1.corp.ad.wrs.com (128.224.56.57) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.408.0; Mon, 10 Dec 2018 12:00:31 -0800
Received: by yow-pgortmak-d1.corp.ad.wrs.com (Postfix, from userid 1000)        id
 259162E0922; Mon, 10 Dec 2018 15:00:31 -0500 (EST)
Date:   Mon, 10 Dec 2018 15:00:31 -0500
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
CC:     Lee Jones <lee.jones@linaro.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 16/18] mfd: wm8350-i2c: Make it explicitly non-modular
Message-ID: <20181210200030.GC11670@windriver.com>
References: <1544213465-16259-1-git-send-email-paul.gortmaker@windriver.com>
 <1544213465-16259-17-git-send-email-paul.gortmaker@windriver.com>
 <20181210092808.GN16508@imbe.wolfsonmicro.main>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181210092808.GN16508@imbe.wolfsonmicro.main>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Re: [PATCH 16/18] mfd: wm8350-i2c: Make it explicitly non-modular] On 10/12/2018 (Mon 09:28) Charles Keepax wrote:

> On Fri, Dec 07, 2018 at 03:11:03PM -0500, Paul Gortmaker wrote:

[...]

> > -static int wm8350_i2c_remove(struct i2c_client *i2c)
> > -{
> > -	struct wm8350 *wm8350 = i2c_get_clientdata(i2c);
> > -
> > -	wm8350_device_exit(wm8350);
> 
> This is the only caller of this function so you probably want to
> remove it in the next patch as we did for the 831x stuff.

Thanks - I should have caught this instance after you pointed me at
the 831x version of the same issue.  But I did not.  :-(

I'll follow up the 17/18 wm8350-core patch with the wm8350_device_exit
delete added ; maybe if you can Ack that and hence the unchanged
wm8350-i2c patch shown here - then we can avoid me spamming Lee and
everyone else with 20-odd patches in v5 just to add acks to a v4 - vs.
hopefully having a v4 being final.

Linus - I'd removed your Ack from 831x-core and this pending 8350-core
update, since the original patch you ack'd has since changed to delete
an orphaned function.  I would of course add them back if you are OK
with the updated versions and put them in the v4, but I did not want to
assume that.

Acks will all be after SOB lines as requested by Lee in the v4 as well.

Thanks,
Paul.
--

> 
> Thanks, Charles
