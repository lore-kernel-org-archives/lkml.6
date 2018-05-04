Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-616729-1525463229-2-1613147586170671298
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525463229; b=Y1VjuhtZBxlLmvH/NR9cBdj8kYS35/zoxaIrIuJslq0CVZqvO+
    xDnUUnzaJF/E+2eUTj12dRc7UBlIi0qh0hVA547BYbJWcKy+Mv4jNTsBEhDAvpwa
    c4DT1GAA8V7ypa0YyBHiz0ZLEmX8HpX+ZPTXpJn7VMnEhGDEBgjiHP2HDBr+gLh6
    NiG9nVx1LwI9ECYs8feVQweFwcq1qvcHCmgeFFJV0bH9+zUr77GobkndryNLeKmz
    iqfq1VRmP2kKg8miLHSfqC7SFQTwQrxHZLhxM9xeoceQ92HdIeb0pZ8yVV+BeMdD
    RFhmqUZDtHL1/9IFdI/ihJl5raCMlUyFdpgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1525463229; bh=XVAG8rGvFFR7WDFNpuYPM44tbjiCu5dt8He6v8Wh0n
    Q=; b=Uo7v4upJIHRz0ck+kzR0YlMvUTNeaJBVDrOCILgfg0Z2gVjE2Xt9YO4TLr
    qPjTN20tJ/cnjGgZX/PXayxDzFzdzVZQCsR/1MKlL2krv9fENf+lxQgHHpAMu9pD
    SHiVrmkLGSDWQ6WJr7enp8dEcZf4CaAL5ezsJRSBJLlzfdzrSYcB/TI6XgGRCRoE
    zrHOI0UVTGAZHh40vwLzadRKZdwiNljEGl419Kit+XjVX05Mp7mlCNnakT0L9+Hd
    ohlogmHN543vli25yrUZRJt9R9IwZynQ11Fxj/bftGXj6gMfCX4VamCaPdGtoaY1
    ArBjirrvnbSRR6uCuNU5r1fOiHLQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=chromium.org header.i=@chromium.org header.b=Wh/kl00n
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=google.com header.i=@google.com header.b=vWC1sIzX x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=Uv5/vjDP;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=chromium.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=chromium.org header.i=@chromium.org header.b=Wh/kl00n
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=google.com header.i=@google.com header.b=vWC1sIzX x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=Uv5/vjDP;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=chromium.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEreELL2mHV/WilDqHN4nSN6iSqmJ0zj2aonP3TvMVVGvOFQfBB+8jHTlDa326OsUQQhWVlOlLN8+pwWX2BE5mWXCEXklAP9QwGR+K98JHI4Cq2/HVlp
    jXLXPkgiCj9Qd4e+o2bKtLEDztn1DIHqwKOjkx45wNP7+jQmDlyNq20i7cXDnp9IN4GuGjdEApsQimrqF2XGUkCIvqQH/Y7Fz1K+UoRtTyQmSa4deFaZJuuQ
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=LpQP-O61AAAA:8 a=cm27Pg_UAAAA:8 a=VwQbUJbxAAAA:8 a=vW78PTNaEhEDNyNt_64A:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=pioyyrs4ZptJ924tMmac:22
    a=xmb-EsYY8bH0VWELuYED:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751655AbeEDTrF (ORCPT <rfc822;greg@kroah.com>);
        Fri, 4 May 2018 15:47:05 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:41022 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751623AbeEDTrD (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 4 May 2018 15:47:03 -0400
X-Google-Smtp-Source: AB8JxZqsPKfFU6TA0n3MDwZG77Mq+7iUqUnu2wvJC1brJO+xncHs7I8bd/mGCtw784qX2QLTSMCVYAWT5LYRUP5id5s=
MIME-Version: 1.0
In-Reply-To: <1525295174-15995-3-git-send-email-mgautam@codeaurora.org>
References: <1525295174-15995-1-git-send-email-mgautam@codeaurora.org> <1525295174-15995-3-git-send-email-mgautam@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 4 May 2018 12:47:01 -0700
X-Google-Sender-Auth: EY36YWTa6caiiaO2M4tInvKwTb4
Message-ID: <CAD=FV=XqRLLeFOfFZWscZf0U_y4_HHeGQMpEcS3FPCX6_YMcvw@mail.gmail.com>
Subject: Re: [PATCH v5 2/7] phy: qcom-qmp: Enable pipe_clk before PHY initialization
To: Manu Gautam <mgautam@codeaurora.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On Wed, May 2, 2018 at 2:06 PM, Manu Gautam <mgautam@codeaurora.org> wrote:
> QMP PHY for USB/PCIE requires pipe_clk for locking of
> retime buffers at the pipe interface. Driver checks for
> PHY_STATUS without enabling pipe_clk due to which
> phy_init() fails with initialization timeout.
> Though pipe_clk is output from PHY (after PLL is programmed
> during initialization sequence) to GCC clock_ctl and then fed
> back to PHY but for PHY_STATUS register to reflect successful
> initialization pipe_clk from GCC must be present.
> Since, clock driver now ignores status_check for pipe_clk on
> clk_enable/disable, driver can safely enable/disable pipe_clk
> from phy_init/exit.
>
> Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp.c | 22 ++++++++--------------
>  1 file changed, 8 insertions(+), 14 deletions(-)

Given the agreement with Stephen Boyd that we'll just BRANCH_HALT_SKIP
for now, this all looks good to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
