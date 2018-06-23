Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B19C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 12:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F04D824BF1
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 12:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMLRwXSo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F04D824BF1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751962AbeFWMqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 08:46:43 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39785 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751622AbeFWMql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 08:46:41 -0400
Received: by mail-ed1-f68.google.com with SMTP id w14-v6so2727953eds.6;
        Sat, 23 Jun 2018 05:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jRH5f1Vbiu0DPKNth7XVcp2AePYEB/AUo3zKfjeYwxU=;
        b=gMLRwXSoMiv6PG32g/Mu+V+PdTOXTeWJwERBVREPHyM3H20x3YmtHUbpC5ZjSGOVn6
         DIxHdPJJNfLMGLfhQRsPDEpkpii36Ui6Y5/kp9ZbcFrlGyJ+EgvrhCOg2GwyHfvKeGd+
         RkYvXuIhkzmllQJwSQXjJbKBoGf4CMlXE+ADabTNHueQddzF5Onx2oHh2FdZaQ2Qmhne
         ugslNdQxwg3zzw5WMgvnMZxLuwyLz7D4O5+fYr7WQo8MOa8klbzjurIPRegcUsDW149X
         OmUzgPblzNB70JBT5knlKbGQr0Yn3PtUHLv0tEpj+Jue0OSxj2qIdkIy1O9ZdnAkf9V+
         qPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jRH5f1Vbiu0DPKNth7XVcp2AePYEB/AUo3zKfjeYwxU=;
        b=tPJSyCKJRUsvTlP/7ku86BFSCIdsX+Yp8Bh3VIERuxibIg4tvOdzQtp/7bXA2gC7J4
         GU7nY1cEI5W/Y0cC/DvWhnCzSj4bDjAO4y8HWvS1t19qKNViRIrTEBFHGMJo/8uiNKS6
         DZ0/D/VMRGwrabwUaKBgYEITN0TW3XF8ZmqnVqZcqTH4IXJSylKAZDl1N8x44urNpD5C
         cN1RQnLHZ6jxRSesHwNPz+0bhFl+baVgvD61DClEDqXO8ZbT8zqbnQMLPIlJtiPaCBO1
         OyNN8BNYPTkD67seGQDjMqGpvAa4DBCpr4YVPQq9gVsFTnmeUyLBw6bIQTBUiChdjZuM
         mC8Q==
X-Gm-Message-State: APt69E3KlgGDspmlibKmRbyaxolmSvbVs1Z7HeNW4EeXvn0kSeeg5kR2
        4WnyMFJslv872/AHRYlBSZmdIB454OlK9FW4yEM=
X-Google-Smtp-Source: ADUXVKK+toa8CVLrG+PprARmqJxOSpUNrr4Bbd2gjTv0dVPPnV2wCYpcMnLNee5o9O5ahHIzjMmZrUsoUXUKc8pQ3Fk=
X-Received: by 2002:a50:a4c6:: with SMTP id x6-v6mr5003205edb.247.1529758000181;
 Sat, 23 Jun 2018 05:46:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:a1c5:0:0:0:0:0 with HTTP; Sat, 23 Jun 2018 05:46:39
 -0700 (PDT)
In-Reply-To: <s5hvaacjrm4.wl-tiwai@suse.de>
References: <s5hk1r01acc.wl-tiwai@suse.de> <20180615190959.pqipwnm6a3tf3lxc@pali>
 <s5hmuvvtdmi.wl-tiwai@suse.de> <20180616154309.ualrx2py6ndr5xgz@pali>
 <s5hh8m2u3cp.wl-tiwai@suse.de> <20180618102806.vwm4rhvxhn6hi43z@pali>
 <s5ha7rsz8i8.wl-tiwai@suse.de> <20180618112121.cl76a3oozsbbbqnb@pali>
 <20180618112618.hcwiacfzzu4swwd2@pali> <s5h1sd4xg3t.wl-tiwai@suse.de>
 <20180621113031.gv53yv3g46uaetwm@pali> <CAEk1YH6-b3HtBN335XNxeYRWCCsBm52kC95_EZH3B4G-_TP5Pw@mail.gmail.com>
 <s5hvaacjrm4.wl-tiwai@suse.de>
From:   Damjan Georgievski <gdamjan@gmail.com>
Date:   Sat, 23 Jun 2018 14:46:39 +0200
Message-ID: <CAEk1YH7RJx8y-tcNZ5SwR9ruX_HZmH61=f4Vb+CN4zfoJM-oiw@mail.gmail.com>
Subject: Re: [ibm-acpi-devel] ThinkPad T480s & LED_MUTE, LED_MICMUTE
To:     Takashi Iwai <tiwai@suse.de>
Cc:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
        ibm-acpi-devel@lists.sourceforge.net,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 June 2018 at 13:39, Takashi Iwai <tiwai@suse.de> wrote:
> On Thu, 21 Jun 2018 13:35:21 +0200,
> Damjan Georgievski wrote:
>>
>> > I applied them to Debian's kernel (with slightly modification) and they
>> > are working fine. Via "alsamixer -c 0" I can change "Mic Mute-LED Mode"
>> > to "Follow Capture" and then led is ON only when microphone is ON.
>> > Recording from microphone is working in both configurations.
>>
>> hm this is the opposite of how it works on my T450s and X1, where the
>> led is ON when microphone is muted.
>> (I do wish the led would be ON when the microphone is not muted ie. listening)
>
> Don't worry, it's still the default behavior ("Follow Mute").
> Only when user chooses another mode (e.g. "Follow Capture"), the
> behavior changes.

Yeah, sorry, I didn't notice that the topic changed in the thread.

Anyways, I was intrigued and applied the patches on top of 4.18.0-rc1
and I can report it works fine on X1 Carbon (5th gen).



-- 
damjan
