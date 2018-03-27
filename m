Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-133288-1522172162-2-15448146535994813931
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES endaro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522172162; b=jydnZ/zNNriSJNugHJPEcB6KDF78QYqxpq0vM+O5hjFf+jx
    vsLNBD1Y2xh/ebrZ98RIhWEHCbob21EeDHTteTqlsr4lL2gjG9EPuh4GWMpufIsB
    EdwEDRGF+A5Bl3UUIFa96G6p91C7C7li8r6ClVZ6b9RmraDj79Zloz5iL5Dso+yL
    1wE9Eq73Asw9aKPcMIDiHMZgpAD50hThCtXqFTqubQZ2kveXEepfHdu4wD8lRcwP
    HTf74faJ9f6sq/nF6FE/2bCu8vXGYn0tohfqsAK2vcelXwxbCdaDdfSTktRiNHrg
    7K+ko9jYMFZttbAtHpGyeul7YMrQt3NZMdqoLZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1522172162; bh=BOTomRhf/DSaGwso3NC9ucsfC5nLE9vZzUTwlR
    cAGfs=; b=KQxTuqLsf3S0n3Tse4m/s76HVQG0S2Bka3yL8TFwGvMEfmydCcR9Bu
    8s/qQk/Msp/7TSbiFVrqioLKhcalTTVHXLUtTCl21wou5fcueoq/o5ynTiS3CoUn
    gCWzNse5FQvA99nPpmjSfp0/LR573EbYtszplFTiAQv2IN1mCTCEc20r2iO5PZa9
    4TYMDADocEY2/TbKKWhWAzIzZSwMpcVqNxAIynVdh3uk1yh6sgfF60dkvwL7WFEA
    K3TExuHK2we2/5zdydwsbkWEdnFzE+A5SQubuL9XVqlz7EUBYIOQUPEIP2y7ew6p
    dUOFinRvSrzKOaE+0OB/3ej9wxSm+Rww==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=bqt64my4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qwImblGD;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=bqt64my4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qwImblGD;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPLdV/XIrX29FqNCvwKSd8qnC39fimWNmyqNR6U0Ka1ERklrymOvqT4r0YkdswYtvEl8gZEqkjp758ZphdLbuGYXd8oURDU0yt92x1xUBcSUTIs4tziZ
    ftFwYGG7MuOxiKQFkFqeXh0KzP7vrb1atTOZZBvFMTxoDLN7KQJ0cFOE1U+Ymr6H9CtLI0mWmdVSGuS6M/MX98tYOLSVqHr9tCRdIkgRexug32TlP3e5VM/L
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=LpQP-O61AAAA:8 a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8 a=K6uW_v_grZFRU5XRMuEA:9
    a=QEXdDO2ut3YA:10 a=pioyyrs4ZptJ924tMmac:22 a=AjGcO6oz07-iQ99wixmX:22
    a=xmb-EsYY8bH0VWELuYED:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754502AbeC0Rfn (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 13:35:43 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:35029 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754436AbeC0Rfk (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 13:35:40 -0400
X-Google-Smtp-Source: AIpwx48+PSBKBsaO9qxRBCIpCMQZArFz70ZYGSYFHYtKDTNoPPCYnTcZ9hrTlUL+VqfhEiWTpbUQBQ==
MIME-Version: 1.0
References: <1521785487-29866-1-git-send-email-mgautam@codeaurora.org> <1521785487-29866-3-git-send-email-mgautam@codeaurora.org>
In-Reply-To: <1521785487-29866-3-git-send-email-mgautam@codeaurora.org>
From: Evan Green <evgreen@chromium.org>
Date: Tue, 27 Mar 2018 17:35:02 +0000
X-Gmail-Original-Message-ID: <CAE=gft67HuudBajKESOgZtgMz7owJqdoYPJp_6LpyB37a0-iYQ@mail.gmail.com>
Message-ID: <CAE=gft67HuudBajKESOgZtgMz7owJqdoYPJp_6LpyB37a0-iYQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] phy: qcom-qusb2: Fix crash if nvmem cell not specified
To: Manu Gautam <mgautam@codeaurora.org>
Cc: kishon@ti.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, stable@vger.kernel.org,
        vivek.gautam@codeaurora.org, jh80.chung@samsung.com,
        yoshihiro.shimoda.uh@renesas.com
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 22, 2018 at 11:13 PM Manu Gautam <mgautam@codeaurora.org> wrote:

> Driver currently crashes due to NULL pointer deference
> while updating PHY tune register if nvmem cell is NULL.
> Since, fused value for Tune1/2 register is optional,
> we'd rather bail out.

> Fixes: ca04d9d3e1b1 ("phy: qcom-qusb2: New driver for QUSB2 PHY on Qcom
chips")
> Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> Cc: stable <stable@vger.kernel.org> # 4.14+
> Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qusb2.c | 4 ++++
>   1 file changed, 4 insertions(+)


Reviewed-by: Evan Green <evgreen@chromium.org>
