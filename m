Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E997C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 10:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D3BB26C94
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 10:53:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D3BB26C94
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965391AbeF1Kxv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 06:53:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54156 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964908AbeF1Kxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 06:53:50 -0400
Received: from localhost (unknown [104.153.224.166])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 51A0FC7F;
        Thu, 28 Jun 2018 10:53:45 +0000 (UTC)
Date:   Thu, 28 Jun 2018 19:24:17 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     hadess@hadess.net, hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: staging: rtl8723bs: bug or pointless if else ?
Message-ID: <20180628102417.GA30782@kroah.com>
References: <473d9997-8c30-a3f3-85b6-076decc7a7c2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <473d9997-8c30-a3f3-85b6-076decc7a7c2@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 09:43:47AM +0200, Michael Straube wrote:
> Hi,
> 
> I stumbled upon the following if else construct in
> drivers/staging/rtl8723bs/os_dep/sdio_intf.c:618
> 
>         if (pwrpriv->bInternalAutoSuspend)
>         {
>                 ret = rtw_resume_process(padapter);
>         }
>         else
>         {
>                 if (pwrpriv->wowlan_mode || pwrpriv->wowlan_ap_mode)
>                 {
>                         ret = rtw_resume_process(padapter);
>                 }
>                 else
>                 {
>                         ret = rtw_resume_process(padapter);
>                 }
>         }
> 
> It does not matter if the conditions are true or not,
> ret is always set to:
> 
> ret = rtw_resume_process(padapter)
> 
> Is this a bug or is the if else construct just pointless?

Looks pretty pointless...
