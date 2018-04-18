Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3696969-1524030508-2-11246533637504965718
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524030508; b=rQZew5jrrEksE9dT33Dmgvz1H7ArwD8qOw8tHP0gUPQyGSceIF
    Ws4RjcCOA6iaGHQCwe+FqpcPO109sK5eg7g3m94LJ7OlohHciJ5QUFIucXQKh0Qv
    4aWaE4CGDw6pjckt75KRiAkSlpAEn6AGQkIppcKrBmmzm4+adRNSrRezkTa02U3z
    B+WVjZ0nH+M7DDDbHKpwu0c2DRFYlu+n7QkOFsFCn+t04TLUjVEa503Klm5x/5cy
    Qe7nPBkLkOKyaFSfRzGvQQqkbX0LvofqOo3PLIOJXoSUN++NIjatekH+2orMp1QV
    nFChi961QpzDdNSt4sDm1tKiK14GXY2gYaRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:content-type
    :content-transfer-encoding:date:from:to:cc:subject:in-reply-to
    :references:message-id:sender:list-id; s=fm2; t=1524030508; bh=j
    BrDBMYh76H3W35jIK8lOUSxlh9dyvJVlseJoJC0kPc=; b=lk7O20TXZtj2meQyg
    M2Ji4kOylFPzUpRZZoHdOpdpJZxf25rucVOUJC0krZKb4BRuCoendzf96ya3rkIY
    Bhpyd4Dy5Z0E0OW8ajHT2wzoU61bVbxo7PxrR81bAblo2okhxUjB1bL+CPAUjxvm
    1HBxf2kxC9z4svtaScxDNBbPPondYgJDgAkG+ZHbdUgG3vmgzy9mAOKmN+mgYCh/
    znrwJFM2+JBmoN0+6uF2e9y6ehEwYRzW00byVGCIdjiOMhiLuD5oZQL++Zml1zud
    J2n1KWTBdLoh99QXq8ReY6dvyO3RwvaULRBGfju29LK3VYN5+gvKbzE0+xESOjPZ
    ZmasQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=PvDpKMs3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=PvDpKMs3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=PvDpKMs3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=PvDpKMs3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfF8b4DeZN6k2Vi0jBpf8ZU5g9b6Nz8Xh/V9tpRqiFNnA6pv8rzWvdXDoiC4aSFrc+6iXed6FdK++Lx8ZP8Q83pb9QlPxX1w6JLg3ClIB9cISn+viKkIl
    7q7gsEV0bxg9vZMwQYKTtZiw1DIGhMfZjkShi/6djcgp0Xx8SUTmuAxII1ktMdmyHzPCIOWYf1n6mlUizzB+wwf6Q/yLqH7d7cWRVEnZfpnAlDwL4uHGKjd9
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=yJRlFQ8ozdylipYq10MA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752144AbeDRFsM (ORCPT <rfc822;greg@kroah.com>);
        Wed, 18 Apr 2018 01:48:12 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35426 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750718AbeDRFsL (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 18 Apr 2018 01:48:11 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-2.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,T_DKIM_INVALID autolearn=no autolearn_force=no version=3.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 18 Apr 2018 08:48:10 +0300
From: yossim@codeaurora.org
To: Peter Rosin <peda@axentia.se>
Cc: Peter Chen <Peter.Chen@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:CHIPIDEA USB HIGH SPEED DUAL ROLE CONTROLLER"
        <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, robh@kernel.org,
        swboyd@chromium.org, devicetree@vger.kernel.org,
        Stephen Boyd <stephen.boyd@linaro.org>
Subject: Re: [PATCH v2] usb: chipidea: Hook into mux framework to toggle usb
 switch
In-Reply-To: <ec1c44d7-45a8-a27e-5c45-717b87d3b252@axentia.se>
References: <1523973148-2094-1-git-send-email-yossim@codeaurora.org>
 <ec1c44d7-45a8-a27e-5c45-717b87d3b252@axentia.se>
Message-ID: <e75dff8424debcabd79f36faf3b23aaf@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-04-17 17:11, Peter Rosin wrote:
> On 2018-04-17 15:52, Yossi Mansharoff wrote:
>> On the db410c 96boards platform we have a TC7USB40MU on the board
>> to mux the D+/D- lines coming from the controller between a micro
>> usb "device" port and a USB hub for "host" roles[1]. During a
>> role switch, we need to toggle this mux to forward the D+/D-
>> lines to either the port or the hub. Add the necessary code to do
>> the role switch in chipidea core via the generic mux framework.
>> Board configurations like on db410c are expected to change roles
>> via the sysfs API described in
>> Documentation/ABI/testing/sysfs-platform-chipidea-usb2.
> 
> Ok, so this is v2. Please describe what is different from v1.
> I have told you before that this information helps.
> 
>> [1] 
>> https://github.com/96boards/documentation/raw/master/ConsumerEdition/DragonBoard-410c/HardwareDocs/Schematics_DragonBoard.pdf
> 
> This link returns 404 for me.
> 
> Cheers,
> Peter


Hi,
This patch was split apart from the original patch into two patches
one for chipidea and the other for bindings.
this patch has no other changes two the code.

I will update the link.

thanks
Yossi
