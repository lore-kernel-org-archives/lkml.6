Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1256125-1525709889-2-18008202581853068368
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
    1525709889; b=AiFJosjy5C4sNM+f4eeo7Tl+tBAENGsHJjcmG9hVeHNHo3a8wl
    I0nrJXSxkhLOe+NGKvoMeNpMSXqLAOdTmw9K9jWHvmzwqNJ1w0wFwUXngm5Q6XTk
    Q1l5LPvEhggaSfNakLgxPHTZELbFhwlEM3HYkjGoZQ+Qm7yvsofMvh9n6ftPaRPH
    NPSAKgHGtcNkqQpp7BKOq1seUuOnXRJh8K0fB02rPEK9mu/PxV6O+L419CtKPGpq
    zrZ3b+qC1NC11QqKG+5/+Xl6Aoc8AuDkfl7kGmM1XHH2mQ0zM7eDhVw9MRxHGGUz
    a/GuBfieJvWENmXD5D/20RzWHSXO7ZoUWKgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525709889; bh=qtg9Qco1PEYKBMO2f5PSDZVy9yujR6
    lWv0X8BZhkWgA=; b=nlyPDUKV2I8KKr7WyVuM2KTmpK0eHRs1HqTW5uamIxmQkb
    MZP/7g0FyA29fNGM4mMcMzB/n5LQ2unNpD8tjMyKGn8OmdRRhoCHSvtenJKBu/rq
    hMdjobv9TflCsYh1nJzf7kOJzQI/nJcTAebXCQEtmyRzRFG9hnaKK2jJldOZdOCi
    tlcIAbP8et7AOFs1Iwuprnbp+4QvL+MlLTqBEOmOt/QiPnmIvWz3Fx9yaQUSa9lu
    TgJE5bDyoY7BdpGoe9bdWgVA76JuxSQvDaew8C+cqV/5UcoJSllPt5QEVAUbRCR9
    91V8CuNR2WoPRk5/DG8/oh60w8cP2ShdDU6m5BoA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=P62In4xN;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=P62In4xN;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfF+UlrMg1fevVZ5StccMXqaNr7E2ley0V10iWeRB50id9kVac2WfKRza7GQ5mi32eQxVLgvXxsb0bR1WiRb7O7rxVYcWvl+qlu9dRida1/tV5p77xzHy
    Jd5XKCTA/9sJK+bFKHl1AZ9USD6CXwsqsEXKJdnxRAIiXN6yr5AOC3bJDwocyS5RAFi1buQmDnjU8DEEU0aUdArgN9ffCGw8YvB9aMkuiVvJU2kDWRV5Col1
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=LpQP-O61AAAA:8 a=VwQbUJbxAAAA:8 a=V6PI3vlqdZ5OXJNwStkA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=pioyyrs4ZptJ924tMmac:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752465AbeEGQRy (ORCPT <rfc822;greg@kroah.com>);
        Mon, 7 May 2018 12:17:54 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:37694 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752408AbeEGQRv (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 7 May 2018 12:17:51 -0400
X-Google-Smtp-Source: AB8JxZoiNR6/BlLC+5AEXG5AcjD4WB0+Jum0VNah108GbJtJ/tKTquHDuxGiAdy3hxpPyeEIR8//lw==
Date: Mon, 7 May 2018 11:17:49 -0500
From: Rob Herring <robh@kernel.org>
To: Manu Gautam <mgautam@codeaurora.org>
Cc: balbi@kernel.org, andy.gross@linaro.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: usb: Update documentation for
 Qualcomm DWC3 driver
Message-ID: <20180507161749.GA26979@rob-hp-laptop>
References: <1525459689-1358-1-git-send-email-mgautam@codeaurora.org>
 <1525459689-1358-2-git-send-email-mgautam@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525459689-1358-2-git-send-email-mgautam@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, May 05, 2018 at 12:18:07AM +0530, Manu Gautam wrote:
> Existing documentation has lot of incorrect information as it
> was originally added for a driver that no longer exists.
> 
> Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
> ---
>  .../devicetree/bindings/usb/qcom,dwc3.txt          | 85 ++++++++++++++++------
>  1 file changed, 63 insertions(+), 22 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
