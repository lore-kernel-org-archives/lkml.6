Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF9FC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 04:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB42920864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 04:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzUjGDde";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="KA5gsvlt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB42920864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754736AbeFRExg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 00:53:36 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:45037 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754264AbeFRExd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 00:53:33 -0400
Received: by mail-qt0-f193.google.com with SMTP id l33-v6so14084946qta.11;
        Sun, 17 Jun 2018 21:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ytW6lLIuezYtSNdm05BBBv2PMzV8nTKMJfeqohHLF+0=;
        b=hzUjGDdef4MpMBvFsyI8Wx0wyladSrY4WC2A4wM80j2NThmnQ+mCQJuNPwfan7pCfD
         ThwjiZ26Gu5j+T6ro2mJAdm3l0GJ6k7PtSL5nJwGheS4mgcjQRNaj+PxIMt2HYfi7vAw
         aNcq4ZDsGWBG5rR6Jp2DgYtvK0gV0QM+rskYHvipBruN5SJvjSeYvqoW8LWej6Zu4+fs
         05lpJQ4oEONHoSGs/LN/QK0N2hDFcdNO17sxZimCGcug8lBq53P74pyaJjxHZZwtNs+O
         hDrKXz1uJVDVUjRZH+Juf/IL+jIGj5tPBoZmZ9thP8sjyqDeEyoXjtX9O3uRfvi0sc2d
         oh2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ytW6lLIuezYtSNdm05BBBv2PMzV8nTKMJfeqohHLF+0=;
        b=KA5gsvlt1vNcm2ktPFnpsfGtoqD09tBoyaxYy3IKEsJIvJ2T0zDShodxp9FbVcUvOB
         14gTA0kys9H8gXcLdqQN8XwA0Yp1K0M7LzvGcA6EHsmziXaSnk9zLdzKAWGR5zc5L73J
         Y9JZs3EWcWZjeQKvoRV4TM5H6oksVvuUW9K0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ytW6lLIuezYtSNdm05BBBv2PMzV8nTKMJfeqohHLF+0=;
        b=YOJ1cHN4LHNPSb23adpm/JmI8t1geB1ra4g0eoa895kP8QK4dFkJce14looK44hjCm
         C86p4dA46wUVx/croFYZiOL1XYDX2Hu2+jZI+4VqBuY+04suR/4kt7ghc/Z3Fgf3cjFP
         0RyfggfGtRU2Z3qs+bYouVuvRXl1zyzazF6WJsdEOgzFDUzGg4YskHNggFI2S9HZRlKm
         X3YRI2SZGgFOwLZ9jwWQHWzW7y8O8CdvUlGui9M8rlszlVk5QJIK2/our2ZvVHOqtOjK
         P41ppYdC3kA3S13WpNqwqDiqTvfnTTz+Vxz3cCYUf67IqOFMxMuLJ2HVHDXJIMad+pLe
         ve/g==
X-Gm-Message-State: APt69E3qxV+g+ggcjxknZNRvIlUkvOcJsxyz6Quw9Nx3TSGoN5ynYhom
        tGuPZ5VBOUE8gb4h8uVBQYForRrNd77SB8Fr+k0=
X-Google-Smtp-Source: ADUXVKJrxLom5UaDGM9crISlamJsMekd9RTCqtu6DycqgkpoeJzUivLzRLpGmalq2dufQETanYcuHYSy2dssU9cPFEI=
X-Received: by 2002:a0c:a2e5:: with SMTP id g92-v6mr9467795qva.60.1529297612264;
 Sun, 17 Jun 2018 21:53:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:184d:0:0:0:0:0 with HTTP; Sun, 17 Jun 2018 21:53:11
 -0700 (PDT)
In-Reply-To: <1528918579-27602-1-git-send-email-eajames@linux.vnet.ibm.com>
References: <1528918579-27602-1-git-send-email-eajames@linux.vnet.ibm.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 18 Jun 2018 14:23:11 +0930
X-Google-Sender-Auth: i6fPovjnUgifzriJvrIQUh7WwGc
Message-ID: <CACPK8XcA7RmerPbK_5pCh_NJQqZ_5pAVD4najW9e4rf1FYL4SQ@mail.gmail.com>
Subject: Re: [PATCH v10 0/7] i2c: Add FSI-attached I2C master algorithm
To:     Eddie James <eajames@linux.vnet.ibm.com>
Cc:     linux-i2c@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Rob Herring <robh+dt@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Peter Rosin <peda@axentia.se>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 June 2018 at 05:06, Eddie James <eajames@linux.vnet.ibm.com> wrote:
> This series adds an algorithm for an I2C master physically located on an FSI
> slave device. The I2C master has multiple ports, each of which may be connected
> to an I2C slave. Access to the I2C master registers is achieved over FSI bus.
>
> Due to the multi-port nature of the I2C master, the driver instantiates a new
> I2C adapter for each port connected to a slave. The connected ports should be
> defined in the device tree under the I2C master device.

Looks good Eddie. I had a read over what you have, and I would be
happy to see this merged in 4.19.

Reviewed-By: Joel Stanley <joel@jms.id.au>

Also, I have merged this into the 4.17 based openbmc tree for testing
while we wait for it to be merged upstream.

Cheers,

Joel
