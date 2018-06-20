Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4C9C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 174D620020
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:35:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 174D620020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754976AbeFTTfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 15:35:41 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:34228 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754800AbeFTTfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 15:35:39 -0400
Received: by mail-yw0-f193.google.com with SMTP id b125-v6so273684ywe.1;
        Wed, 20 Jun 2018 12:35:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+IpjmmAyeG2wCSeQUSKU5YITICHNzL8mIa1wZfPZiNY=;
        b=TDHaAige52CunUECZFBS4wDeuuiQzqfDY6ssqJ7RQ5sthL0EWG/G7wGw+ZA5CYOiv2
         qTgkb/0aETpLSJVfB5VpVtJSfJLOqNreguXQWsrYG5IwKhfBizmrslDrtYkBtcUfzsyG
         KQGPNBPzKY19pfBL19afr2vm0GZGIBpheAVsei6RG0CO1QdpdUD9QrSznTLemIoIw3Dq
         kccCnSwgcf9fYKuUBEc4UEZyzDhJV/J1tcWOgCyEasUJHZGG8WRNVRdwA9WEWlUataZi
         IBZdmoQO4U2pn92Usq0GeVyllKoITpkaHjUftV61iUw/eE/xRS5t1y3FF1uWxwiwZQAT
         ALDA==
X-Gm-Message-State: APt69E1ychHdwCD3NI9b2jBFtEskEvTfjFMR0i+h2JxDfV1sTDUGAYqm
        p9u3V8O9/EdSygMBRlQgTvevFJhmnQ==
X-Google-Smtp-Source: ADUXVKL1i28/yncTFSULFiuC+Ov9pbTlQgOGwsfp9qE2usKo121Ia9uFrj+063HDWgOYwKHYX5teeA==
X-Received: by 2002:a81:4b57:: with SMTP id y84-v6mr10776624ywa.35.1529523338867;
        Wed, 20 Jun 2018 12:35:38 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id c68-v6sm1072386ywc.95.2018.06.20.12.35.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 12:35:37 -0700 (PDT)
Date:   Wed, 20 Jun 2018 13:35:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ben Whitten <ben.whitten@gmail.com>
Cc:     devicetree@vger.kernel.org, mark.rutland@arm.com,
        alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, nicolas.ferre@microchip.com,
        Ben Whitten <ben.whitten@lairdtech.com>
Subject: Re: [PATCH v2 1/6] dt-bindings: add laird and giantec vendor prefix
Message-ID: <20180620193536.GA26356@rob-hp-laptop>
References: <1529070055-18701-1-git-send-email-ben.whitten@lairdtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529070055-18701-1-git-send-email-ben.whitten@lairdtech.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 02:40:50PM +0100, Ben Whitten wrote:
> This adds a vendor prefix "laird" for Laird PLC who make
> CPU modules and system on chips.
> Also adds "giantec" for Giantec Semiconductor, Inc. who
> make eeprom memory used on Laird designs.
> 
> Signed-off-by: Ben Whitten <ben.whitten@lairdtech.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
