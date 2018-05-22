Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2827271-1527009391-2-3611593821985834836
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES daen, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527009391; b=iM2rcK2dqQMLl4zlFeWOmUtChz9vf+eqf+s9mXFQiXEQ4qervd
    4AX3VcZ422yx9j+DVJn3lncYHrh54h+FByOThnlftCLLodRt08AJl2Dp4aql7uDa
    CwQDAxQdiMPsbyqmN9FYmdXZl6E10ggTzZFm/I7XE7fb9JbmPhCCFpNEqcSaOXzI
    yOXNW+k2ivrMTCroCHbfWZOVFpNNI1q4nHF8uXqMAoqENpRqKPmKyejNYdXAFu50
    SSWL1JbD46fKcaRUEZagTX7JSv7v4sHcqTFXiMLH+ZuMYxDPg7DvqUS/+mPo0bVY
    mZyaDyQQcxYqWN7rAir3ODEVJyWqyP/uVUWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527009391; bh=lL5YswFyh3I4iQXw9GIz/HQiRwEaqH
    vrFMsBkyyXrC0=; b=JsExUZCRBMl3mh3hwoK/YQHqTDPrNh8UuaTwdB/+eAItZ9
    259rZNW1I8s3Ups9omt//pnP4kpsSjG+LogW//WkttMquIllFGaoQtEkzCkjpbm3
    4PNIr8xV6VmqVNuRMpZPViI2+QVdw7wQ1Xdf/C/8eosyVVJxDa08X6x5/RQjUvJN
    dVGToXcc7KI6WgDo/QLBl06b8BLZzSmgyvpB+Kqr7e2TYhLqtiNJqWLO5kyWigot
    Qb4yWwLXvU/uStLkvoJk6VsWhTkJciHx4u4u77P34tOAkUhqypCM7dpV8NIv7X6u
    pJLC3BmXxH0K0uV20pIpioUn0jTmxPKN4OHUKRKw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=eDZd9h+J;
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
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=eDZd9h+J;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDTlz4DD4d67wXmtYc5TcYXZ8oq/ZOEP6haxejWkH8Z0Hod+e7iXsuCY8t/jlnIYN2ZtnKP+huMKofAkiEvw2xTQgga4CGbCwugE5AayvDZPYDOFKtRn
    Mam/nvaxQreUyvAG/t5XCVETELW2d30Y5u977xrEy4NyZdHco1guF82V+zvkiXcJlSTGgAgsgHFcZu6PnV3Pq0jwTLU5K9Zgf8IebSjOijKaHlkDfAZDvFux
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=mpaa-ttXAAAA:8 a=VwQbUJbxAAAA:8 a=_3iAN5dmJPxjh_Nw_akA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=6heAxKwa5pAsJatQ0mat:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751342AbeEVRQ2 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 13:16:28 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:45631 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751329AbeEVRPD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 22 May 2018 13:15:03 -0400
X-Google-Smtp-Source: AB8JxZp59bPwweRy8zvtngxJoDE/MlUb3iXlmUIfVVtE6BN4t6T1/ASZQJ2tKReaxJiY5FjztmH0ow==
Date: Tue, 22 May 2018 12:15:01 -0500
From: Rob Herring <robh@kernel.org>
To: Erin Lo <erin.lo@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org,
        srv_heupstream <srv_heupstream@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, yingjoe.chen@mediatek.com,
        mars.cheng@mediatek.com
Subject: Re: [PATCH v3 2/4] dt-bindings: mtk-sysirq: Add compatible for
 Mediatek MT8183
Message-ID: <20180522171501.GA21284@rob-hp-laptop>
References: <1526538126-51497-1-git-send-email-erin.lo@mediatek.com>
 <1526538126-51497-3-git-send-email-erin.lo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526538126-51497-3-git-send-email-erin.lo@mediatek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 17, 2018 at 02:22:04PM +0800, Erin Lo wrote:
> This adds dt-binding documentation of SYSIRQ for Mediatek MT8183 SoC
> Platform.
> 
> Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> ---
>  .../devicetree/bindings/interrupt-controller/mediatek,sysirq.txt         | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>

