Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD8AC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60546208B7
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:27:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60546208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754324AbeFTP07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 11:26:59 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:40491 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754089AbeFTP0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 11:26:55 -0400
Received: by mail-yw0-f196.google.com with SMTP id p129-v6so1302732ywg.7;
        Wed, 20 Jun 2018 08:26:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M0ncQKFGoHNU/4u0aooKD+miPaB+SeSD+pn1p18Jaxg=;
        b=hnlS1qVyoeGZMKV70vmTuUc51sB2h62WWEMbZFj9IHADmuDwt9W3qYOZrB4idQVTIY
         O++ET8BD7M0K6g3sAu5EKp6Y/kWnUdXEtgm0jAeBVum2cyQViwhnRMJnvNngV1BFUbQl
         +fcZdbzpu6KA/oTj9oVKqjomwh2k7F+Wtg0p3C2G7LVuAPKKxhBhq7RTon3Uzw9zC2lJ
         XHs9MlGUmnF1TXkAg/OClEgft0vOHMJko+5YKIu1E9rlmZSTiuroINsoNaEkaN/fR2Fp
         lgt60R7rl2UcI2usw2gXyikGV/di4q9LAQMomSTAUI91YgqcbWzOJlp+Kg+PmiatWgQ6
         h3Qg==
X-Gm-Message-State: APt69E2T1KH25Uy+YRjs8i6JWS6w6j05XmKLFb8SewMayA5Yzw1l0+g8
        VYCUKCiPI6Nqpq2SB303yA==
X-Google-Smtp-Source: ADUXVKKB0JvUuJ9N98N9PcK/5hOmWzO3DrjuvocJgZfnO9+e8hOOPjGGq0MEsBn8IhxNzU2dncyTGw==
X-Received: by 2002:a0d:f0c2:: with SMTP id z185-v6mr10765267ywe.28.1529508414499;
        Wed, 20 Jun 2018 08:26:54 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id j207-v6sm994761ywj.19.2018.06.20.08.26.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 08:26:53 -0700 (PDT)
Date:   Wed, 20 Jun 2018 09:26:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Harry Wei <harryxiyou@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Roy Pledge <Roy.Pledge@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-gpio@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@zh-kernel.org, linux-usb@vger.kernel.org,
        linux-input@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-fbdev@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v4 04/26] docs: fix broken references with multiple hints
Message-ID: <20180620152652.GA12591@rob-hp-laptop>
References: <cover.1529079119.git.mchehab+samsung@kernel.org>
 <75c14f6d84eef8c10787e85ddc172afebee116d6.1529079119.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75c14f6d84eef8c10787e85ddc172afebee116d6.1529079119.git.mchehab+samsung@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 01:30:32PM -0300, Mauro Carvalho Chehab wrote:
> The script:
> 	./scripts/documentation-file-ref-check --fix
> 
> Gives multiple hints for broken references on some files.
> Manually use the one that applies for some files.
> 
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  Documentation/ABI/obsolete/sysfs-gpio                     | 2 +-
>  .../devicetree/bindings/display/bridge/tda998x.txt        | 2 +-

Acked-by: Rob Herring <robh@kernel.org>

>  Documentation/trace/events.rst                            | 2 +-
>  Documentation/trace/tracepoint-analysis.rst               | 2 +-
>  Documentation/translations/zh_CN/SubmittingDrivers        | 2 +-
>  Documentation/translations/zh_CN/gpio.txt                 | 4 ++--
>  MAINTAINERS                                               | 2 +-
>  drivers/hid/usbhid/Kconfig                                | 2 +-
>  drivers/input/Kconfig                                     | 4 ++--
>  drivers/input/joystick/Kconfig                            | 4 ++--
>  drivers/input/joystick/iforce/Kconfig                     | 4 ++--
>  drivers/input/serio/Kconfig                               | 4 ++--
>  drivers/staging/fsl-mc/bus/dpio/dpio-driver.txt           | 2 +-
>  drivers/video/fbdev/skeletonfb.c                          | 8 ++++----
>  include/linux/tracepoint.h                                | 2 +-
>  security/device_cgroup.c                                  | 2 +-
>  16 files changed, 24 insertions(+), 24 deletions(-)
