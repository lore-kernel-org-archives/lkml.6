Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-616729-1525463257-2-7352399282250132319
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
    1525463257; b=hCHVIcT0aSDK/ZIs5MtoY/HwMmhmJnLvbsqpBFfrk15kwWg4nT
    G4YFkA2WTSH1S1L4FTkq9JvEugU+IPoLiWL1D4aipqTgFAtGH+o9rGXQBuT9EnwH
    QWYSgvvYWMSxbRJlc0zO3tp4CxY9xMCwW8OBuouI6QiX00TgYPjg2XQYSKDuvsOw
    Mx7O+1JoMNQ5y19EDLfuJzhzP9WXqd0pvP7cY7F3Hyp4lgBwdY1OfbWusmWX+J0Y
    K/qzL/hnNFonJrMGzzbE8YQQFvxw4DhG2QtG3nawpA1NPfGokbJV75cX34yorRLe
    mlN5aVpFgmvV5oMpUH+c5jqdqRqZV3JKyL7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1525463257; bh=+cztbPDQNQK5xUjvk1310JMV6L5MLYFh17erN/UczO
    0=; b=CfiFJMtD0/oQkzCjfQcRdHpL8S2JTiMUOg0yNI8JXsOBv03JFNodgnE3Ix
    +HOKTOiBUeSFhBc4aaZlK+8OZzCheTSO1btquNskWniaeGHQN1urCqgQQwo2+cFo
    SFFWWG0RF5VNfBRvNpGhfdDlxSWExzeloNwlTfARVObVPZ0ravrkl31309BrcPqE
    cnELR5VWa1Vq23ORsACVm9ckx7mUMiR70g9mpfheI6IK3l0Jsoq47H4AMRN3ItRU
    iDev3hG4VMyBxUvA8QIO8Vc2o4hDndGYw7evACyZA4gIkmDawtvfRqqmg4a17S9l
    RSwXx1HpxqZjDqgS86J1yuV3vkYg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=chromium.org header.i=@chromium.org header.b=Lf1LLJSu
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=google.com header.i=@google.com header.b=CPPX4BeS x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=e2F7uplj;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=chromium.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=chromium.org header.i=@chromium.org header.b=Lf1LLJSu
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=google.com header.i=@google.com header.b=CPPX4BeS x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=e2F7uplj;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=chromium.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOCcVmkr46W6TwzIa3IcrBTuTYdP+J8/YULrTOWDYu7zaSEALBRk1dqHFixR/3kF5AJFlqd/dwHPnzhnfQbbs5iuWV/KHDrw0dQ2JkpqotjaRB2kxXGH
    XcwQgLimTalI6ctIktrXe6jBqfEs1Xm27pYgEugbJBFSOKy+rKc/gYyI9Yszniiu4GpXdr86hrGqQRWgifHpo92IoHTM+HYmlmRGin8n1D77ssIHlKaf1XXq
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=LpQP-O61AAAA:8 a=cm27Pg_UAAAA:8 a=VwQbUJbxAAAA:8 a=Y_kadahiSOX0PARr3iYA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=pioyyrs4ZptJ924tMmac:22
    a=xmb-EsYY8bH0VWELuYED:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751933AbeEDTrc (ORCPT <rfc822;greg@kroah.com>);
        Fri, 4 May 2018 15:47:32 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:43212 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751890AbeEDTra (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 4 May 2018 15:47:30 -0400
X-Google-Smtp-Source: AB8JxZphGRAi5prpfrQDemuEJgQgsz5Pj2LzbUW2GJhuQQ8yiT/D4UYPLc3iQZ884BuYSQ9y/TPkQwtkMk0J6uRO418=
MIME-Version: 1.0
In-Reply-To: <1525295174-15995-8-git-send-email-mgautam@codeaurora.org>
References: <1525295174-15995-1-git-send-email-mgautam@codeaurora.org> <1525295174-15995-8-git-send-email-mgautam@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 4 May 2018 12:47:28 -0700
X-Google-Sender-Auth: qIiz_EhUCIf7jYwfu90uegA2-pg
Message-ID: <CAD=FV=VGeCARsa0pooug9=y1GM1rNsmOLCP-EH1ar2o81AfcmA@mail.gmail.com>
Subject: Re: [PATCH v5 7/7] phy: qcom-qusb2: Add QUSB2 PHYs support for sdm845
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
> There are two QUSB2 PHYs present on sdm845. In order
> to improve eye diagram for both the PHYs some parameters
> need to be changed. Provide device tree properties to
> override these from board specific device tree files.
>
> Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qusb2.c | 126 +++++++++++++++++++++++++++++++---
>  1 file changed, 118 insertions(+), 8 deletions(-)

I confirmed that all my previous comments were fixed and this looks
nice to me now.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
