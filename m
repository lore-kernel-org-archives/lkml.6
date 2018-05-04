Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-616729-1525463276-2-2626127091479407396
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
    1525463275; b=B7Gh+rWp4E3CSRu/sZK8ztjGMtINo/fgUPcgc9aoaPS4teugmo
    /RxhculrT4ddJHu0bkXuSkfw+arntXj0vG6zrxNBRlHzkgrMs8QFSbxNu1XWZTsZ
    o5/VeL8H3ffYkSp7qa31PDceatLhNh2Sy/Q9augMf1ZdHw6VmtRwuf/RhR7c84X2
    Cb71Ovh5EwcU6BErSn1ucoT4sO0BVd4MMOMZ9p7ELa1ZA0puq0ieAgG/Bdm6nVMS
    sehJ7EFQw7Eip+bRrbsvrNvYr8hRWcI8Xf3P36mi57/Byn1gu71YT926UuaZrpad
    TBSEMstn+wkO4lqC+Hkts33aAvRsYU8dNz3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1525463275; bh=Pa+p3l8KE77jUQ/aoJYGKuw3KwWtK9NtYl+Oj82Ari
    4=; b=LYdh2+01uFHomQyDUOGXXcYX7lMxvZeikaf53XzM2K6XquHC+LFgZuZwb0
    j9C6/cJ0SeXfCFkYefhXrTd96doHHroiaeRD9ULwTGVrpAP078zzlEsqeKwPIbbi
    WSZT7MZNWld80FehyRLN/+UgduJtYQKlgqph+NbrcwSTPKbYD1sQEi5U3QwB6edw
    hQkhip+RTVG/G3c3wCFTStP4myYGv0tbOgxSscLQga3V8LCzPXpgu6PWuCIi/wr0
    Br+SalG/lGHYnW7sKSjaKJX9fseFeQ5CWc9wbVkVmmmFmXmXY2YaaOk7/Se+l/cr
    Cgw/+KRrzHMKUts45O4ey1opoYdg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=chromium.org header.i=@chromium.org header.b=JtJ2j4Ya
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=google.com header.i=@google.com header.b=OXoewgsO x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=NJbh9otk;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=chromium.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=chromium.org header.i=@chromium.org header.b=JtJ2j4Ya
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=google.com header.i=@google.com header.b=OXoewgsO x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=NJbh9otk;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=chromium.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfD6SZiSh3cyGxqZV/axMxVTMe8J7+/lKCSal7IdMf8BmzENaiXFchYwm8XaPmAB0p/O5xkemOckD88eK0pbKZMfvHsjz8u0bHXeS7Pk8rARGGQ782zFC
    l4g8b/tAdOQP0rChA+kdkjkJKNnTuTTGqVkNoEmaA1Ot/bvO50FL1A76YxJviBMz14ANt8mXuQAW25v4WmbScKu1j/jqik3Axfs88rl3L7uAjGpLBC7ZWvjY
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=LpQP-O61AAAA:8 a=cm27Pg_UAAAA:8 a=VwQbUJbxAAAA:8 a=1u7RdJkFspxwNcgz678A:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=pioyyrs4ZptJ924tMmac:22
    a=xmb-EsYY8bH0VWELuYED:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751785AbeEDTrW (ORCPT <rfc822;greg@kroah.com>);
        Fri, 4 May 2018 15:47:22 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:39315 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751774AbeEDTrU (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 4 May 2018 15:47:20 -0400
X-Google-Smtp-Source: AB8JxZrwfA410cp9GSBo5cavJzHSIcxPCv/HynxPrZCHnyZGAArtQgO8UpGnYnaKQPz9Cemy3aJx5cvwEinwgfTm/jM=
MIME-Version: 1.0
In-Reply-To: <1525295174-15995-7-git-send-email-mgautam@codeaurora.org>
References: <1525295174-15995-1-git-send-email-mgautam@codeaurora.org> <1525295174-15995-7-git-send-email-mgautam@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 4 May 2018 12:47:18 -0700
X-Google-Sender-Auth: k2UsTL5dVsLutqSFLnLend1c9wY
Message-ID: <CAD=FV=Ux+Ei0HE5FWnUrMBjWqh4ZVfobfbZfJTfKn54o4fmq5g@mail.gmail.com>
Subject: Re: [PATCH v5 6/7] dt-bindings: phy-qcom-usb2: Add support to
 override tuning values
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
> To improve eye diagram for PHYs on different boards of same SOC,
> some parameters may need to be changed. Provide device tree
> properties to override these from board specific device tree
> files. While at it, replace "qcom,qusb2-v2-phy" with compatible
> string for USB2 PHY on sdm845 which was earlier added for
> sdm845 only.
>
> Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
> ---
>  .../devicetree/bindings/phy/qcom-qusb2-phy.txt     | 23 +++++++++++++-
>  include/dt-bindings/phy/phy-qcom-qusb2.h           | 37 ++++++++++++++++++++++
>  2 files changed, 59 insertions(+), 1 deletion(-)
>  create mode 100644 include/dt-bindings/phy/phy-qcom-qusb2.h

Thanks for adding the #defines, describing the defaults, and including
which SoCs the new properties work on.  This looks great to me now,
thanks!

Reviewed-by: Douglas Anderson <dianders@chromium.org>
