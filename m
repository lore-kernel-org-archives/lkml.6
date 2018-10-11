Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1233AC4161D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC39C20841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IiUBttym"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC39C20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbeJKVaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 17:30:06 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39331 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727864AbeJKVaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 17:30:05 -0400
Received: by mail-qk1-f195.google.com with SMTP id q5-v6so5471215qki.6;
        Thu, 11 Oct 2018 07:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=9V7oSUadqJzaBgiKezYyYnhl2kPlRH2vKrkrTRrxIR8=;
        b=IiUBttymOAQ0SdA3EcF3El0KKHCzQPrem7gX5TlbrpdqYPxqJ2uuOWUrTciP6d9b7t
         IAk/pG6LVir2my+o/G1t3JGmrn6hsObovPti6iZeDNPWWfzg2IYNhnQ8qYB1k45OOkOz
         pha0DvvGRLJX8COpbnGiVvpxc3RO0Nz4v/HJGcdIbp0tq0tqYG8sokqj6FDFFEzoWlY/
         Pk9Cf543okCgNIkx6ibjvmpiJfomL9L8az1QIkskes0coaNHeHiir+cansJZBoOgIPQp
         olZPuGNpJ4FxU3YDNC9G7yLi5ImQQnF3JyqveqGzc1yqr0c9aIWTV93chf8Zviz+HxMb
         6TfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=9V7oSUadqJzaBgiKezYyYnhl2kPlRH2vKrkrTRrxIR8=;
        b=mqs//fkfCOMVCGThJHOX1X02qNfTC0Ui2L58QXFkFRQ3Ey+ntahnLsJekjFPs05hJR
         dtAg7abb21aQZO6wRmSGjqfnm+kvItqU7EW0aGINP77KN6Q/v1o3BJpXslVEstGUftw2
         dq2qgxCE58Ugv/czvfYn2iWayNOVoeUdeHg5pPlknhqc5bNQaqsN+K+70AR0gMV/yPUP
         gHYTx7yPjFW5NxUCFd9zMo1fx3PJMXuJ3M7kt83AZsc8SUfqWB62zOQQ3/IcEMgU7exX
         5vyXR+/MF8aW5EEgUSAJTZr/WyzjfzenH8710J7IhoZZzXUOonpTHMuph2D7124gght8
         3jRg==
X-Gm-Message-State: ABuFfogI8h5PEBAuHI13t+aiEeyp6uUy5Lkifkr7oqLUwxUi3B043OSn
        Uqa1Ugtm9VugnXQlr65lRy39dyndh6MhOhZRBgE=
X-Google-Smtp-Source: ACcGV62re/zXwp5pUgcmaGhLNZt/jMfOCkkE1km8qjNbKW9rYjULW1kw05uOsy+j69wkE8ngxCxQz0ZD4CJrCrXD1NA=
X-Received: by 2002:a37:38b:: with SMTP id 133-v6mr1601240qkd.173.1539266565656;
 Thu, 11 Oct 2018 07:02:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:fd8b:0:0:0:0:0 with HTTP; Thu, 11 Oct 2018 07:02:45
 -0700 (PDT)
In-Reply-To: <20181010182558.7034-4-krzk@kernel.org>
References: <20181010182558.7034-1-krzk@kernel.org> <20181010182558.7034-4-krzk@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 11 Oct 2018 16:02:45 +0200
X-Google-Sender-Auth: 2iXZKMBBimHCMKCvK3F67hGzCIk
Message-ID: <CAK8P3a2+wyge4=eCxJps0Ar3bYFrqjvdMakiYHBPmn3p63+GDg@mail.gmail.com>
Subject: Re: [GIT PULL 3/4] ARM: exynos: soc/mach for v4.20, second round
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Olof Johansson <olof@lixom.net>, arm@kernel.org,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/18, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Hi,
>
> On top of previous pull request.
>
> ----------------------------------------------------------------
> Samsung mach/soc changes for v4.20, second round
>
> 1. Disable SAMSUNG_PM_CHECK Kconfig feature incompatible with Exynos.
>

I suspect Olof made a small mistake when he pulled the previous branch
into next/dt instead of next/soc, so I ended up pulling the new branch
with all commits into next/soc again.

Nothing harmful happened and you did everything right, I was just
a bit confused by this.

Thanks,

       Arnd
