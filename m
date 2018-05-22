Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2827271-1527009477-2-968617071626403443
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527009477; b=nL6zjohIWM1egsnwAQCQgfd/0JsoZb82V6eURkGg2g8YqFnfDr
    +PO68iCaBjaf5McBNMLKuQ7n7qA/P9vvBd2Lxeb8GQuKgZ/vCh41+8v137jNqItl
    u/hLaRplqlLxsCQ5ZYO/Q16Q5eZfB7oukFX6bJIy2LllyFcyCib8+/UcAFeP4g08
    pQr2Dw390LbWiLek+tBKDjyO7HTubRKMe5aTZW/s02Oi0n+apqbL4JwlG1Y+jiDW
    c8rQoO6B75GVziDrUg+VRlhgaeeaFcl8xytufuP8KtzkhXSpEdYjdX7h2K6v0VFV
    rqiAE7OBQMLu7s8LC99GQuscpdHA4yvHp68A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527009477; bh=MusdZykjBYJnJde7DOj6sadbicuI6g
    nHz2VQEhwIyNU=; b=ImDNR4iLVcHqCrdZ1b7K6ghnpZkH1khfz5HeoU9CogtMwy
    sMulOb4Dyw0silB9thixWcnh6tfHkXNbbn7Wku09QQKv3C2nEvJRy4gJBFukm7bD
    26guYPpG7tLaYpqKm6oxmk2dkdVQRrCbHZrEs372L9H2jh3zyniCgYr8GTfjICay
    yYUuV3uOT2dAL+q3ldqazknib7tu5UJr9cmvoj9QlS/ChS51PqDaKQBamwn/jGJf
    +zX3DAVbTUexY6bjBS/AJSUyT0BLjCd67M2+AQmyRRyjZnIOGF8dm04evUJahhgb
    FDz5NpCgTRp5tKg/ix1iYLLaNPCCmRN5U5lR5Xkg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=a+H+3ep7;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=a+H+3ep7;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLm2dwxQVAoN9RPQWS4CxawQBdgDlveb/3sDR5Hchh0+NlN2q4LqVipPwjWUvVJY/1HGGrz/l8S2qoJPc2ZHDBXbE0k/O7R8KlftTvd33UWCzPdXZ2ci
    kChBVO33mAeAwBS9uQr8zAV+sFI6ma+aDrJnduJ7AbGW42OXNt3IOdjpdTSbQ4lVSeWjZCE/H9QxjhcuHccpbu9es6AAJX8UV3LK41tD+aMwvbGCv3DcbisC
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=mpaa-ttXAAAA:8 a=VwQbUJbxAAAA:8 a=_3iAN5dmJPxjh_Nw_akA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=6heAxKwa5pAsJatQ0mat:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751511AbeEVRQa (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 13:16:30 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:42679 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751326AbeEVRPm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 22 May 2018 13:15:42 -0400
X-Google-Smtp-Source: AB8JxZpmER4sMKiD1HSGDBqZggXdWpTs8r6+CEQs7hRz0gYXsTHogGhks3rN5o5KB01IJqnBt2ap4g==
Date: Tue, 22 May 2018 12:15:40 -0500
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
Subject: Re: [PATCH v3 3/4] dt-bindings: serial: Add compatible for Mediatek
 MT8183
Message-ID: <20180522171540.GA21870@rob-hp-laptop>
References: <1526538126-51497-1-git-send-email-erin.lo@mediatek.com>
 <1526538126-51497-4-git-send-email-erin.lo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526538126-51497-4-git-send-email-erin.lo@mediatek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 17, 2018 at 02:22:05PM +0800, Erin Lo wrote:
> This adds dt-binding documentation of uart for Mediatek MT8183 SoC
> Platform.
> 
> Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> ---
>  Documentation/devicetree/bindings/serial/mtk-uart.txt | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>

