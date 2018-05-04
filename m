Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-649494-1525463288-2-395784043862529978
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
    1525463287; b=QasRX2V11WHYgDKg932z5gr5su8X5gYm0mOIwUWkhnTmjBPa1W
    cwozrfHnSNZ8emPQ+XrfRlYogBaLwUwQ3RcrMqI7LF5epQpihWPCf/GpB8SsExCB
    bvpbZQZwSI4JVg+uHzpWYWLNlvVzs7tbFs1RIBTHhX6CFSCE9dIsdKpVQc7CupZ6
    2eUALXKfSx0Giv2+/tmCmiGdFPEuFU0WCsOFioh13MBKN/kYiS28bDCfIg8fk+j6
    YHGSA20xiQXEecC35W9CvLbmCThtZVqMY5NV3XDTDKMz7YWrv//MN/KBE43HnzQB
    Y9rEz1uSBWOtxgmgK6BPrx0lfe4950tBI2Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1525463287; bh=ZWc47ZEbM80iwXnfNuwl8xSVMF5xS0T02sA9MktoUG
    s=; b=CK6gp9bjlWk6qOmnm460QSUASwROdeT988F7Dm/B5joqI/gHnB9pvw6sze
    BKg9UJ/gekzTgpxfAlR0j9kdUWIGVU2+9d2K/snNDHDLpfqkXeImv919HK7JjOFP
    h0xACNOKMmP9sR48eIn/F4VdphDPjo3G0YNDNwPehWTucQDR/zHjI/aDn/9brXdh
    XEFuwBSlRMAUfuZxWoWazZxsnTB2GEXOQQ3Q3ad0C7BvJETAT290alTUqlAVRGn9
    ZW1BZFOnpsUR1OZ7ypPZNIToMoSZUzulxmQutpz9nHly1LESftRwiWCM8wGGvu0R
    VVYZJYJqSB+diKz/4vqnnb5qM22A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=chromium.org header.i=@chromium.org header.b=IJYvvwkL
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=google.com header.i=@google.com header.b=qC4EblZT x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=YdRgpBNm;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=chromium.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=chromium.org header.i=@chromium.org header.b=IJYvvwkL
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=google.com header.i=@google.com header.b=qC4EblZT x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=YdRgpBNm;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=chromium.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIj84chPVo3U5FoCTj6FObQ6pVuLz1EvagZ3WS+Oj4B5IUX/Fav5M9L1zCcKuT65OS0JrQf2aso19ubT2GAINsHKSMqeGQQ98xWvo2LOMiQFEj4Q5vMM
    F8Dl1PUThkEcFz5kcHQJtF4bOiF8YDD2/edf/ytOA96TL0Stum9sLNEQtashHTLlgJ0Hn3YTkwKicYQMnHY66k0Z+zhddbgVQ8aaIsIf/vLL681L0eRBQjGi
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=LpQP-O61AAAA:8 a=cm27Pg_UAAAA:8 a=VwQbUJbxAAAA:8 a=kPhjeGw7KgLbYwEWALQA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=pioyyrs4ZptJ924tMmac:22
    a=xmb-EsYY8bH0VWELuYED:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751834AbeEDTqz (ORCPT <rfc822;greg@kroah.com>);
        Fri, 4 May 2018 15:46:55 -0400
Received: from mail-ua0-f177.google.com ([209.85.217.177]:33532 "EHLO
        mail-ua0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751748AbeEDTqx (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 4 May 2018 15:46:53 -0400
X-Google-Smtp-Source: AB8JxZo8LBwmVvTZlmH9XbHdmzFSyOdNxqk7HVqanEAVh55842JnzSKmYQuX+/gAoiMV0odhn3Br72YqsTphrbJDqNk=
MIME-Version: 1.0
In-Reply-To: <1525295174-15995-2-git-send-email-mgautam@codeaurora.org>
References: <1525295174-15995-1-git-send-email-mgautam@codeaurora.org> <1525295174-15995-2-git-send-email-mgautam@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 4 May 2018 12:46:51 -0700
X-Google-Sender-Auth: xJR_JNxgUTyDMEQ-fcGSr3gsBtY
Message-ID: <CAD=FV=WNa=k__pymaTWEGtHn+QaHW7ezPb+ZsO4Z9UtLKYQQSg@mail.gmail.com>
Subject: Re: [PATCH v5 1/7] clk: msm8996-gcc: Mark halt check as no-op for
 USB/PCIE pipe_clk
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
> The USB and PCIE pipe clocks are sourced from external clocks
> inside the QMP USB/PCIE PHYs. Enabling or disabling of PIPE RCG
> clocks is dependent on PHY initialization sequence hence
> update halt_check to BRANCH_HALT_SKIP for these clocks so
> that clock status bit is not polled when enabling or disabling
> the clocks. It allows to simplify PHY client driver code which
> is both user and source of the pipe_clk and avoid error logging
> related status check on clk_disable/enable.
>
> Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
> ---
>  drivers/clk/qcom/gcc-msm8996.c | 4 ++++
>  1 file changed, 4 insertions(+)

FWIW this matches my understanding of what Stephen and you agreed upon.  Thus:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
