Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1876232-1524721043-2-13784721011051585142
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: subject='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524721042; b=InuOaYnTRZQWbPAdQzIZQa15KTlbSKfBz5AiijQrCA75Qsphoh
    ldYrgpu2jwY3pYxtC5AHwEO/mrmkOfS7bbGemO03nwr6LhG8xF41pP+sgsTPNCpW
    P+5FkNwtpH169/2k2C+A5Q8xwz699xfikc4iRHXlaKheLAmKBcEXott5F35N/UWK
    TRB5fLN7KRyPDCCJ9A2vKU5VXj8ez29xgxoy9IczcJhqAdrpu6x3M4VyymLvM4wt
    4dIrF8r5GEJ9mm9B/Ho0vdzxvhHCue+qR24ihFz9VjHd6MGx+BWwUCYCIbLA+YMU
    5+M7735t8l4stxbp24hmbmTKqXnvyHs+y53w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:content-type
    :content-transfer-encoding:date:from:to:cc:subject:in-reply-to
    :references:message-id:sender:list-id; s=fm2; t=1524721042; bh=7
    nIbjkwRefXgtnUWPaptffWFCG4tjEEoz9gb2zxQprU=; b=UaofQPDhR4SHLMGt5
    M8pRYtyrIhfWetR/ovNkCEnOdXjEQpmCAYBG6R+6SB4rtF2pUUkaNpDCU4unFQsl
    yiZyWB79FHiZ3EePx/Sdq+t1vm6QTF8J4bdDs6OwFF5Bok14OPuRssX4Q8arayym
    xRSfyVrCA2h7o9ePE1sb0G8sQ1BY5i/wfjf70cXKRuJ7DxyM0GLkDuIuCUuuciiy
    9/t45ZKIVfeK3ObPYCeEfBanYju4k3vbb6jnG6IlUmL/Wm1p/CytqXcCCf3DP9nv
    1GZyoJmBZdEAfIuaAP/3Yb+5fG9l86Am2ZOkAnYCqBf9PMFmVcsyqn5c5K9t98w2
    zGYsA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (4096-bit rsa key sha256) header.d=vittgam.net header.i=@vittgam.net header.b=AA3T7ePA x-bits=4096 x-keytype=rsa x-algorithm=sha256 x-selector=20150519;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=vittgam.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=vittgam.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (4096-bit rsa key sha256) header.d=vittgam.net header.i=@vittgam.net header.b=AA3T7ePA x-bits=4096 x-keytype=rsa x-algorithm=sha256 x-selector=20150519;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=vittgam.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=vittgam.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIhDMR/HNGdlYeUhsT+S15H7BfiB9BrNZAQklxA5tqUNB6LUAYeVwzPOO1dYr+3q5bndypyT3QEMEPjFW9LjftYLNJvZ58KtNuxTQA02uxkzytgWTv00
    ejmzfGOJMFixGsFLcEpStH9xFSu5Jn5G8oxlIq/Sp9BtDxNOY21X0UCUKiQeoDEvmoOw1oYD4lXUlOj2dSQoknDcLhYQaZiq2rAzEqej3iYP5JsXuNGBo7vq
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=rEqvwrX8AAAA:8 a=nx57h0buAAAA:8 a=a6w697QCBlvHqrne3KQA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=2B8fXRCmRxTqFPaLtVU6:22
    a=YtO9EDU9lxz8Tya6zqt4:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751396AbeDZFhS (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 01:37:18 -0400
Received: from server1.vittgam.net ([213.239.197.142]:51579 "EHLO
        mail.vittgam.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbeDZFhR (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 26 Apr 2018 01:37:17 -0400
X-DKIM: OpenDKIM Filter v2.4.2 mail.vittgam.net w3Q5bAL6058955
X-VittGamMilter-Outgoing-SubjectPrefix: [linux-stable]
X-VittGamMilter-Outgoing-OriginalSubject: Re: [PATCH v2] input/touchscreen: =?UTF-8?Q?atmel=5Fmxt=5Fts=3A?=
 =?UTF-8?Q?=20Add=20correct=20touchpad=20button=20mapping=20for=20the=20Ca?=
 =?UTF-8?Q?roline=20Chromebook=2E?=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Date: Thu, 26 Apr 2018 07:37:10 +0200
From: "Vittorio Gambaletta (VittGam)" <linuxbugs@vittgam.net>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-input@vger.kernel.org>,
        <stable@vger.kernel.org>, <nick@shmanahar.org>,
        <bleung@chromium.org>, Salvatore Bellizzi <lkml@seppia.net>,
        <groeck@chromium.org>
Subject: Re: [PATCH v2] input/touchscreen: =?UTF-8?Q?atmel=5Fmxt=5Fts=3A?=
 =?UTF-8?Q?=20Add=20correct=20touchpad=20button=20mapping=20for=20the=20Ca?=
 =?UTF-8?Q?roline=20Chromebook=2E?=
In-Reply-To: <20180425225734.GD200812@dtor-ws>
References: <201804251232.w3PCWweA028076@mail.vittgam.net>
 <20180425222650.GC200812@dtor-ws> <20180425225734.GD200812@dtor-ws>
Message-ID: <ff623f6afb4e7910f3bb6d211f0f187f@vittgam.net>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello,

On 26/04/2018 00:57:34 CEST, Dmitry Torokhov wrote:
> On Wed, Apr 25, 2018 at 03:26:50PM -0700, Dmitry Torokhov wrote:
>> On Wed, Apr 25, 2018 at 02:32:58PM +0200, Vittorio Gambaletta (VittGam) wrote:
>> > This patch adds the correct platform data information for the Caroline
>> > Chromebook, so that the mouse button does not get stuck in pressed state
>> > after the first click.
>> >
>> > The Samus button keymap and platform data definition are the correct
>> > ones for Caroline, so they have been reused here.
>> >
>> > v2: updated patch offset after 20180409 changes.
>> >
>> > Cc: stable@vger.kernel.org
>> > Signed-off-by: Vittorio Gambaletta <linuxbugs@vittgam.net>
>> > Signed-off-by: Salvatore Bellizzi <lkml@seppia.net>
>> >
>>
>> Applied, thank you.
>>
>> > ---
>> >
>> > --- a/drivers/input/touchscreen/atmel_mxt_ts.c
>> > +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
>> > @@ -3035,6 +3035,15 @@
>> >  		.driver_data = samus_platform_data,
>> >  	},
>> >  	{
>> > +		/* Samsung Chromebook Pro */
>> > +		.ident = "Samsung Chromebook Pro",
>> > +		.matches = {
>> > +			DMI_MATCH(DMI_SYS_VENDOR, "GOOGLE"),
> 
> I've been alerted that shipping BIOS has vendor not capitalized; where
> did you get the firmware that has vendor all capitals?

Upstream coreboot and mrchromebox's coreboot, which do support loading Linux
natively or with UEFI, both use capitalized GOOGLE as DMI System Vendor
as far as I know.

By the way, the shipping BIOS (coreboot customized by Google) does not support
mainline Linux natively (eg. without seabios and nasty tricks), but only
Chromium OS, which for Caroline is an old 3.something fork of Linux, so this
patch does not really apply to Chromium OS or to Linux running on shipping BIOS.

Anyway if I recall correctly, the DMI System Vendor should be GOOGLE in
Google's coreboot for Caroline too, but I'm not 100% sure and cannot check
right now.

By the way please note that this is the DMI System Vendor and not the DMI
BIOS version string, which indeed starts with "Google_" in the shipping BIOS
(but not in coreboot, see f56db262e46d3368ee4e5c9e19797853cab382cd).

> Thanks.

Cheers,
Vittorio G

>> > +			DMI_MATCH(DMI_PRODUCT_NAME, "Caroline"),
>> > +		},
>> > +		.driver_data = samus_platform_data,
>> > +	},
>> > +	{
>> >  		/* Other Google Chromebooks */
>> >  		.ident = "Chromebook",
>> >  		.matches = {
>>
>> --
>> Dmitry
