Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3296075-1523347951-2-3323012913521074842
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, URIBL_RED 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523347950; b=YVJQx7yYvTuT4zS/JU7AbSynQeqjhGdImLVL3J69zij2850czE
    a0dtAg8HNqnz6/ive7mcCCvLGKae8Cu8QcLyZbeYBmz8n4c7poAGlWAo2V6rSLya
    w0Y26hyiNRIZr+2kU9lOM2ry+UulLToR1oYcNgjmx1qqamUvbA+cREsr2v2FDYbX
    WFqiyJ0lv80FV/vmSTMOnCtMOaji5F7oFTT9gmMvt2hhF+RCpTfTgWl8QLfli2rJ
    5FZ7g2+Lz3IT+R7jdO1yXxHaOcOCl43k7BdDyfvIT4+Q2qfhZ9mJ8wAu+s+iLyXC
    IUT74qwQFdkrQdgZBr9K2YNbE1zfV1zU7ZAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523347950;
    bh=1obyalmtEZDx1su5Iec8MtomjSayBWnW3QKoQ9KLIzE=; b=aDJLoUiQX0sc
    w5hloiYsMk2Bf/6TWeuwqcXrReREQ50os4ddZBwO9b7o6YtpGckWSjnKjksukMTh
    UJy5tmWxYr9sLbu42FSJK22pRTSSi+Wj/ZcihVPhYqCcXrZRbZaWkmRGyeYffhcW
    W4HMiwAWKxZPYMpj0cwP1NBYbsT4dO8Or+b+3IcnQCznu4w3zMP1coQAdOg4vAVb
    t2907ST/4Xa4VF5RpuvB19lP+AyOpAfwxgN3i6Df/NPcHZkaqbrNQaFHdjpWWfVV
    e5hNIjqUJNfqmZYzd/3Yzo57Bo2oPuzUTgkbOykFaBSruo+ZLyRLZb67X47CGWGs
    Mb2zsHEGvw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=bootlin.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=bootlin.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=bootlin.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=bootlin.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfL6QrI61W1QhyugfmJuJDMQXzGKd877dJNcGTSJbQtWrji+fLqvx3TOJjQtmbgI/nbq7edKq1cZoUQKxZg7uYs4Ygnwn2e2hJ4OYZ4HGrhzEU0spORKP
    X5MjZluI/h4uoZPKoszHIYWIX3r3wxRAUMoC21MzY9xYYny0yYwHx2W5Ker7qCitwtbEQPzo+soqWtmFTAl9P67qiRizsUht/v0c8IDZzzziDZelijT97Mr9
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=b5HTAggMAAAA:8 a=VwQbUJbxAAAA:8 a=uXOKQtt7xGH2hWp_QDYA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=zfgeMz1PSwFLVvhDL7gT:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752442AbeDJIMR (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 04:12:17 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38709 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752426AbeDJIMO (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Tue, 10 Apr 2018 04:12:14 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on mail.bootlin.com
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,SHORTCIRCUIT
        shortcircuit=ham autolearn=disabled version=3.4.0
Date: Tue, 10 Apr 2018 10:12:02 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Marcin Ziemianowicz <marcin@ziemianowicz.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 0/2] clk: at91: Added more information logging
Message-ID: <20180410101202.2abdf68f@bbrezillon>
In-Reply-To: <20180410001551.GA62208@hak8or>
References: <20180410001551.GA62208@hak8or>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Marcin

On Mon, 9 Apr 2018 20:15:51 -0400
Marcin Ziemianowicz <marcin@ziemianowicz.com> wrote:

> This is a series of patches which resolves set_rate() for the PLL not
> having any effect and therefore the USB Host port not working. Also, a
> few messages were added which may be helpful in the future when others
> are working with USB clocking.

Can you please send patch series in a threaded manner (the cover
letter being the mail email and patches 1 to X being tagged as
'In-reply-to')? Normally, git send-email takes care of that for you if
you do

# git send-email *.patch

> 
> Changes since V1:
>   Added patch set cover letter
>   Shortened lines which were over >80 characters long
>   > Comment by Greg Kroah-Hartman about "from" field in email addressed
>   > Comment by Alan Stern about redundant debug lines addressed  
> 
> hak8or (2):
>   clk: at91: Added more information logging.
>   clk: at91: Fix for PLL set_rate changes not being actually written to
>     PLL peripheral bits
> 
>  drivers/clk/at91/clk-pll.c   | 14 +++++++++++++-
>  drivers/clk/at91/clk-usb.c   | 10 ++++++++--
>  drivers/usb/host/ohci-at91.c | 16 ++++++++++------
>  3 files changed, 31 insertions(+), 9 deletions(-)
> 

