Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0435AC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB1242085A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYei1ZQW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB1242085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbeKCAXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 20:23:15 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41122 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbeKCAXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 20:23:15 -0400
Received: by mail-qk1-f195.google.com with SMTP id 189so3543079qkj.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 08:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=EvNTaNiSav0a9d3Jmf5cZ6t42xssfwWNmINzcM45CIM=;
        b=lYei1ZQWUgkSfXqDocfa68cGxGY3YyZ0zyE77zxOZOpF4mlFb6m+xK17CDFKOjYyDF
         DJMsdG4AyoL8BvQB7ncP39Prr75jjvAm51vKvKakYcXUL/W/uHHDWVLHu8IihZBTZCWA
         WWmqEhzOwqSeH5BTXnpPei3vE1WaTPD/xpmPrX53ecuhM3m5wyDkaNtPy5+hASsjJ3ho
         t2Kfq/dalnaeTRYmck7TiDXQ9s+U3WEngh1lko4uosto5FSsYGV2uY7dvt/yAzcDnB+g
         GYCr4a2LmUPLL/U5ApWcvDZgbxmiH5SQLb/WPauzG8mDwOYHBjWtYKLzIu0uT1Z83ha5
         2hpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=EvNTaNiSav0a9d3Jmf5cZ6t42xssfwWNmINzcM45CIM=;
        b=p+3r6+3e47h5Z3NxvFsvOIyH4GwWQSB3mwlFVneWt1ZCa655ltYOyrvpwliWL4HOIr
         C4dt/cxnGdOinv3kKhKfBNc4JOorVFn7przSRneMRPTrDGFKeoq+5K7EPnhJOn3HB9r7
         49BSYNf4nZrCNwnFHlgb6paqQuyTTnkYi183ykYMGNWVXQEzToKiyvS1V02BxebtGSHn
         u932VCUzg5z6CkMYwMkCI+gKgr+r5eIjFMJrbZ7LOTeWGhhj+026zfEXMF45wxXnYyUH
         ZFI7+Bc2KCmbVeSb0F+uGI3OtMhm1iYKpGzbMD1WZ4lKZdLYMHzwx9HBt6sQADQNfcmB
         U7aw==
X-Gm-Message-State: AGRZ1gIU5pgk/j7FnLIlzB8YAfJWkfm3WkcFGyFTqowZgZmdIk3GfvL7
        yD+4A4USwy0WiiGoXZligVQ789LkUVdH5WpdILk=
X-Google-Smtp-Source: AJdET5fwh8UNBD5lofGinNxhurk/CH4XQsAb2Ry9FkpBKoKsSs6JlZ31KEltt1G93Vl0WG7vspnxa9HES41kJlzkT5M=
X-Received: by 2002:a0c:e202:: with SMTP id q2mr10921615qvl.180.1541171749897;
 Fri, 02 Nov 2018 08:15:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:9881:0:0:0:0:0 with HTTP; Fri, 2 Nov 2018 08:15:48 -0700 (PDT)
In-Reply-To: <20181102143817.GP16508@imbe.wolfsonmicro.main>
References: <20181102112341.753642-1-arnd@arndb.de> <20181102143817.GP16508@imbe.wolfsonmicro.main>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 2 Nov 2018 16:15:48 +0100
X-Google-Sender-Auth: QGY0p8kJzZxYfavL9Kh4MVcu4fI
Message-ID: <CAK8P3a0Mb3k8FAVdRWyiEwjCV4re1-LEvxG-NQXLfhEHts1ZDA@mail.gmail.com>
Subject: Re: [PATCH] ASoC: wm97xx: fix uninitialized regmap pointer problem
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/18, Charles Keepax <ckeepax@opensource.cirrus.com> wrote:
> On Fri, Nov 02, 2018 at 12:23:08PM +0100, Arnd Bergmann wrote:

>>  static void wm9713_soc_remove(struct snd_soc_component *component)
>>  {
>> -#ifdef CONFIG_SND_SOC_AC97_BUS
>>  	struct wm9713_priv *wm9713 = snd_soc_component_get_drvdata(component);
>>
>> -	if (!wm9713->mfd_pdata) {
>> +	if (IS_ENABLED(CONFIG_SND_SOC_AC97_BUS)) {
>
> Should this one not also have an && !wm9713->mfd_pdata?

Right, good catch!. I'll send a fixed version in a bit.

       Arnd
