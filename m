Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C40EC433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 05:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C023620833
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 05:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbzzWVWT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C023620833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbeIWL2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 07:28:08 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38372 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbeIWL2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 07:28:08 -0400
Received: by mail-pl1-f194.google.com with SMTP id u11-v6so7700669plq.5;
        Sat, 22 Sep 2018 22:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9XgC6zXvenDtvbruJd1ZGg1kjf8Kc8q4OfayyGuymDI=;
        b=IbzzWVWT37lL5OClU19j4ghP6IBWlDsCDAMMqwmDi12jSm+PPqc1bnOLsfGVU/XY4s
         JQoI6xRwVqJyg2eBh9U9bzVlYuPSYLKa9BEVBeceRowskJKub8zY5vYRGwRbPBMJyZo6
         hhVrmQcynUZyL6SVbdmCxAqCSM5HhQZB5Qnhx3iVbAkZQ3KddD6rEZadHgkYh2bXBWtt
         O4ENrvLeiS9rZQs4MhGqHHHB1hKKlQ5IhbPesQvANgawJO/R/xGOnp1Q5NHWQh4BHQMB
         lxhKlgY/9TAjfbsUX4fStMLCAHQS1YFrwwEujKEdkoTXxxGg+tX50MnUXt29NTZy2z17
         Tzrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9XgC6zXvenDtvbruJd1ZGg1kjf8Kc8q4OfayyGuymDI=;
        b=m9NgoNBc1moCCxsk3be7fAOfFpz13RutJ0abys1YL14OVtRLqcwwBwJVIHbGh8EI+2
         XLkhu67J7IQHKGddGtyHEfaP85FFxPvhPZ/sNwK4xN7sWGdm5gfRz91QS2Qth9tuxCq/
         3vZBbCmTAyFPcc7VkhhKDJ1O+/xFxCPOUazSi9jcnxg6/yL36GSnIF+jmlRiL7wEOtru
         hK4DwN4GOn2F/OYkSyKulBrrmj9LYiz6ifiQlI7KbuwLSXS/wOqm8cA3QnC0BftFbt4t
         MERTwSUtHZtIf6uCopz9P1haxB6nH+SwxK0EaKR9VNvguHddGGBUvnddG62m1BTSm4Z4
         lmYg==
X-Gm-Message-State: ABuFfoi1z1gzzNqssS3ftzox8PH/ezPOUK7wTS0qI2sFm6PWJ77JGZVy
        MOks98h4IYf74RN5GurqfE4=
X-Google-Smtp-Source: ACcGV62C4ZsQR5QE0Oer2I3iO1BTDRCPF/nm1Tu3cs/G7FlDFD9HC07n3Y0KnSOVfkauPgABvBtPTw==
X-Received: by 2002:a17:902:3a2:: with SMTP id d31-v6mr4999612pld.287.1537680716429;
        Sat, 22 Sep 2018 22:31:56 -0700 (PDT)
Received: from Asurada (c-73-231-2-134.hsd1.ca.comcast.net. [73.231.2.134])
        by smtp.gmail.com with ESMTPSA id l79-v6sm57268655pfi.172.2018.09.22.22.31.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 22:31:55 -0700 (PDT)
Date:   Sat, 22 Sep 2018 22:31:52 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        corbet@lwn.net, afd@ti.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: hwmon: Add ina3221 documentation
Message-ID: <20180923053151.GB9960@Asurada>
References: <20180923041118.8743-1-nicoleotsuka@gmail.com>
 <20180923041118.8743-2-nicoleotsuka@gmail.com>
 <353ccbbd-94c8-72eb-eb98-8a0507431e15@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <353ccbbd-94c8-72eb-eb98-8a0507431e15@roeck-us.net>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 22, 2018 at 10:19:42PM -0700, Guenter Roeck wrote:
> >+2) child nodes
> >+  Required properties:
> >+  - input-id: Must be 1, 2 or 3
> >+
> >+  Optional properties:
> >+  - input-label: Name of the input source
> >+  - shunt-resistor: Shunt resistor value in micro-Ohm
> >+  - status: Should be "disabled" if no input source
> >+
> >+  Example:
> >+
> >+  input1 {
> >+          input-id = <0x1>;
> 
> We'll have to find a better name for this. Feel free to look up examples in the
> existing devicetree descriptions. The one that seems to be used most of the time
> to indicate a channel index or id is "reg". It should also start with 0 - there
> is no real reason for it to start with 1; it only makes the code more complex.

The reason is that the port start from 1 in the datasheet.

I don't mind using reg or count it from 0, will look up to
see if I can find something solid; otherwise, I'll wait for
binding doc maintainers' opinions before sending v5.

> >+          status = "disabled";
> >+  };
> >+  input2 {
> >+          input-id = <0x2>;
> >+          shunt-resistor = <5000>;
> 
> I would suggest shunt-resistor-micro-ohms as per
> Documentation/devicetree/bindings/property-units.txt.

Will change it.

Thank you
Nicolin
