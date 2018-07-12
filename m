Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF71C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 06:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F2AE20C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 06:11:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F2AE20C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbeGLGTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 02:19:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56858 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbeGLGTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 02:19:33 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2AFB1CA4;
        Thu, 12 Jul 2018 06:11:31 +0000 (UTC)
Date:   Thu, 12 Jul 2018 08:11:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] extcon: max3355: include mod_devicetable.h
Message-ID: <20180712061128.GD20905@kroah.com>
References: <CGME20180711155116epcas3p1d50af5ed86f7f55f607657d195492582@epcas3p1.samsung.com>
 <20180711155039.3600663-1-arnd@arndb.de>
 <ceb8cd99-91e3-aad6-bedc-bf5626c7683a@samsung.com>
 <ebd7d32f-48f6-1944-00a3-c2743f83b000@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ebd7d32f-48f6-1944-00a3-c2743f83b000@samsung.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 10:31:45AM +0900, Chanwoo Choi wrote:
> On 2018년 07월 12일 10:30, Chanwoo Choi wrote:
> > On 2018년 07월 12일 00:50, Arnd Bergmann wrote:
> >> Another driver turned up that is missing linux/mod_devicetable.h after
> >> the device IDs are split out from linux/platform_device.h:
> >>
> >> drivers/extcon/extcon-max3355.c:127:34: error: array type has incomplete element type 'struct of_device_id'
> >>  static const struct of_device_id max3355_match_table[] = {
> >>
> >> Fixes: ac3167257b9f ("headers: separate linux/mod_devicetable.h from linux/platform_device.h")
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >> ---
> >> Greg, please add that to the char-misc tree that already has
> >> other related patches.
> >> ---
> >>  drivers/extcon/extcon-max3355.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/extcon/extcon-max3355.c b/drivers/extcon/extcon-max3355.c
> >> index 0aa410836f4e..1335a476bfec 100644
> >> --- a/drivers/extcon/extcon-max3355.c
> >> +++ b/drivers/extcon/extcon-max3355.c
> >> @@ -14,6 +14,7 @@
> >>  #include <linux/gpio/consumer.h>
> >>  #include <linux/interrupt.h>
> >>  #include <linux/module.h>
> >> +#include <linux/mod_devicetable.h>
> >>  #include <linux/platform_device.h>
> >>  
> >>  struct max3355_data {
> >>
> > 
> > Applied it. Thanks.
> > 
> 
> If Greg pick up this patch, I'll drop it from extcon git.

Greg picked it up already :)

thanks,

greg k-h
