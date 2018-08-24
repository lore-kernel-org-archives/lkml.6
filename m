Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CEDBC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 20:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0341C208FE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 20:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VuMTDQK7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0341C208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbeHYAdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 20:33:40 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:34499 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbeHYAdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 20:33:40 -0400
Received: by mail-io0-f173.google.com with SMTP id c22-v6so8222039iob.1;
        Fri, 24 Aug 2018 13:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zDgpmNlejtRjiBLSWcQI9VJ+g1fSVIcS+DIbcVvXXII=;
        b=VuMTDQK7X60nhGCg7uii6zpo2wWYvymXTlpixnpaxQFkp+ITc1aI9HAkAz3q6xmqC9
         z6A7VUDFA4VEG6zKjljGIZetCKCiLddzoXOHMHYxT2CNYsl9rPR7wZx1/h+c+RWWCNo3
         dKwbFI4gkE7Zh7tdENmJZKzfSXHmC1Rj6ejCAUYBzhHil1VhSrSDO1vOBCgjcELxLoLa
         kmjUqVKORx1qjTXWau00lQ6YRoJ1dIHNv6PJIeaAHt0xxqDcy0ZVSd4j03ZZNBqoWdM2
         JRip+9Pi/3ASdAKoZyf4HoVzh6vzX6jdyqOcQ8jfB4rjyqz3GPmv5u74kNeO8ukXRckr
         0uMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zDgpmNlejtRjiBLSWcQI9VJ+g1fSVIcS+DIbcVvXXII=;
        b=oH6HnFkGbmcm69WIsbOZB6Q34iHRpbvkxObMOQaqZKDepq1Rr8btmkefokut2dQYVG
         w4DAJ/ADUN08XwXloRQdEDkF4NsKkHGJxtj+hc+ieK6zyhp3+orff+gtfVCr3hybhJxe
         wQgG/J+nddlNHfrDbiKdkrsog/kLzrRO6ahqyo4R3CKJRe2zc6+DZs4CrWLxrZE4balz
         4D6DBTRtGpLPzfsHv44wcghuBRjmbpA3EZjQ6squ9q40H48W2Dcr41ZTXKw7bBY7FtUM
         +Y9uW41HWvVnBQh7TjnnNVHyrLSp/puP7ATM52QCGUJNBBwmoKuWzUH9INbJabnVcAGK
         cw5Q==
X-Gm-Message-State: APzg51DNikCwPMzEkt7Beat8QtlifSKeCecJfDG8fQekbYwxvwX2VVzS
        9Ua5MfhxXKX/3kzC21YNo+L8WE/UMvL5LVQ+1OsPCAaz
X-Google-Smtp-Source: ANB0Vda3ZAhk3AHyLvey6r83Wk1M4pyBogcV/nJQbsrpjiL8CB1v1QgPIW+2LR9aqDJIbc6dOxdflPg1Y1vVL6Si+Jc=
X-Received: by 2002:a6b:d541:: with SMTP id x1-v6mr2675888ioc.152.1535144244338;
 Fri, 24 Aug 2018 13:57:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180815190449.23738-1-zertsekel@gmail.com>
In-Reply-To: <20180815190449.23738-1-zertsekel@gmail.com>
From:   Kosta Zertsekel <zertsekel@gmail.com>
Date:   Fri, 24 Aug 2018 23:57:13 +0300
Message-ID: <CADxo8WKvfKS+NEqPYj6SeR_F87Dub7OLPzEBbOESJ8L-=GEAWQ@mail.gmail.com>
Subject: Re: [PATCH v4] spi: orion: cosmetics - alias long direct_access variables
To:     Mark Brown <broonie@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?B?SmFuIEt1bmRyw6F0?= <jan.kundrat@cesnet.cz>,
        Stefan Roese <sr@denx.de>, Ken Wilson <ken.wilson@opengear.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guys,

Any additional comments?
Or the patch is ready to be merged?

Thanks,
--- Kosta Z.
