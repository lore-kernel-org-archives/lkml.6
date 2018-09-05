Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61C5C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F35D2077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:18:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F35D2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbeIEPrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 11:47:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53378 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbeIEPrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 11:47:49 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 762CCD5D;
        Wed,  5 Sep 2018 11:18:02 +0000 (UTC)
Date:   Wed, 5 Sep 2018 13:18:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Manu Gautam <mgautam@codeaurora.org>
Cc:     Prakruthi Deepak Heragu <pheragu@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ckadabi@codeaurora.org, tsoni@codeaurora.org,
        rnayak@codeaurora.org, bryanh@codeaurora.org,
        psodagud@codeaurora.org,
        Satya Durga Srinivasu Prabhala <satyap@codeaurora.org>
Subject: Re: [PATCH v2 2/2] Embedded USB Debugger (EUD) driver
Message-ID: <20180905111800.GA30003@kroah.com>
References: <1536096853-30473-1-git-send-email-pheragu@codeaurora.org>
 <1536096853-30473-3-git-send-email-pheragu@codeaurora.org>
 <c68c466a-576f-43d9-a7dd-7ee8e0ebba3f@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c68c466a-576f-43d9-a7dd-7ee8e0ebba3f@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 03:01:26PM +0530, Manu Gautam wrote:
> Hi,
> 
> 
> On 9/5/2018 3:04 AM, Prakruthi Deepak Heragu wrote:
> > Add support for control peripheral of EUD (Embedded USB Debugger) to
> > listen to events such as USB attach/detach, charger enable/disable, pet
> > EUD to indicate software is functional.
> >
> > Signed-off-by: Satya Durga Srinivasu Prabhala <satyap@codeaurora.org>
> > Signed-off-by: Prakruthi Deepak Heragu <pheragu@codeaurora.org>
> > ---
> >  drivers/soc/qcom/Kconfig  |  12 ++
> >  drivers/soc/qcom/Makefile |   1 +
> >  drivers/soc/qcom/eud.c    | 338 ++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 351 insertions(+)
> >  create mode 100644 drivers/soc/qcom/eud.c
> >
> > diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> [snip]
> > +
> > +#define EUD_ENABLE_CMD 1
> > +#define EUD_DISABLE_CMD 0
> 
> Why not use module param as boolean? I mean zero to disable and non-zero to enable?

Never use module parameters on new code, as it's really hard to ever
change them.  It also doesn't work for multiple devices of the same
type.

thanks,

greg k-h
