Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3943267-1524036809-2-2760491530746709817
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524036809; b=T2f+AI28RSrhHMpjABbZWHGLCxsCfbFmBatxuhF06E6ZIE8Wdf
    XZgsr7IIXnQUbdtWeE/FXViGg8yhiBs17w/1JhoPTwwtHaYd5uzIvjTXD5F+LL1B
    ZZUctrnuiZMy0CCuXLIjZUjd0ObF0+bJ1yrD6eQFDwPWllZ/ZLsVzc0ynF+zOjkv
    6XDIK6A4p3U7yHr7v/nW/Yb4IL0XvPHM0/9k/ksVhWzEbP/vw9v5tTLsc8fm7yAn
    /0t34P00mVmVPMjePHahrkG9X9cIEHYtnBfh5VRYQgF9cYwLIptpgdxFBX3U4nWp
    8Ykj1cjIyRQHeTICaMPsB5nTGuN+RzyG5b3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:mime-version:subject:from
    :in-reply-to:date:cc:content-transfer-encoding:message-id
    :references:to:sender:list-id; s=fm2; t=1524036809; bh=s3Af1CS5C
    JwU0N69VMGfGu/9J/tTXvrmZ+LP5YoIT3w=; b=ZbSEapkjFvAuREqn4h5xL+CsI
    Oyw1UGhqtUUhL7i0CWBZoxY8XYYguVTPVJ9eVa9RiRaP5WM9o1jQily1TeMrpGr1
    nG88ny9Kcs+2Xa4l14RGWTFjWNcT7grXaNepHxMnMLgdLpm4jddNZXHoUQAGnk9m
    /XpkXi27HrZKXSMg18OI0FG0ML8mQTysrV6n9JGQs3+MMBN9Pey4LZpfbbW0AItK
    yOaVceymxzNKA6VBybk5e815M9eJLzvEtELxkdpq9tVwKd/+YNyrvgW7so7hzSMZ
    Ao5I+fP2uffnOnHQluVhG0L7c/kBYE0rKtpAMLYXGexOt39zJUU19cshW9Dyg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=holtmann.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=holtmann.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=holtmann.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=holtmann.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLHw21Gq8qWpIZ0/FT8b1R6i6vCTXj3tPXeD1NSCNOzVSPpZJfeLWvrBJV2keJ/W4HzJ/KYwf8EoINjVvyA3CcOITSmCWcGDs5ec7R1sjunAa4ULEskS
    ajKnKdgpc+TTSAnL38jd5+gLECpgiVfkDe8p41pfziEIetmlDXkC9OSDeuGa59FsOeJ3eYoekmC5nebuCIHgbdgxNcQyBPZlFoThrqASF3UYaFP1V1fBE+Qq
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=KKAkSRfTAAAA:8 a=Dei6p5SHAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
    a=Lq4HHxXSK_lPJjLtylgA:9 a=CjuIK1q_8ugA:10 a=cvBusfyB2V15izCimMoJ:22
    a=M-Yerj1wOn-OpK7r_3ei:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753197AbeDRHdP (ORCPT <rfc822;greg@kroah.com>);
        Wed, 18 Apr 2018 03:33:15 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:35059 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752989AbeDRHdO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 18 Apr 2018 03:33:14 -0400
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH] Bluetooth: hci_qca: Avoid missing rampatch failure with
 userspace fw loader
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1523860824-3392-1-git-send-email-amit.pundir@linaro.org>
Date: Wed, 18 Apr 2018 09:33:11 +0200
Cc: LKML <linux-kernel@vger.kernel.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        dragonboard@lists.96boards.org,
        Loic Poulain <loic.poulain@linaro.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Stable <stable@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <1C10FB33-04EA-4409-BE56-6C8BFC28B3ED@holtmann.org>
References: <1523860824-3392-1-git-send-email-amit.pundir@linaro.org>
To: Amit Pundir <amit.pundir@linaro.org>
X-Mailer: Apple Mail (2.3445.6.18)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Amit,

> AOSP use userspace firmware loader to load firmwares, which will
> return -EAGAIN in case qca/rampatch_00440302.bin is not found.
> Since there is no rampatch for dragonboard820c QCA controller
> revision, just make it work as is.
> 
> CC: Loic Poulain <loic.poulain@linaro.org>
> CC: Nicolas Dechesne <nicolas.dechesne@linaro.org>
> CC: Marcel Holtmann <marcel@holtmann.org>
> CC: Johan Hedberg <johan.hedberg@gmail.com>
> CC: Stable <stable@vger.kernel.org>
> Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> ---
> drivers/bluetooth/hci_qca.c | 6 ++++++
> 1 file changed, 6 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel
