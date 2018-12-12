Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F6DC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 734DF20870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:45:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 734DF20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ze-it.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbeLLXpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 18:45:22 -0500
Received: from vie01a-dmta-pe06-2.mx.upcmail.net ([84.116.36.15]:62423 "EHLO
        vie01a-dmta-pe06-2.mx.upcmail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726355AbeLLXpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 18:45:22 -0500
Received: from [172.31.216.234] (helo=vie01a-pemc-psmtp-pe11.mail.upcmail.net)
        by vie01a-dmta-pe06.mx.upcmail.net with esmtp (Exim 4.88)
        (envelope-from <thomas.zeitlhofer@ze-it.at>)
        id 1gXEBr-0002d2-IY
        for linux-kernel@vger.kernel.org; Thu, 13 Dec 2018 00:45:19 +0100
Received: from localhost.localdomain ([80.108.25.171])
        by vie01a-pemc-psmtp-pe11.mail.upcmail.net with ESMTP
        id XEBrgS2Fj5WeQXEBrgdbQI; Thu, 13 Dec 2018 00:45:19 +0100
X-Env-Mailfrom: thomas.zeitlhofer@ze-it.at
X-Env-Rcptto: linux-kernel@vger.kernel.org
X-SourceIP: 80.108.25.171
X-CNFS-Analysis: v=2.3 cv=YaJsGDZf c=1 sm=1 tr=0
 a=cw3iLm2b3cPoAt0NIr38/g==:117 a=cw3iLm2b3cPoAt0NIr38/g==:17
 a=kj9zAlcOel0A:10 a=DfNHnWVPAAAA:8 a=TLPPrWp_WpJSEZnYMI4A:9
 a=gAS41HzU6552_AA0:21 a=FJiIHrl6db20WXu0:21 a=CjuIK1q_8ugA:10
 a=rjTVMONInIDnV1a_A2c_:22
Date:   Thu, 13 Dec 2018 00:45:17 +0100
From:   Thomas Zeitlhofer <thomas.zeitlhofer@ze-it.at>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Kailang Yang <kailang@realtek.com>,
        Hui Wang <hui.wang@canonical.com>, Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 4.19 096/139] ALSA: hda/realtek - fix the pop noise on
 headphone for lenovo laptops
Message-ID: <20181212234517.GA15065@x1>
References: <20181204103649.950154335@linuxfoundation.org>
 <20181204103654.341269777@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204103654.341269777@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Envelope: MS4wfDWgpcnBYbkl14n1Pgb+wzRxlDOlYqF/cEhlEKJ+wwIobiFNns2OURcs2at8JA3JUeTtZfDKEwmFLa0uDtEOKZH2HlAIWS6Eei/Hy07wqyk1syud/Bw0
 eIKJai9TyCTWuI3qwbDcjsLmymc4UgXaV+E5x7u+trHfnL9vAuUZPNnubsG5ADqkFYonx+KbJ6bXEHyWd7m4sEsEY+sCf1k3EJcjgn5VjfaPw0rZ1S0iDGfK
 KOEKCH0Ss0IlFhdPsQ1zU9nOuqShjJRB7a+L1wate4NgWcIcDpemi079Yv/XhMIfKQVNVsg1eR6ehbwTjIQSJGTbl0jbjoHHXyOo6DXf8rsW9+qJi6cTwzvV
 TjLwyIgB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Dec 04, 2018 at 11:49:37AM +0100, Greg Kroah-Hartman wrote:
> 4.19-stable review patch.  If anyone has any objections, please let me
> know.
> 
> ------------------
> 
> From: Hui Wang <hui.wang@canonical.com>
> 
> commit c4cfcf6f4297c9256b53790bacbbbd6901fef468 upstream.
> 
> We have several Lenovo laptops with the codec alc285, when playing
> sound via headphone, we can hear click/pop noise in the headphone, if
> we let the headphone share the DAC of NID 0x2 with the speaker, the
> noise disappears.
> 
> The Lenovo laptops here include P52, P72, X1 yoda2 and X1 carbon.
[...]

on a current Thinkpad X1 Yoga, this breaks the LED functionality on the
audio- and mic-mute buttons. While the buttons still work, the LEDs are
permanently off and do not reflect the mute state any more.

Reverting this patch restores the LED functionality.

Here, even without this patch, there is no click/pop noise noticeable
when using headphones.

Regards,

Thomas
