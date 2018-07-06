Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA8EC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 802802133D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:35:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 802802133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934710AbeGFSfL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 14:35:11 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35961 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934326AbeGFSfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 14:35:09 -0400
Received: by mail-qt0-f196.google.com with SMTP id f1-v6so10729911qti.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 11:35:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZAEHiVNqdSeX4P38xpV2De7uG7HEnoFSoz2rNMkM9Sg=;
        b=eHxzmmtTvjtfvy/oWpLg5PcCqChrhggKhhNU8+WEgPJ9zmTMo1Yj0T6qCHbPdXmwSu
         qcQu5TJ6cZj+saFhRF7iOF5H9W1uHkk6RCTBClzfz8Rqlq2tjH8u3o650PCHPRxMwUY2
         jq4Xl2YGYQktw72ofvN/H4ip7uAL4cNjnC78BcWoXMusaizTQT5cx6nkXcguWUbhEXV9
         K34saurwkI/XDNbzHFK7mkK2p5phFlM6Rayrpv3otHBCV2y743RHmxBwhDEBdfCqeBSc
         fO+LwQQgyYC882TqT5sKm3/TsFugwAxM9JBOUOK0iOjS6rxrSrDcLCZc7znK8PGZlU9K
         9o6w==
X-Gm-Message-State: APt69E2O7r5e+h3MiBvlcc2vbkAz241kHm5vLyGPscFNcA2+IGnNKdb2
        73+tAXOKZSGe8I3eB34LS489Hmm0b88=
X-Google-Smtp-Source: AAOMgpfJp0xN7Mdw3nblv26aWc9rrzDN1RS4BTMi9E8QHqHKmIXpKudwKLRfwrmTITI/zW7LSos2tA==
X-Received: by 2002:ac8:230b:: with SMTP id a11-v6mr10564471qta.123.1530902108886;
        Fri, 06 Jul 2018 11:35:08 -0700 (PDT)
Received: from dhcp-10-20-1-165.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id u25-v6sm6097917qku.3.2018.07.06.11.35.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 11:35:08 -0700 (PDT)
Message-ID: <e127596f255261d78fdfe6f534a1000f60c3c605.camel@redhat.com>
Subject: Re: [PATCH] drm/cirrus: flip default to 32bpp
From:   Adam Jackson <ajax@redhat.com>
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>, Dave Airlie <airlied@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" 
        <virtualization@lists.linux-foundation.org>
Date:   Fri, 06 Jul 2018 14:35:07 -0400
In-Reply-To: <20180706091249.25086-1-kraxel@redhat.com>
References: <20180706091249.25086-1-kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.2 (3.28.2-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-07-06 at 11:12 +0200, Gerd Hoffmann wrote:
> cirrus can handle 1024x768 (and slightly higher) with 24bpp depth.
> cirrus can handle up to 800x600 with 32bpp.

16bpp is maybe a better choice? Nobody's using cirrus because they care
about color fidelity and it'll use less CPU to update. There's
precedent here, mgag200 defaults to 16bpp on sufficiently memory-
impaired devices.

- ajax
