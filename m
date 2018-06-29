Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98F8C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 12:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 745EF214DD
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 12:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BXZyMPTg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 745EF214DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755521AbeF2MsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 08:48:13 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:41353 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753639AbeF2MsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 08:48:11 -0400
Received: by mail-yw0-f195.google.com with SMTP id j5-v6so3346741ywe.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 05:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JZhpXvXRE3/POhG15jwPdKe0GeIdj50A+HUCgpZVFI0=;
        b=BXZyMPTg6/AmiPmPcOGsUUzxMvVb5u+6VczZhGXz8Dh4r69cho0TBsfxiaxwDGwOuN
         TxzdtSglvyLUDhpQzzPFuGgqosm7wuCN7dtUrp+iZizHQpaDR0+6r6gmNEHyAC/1v6jj
         sGg8CITFXJaGx5ykjkE2uwDPWY+uLTneqNxF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JZhpXvXRE3/POhG15jwPdKe0GeIdj50A+HUCgpZVFI0=;
        b=BX+NmOOzewFcJ6nGzPdFjRrmeZ9vQLbu5N1X6GjtWqxjnb8vdi5iP15KMbSaaPw/YQ
         XOJGX6dPKq18GJPNvLRbTuwjqB3ejSdF68+1Ds2JDFvNTggfPSF2L3/MztpJ08e3Syk+
         4Do3ON8Wu9Ji73Nr5KzFgOeGgiI203aKHYQ159/csMUkkeBa/7dftLCOIWK7U/WkZ94z
         uqOuMsI2HFXq0+hDqapCBU9UQ+xboat3l+ku/puHeLANGWz+McKXXqedVFSyp9sI9I2B
         PHWTbmwRxRhaNHsyqrbgSHCgqKKRdMmecUHS3iP1ECfobrR6xYrF+QSo6a0VcDauku90
         y54A==
X-Gm-Message-State: APt69E2xKT6sLoKdrbw3M/NF8iLSg1C7HZx2ICAm7rz6r4LVJc1mibUu
        HDmkcH8agF6QsMcbjaPg6kX6kwCyP1d8kf8Im/pORA==
X-Google-Smtp-Source: AAOMgpd4PWEfycLjEIvB3I7BwwSiL9JbMr/QIz3LKBSJk2WAYaqeEg5I6I5lq2PE2qSqyfX1XXP8l41b0JyjK0jRDz4=
X-Received: by 2002:a0d:f547:: with SMTP id e68-v6mr7118992ywf.298.1530276490550;
 Fri, 29 Jun 2018 05:48:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180629100248.11560-1-anders.roxell@linaro.org> <53d599f2-44a1-c366-4a5c-2ca6cd19b031@kernel.org>
In-Reply-To: <53d599f2-44a1-c366-4a5c-2ca6cd19b031@kernel.org>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Fri, 29 Jun 2018 14:47:59 +0200
Message-ID: <CADYN=9L3hQCfiD2CBrx3_2pLxTaZGPTt-gAcScKqe7pTq4ZgCg@mail.gmail.com>
Subject: Re: [PATCH] doc: dev-tools: kselftest.rst: update contributing new tests
To:     Shuah Khan <shuah@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jun 2018 at 14:10, Shuah Khan <shuah@kernel.org> wrote:
>
> On 06/29/2018 04:02 AM, Anders Roxell wrote:
> > Add a description that kernel config options should be added into a
> > config file that is placed next to the newly added test.
> >
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > ---
> >  Documentation/dev-tools/kselftest.rst | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
> > index 3bf371a938d0..4c546a35bd58 100644
> > --- a/Documentation/dev-tools/kselftest.rst
> > +++ b/Documentation/dev-tools/kselftest.rst
> > @@ -156,6 +156,9 @@ Contributing new tests (details)
> >     installed by the distro on the system should be the primary focus to be able
> >     to find regressions.
> >
> > + * If a new test needs specific kernel options, they should be enabled in
>
> get rid of new
>
> > +   then config file in the same directory where the test is added.
>
> "the config" instead of "then config"
>
> Rephrasing this might be better:
>
> "If a test needs specific kernel config options enabled, add a config file in the
> test directory to enable them.
>
> e.g: tools/testing/selftests/android/ion/config

I like it. sending v2 shortly.

Thank you.

Cheers,
Anders

>
> > +
> >  Test Harness
> >  ============
> >
> >
>
