Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04373ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E9D2064C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gB4Rz4um"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85E9D2064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbeKAIvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:51:00 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44866 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728427AbeKAIu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:50:59 -0400
Received: by mail-lj1-f194.google.com with SMTP id k19-v6so7953854lji.11
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 16:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wyRdDXnrHR4VkJBtq6UIY2Dg/65n0Ongwd+jE4jaPsg=;
        b=gB4Rz4um+u3gAuKNms1aan64B24lwa01mDqXpy0dBTkJQzuLPIVK9zjhCqbNde8ENZ
         NV4BLsVuz7UWx8rUBVfzdQEFEXY+Kqn7s7yAgMfhScjTn16xigIYo/L6KLS+k+9baDkM
         itky7EVv3QH6FwUzrTKvyhlCXBjN5u/BHEtKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wyRdDXnrHR4VkJBtq6UIY2Dg/65n0Ongwd+jE4jaPsg=;
        b=YMgNjejyBfaNWvTJcStaqG00EzHPl81X2DPDwrS3KSqXAtejDX7nhHE5oAHMveJiuo
         shCfbFQM/nhKU1Rm9LxYp7Y4jYKYrcOmC7RTLe/WEr0hzqO6XDc1I7qx86Bedtx51gc5
         4ao61FxBPvofl5dFJ1GOW9nuf1zlw2qwsweZwsM7ybwTyAHCBY3kGnQnen/ViL6ZswR2
         5rsDrA2tzxataOkC+/h5+MVGXbaXuj7OSFVPOQ0BuEOUFijqgh32MfRdd24uG8Ujexwg
         dreses0FD4cWJtqi//HUv+gRHCKS7M/dO3uIM+Ff5hWbNrZlxrHEWwxIDr2TmdDMc0LI
         WclA==
X-Gm-Message-State: AGRZ1gJVJU6rZo7mY62YsCletJkHWNWP0Y+LbSdTeSoJfOxitlahkrFD
        1Jcy+95hSIOUeGFIPNFCiDXR+byTCrPMyw==
X-Google-Smtp-Source: AJdET5fWtGpedqhCwudown4jBP7KblQlSt18oxGFZGiThfXY2objfiNRXA48oiD1TUgbE9TVNpbpUA==
X-Received: by 2002:a2e:9445:: with SMTP id o5-v6mr1260895ljh.7.1541029832880;
        Wed, 31 Oct 2018 16:50:32 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id l7-v6sm4313206ljh.5.2018.10.31.16.50.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 16:50:32 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id n18so4641954lfh.6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 16:50:31 -0700 (PDT)
X-Received: by 2002:a19:288c:: with SMTP id o134-v6mr3279916lfo.124.1541029831298;
 Wed, 31 Oct 2018 16:50:31 -0700 (PDT)
MIME-Version: 1.0
References: <20181031232531.GA195672@google.com>
In-Reply-To: <20181031232531.GA195672@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 31 Oct 2018 16:50:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=whvXe4sEC1OtSqzZDJULtv+fpM5M+VctWg8CzzQrNmYeQ@mail.gmail.com>
Message-ID: <CAHk-=whvXe4sEC1OtSqzZDJULtv+fpM5M+VctWg8CzzQrNmYeQ@mail.gmail.com>
Subject: Re: [GIT PULL] chrome-platform updates for v4.20
To:     bleung@google.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bleung@chromium.org, Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 4:25 PM Benson Leung <bleung@google.com> wrote:
>
> * Move mfd/cros_ec_lpc* includes to drivers/platform from mfd
> * Adding a new interrupt path for cros_ec_lpc

Pulled,

                  Linus
