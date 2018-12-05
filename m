Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDBEC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 237EF2082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="RzfK8pdF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 237EF2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbeLEBBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 20:01:14 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41085 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbeLEBBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 20:01:13 -0500
Received: by mail-pf1-f195.google.com with SMTP id b7so9099214pfi.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 17:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=VJ4Xggx/M5TuF1a8xLngAs7VDg7Kg/bcesHAhVDONtY=;
        b=RzfK8pdFyLksbusmB8e3SXki8e8zPkdYAZia4U+Tfeln+wY1bkAbPX4QFzku5ofR0Z
         LRAeQft8ftzAr+g0BBTfKC2aWvMEk9rXQU/AYN9hwdmvi9R7rkggzbslm5r7fJzn5WKM
         4T/iz9GtYAkwZY3iFlD3lgTgmkv+4RbZzRPfugFpSXAmsvtp5DW8t04rYfE5SECxCua6
         z3DldOYh4Y3mZgcUQDboEHQu7sXT0BwfCjk8M4frTt/A4/8Gjiy5j9SwA7A/VsnfVZSH
         Yzu5eMgUlqXbYXPc/jy6Er3rBV1nBNTE+AyuqJFRsOeDpwKNPOedbeVKxpoeAdoYcwyb
         5zUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=VJ4Xggx/M5TuF1a8xLngAs7VDg7Kg/bcesHAhVDONtY=;
        b=sIECX/wMNohH50ynYrp9LUyTyWeWDPpLMUfwm2gcuLfMoV8Ev9aPjyUfLwp5knPiuo
         LA4vdAwn9v3gI3BFQy1JB7rl1xyoAwGoNIc9wv0renmv3XXated1RXox6muQP8Tn2pLH
         OpDmM+Ge3h2VhhpWeCGOFKM3hV18qPf6fEIFfv5ZwXQgKgW0wrxPgKQ3ijNeFeo7u8td
         AgOT4f1enI0NUBetpRKK89dSuy21QmtturDGnumv8xuvTtOqTQWEyN/1Ay+Bt00yIP5O
         +CQ+2WghtfD06rkcyA6hRoc+cvLOqU6b8j4ycpv9kM7ossPVwFaFpM5D0WwVQ9pESdJg
         +ynA==
X-Gm-Message-State: AA+aEWbGLBxslBt7eH+VrQHNyL8CPzdN1wFI4+ZvpMwABAuSbZkcvwsV
        C9xBmKZIBfta4vKqSGkDGV5dwg==
X-Google-Smtp-Source: AFSGD/XucL5NZBkNTnqI9hosWyuzrKRTkweZcEuw0ajmO8GnUu/pgA/O0jxAl3OIKVAVP93NXQy9/w==
X-Received: by 2002:a63:f658:: with SMTP id u24mr18745008pgj.267.1543971672921;
        Tue, 04 Dec 2018 17:01:12 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id e128sm25594123pfe.67.2018.12.04.17.01.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 17:01:12 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Sean Hudson <darknighte@darknighte.com>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Grant Likely <grant.likely@arm.com>,
        Kumar Gala <kumar.gala@linaro.org>, arm@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Carlo Caione <carlo@caione.org>,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v2 13/34] dt-bindings: arm: amlogic: Move 'amlogic,meson-gx-ao-secure' binding to its own file
In-Reply-To: <20181203213223.16986-14-robh@kernel.org>
References: <20181203213223.16986-1-robh@kernel.org> <20181203213223.16986-14-robh@kernel.org>
Date:   Tue, 04 Dec 2018 17:01:11 -0800
Message-ID: <7hr2ewbxd4.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh@kernel.org> writes:

> It is best practice to have 1 binding per file, so board level bindings
> should be separate for various misc SoC bindings.
>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Carlo Caione <carlo@caione.org>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-amlogic@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/arm/amlogic.txt       | 29 -------------------
>  .../amlogic/amlogic,meson-gx-ao-secure.txt    | 28 ++++++++++++++++++
>  2 files changed, 28 insertions(+), 29 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-gx-ao-secure.txt

Acked-by: Kevin Hilman <khilman@baylibre.com>

But this isn't really related to the schema series is it?  If you
prefer, I can just queue this one separately via my tree.

Kevin
