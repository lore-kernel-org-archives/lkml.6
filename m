Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 835F0C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 14:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EE8A21782
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 14:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmVkQ9yg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EE8A21782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729891AbeHMRUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 13:20:33 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:33677 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728778AbeHMRUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 13:20:33 -0400
Received: by mail-it0-f68.google.com with SMTP id d16-v6so11768626itj.0;
        Mon, 13 Aug 2018 07:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IVe3bp1cMLioD8xF1aet4fpTlJR3AGKU9IM4aMOVP1o=;
        b=XmVkQ9ygUhqzTSxSNJMO4eaVsKZ3QXo/sqaerWrwOtzyTS3E6TegM/R+0Qlmlq3Oq7
         ttCHiOOf89gH69Fqmx01HZX5SX9a2ak76RHy/ok5LrrG7nQifU6EHXeIdKf7ERl+Kbfr
         aDa5CHAsiGigeYZRdN1M35ztRWPlOq8FHKeep+v52V5+VoFCrUmDWBvV1tM/uoSeCrzw
         WT0fwu/Iv4xnZ8L/uBpIq+Jihb/2Y3YOJRCqRdPO0/P5NjFjObP63WLRXVWBZZ5Bzbwj
         g7iuD3ap/LcmKuRDikXH+78UHOanxCYqyNwJY2dxoi8qTk657ocg1Wc2li8dt+AQXbtg
         WACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IVe3bp1cMLioD8xF1aet4fpTlJR3AGKU9IM4aMOVP1o=;
        b=OXJdR99/hKL9pFW0PDGoKpuW82bHuWoBtZQjfFbMufkR4IrXIdBbSnUPEWYJatf9vv
         qgGsgPhdBzVV8Rzfe0dCeldfxssXMQlfdmrP5JAA8ac+bij1mUoaA8GH42oJn3znwVow
         OwZAYNWyeOk8rPMQvHLgMoRhz2akWBhT6dWPQV5MnIZbg5R6WWkSrg4MCzQFKrptGe5s
         6ZkvSYa2hOBbT0yVoWUrYhIlTSEVoVaZCyye7eqzxj5rbVZRN+b0t/h9iSgj9Jt+5Hoa
         98wBbFLaqL1U87nqeCSg/Sf3DNu1SR/NRcOZRNHXJ4+oJ/B+6rqXwEoY/zCVWBhm4liO
         MErw==
X-Gm-Message-State: AOUpUlEDjx19iCM0O6t4+x0KSaXTOLG1RMixFWMtvEZRf6tv51ntBYUB
        3IePhV4YIg2qjoCX+2B+dsKQI1XXMNyNFkGEBCI=
X-Google-Smtp-Source: AA+uWPxsMPojUzJzH9nWC+prWuHQr/EO3+nJm6ToLkMt8T+nrkgQh3Ij7CdZC5n++LYSr+lPGwjY9iEzMetcqOrF4HU=
X-Received: by 2002:a24:b54b:: with SMTP id j11-v6mr11108954iti.79.1534171079934;
 Mon, 13 Aug 2018 07:37:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180810001714.14659-1-andrew.smirnov@gmail.com> <ad932296a864b13134c5af6efe7754e5e588314e.camel@hadess.net>
In-Reply-To: <ad932296a864b13134c5af6efe7754e5e588314e.camel@hadess.net>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Mon, 13 Aug 2018 07:37:48 -0700
Message-ID: <CAHQ1cqEMJFCD8GU9o194EUPfUV9TTswW-jE2MPhoEzrg3cshYQ@mail.gmail.com>
Subject: Re: [PATCH] hid: microsoft: Add rumble support for Xbox One S controller
To:     hadess@hadess.net
Cc:     Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        Juha Kuikka <juha.kuikka@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 4:38 AM Bastien Nocera <hadess@hadess.net> wrote:
>
> On Thu, 2018-08-09 at 17:17 -0700, Andrey Smirnov wrote:
> > Add HID quirk driver for Xbox One S controller over bluetooth.
> >
> > This driver only adds support for rumble. Standard controller
> > functionality is exposed by default HID driver.
>
> Did you manage to make the joypad work without hacks in the Bluetooth
> stack[1]?

I was not aware this hack actually existed, but now that I see it I
think it explains why doing

echo 1 > /sys/module/bluetooth/parameters/disable_ertm

was necessary to make the controller connect over Bluetooth on my
machine. It looks like disabling ERTM just happens to have the same
effect as the hack that you mention. I'd like/plan to look into
finding a proper solution to replace that hack, but that'd probably be
a separate patch.

Thanks,
Andrey Smirnov
