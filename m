Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E727EC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 06:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7384E2089D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 06:06:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7384E2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kobol.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbeIZMRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 08:17:19 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:53825 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbeIZMRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 08:17:18 -0400
X-Originating-IP: 209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        (Authenticated sender: aditya@kobol.io)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 89C7E24000A;
        Wed, 26 Sep 2018 06:06:01 +0000 (UTC)
Received: by mail-qt1-f169.google.com with SMTP id h22-v6so8088681qtr.13;
        Tue, 25 Sep 2018 23:06:01 -0700 (PDT)
X-Gm-Message-State: ABuFfojKU5nmCBNbhXkFly+VUc423g30Qfh8w0s+HSypKAyv/ibb1abJ
        TNQCfAHNZhHUhXCWc5dLn/zTOwX10bG7Qy1bdmY=
X-Google-Smtp-Source: ACcGV62Ko02usxmXjVMeNFbpoWxqotcsHqRt2KBCQ+W2LQpp/YAVUD/GXXst2PFK9V+Cajc7pBLgFWLK9RFL12en9Jg=
X-Received: by 2002:ac8:3679:: with SMTP id n54-v6mr3421454qtb.133.1537941960346;
 Tue, 25 Sep 2018 23:06:00 -0700 (PDT)
MIME-Version: 1.0
References: <1537328730-9156-1-git-send-email-aditya@kobol.io>
 <1537328730-9156-3-git-send-email-aditya@kobol.io> <20180920072635.GB20392@amd>
In-Reply-To: <20180920072635.GB20392@amd>
From:   Aditya Prayoga <aditya@kobol.io>
Date:   Wed, 26 Sep 2018 13:05:49 +0700
X-Gmail-Original-Message-ID: <CAFTRUBdqz8fQN--KQ36LQm_EJpOvZ2723oDRyEn+_HMM5YK5CA@mail.gmail.com>
Message-ID: <CAFTRUBdqz8fQN--KQ36LQm_EJpOvZ2723oDRyEn+_HMM5YK5CA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: mvebu: Enable ARCH_WANT_LIBATA_LEDS in Armada 38x
To:     pavel@ucw.cz
Cc:     linux-ide@vger.kernel.org, linux-leds@vger.kernel.org,
        jason@lakedaemon.net, Andrew Lunn <andrew@lunn.ch>,
        gregory.clement@bootlin.com,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux@armlinux.org.uk, axboe@kernel.dk,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jacek.anaszewski@gmail.com, Daniel Golle <daniel@makrotopia.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 2:26 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> On Wed 2018-09-19 11:45:30, Aditya Prayoga wrote:
> > Enable hidden symbol ARCH_WANT_LIBATA_LEDS so CONFIG_ATA_LEDS can be
> > used in kernel configuration.
>
> Should that be hidden symbol and should that be architecture specific?
>

The intention was to minimize the risk of the ledtrig code being
included by accident. The
code itself does not have architecture specific instruction

> For a notebook, I may want scrolllock LED to indicate ATA activity
> (because I'm using USB keyboard and can't see the disk led).
>
> Hmm. And while at it... it would be nice to have option to watch all
> ATA ports combined, as well.

but there is disk-activity trigger for that purpose.

Aditya

>                                                                         Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
