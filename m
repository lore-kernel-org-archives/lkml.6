Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1097881-1525702162-2-5531306561863431252
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525702161; b=A0zrez3B1r8rKcSaSyK6BvQTabv0Mrq2ecLgOVkVrefV4yoar5
    s0O5WPrh9erdB6qKFpnacejFLcalG6WdsQzX8EOugSUU42QNO1y0Qp3O5GNWdQQN
    5wCghHil64FIoxB8rU5OtiISmziYurQiziuGGQMPZD3M0XAD3sXhfzww7WENCmOf
    IpFoznh8gSjnxKs9BlTIBBqr0C9EwjTA8fgGf6otKfPY0Pl5Q9ykGTtxAfQtR4zW
    C9fVUW4yNWQ5Lr9piGmB40XxlpHyTwiv+8ns1A6rcT5sac3FWbEE0jPZyx7SXXlG
    DvNCf0adoHLRoxqat6eBz7ZfFp56Ya1X0Xow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525702161; bh=6Y2RohyIQ3mMhuhfowiTECOi+pBza4
    Foy8Q17jDGRY8=; b=mJzOV2gmPY5WxSpPnMrQDvdne4C8JrO3mrW//pohrH7CsB
    tTwEaTHoHTYkCbI8eXDZUo8PDWnWKbB9LcExxNJ2LDpTvEIwGwoSw2nyvHFB+eex
    OlWcXeXkD8XXk9hUgemTLTwntKJ+aO7TZ1Rs4zfrhaP0LBVvuUMVoTY4Z5vs5GN0
    EPWGlFwikU3VMNIRDIXJ/T4tGcJ9+T9Kqgw5dPDm/Z2IJcK2mJ07A8TR/GqvRNbu
    j8Is5tKm/gtfB5gmT8w/FXGv1UWA59kH9HTOgo6RfZlebIvA4P+QewGcD2HPV7iV
    5fFxx/HlprJkKvGfwrLzzv8VlYpjdLwNSQxcRzuA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=j7Lf1nHj;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=j7Lf1nHj;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfM1t66UPvuUW+xCvUiMleMoT2op51Y58GmKOK2O2qozWwgtwCoRBQlr99C/TSrAOc4WYvnnsLoofeHBkoYwds1KYVQAkQrrn60ldw000Sv5Q4qT6RWeL
    x9x2Z4ryGMnDnrIBal/0rXpQi7yuQXkP4a4O+tBpaST9RBGCFeBHPbYwjsi8tjpYLpgCRs+wELYhEA6pRm098uJwDfh25yEVGAvmKGakajz42T0A7rqdqEfQ
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=cm27Pg_UAAAA:8 a=LpQP-O61AAAA:8 a=VwQbUJbxAAAA:8 a=LNwN9wm3qrp9moekUMsA:9
    a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=xmb-EsYY8bH0VWELuYED:22
    a=pioyyrs4ZptJ924tMmac:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752616AbeEGOIV (ORCPT <rfc822;greg@kroah.com>);
        Mon, 7 May 2018 10:08:21 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:43437 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751943AbeEGOIR (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 7 May 2018 10:08:17 -0400
X-Google-Smtp-Source: AB8JxZotT0oqVfCc6zAMxsREjAi67cyULPLS/zkBg01nz21RJhxVzyLQ8OXpZN0FnZfzNQFfzLGzRw==
Date: Mon, 7 May 2018 09:08:15 -0500
From: Rob Herring <robh@kernel.org>
To: Manu Gautam <mgautam@codeaurora.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, sboyd@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, evgreen@chromium.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v5 4/7] dt-bindings: phy-qcom-qmp: Update bindings for
 sdm845
Message-ID: <20180507140815.GA22684@rob-hp-laptop>
References: <1525295174-15995-1-git-send-email-mgautam@codeaurora.org>
 <1525295174-15995-5-git-send-email-mgautam@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525295174-15995-5-git-send-email-mgautam@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 03, 2018 at 02:36:11AM +0530, Manu Gautam wrote:
> Update compatible strings for USB3 PHYs on SDM845.
> One is QMPv3 DisplayPort-USB combo PHY and other one
> is USB UNI PHY which is single lane USB3 PHY without
> DP capability. While at it also remove "qcom,qmp-v3-usb3-phy"
> compatible string which was earlier added for sdm845
> only as there wouldn't be any user of same.
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
