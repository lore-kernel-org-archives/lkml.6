Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DD3C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F29920866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ciYaCuum"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F29920866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbeIJMlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 08:41:53 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:37728 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbeIJMlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 08:41:53 -0400
Received: by mail-it0-f65.google.com with SMTP id h20-v6so27463196itf.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 00:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZhNqmJ+r6uG+UmMpv958U+glbyuDBh2JeMzYExJT2pM=;
        b=ciYaCuums/YAo82lnCWV4lLkhZmdsAOI8wOYxgDqAcFNldE0AeJce5QijDNIvIJd0R
         4Q6AH9oyjx0z7hzkv0Y/X4zAufGAwczztD8KdHpoz6JwjKbVcvIA1/ydkPh3SX6pYWgL
         hOuc1WQ610vJMwRwnxnW3CfrmkrifkFPA714Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZhNqmJ+r6uG+UmMpv958U+glbyuDBh2JeMzYExJT2pM=;
        b=KXtI5pPHxYuL13rfZxUBsgWp61izpWn1kLBfWR84KYku66Ads4RzLTT8HAtGvhMz0L
         rwY0D1G0x2q8ks/NtQobPxtsNeiACvFpLT6brJVtjE5OSw1y6uELG5sERnwlvKy2RbW4
         s8wwT3bOWn4UNcr/FOa7l4sUQQvxoeTPvYa+wNJSP0X9bcKJBXcOCZrF7bgB1wiAK57R
         VNwMsjC4N2d+6hbflF8pW83FmpGwbtYm+cagpiBxYK/NrRsZKMgCFtbI0E/G6YoesFEC
         PmyQrYUyXO+x40V6uvm5/GUTza3olBoow4o05I1BJA+bjPRtuXGzVfNqt06G7oLgU9D6
         9E9A==
X-Gm-Message-State: APzg51AfJ61Y2QkO2y0/n8BiedW8c9MARWYiYwMihdNGByLheXvjtu9h
        CYx8CbT4Iwy4rplpr/Ca0XlbLUrPblVxt9V8+X7YHA==
X-Google-Smtp-Source: ANB0VdYIFFkmWKJft1JRsRsjh+v2nfvLeeoXYl8Y2mXgkX2hW7hFCXDUAHK/GOJSNx1wusRbg71fZM05ZqkaNEGjWsQ=
X-Received: by 2002:a02:5916:: with SMTP id p22-v6mr16361532jab.113.1536565749914;
 Mon, 10 Sep 2018 00:49:09 -0700 (PDT)
MIME-Version: 1.0
References: <1535634775-19365-1-git-send-email-phil.edworthy@renesas.com>
 <20180903103358.GC20333@w540> <TY1PR01MB17697F04004A7C8CF1D21CC1F50C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
 <CAMuHMdU-CcckKueeT5r9-jCoNr0H5KhzrAMbL4LeFta_fAqWuA@mail.gmail.com> <TY1PR01MB17697A2D3BCA85B3BFC1FE21F5020@TY1PR01MB1769.jpnprd01.prod.outlook.com>
In-Reply-To: <TY1PR01MB17697A2D3BCA85B3BFC1FE21F5020@TY1PR01MB1769.jpnprd01.prod.outlook.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 10 Sep 2018 09:48:58 +0200
Message-ID: <CACRpkdad=U5YACQ6k86A4BJo9-U4bC61A0kJ8kONSHu+u3BPyA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Renesas R9A06G032 PINCTRL Driver
To:     Phil Edworthy <phil.edworthy@renesas.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        jacopo <jacopo@jmondi.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Simon Horman <horms@verge.net.au>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 5, 2018 at 11:59 AM Phil Edworthy <phil.edworthy@renesas.com> wrote:
> On 05 September 2018 10:37, Geert Uytterhoeven wrote:

> > Have the VxWorks DT bindings been submitted for review to the devicetree
> > mailing list?

> I'm not involved with the VxWorks port, but I am pretty sure that they have
> not been submitted for review.

We have had other cases where deployments on other OSes have been
establishing bindings (even not very pretty ones).

Examples include typically the Power MacIntosh and the original SPARC
bindings.

Yours,
Linus Walleij
