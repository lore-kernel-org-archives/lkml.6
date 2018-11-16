Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBE2C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EC742086A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:53:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EC742086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729833AbeKQJHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 04:07:22 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45486 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeKQJHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 04:07:21 -0500
Received: by mail-oi1-f193.google.com with SMTP id b141so11952944oii.12;
        Fri, 16 Nov 2018 14:53:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YM487RjAuKRlqpipqJj6oF67swr/NT2TrrKWia2CBOY=;
        b=WC+sx4JzHXT6T6u3P8IBf5DcsoziNYrM7yKKnY+DRSZox6xUkR96MCcC2gq7Envkw+
         p4399iVFJ7fRPg+Se5V/ENcgQ9abjs2N6b+03aeo6bf1vuGZVAIpg8GtvF0CCKxF3yPL
         2jUj2OvlfxBkJeIb5n1ru07YcTeh8cgR+xyYK58pdpqdUXaEkVxBa7CfAf5v+R2UfAz0
         uno+aWGZhfGKOZjrlpwxs5EZNy44j/shKZW4E1dEeqendc28T1JwaCN4GTZYDgm5x3+H
         s2teD+SfFQ9wPPZnjWeRzFjaAD3LB+oY+Qumbhf9VyhrKtSo8xm6yrSsTb6/6XuNUF0y
         GKHw==
X-Gm-Message-State: AGRZ1gJ2/1VuByogORBIZbvGkYL4XVjddjzGxo8eFj8fA5mDDhlZDwt2
        Jgk3+aF7ZAfpZqiybUPDsQ==
X-Google-Smtp-Source: AJdET5dRq3sKlmd7Ux0FmJnblp6YVNThw3yqpcuYFIHO9Md4D8YtT1+kVgxS9eOY7ey91rwBgqKrvQ==
X-Received: by 2002:aca:2dc8:: with SMTP id t191mr1976091oit.235.1542408785399;
        Fri, 16 Nov 2018 14:53:05 -0800 (PST)
Received: from localhost (mobile-166-173-57-127.mycingular.net. [166.173.57.127])
        by smtp.gmail.com with ESMTPSA id l18sm27888016otb.68.2018.11.16.14.53.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 14:53:04 -0800 (PST)
Date:   Fri, 16 Nov 2018 16:53:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Stefan Popa <stefan.popa@analog.com>, mark.rutland@arm.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        Michael.Hennerich@analog.com, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/4] dt-bindings: iio: adc: Add common ADCs properties
 to a separate file
Message-ID: <20181116225302.GA23266@bogus>
References: <1542108061-3471-1-git-send-email-stefan.popa@analog.com>
 <20181116183838.6a079255@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116183838.6a079255@archlinux>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 06:38:38PM +0000, Jonathan Cameron wrote:
> On Tue, 13 Nov 2018 13:21:01 +0200
> Stefan Popa <stefan.popa@analog.com> wrote:
> 
> > There are several ADC drivers that depend on the same device tree
> > bindings. Rather than continue to duplicate the properties, this patch
> > adds a common adc binding document that can be referenced. For beginning,
> > only two properties are documented.
> > 
> > Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> Looks very sensible to me, but as we are looking at a some generalization
> here, I'd like an Ack from Rob if possible (as he suggested it I think :)

Looks fine to me, but I don't have any clue if this will be flexible 
enough for various h/w.

Rob

