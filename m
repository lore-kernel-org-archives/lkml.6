Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12593ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C7CD21531
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2w7+5Jn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C7CD21531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732848AbeITT7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 15:59:22 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45405 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727633AbeITT7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 15:59:21 -0400
Received: by mail-ot1-f68.google.com with SMTP id a19-v6so9540605otl.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 07:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bcrcEFWYFXO0bI7EyLzl7WW70R6tAqP/4IZ8PwOudEQ=;
        b=b2w7+5JnSq9537KrU+5UbgmZfT1Dghl8RqVpF97knp7AqeDMBNbVOKiXNs/htMpH8y
         VMyBkw+t0Ksu7JnPzZHVN7WbEhLBVaVl1vcIjlkspw7cMk3zVbUb99lubB9rBN8cMX/v
         ordeJMcha5MTPWtFv4ndXzr4k4d7rgvVCNLyfvmQGmUvvyA/RUZOFKUGAq3HzVljdVk4
         +NAk0mpPZZJKzxunP3sbugQpJxQqTlLK+LoCZ1IGxYoGBnZkvWS4EbLUEv706OeShkBG
         sEDU0Q3s/3+qYil3X3PhZz+Xju3tIRlRUkJLGaSD53VhDlW59o3WRiCoTgZqs/Y4nJvr
         ++RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bcrcEFWYFXO0bI7EyLzl7WW70R6tAqP/4IZ8PwOudEQ=;
        b=uAcarwnEglPlBaaEw5NmXPzYjEnd6WKyyTK9JJXtE1byK6GzADjE9c1qsYViey8jeq
         S2ERXzrZ4sadLbR9KGlmq9CgBkPPe4NZxI+ICRSxNxKKbbR+FymANefV9jGGt48bWBx/
         ePpV0krm54f341h7qDSsYCy3WHnNt/I0taO/ekK2X+e7kZYMI/xdBHeYLKLfqtOoBNIO
         Ym31aXdRahl/xkvfIWTYIGIvUc7jiAomW39AtXYyP0bZ/YItDt4heUoeaVQLxlwpKfWW
         YAqg2WH67wIzH70sTXTbfHUfz0MhjIunI8OSC7RpHA9eiac1L/RZGykC+buBzXHq/0D2
         uoJQ==
X-Gm-Message-State: APzg51CSsY+DHI9e0GyV15VGFQAWR6eh1d2N4NiQnL4kQNb+SNbNUTN6
        eEu0aPBrMSW1lk1YUK3qhrf7HM5iFzyufoKo6COf5A==
X-Google-Smtp-Source: ANB0Vdbl5r0OYm9cXbW/dOvtUOSyJPB/RohRX/gLNdJRuWKpjRO0KwUAaIiPVMg8yNgnZV2Tj86dr9heOMqzeyMtzDo=
X-Received: by 2002:a9d:41cd:: with SMTP id v13-v6mr22936941oti.81.1537452939886;
 Thu, 20 Sep 2018 07:15:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:50d9:0:0:0:0:0 with HTTP; Thu, 20 Sep 2018 07:15:39
 -0700 (PDT)
In-Reply-To: <s5hbm8sskco.wl-tiwai@suse.de>
References: <1537295625-8082-1-git-send-email-conmanx360@gmail.com> <s5hbm8sskco.wl-tiwai@suse.de>
From:   Connor McAdams <conmanx360@gmail.com>
Date:   Thu, 20 Sep 2018 10:15:39 -0400
Message-ID: <CAM8Agx2VAfDv5TD4W_VSo-Ln5g=3wecBicyS4Xr7SiKAwQU-Bg@mail.gmail.com>
Subject: Re: [PATCH 00/15] Add support for Sound BlasterX AE-5
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org,
        Alastair Bridgewater <alastair.bridgewater@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for fixing that. I was doing that previously, but this time
I was only doing it every few commits. Will make sure to go back to
the way I was doing it before. Sorry about that.

On Thu, Sep 20, 2018 at 3:23 AM, Takashi Iwai <tiwai@suse.de> wrote:
> On Tue, 18 Sep 2018 20:33:28 +0200,
> Connor McAdams wrote:
>>
>> This patch series adds support for the Sound BlasterX AE-5. I have
>> personally tested it, and had others test it as well. All outputs work,
>> front headphone, rear headphone, rear line-out, surround, digital. The
>> only issue currently is that the microphone suffers from inconsistency
>> like the Sound Blaster Z does, and Creative may be willing to help fix
>> that, but if they're not, I have a few ideas.
>>
>> I also have the ZxR working currently. That will require some more
>> complicated changes of the driver, so I have left it out and just
>> focused on the AE-5.
>>
>> Connor McAdams (15):
>>   ALSA: hda/ca0132 - Define new verbs and control params
>>   ALSA: hda/ca0132 - Add quirk for Sound BlasterX AE-5
>>   ALSA: hda/ca0132 - Add pincfg for AE-5
>>   ALSA: hda/ca0132 - Set AE-5 bools and select mixer
>>   ALSA: hda/ca0132 - Change ca0132_mmio_init for AE-5
>>   ALSA: hda/ca0132 - Add AE-5 pre-init and ca0113 functions
>>   ALSA: hda/ca0132 - Add AE-5 regular init setup
>>   ALSA: hda/ca0132 - Change firmware name and usage
>>   ALSA: hda/ca0132 - Merge post-dsp functions + cleanup
>>   ALSA: hda/ca0132 - Add DSP setup functions for AE-5
>>   ALSA: hda/ca0132 - Clean up ca0132_alt_out_select
>>   ALSA: hda/ca0132 - Add output set commands for AE-5
>>   ALSA: hda/ca0132 - Add input selection commands for AE-5
>>   ALSA: hda/ca0132 - Add AE-5 specific controls
>>   ALSA: hda/ca0132 - Add AE-5 exit function
>
> Thanks, applied now all 15 patches.
>
> One patch caused a compile warning in the middle of series due to an
> unused variable which is used in a later patch.  Since it's a trivial
> issue, I addressed it by myself locally.  But at the next time, it'd
> be helpful if you do a compile test for each commit in the series
> before submission.
>
>
> Takashi
