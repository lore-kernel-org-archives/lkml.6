Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-454547-1521655980-2-16653101420386171500
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521655980; b=g5s+oVZNBbf9HFHW9ZldXeOfEAscvkI2ouTdx1J1zM3Osth
    7FBFFwW0rsB4Su5xSLL2bWOPO/4ZuJlpjtGaKnmVN77R9iqyLm17gTL0QduqhtBb
    ZK3Gl9vNM1/gRoam01IQsZ0RTzk3F/6OW1aHWbU8LF4jYTAU1xC2xvr5zYUAf/Us
    GL9lKJ1GZ/3yJqZIQebucJX3mANLH39+46bvWURoz4TAapUFe+hRt6L2qWLSGdBP
    A5+EmTcDp5Kb3gLhQt/wx9w7ybO3+EXjQSudNy9TFEfG8xBh2LftFw8qKK+Y5MKv
    7mSKn/VRSEYNEtHEz3AAaj/Wj7r0AO51+9ndIGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:in-reply-to:references:mime-version
    :content-type:content-transfer-encoding:subject:to:cc:from
    :message-id:sender:list-id; s=arctest; t=1521655980; bh=zhG+6JOv
    Yb5UOlD1nKrLzdI21LmkWAzWWCnwpGErJTc=; b=Jn9bpGB7Ps0Qmz96YzgDH6F4
    EQq/5nEzB/itzmVWwwYkpkaN7WNtISKhjjCHwcfw+5oFvdZxAPjXqziBnEtOgRiS
    cRJcEhw60wr0KzIyKWqD0EVQSQJUyTaRbMPywUvObBO31CbIFDCdxTNGD9nJKuVi
    8InH900AjsRLLJ7sAfp7YKBvM/m5eC8ao7WhMh6LhUq/XZ8+zS9Omak5nBrP1HVf
    2X1EyOq8BgaG0oeFoSvthLHMChprbPHLs/bt7f9ox20SRFlfBeLkLf030MAM7QQ8
    ypfDZS3KdZVAyRp0u5Qk4e7pzYh+PsoI20FrTRMLRZh3Ubv/pR6ec4f0QT/Y1Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=JR9g4bsV x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ib6FheWg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=spam score=190 state=1
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=JR9g4bsV x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ib6FheWg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=spam score=190 state=1
X-ME-VSCategory: spam
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752596AbeCUSMf (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 14:12:35 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:34985 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751416AbeCUSMe (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Mar 2018 14:12:34 -0400
X-Google-Smtp-Source: AG47ELvlvEbf2AykY1yzYr8101bVsCD4VvmkAMn/l/x4G9LmwXEGJLyw8Oeu2k49JV57RS4R+lYkuw==
Date: Wed, 21 Mar 2018 23:40:07 +0530
User-Agent: K-9 Mail for Android
In-Reply-To: <20180321162437.GB3506@kroah.com>
References: <1521648597-2642-1-git-send-email-vwei@codeaurora.org> <20180321162437.GB3506@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/1] Bluetooth: Set HCI_QUIRK_SIMULTANEOUS_DISCOVERY for BTUSB_QCA_ROME
To: Greg KH <gregkh@linuxfoundation.org>, Vic Wei <vwei@codeaurora.org>
CC: marcel@holtmann.org, linux-kernel@vger.kernel.org,
        majordomo@vger.kernel.org, stable@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@vger.kernel.org,
        kumo@qti.qualcomm.com, vwei@qti.qualcomm.com
From: Harsh Shandilya <msfjarvis@gmail.com>
Message-ID: <FD229C76-5144-46E0-B7DE-47333B3B4D03@gmail.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 21 March 2018 9:54:37 PM IST, Greg KH <gregkh@linuxfoundation=2Eorg> wr=
ote:
>On Wed, Mar 21, 2018 at 09:09:57AM -0700, Vic Wei wrote:
>> QCA Rome controllers can do both LE scan and BR/EDR inquiry at once=2E
>>=20
>> Change-Id: I89e1412d635f4cd7b2500f7492f37430ea139f0c
>
>What is this line for?

That's the Change ID required by everything that goes through Gerrit=2E CA=
F (I'm assuming Vic is from CodeAurora Forums judging by the email) uses Ge=
rrit as their review platform for the Android for MSM project=2E
