Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42101C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 15:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE73620869
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 15:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXHTvtv+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE73620869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbeIMUXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 16:23:10 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43271 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbeIMUXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 16:23:10 -0400
Received: by mail-io1-f67.google.com with SMTP id y10-v6so3411079ioa.10;
        Thu, 13 Sep 2018 08:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uc8x5B5uMqSvgGTcwWTC03EAT0U3e2aE2S12R9uPm2g=;
        b=SXHTvtv+8QIJ2cHmOmfEK3YgtxRD83101+oN+Z3BB+bOWQNhAm1QNDB/pQqEPB2Ln6
         MOgSjryQtA1a2tH2PRreeRl+9q0DNa8zBYl/siUlFa+rxV3CNvdXiWbz91tK9Dfj95iv
         d475sATXI0nnrytDU9cwZ3ZzDESp+JupBllx8mixpnuR/qzV9CuU9TLel0aABe0KcBeV
         UJ3EegE1ygeGg7ATosEOXom6nNcqSGj34ypOFyk9dDSWUQyTQIsGk7uCjvElcDMhzXKU
         HJZ+hBNZz/zaW9Fw+qjZb9jhj5LgIuOpWsw+C/w+nylZsSBW1ukYGcmpMqjUWGcpF5/W
         p1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uc8x5B5uMqSvgGTcwWTC03EAT0U3e2aE2S12R9uPm2g=;
        b=NlDLj3oA2u5sw7PBQfbfjiF0JFn0QtQzhKY2QsE1cBpGDPgtfkwtDXmsiiDtrgWgTO
         KPZpyZNVf6cxkqAE2DTuiaihmKx9fsHsfgMZa//vtRTcSNGs6NATFuLDVpTS7hsbAmVq
         O7tcuu6QRjKgTjUkWPY9kOw+5IEazLAi21dQlRGuu7fpia/IukB8mjcQFiANx3IYYl/Z
         XYZi8oIymFc/yzZUg9fccJixWKHSsYCIOdqaZi0dS2+1WwmDO7e4Dw+ieiqpsb7BN4if
         mKWM8ZJ/G4Y6LEaOhOdeqIbInD4mWVBR5+4Qb12GK9dIXfXWLvdwkcbJEEbHWkcPwhdm
         WjgQ==
X-Gm-Message-State: APzg51A1Po0cxooksYD+YaOmpye9FVvWivRdrAWxUPetEKqMTH7nHWXd
        LcrhCGA0qYK5gV4v+h8zvx1HUMqILC6cbQEnTvuf/mke
X-Google-Smtp-Source: ANB0VdYo6KSkY30z9hVdMFAhuaCOgMUddVNlicuZbJsmskZqKbfyMoypvN4el/Vi28r4qP5/j/TS/E8KPChz/n4K1mo=
X-Received: by 2002:a6b:d819:: with SMTP id y25-v6mr6768765iob.247.1536851594030;
 Thu, 13 Sep 2018 08:13:14 -0700 (PDT)
MIME-Version: 1.0
References: <20180908125754.1947-1-kristian.evensen@gmail.com>
 <20180910103022.GR1089@localhost> <CAKfDRXiVbE3-eteTCZjEqyR0LaLMpN8t4P_ihzHPChse9=FxmQ@mail.gmail.com>
 <8ce10eef-f332-a1c0-e16e-fb1c2055131a@gmail.com> <CAKfDRXgTL6L27JLbbOLLsXd9KK8vBtVCjrTNpv6R_MYCJoZqPg@mail.gmail.com>
 <de1b5aa3-d9d6-da49-7e49-553694f5b666@gmail.com> <CAKfDRXi3QdB0qCvqHPFXpxdpiHSJ2WoSqZGgjD3gEzAaPbBPUQ@mail.gmail.com>
 <f2c15eef-ed8d-12c0-2ba4-3dc068ca9fd4@gmail.com> <f3c647ec7c50ae390fb92861d492e7aa4bef8c6f.camel@redhat.com>
 <87y3c6a1zw.fsf@miraculix.mork.no> <20180913091753.GA3443@localhost>
In-Reply-To: <20180913091753.GA3443@localhost>
From:   Kristian Evensen <kristian.evensen@gmail.com>
Date:   Thu, 13 Sep 2018 17:13:02 +0200
Message-ID: <CAKfDRXgNxohLv_SzAZ0niv5QreToSotACadTMx_fqSi_ozObvg@mail.gmail.com>
Subject: Re: [PATCH] option: Improve Quectel EP06 detection
To:     Johan Hovold <johan@kernel.org>
Cc:     =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>, dcbw@redhat.com,
        Lars Melin <larsm17@gmail.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again,

On Thu, Sep 13, 2018 at 11:17 AM Johan Hovold <johan@kernel.org> wrote:
> Kristian would you mind giving it a try?

I just finished backporting + testing your patch with our 4.14-kernel
(mine is already there) and it works great. The driver correctly
handles different EP06-configurations.

Thanks a lot!

BR,
Kristian
