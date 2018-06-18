Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01D8C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C058208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="M6SvDUDI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C058208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935207AbeFRMFW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 08:05:22 -0400
Received: from mx-rz-3.rrze.uni-erlangen.de ([131.188.11.22]:52971 "EHLO
        mx-rz-3.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934790AbeFRME6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 08:04:58 -0400
X-Greylist: delayed 493 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Jun 2018 08:04:58 EDT
Received: from mx-rz-3.rrze.uni-erlangen.de (mx-rz-3.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::16])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTPS id 418V1m5HlSz1y6S;
        Mon, 18 Jun 2018 13:56:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1529323004; bh=VuzJraIjlQmM9oQIXQvoJQzGPdopD9k7qSm2ZyLEtYA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From:To:CC:
         Subject;
        b=M6SvDUDISuzg2e48+gjHiYA42Db3NZvb1CsJaoUSw+XSPBRRJcm5k/VDH7aHW8X4E
         QxUWRyuWPATSA3+h4pmnv4jJs8XwT/czrPBPh63jVFeEITFUn+DXZ4liZ7zOVGyNH2
         G3SKBhWvtfXCk5QzrwNeajMMVWrxksvb6Xdw0VAAsoWHwK+GyS6tmiKZ9HKr0Wpcj1
         h0E4KFFdgv1emVK+GllRub+RaEZJdP6GhYpro8HvyviJhfB7qjftskDOazqVWk5V/u
         day931G1reQrTjJwW/zXkwJefNnJOuv8qEHGx4A6ecNVMFRP1GOLXrof/JClk3Nhwu
         CzfVg1OVbRjCg==
X-Virus-Scanned: amavisd-new at boeck4.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 131.188.11.37
Received: from faumail.fau.de (smtp-auth.fau.de [131.188.11.37])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX19ov6isG38nVuh4zGmP8NQ+ujgivVapYAw=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 418V1k4bcmz1y8r;
        Mon, 18 Jun 2018 13:56:42 +0200 (CEST)
Received: from
 lCNWPlPjsYJKrW5ckuCGyD/ycu1PrZ2yuUwESm0OsbzXM4S4ggaMNxLrLc5TXA7+
 by faumail.uni-erlangen.de
 with HTTP (HTTP/1.1 POST); Mon, 18 Jun 2018 13:56:42 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 18 Jun 2018 13:56:42 +0200
From:   "Sommer, Roman" <roman.sommer@fau.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@i4.cs.fau.de, Daniel Graefe <daniel.graefe@fau.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        =?UTF-8?Q?Hans_P=2E_M=C3=B6ller_Eb?= =?UTF-8?Q?ner?= 
        <hmoller@uc.cl>, Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?Q?Fabi=C3=A1n_Inostroza?= <soulsonceonfire@gmail.com>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] sound/line6: checkpatch: fix block comment style
In-Reply-To: <20180618112134.GA4289@kroah.com>
References: <1529317779-15908-1-git-send-email-roman.sommer@fau.de>
 <1529317779-15908-2-git-send-email-roman.sommer@fau.de>
 <20180618112134.GA4289@kroah.com>
Message-ID: <6dd9eb6c3dc6d57eb140696bed4e4a6c@fau.de>
X-Sender: roman.sommer@fau.de
User-Agent: Roundcube Webmail/1.2.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-18 13:21, Greg Kroah-Hartman wrote:
> On Mon, Jun 18, 2018 at 12:29:37PM +0200, Roman Sommer wrote:
>> CC: Jaroslav Kysela <perex@perex.cz>
>> CC: Takashi Iwai <tiwai@suse.com>
>> CC: Takashi Sakamoto <o-takashi@sakamocchi.jp>
>> CC: "Hans P. Möller Ebner" <hmoller@uc.cl>
>> CC: Kees Cook <keescook@chromium.org>
>> CC: Kate Stewart <kstewart@linuxfoundation.org>
>> CC: Thomas Gleixner <tglx@linutronix.de>
>> CC: "Fabián Inostroza" <soulsonceonfire@gmail.com>
>> CC: Bhumika Goyal <bhumirks@gmail.com>
>> CC: Philippe Ombredanne <pombredanne@nexb.com>
>> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> CC: alsa-devel@alsa-project.org
>> CC: linux-kernel@vger.kernel.org
>> 
>> This patch fixed the style of multiline comments in sound/usb/line6.
> 
> Why is all of those cc: lines in the changelog body?
> 
> Very odd...
> 
> greg k-h

Hi Greg,

Sorry for the mess-up here, they were meant for the header only.

I used a newline to group people in the patches which I now know I 
should
not do.


Roman
