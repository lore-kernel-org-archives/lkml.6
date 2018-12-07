Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522EFC64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E92C2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:17:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E92C2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbeLGSQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 13:16:59 -0500
Received: from mail.windriver.com ([147.11.1.11]:52281 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbeLGSQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 13:16:58 -0500
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id wB7IGorS010921
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Fri, 7 Dec 2018 10:16:50 -0800 (PST)
Received: from yow-pgortmak-d1.corp.ad.wrs.com (128.224.56.57) by
 ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
 14.3.408.0; Fri, 7 Dec 2018 10:16:49 -0800
Received: by yow-pgortmak-d1.corp.ad.wrs.com (Postfix, from userid 1000)        id
 5C9CC2E0AC5; Fri,  7 Dec 2018 13:16:49 -0500 (EST)
Date:   Fri, 7 Dec 2018 13:16:49 -0500
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
CC:     Lee Jones <lee.jones@linaro.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH 18/22] mfd: wm831x-i2c: Make it explicitly non-modular
Message-ID: <20181207181648.GQ23156@windriver.com>
References: <1543811009-15112-1-git-send-email-paul.gortmaker@windriver.com>
 <1543811009-15112-19-git-send-email-paul.gortmaker@windriver.com>
 <20181205113820.GZ16508@imbe.wolfsonmicro.main>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181205113820.GZ16508@imbe.wolfsonmicro.main>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Re: [PATCH 18/22] mfd: wm831x-i2c: Make it explicitly non-modular] On 05/12/2018 (Wed 11:38) Charles Keepax wrote:

> On Sun, Dec 02, 2018 at 11:23:25PM -0500, Paul Gortmaker wrote:

[...]

> > -static int wm831x_i2c_remove(struct i2c_client *i2c)
> > -{
> > -	struct wm831x *wm831x = i2c_get_clientdata(i2c);
> > -
> > -	wm831x_device_exit(wm831x);
> 
> These patches remove the only callers of wm831x_device_exit, so I
> guess we should probably remove that function too?

Agreed. I've ammended the 831x-core patch to remove this as well.
Thanks for spotting it.  Will send v3 shortly.

Paul.
--

> 
> Thanks,
> Charles
