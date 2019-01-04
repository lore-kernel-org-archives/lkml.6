Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64E8C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D5B421872
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546621679;
	bh=aMZFLNMv+3c4Pi53ajEeHIzOHLg1YhMi6xbzSXdAQv8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=sn4opyI7zQ7Gu7W0aEeguHRuasyarUBW1twRVFNO/gUsQF4A39VojeApaLOgPpQK3
	 T8db8WhgdrjhkHMBR+50djg+K/viW/10VBkHhlvZusDSl+3qqcnKw4NJkVqZXedTdb
	 iW6w+QwOJ5ksag72JG6XSRQNIS9TKv5uPhfhnxwA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbfADRH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 12:07:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:50666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbfADRH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 12:07:58 -0500
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 783B1218E2;
        Fri,  4 Jan 2019 17:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546621677;
        bh=aMZFLNMv+3c4Pi53ajEeHIzOHLg1YhMi6xbzSXdAQv8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DwSunYw9zluW44vpdzKDfTgu/Q8w5FdKdY+FY8t7B8u0Kbd4dtkNbcO+SR0R4jFMx
         HaAvZ820V5Evy5+Ivj3yZJ/5vGYbx72S+ptocd3Lyq9i4Q5uKhEoWOta+4gbvFgpIk
         ETBYS1nxIpQ/Sahaobbhw0K+QPJAM9Pl9Ryn9Cq8=
Received: by mail-qk1-f175.google.com with SMTP id z18so5890948qkj.10;
        Fri, 04 Jan 2019 09:07:57 -0800 (PST)
X-Gm-Message-State: AJcUukc7rNBa2zT+1+wHiMK2FaBACBIn+HfkCkw+ybKR2+EVIDZSHzV1
        07nKOj+x6zN+zQVkTZ6uA9qcoiiXKfh9GrfUwQ==
X-Google-Smtp-Source: ALg8bN7KHWVX7SCKkw1pH6XNctNBAFHQYbD2JAosqLtzQnc+Dr7gf9GJ+6BRg2vuYFAUUVSWIzPoXb3OY1pT/k9mmTU=
X-Received: by 2002:a37:7682:: with SMTP id r124mr48792614qkc.79.1546621676666;
 Fri, 04 Jan 2019 09:07:56 -0800 (PST)
MIME-Version: 1.0
References: <20190104112131.14451-1-afaerber@suse.de> <20190104112131.14451-6-afaerber@suse.de>
In-Reply-To: <20190104112131.14451-6-afaerber@suse.de>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 4 Jan 2019 11:07:45 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+BMOvRLEbD2Eo2D=n446vSubeXV3-FbkBSHjpfL=LYsg@mail.gmail.com>
Message-ID: <CAL_Jsq+BMOvRLEbD2Eo2D=n446vSubeXV3-FbkBSHjpfL=LYsg@mail.gmail.com>
Subject: Re: [RFC lora-next 5/5] HACK: net: lora: sx130x: Add PicoCell gateway
 shim for cdc-acm
To:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc:     linux-lpwan@lists.infradead.org,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 4, 2019 at 5:21 AM Andreas F=C3=A4rber <afaerber@suse.de> wrote=
:
>
> Ignore our device in cdc-acm probing and add a new driver for it,
> dispatching to cdc-acm for the actual implementation.
>
> WARNING: It is likely that this VID/PID is in use for unrelated devices.
> Only the Product string hints what this really is in current v0.2.1.
> Previous code v0.2.0 was using a Semtech VID/PID, but no card shipping
> with such firmware is known to me.
>
> While this may seem unorthodox, no internals of the driver are accessed,
> just the set of driver callbacks is duplicated as shim.
>
> Use this shim construct to fake DT nodes for serdev on probe.
> For testing purposes these nodes do not have a parent yet.
> This results in two "Error -2 creating of_node link" warnings on probe.

It looks like the DT is pretty static. Rather than creating the nodes
at run-time, can't you create a dts file and build that into your
module.

Rob
