Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EB1C4646A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85D5F206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XtZMgZLG";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XPzIolQI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85D5F206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbeILBlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 21:41:21 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42646 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbeILBlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 21:41:20 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 35798607C6; Tue, 11 Sep 2018 20:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536698420;
        bh=bm6YGDI5aHm7L9BhLRKhwEWtg/w7tozyNjfyBTBWUxU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XtZMgZLGd1+yyR0y6fSAfe7IfnC8oCO8g+qN7jzvF6FlHYAxNkBJk5TdLaowsYpiS
         7gM+aLhgfrLcgsSHvTRQyDFS9I+RFRWwLFUYoa8S1sXcmgUYcl9UiEvLMJeC1iR0HY
         qspO2CDFcdWSe8jUtJkU6bbX/S47rLaVwm4892Lw=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id C2F09607BD;
        Tue, 11 Sep 2018 20:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536698419;
        bh=bm6YGDI5aHm7L9BhLRKhwEWtg/w7tozyNjfyBTBWUxU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XPzIolQIsxoi+QgYj/fgm78wjVlZDe5IXG4I/PMH0oFH/ky9MGFSkyTrkzJLuU2sJ
         U1kUGdYZcDOve++4/T3QRxj3hqvgxh9f/8Gj1XxM2IgFf5/pv70qsuM2ymoIAe+gZQ
         8Wbh0nXjr09a2tbol74Fteq7zF7pYSODla5IJr4w=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 11 Sep 2018 13:40:19 -0700
From:   pheragu@codeaurora.org
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Manu Gautam <mgautam@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ckadabi@codeaurora.org, tsoni@codeaurora.org,
        rnayak@codeaurora.org, bryanh@codeaurora.org,
        psodagud@codeaurora.org,
        Satya Durga Srinivasu Prabhala <satyap@codeaurora.org>
Subject: Re: [PATCH v2 2/2] Embedded USB Debugger (EUD) driver
In-Reply-To: <20180905111800.GA30003@kroah.com>
References: <1536096853-30473-1-git-send-email-pheragu@codeaurora.org>
 <1536096853-30473-3-git-send-email-pheragu@codeaurora.org>
 <c68c466a-576f-43d9-a7dd-7ee8e0ebba3f@codeaurora.org>
 <20180905111800.GA30003@kroah.com>
Message-ID: <aade97184ee5027ac6e32fd742cfbc5a@codeaurora.org>
X-Sender: pheragu@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-05 04:18, Greg KH wrote:
> On Wed, Sep 05, 2018 at 03:01:26PM +0530, Manu Gautam wrote:
>> Hi,
>> 
>> 
>> On 9/5/2018 3:04 AM, Prakruthi Deepak Heragu wrote:
>> > Add support for control peripheral of EUD (Embedded USB Debugger) to
>> > listen to events such as USB attach/detach, charger enable/disable, pet
>> > EUD to indicate software is functional.
>> >
>> > Signed-off-by: Satya Durga Srinivasu Prabhala <satyap@codeaurora.org>
>> > Signed-off-by: Prakruthi Deepak Heragu <pheragu@codeaurora.org>
>> > ---
>> >  drivers/soc/qcom/Kconfig  |  12 ++
>> >  drivers/soc/qcom/Makefile |   1 +
>> >  drivers/soc/qcom/eud.c    | 338 ++++++++++++++++++++++++++++++++++++++++++++++
>> >  3 files changed, 351 insertions(+)
>> >  create mode 100644 drivers/soc/qcom/eud.c
>> >
>> > diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
>> [snip]
>> > +
>> > +#define EUD_ENABLE_CMD 1
>> > +#define EUD_DISABLE_CMD 0
>> 
>> Why not use module param as boolean? I mean zero to disable and 
>> non-zero to enable?
> 
> Never use module parameters on new code, as it's really hard to ever
> change them.  It also doesn't work for multiple devices of the same
> type.
> 
If not for module_param, do you suggest we use sysfs? module_param also 
provides a
facility to control these parameters through command line too. If we 
can't use
module_param, do you expect us to use __setup(..) API?

> thanks,
> 
> greg k-h

Regards,
Prakruthi Deepak Heragu
