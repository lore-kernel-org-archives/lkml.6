Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DCA6C6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 14:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5A4020843
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 14:24:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5A4020843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eircom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbeJ1XJl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 19:09:41 -0400
Received: from vie01a-dmta-pe08-1.mx.upcmail.net ([84.116.36.20]:61411 "EHLO
        vie01a-dmta-pe08-1.mx.upcmail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726828AbeJ1XJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 19:09:41 -0400
Received: from [172.31.216.235] (helo=vie01a-pemc-psmtp-pe12.mail.upcmail.net)
        by vie01a-dmta-pe08.mx.upcmail.net with esmtp (Exim 4.88)
        (envelope-from <mikebrady@eircom.net>)
        id 1gGlzq-0001re-0z
        for linux-kernel@vger.kernel.org; Sun, 28 Oct 2018 15:24:54 +0100
Received: from helix.aillwee.com ([37.228.204.209])
        by vie01a-pemc-psmtp-pe12.mail.upcmail.net with ESMTP
        id GlzngtHcYkosQGlzng9BpX; Sun, 28 Oct 2018 15:24:52 +0100
X-Env-Mailfrom: mikebrady@eircom.net
X-Env-Rcptto: linux-kernel@vger.kernel.org
X-SourceIP: 37.228.204.209
X-CNFS-Analysis: v=2.3 cv=NNQEBHyg c=1 sm=1 tr=0
 a=/+iDkf0alGTUGXENEoGzTg==:117 a=/+iDkf0alGTUGXENEoGzTg==:17
 a=kj9zAlcOel0A:10 a=smKx5t2vBNcA:10 a=pGLkceISAAAA:8 a=foHCeV_ZAAAA:8
 a=qjr1OBkKLYMV1eQWp_MA:9 a=CjuIK1q_8ugA:10 a=h8a9FgHX5U4dIE3jaWyr:22
Received: from [172.20.10.4] (unknown [77.75.241.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by helix.aillwee.com (Postfix) with ESMTPSA id 95E7B4E607;
        Sun, 28 Oct 2018 14:24:50 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [alsa-devel] [PATCH v2] staging: bcm2835-audio: interpolate audio
 delay
From:   Mike Brady <mikebrady@eircom.net>
In-Reply-To: <5bc8295a-1e38-99b5-d54c-72e920600f83@gmail.com>
Date:   Sun, 28 Oct 2018 14:24:56 +0000
Cc:     Takashi Iwai <tiwai@suse.de>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        devel@driverdev.osuosl.org, alsa-devel@alsa-project.org,
        f.fainelli@gmail.com, julia.lawall@lip6.fr,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        eric@anholt.net, linux-rpi-kernel@lists.infradead.org,
        nishka.dasgupta_ug18@ashoka.edu.in,
        linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 8BIT
Message-Id: <4E95A62E-951C-4432-BCE4-A2BA64029551@eircom.net>
References: <20181022191708.GA4659@ubuntu>
 <a703f8a2-e85a-bc5b-750a-cc43ef252ba5@gmail.com>
 <EA85FEC9-B1C7-4548-88F5-F0E7BC12158E@eircom.net>
 <046aea96-e0d3-60f4-c61a-c26bb1b5c193@gmail.com>
 <B9A84822-3780-4E01-96AD-FD3B42C44B45@eircom.net>
 <9884c4f5-2343-e3a4-8d8b-dd2db404ef27@gmail.com>
 <s5hftwuo4t0.wl-tiwai@suse.de>
 <5bc8295a-1e38-99b5-d54c-72e920600f83@gmail.com>
To:     Kirill Marinushkin <k.marinushkin@gmail.com>
X-Mailer: Apple Mail (2.3445.100.39)
X-CMAE-Envelope: MS4wfN+obAUj1HnM3caf4Xchuzx6v7UXSo3WpTOBcR1zjaor1lNMRI/gFQNnlXbDP0Zso2J0XxXbt8q80/UIiXa5ZHKF6fy51ngcngpygCDnKuWw9dxSXDHT
 uw+Bi2ilcZQMSG9OteeiUY8RP59WLBeuepEdVyXtZgTfYJhwPmHOI+JERnJsLnQCoTWRT5Ck+CBjqegkUDk7HSiFu2oTIsCT7Ncg9+il0dzQ2FeinbBZyLg4
 Pxikgu9W82ah/K57cVsFuEVyMvqfaDNh8UZMi5VxivvW1ow6c4IgTJ1OnrrD2GmwhPUVrcQMordraCdTIT35CEKnt5QBUfzMzwJdGdbIf6QhMLRUKJD0d8ms
 +2BNO1qlwYvdxHnIvAC8mXJNT9yy+ZimjiXl+AylpiVrFu/LnsaWS6yXP0av01fDAmVCGxUEKewZKlFKzfovLyJZGESxINW/hUyygKzw7O+mt/poA0zdugoy
 lARVoGtG0JvjXuPtOH89Lx/G30aqvoaQHX18S/ogrY1Y2mKvYG6GEke3KMXff9oMzr2hNcHjU/VshtnYl7cv4WtbdYlzzHL+2a82xtO+eEcOmR+Q1kMKf1LY
 X9GqPJD5cS8NVhx4GysCTPngdkMZt2dyGtMBr2z1IzhtxzsCxwyHveWBfNqKYUs9CE4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kirill. Thanks for the post.
Mike

> On 25 Oct 2018, at 18:20, Kirill Marinushkin <k.marinushkin@gmail.com> wrote:
> 
> Hello Takashi, Mike,
> 
> @Takashi
> 
> On 10/25/18 09:37, Takashi Iwai wrote:
>> Well, in the API POV, it's nothing wrong to keep hwptr sticking while
>> updating only delay value.  It implies that the hardware chip doesn't
>> provide the hwptr update.
> 
> Thank you for the clarification. Modifying `runtime->delay` from the `pointer`
> function looked wrong for me. Now I understand the motivation and the use-case.
> I will be more careful when analyzing the code which doesn't fit my expectations.
> 
> @Mike
> 
> I was wrong. You can ignore my comments. Please don't take them personal: it's
> all about having high-quality code in kernel.
> 
> Best Regards,
> Kirill
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

