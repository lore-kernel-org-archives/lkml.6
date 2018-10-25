Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC702C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 17:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5642B20848
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 17:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pBE36YUO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5642B20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbeJZBfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 21:35:48 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38591 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727574AbeJZBfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 21:35:47 -0400
Received: by mail-ot1-f66.google.com with SMTP id l1so9828866otj.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 10:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SaZWBXqG3Ybod0NnyCDjuz9mi3nAcf18DKNoWpTncsI=;
        b=pBE36YUOr/rl87zEzfWbp92eV2xn872JX1UG+ckMC5mglA+3w4frcTgxBOCRiFAYjA
         J08PNvG4pliKwmzSA26POJ5JpSEy9rf3pIIdUDpq+lYVXQq2pPSdQs3VME/eJasUyRZV
         jOVlsAzrdz1H7AWU9XLmVZdVbfptP75HCua+3zQxjsXwhPDIZ6n4uqJow/RWWWOzrQYV
         CFbowLyspV6ionyKW59Vbb9o/UDjlej1ZeIj8SVoKYbqJBu/fR4tmNCTXyoUqITVnnFU
         p0vwzM8qAQDZbCx+xBuaaeMLdSBsLDSv/uC+RPguk0yre/2gD2/oDX6/nObbBXjJ5yx3
         I+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SaZWBXqG3Ybod0NnyCDjuz9mi3nAcf18DKNoWpTncsI=;
        b=Up7NXeLvi6pD8ME1xrWA1V6Zz48DOcPUHB2SY3mxowhm4Hx3i/011O+w1EmfHCmARs
         MEozzMuNPUc93WpD1bqeWWWn4xRgJQJG7WoX1kBZuPANCr3FiUTN13oYyHLziDS3O5Wl
         u0sSHzr342FIcBKRZZqW7tm3gJZ7N9eYh634gtoSbL3afCCuZtgVVERTYo/sL/kMhIn/
         EwPz0w2Nl8UJk1rTx8Io9ja96AgZTwgdj8mGdKI7CvI4nV7WMcZ0S/I36TH6JYCbLX2t
         YP8Bd9Eb7+ynCwlFfAsRgNwXZy59vZfJem+7mWmtFm99/u2Rt58I5Lqdy3HeDYR+7XWg
         kGQw==
X-Gm-Message-State: AGRZ1gK1Qx+L5XzOsyDRFnzAFNCulPieb1OzQrUAjM+xjWy6FfgMZ56Z
        lYXUrX1vTWZMw8/tNutom7xaU1BZ6NjkrCryfemABg==
X-Google-Smtp-Source: AJdET5fQTzk42asZIiqMdErqJrcpurF5oY/zJRgCmT+OfpBUDLwC3ol28IX7GdXeZ2zPZPgwoLM8TqzhB1yjnDxUBfg=
X-Received: by 2002:a9d:bb8:: with SMTP id 53mr45027oth.120.1540486929487;
 Thu, 25 Oct 2018 10:02:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:2ac9:0:0:0:0:0 with HTTP; Thu, 25 Oct 2018 10:02:08
 -0700 (PDT)
In-Reply-To: <09986c98c9655f1542768ecfda644ac821e67a57.1540369608.git.jsteckli@amazon.de>
References: <09986c98c9655f1542768ecfda644ac821e67a57.1540369608.git.jsteckli@amazon.de>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 25 Oct 2018 10:02:08 -0700
Message-ID: <CALMp9eQ=+jEabpDqa-a7WP7LVfTjmpW1ymWrVYeSxH4O4XOmyA@mail.gmail.com>
Subject: Re: [PATCH 1/4] kvm, vmx: move CR2 context switch out of assembly path
To:     Julian Stecklina <jsteckli@amazon.de>
Cc:     kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, js@alien8.de,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 1:28 AM, Julian Stecklina <jsteckli@amazon.de> wrot=
e:
> The VM entry/exit path is a giant inline assembly statement. Simplify it
> by doing CR2 context switching in plain C. Move CR2 restore behind IBRS
> clearing, so we reduce the amount of code we execute with IBRS on.
>
> Signed-off-by: Julian Stecklina <jsteckli@amazon.de>
> Reviewed-by: Jan H. Sch=C3=B6nherr <jschoenh@amazon.de>
> Reviewed-by: Konrad Jan Miller <kjm@amazon.de>
Reviewed-by: Jim Mattson <jmattson@google.com>
