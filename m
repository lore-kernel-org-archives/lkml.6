Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-906798-1525895933-2-6737036948507464803
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: to='UTF-8', plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525895933; b=Zc05Wak3PMCQJO2btf81POsAu9fkAue6kkD5041Ffh5ZBlmQxM
    Qcf1G1okI6VY5X+c/Sbyhus+hhvKR09iST/Szsa3JVuHkO/nEvfnEWZ1bMEaIx9N
    aqLMG+Lai7xhm16gU6tqOKwDOW2OLOjdRtDU2yAXyTwjFmifP/tcqQBdfSk7ZGVl
    DMF505Fh9fVhNKDkeklyKPjgsnd5pJnV85+uo9eI3UlQ19POCnlYTFLsvdtKUzPY
    SWwmmUY109P0ILBk73cAP+JAskWUkV1QxXlbxiJd2h8jabxVZpX6LOqbvtTT1z4u
    6WIcHUunXNq181qwY3kfosnGRygZmsIkhmyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525895933;
    bh=71SddPlWqTUyNC4PPYwVdfgG0GenHohJef76cPc53rE=; b=KnNpfo6A2qIl
    NKiZ2uVucwGUbMT76V4kDyRK8rnhlDvXMQEvnhXTfrVvPkJSO13ylw9+unf96Lw0
    Oi/KfxMfMUR0jR61YR1rpBUzIg2a9iI86h+1OVFfie7bGbhylmuXklhtDMjYC/YW
    uNbGl78oSMub7Gr8EBFuuuCbriUi4w3m5V+HUPe9lWRXcie+3ROX/9WWcQ0dYSlc
    UTi641YmutFYTcYEoOMe7qXPQ/cBF+oPh+JNx4VgFpchQt8CqrV0Vh2IpMHH+7aU
    rcG+DsxcizhA/wtOcWjvX9jndxB8sSKugwrznwUYorRDRaU976DpzDdo0mCqZyWq
    vbtcqbVKJA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=b83PVMxE x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=uBTnljav;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=b83PVMxE x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=uBTnljav;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFWDnmyo2p0MA2TTY1nvUCM7X1gEmOBsvfD6RfKlROiEXHzZ7oTVzDQnC2Wk9+fIWKDWRTBWjCljyKD2JPPyxeX8PwmlQlypAxcZ+9vD0rHMDJ1r9nHW
    9kXi8Zr6mtWhdTtu1TpOrrfwzIZl6xeen+ZaPdCFkxKwo55voMITcfUbJdIKZ3Yv2jnoWHUM3mQICa4EOJkuduU1w5AlZplWnrMjsqC84bQ9TcI5+oKVqOKv
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=H_xvhQCm9QgA:10 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=tTPqZ0fZbGZ8rJ7VY6AA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756283AbeEIT6k (ORCPT <rfc822;greg@kroah.com>);
        Wed, 9 May 2018 15:58:40 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34690 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751803AbeEIT6i (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 9 May 2018 15:58:38 -0400
X-Google-Smtp-Source: AB8JxZr2CCCU/HaiYvpammDWHFJrTYuuXs1Ko6jK2OtLRHgiKF6owYzqM3x6Te9X1q6A4RWDxRNlFQ==
Subject: Re: [PATCH v3 1/3] leds: triggers: provide
 led_trigger_register_format()
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Marc Kleine-Budde <m.kleine-budde@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-serial@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        Robin Murphy <robin.murphy@arm.com>, linux-leds@vger.kernel.org
References: <20180508100543.12559-1-u.kleine-koenig@pengutronix.de>
 <20180508100543.12559-2-u.kleine-koenig@pengutronix.de>
 <ea34ce99-d446-03d2-b38d-d40a22480337@gmail.com>
 <20180508201725.3alpkcpaxebupzqv@pengutronix.de>
From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <906d2b27-2e8b-92a9-13ff-2676f48142f4@gmail.com>
Date: Wed, 9 May 2018 21:57:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180508201725.3alpkcpaxebupzqv@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Uwe,

On 05/08/2018 10:17 PM, Uwe Kleine-König wrote:
> Hello Jacek,
> 
> On Tue, May 08, 2018 at 09:33:14PM +0200, Jacek Anaszewski wrote:
>> Thank you for the patch. It looks fine, but please split
>> the drivers/net/can/led.c related changes into a separate one.
> 
> I renamed led_trigger_rename_static() to led_trigger_rename() (and
> changed the parameters). The can change just adapts the only user of
> led_trigger_rename_static() to use the new one.
> 
> It's not impossible to separate this patches, but I wonder if it's worth
> the effort.
> 
> The first patch would be like the patch under discussion, just without
> the can bits and introducing something like:
> 
> 	/*
> 	 * compat stuff to be removed once the only caller is converted
> 	 */
> 	static inline led_trigger_rename_static(const char *name, struct led_trigger *trig)
> 	{
> 		(void)led_trigger_rename(trig, "%s", name);
> 	}
> 
> Then the second patch would just be the 6-line can hunk. And a third
> patch would remove the compat function. (Maybe I'd choose to squash the
> two can patches together then, but this doesn't reduce the overhead
> considerably.) The only upside I can see here is that it increases my
> patch count, but it's otherwise not worth the effort for such an easy
> change. Further more as there is a strict dependency on these three
> patches this either delays the cleanup or (IMHO more likely) the can
> change would go in via the led tree anyhow.  (Mark already acked patch 2
> of this series and in private confirmed that the agrees to let this
> change go in via the led tree, too.)

OK, makes sense. I'll wait also for ack on 3/3 since it should
go through the LED tree as well - uses a new led_trigger_register_format().

-- 
Best regards,
Jacek Anaszewski
