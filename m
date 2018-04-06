Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-836254-1523001693-2-12718665253882907737
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523001693; b=UejM8+bRaeNXzuI9aRVrXWdMjRnLmCqh2o0Y52sMSxfl5NWOQl
    aQWx+NDmdjTJdPiDCLkkNh9fQXD+LUUcQ8xK4ubtPABNmrB7zspsU0g2VXOc29Bv
    hsC/S05VhiLGrIPCLJ6QkkrPcjc3qpeVLqEgfNf+8VX6+DPr6Ff1VciA+pE15wiS
    ryL0mCKhcpzZkJ+jjWut80n7vKgF+YIYVqAk1rctTivXKWiYhOIknasyv41Cfrgn
    xjIan+eTmWmkDLZRLQEsBUjKvCK1nKLWGIbGmQpXcgAKmbq25nAzt0AIZs2XxIX1
    X2pMVKAApXUe55ZBpQQ09EZXBmTSDb0qzeXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523001693;
    bh=n2fuEeOP9IAxdrs6fFQIjKAtwL0xvBkDv77gw388JL4=; b=VXZxujHLLd52
    aSEzon9AuK57x+CsXKseVUIcG2JmuqfeCkyoHpEHCwLRukrtfzyTSVTSvGn99NTb
    p5nEUWwkLbUFjuMOtGg4HbkHGBhAgoElgMCwZPn4xJyUEgGZXGAucXvLGUJ69nZt
    WSoDGHT2rIZkWSg4Hgb2qO4VM27gZeRdvYpCjoF4PkSmDA7VyWa/k0mNiRr+ZAOs
    dotSMqEBa6DYCLpbj6Mtokr2DDPrYlDrdHeGD5thHac3z/C4mN4pRshJ/qxspHr+
    0t9euyXUc5AXIRCfzsFOiAMdG+E1UDr8PWmQB7ijY0CuWDca5xut3xD/NDA8dabG
    THBfQi8vmg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b=HaDvPUxr x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=cogentembedded.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=OlpzKF0f;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=cogentembedded.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b=HaDvPUxr x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=cogentembedded.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=OlpzKF0f;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=cogentembedded.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfN7VNVce6rWNB2TIn4rSrAQxxgTn8OGycjCOd5fhi5NyoCpfyrP7+3l2g4VlaLFzCwnuD9VQoy99Qr5RHaa9rKQ33S5Tc81g78Y2TyBoYifb6SlefPk0
    SC0DDLjjzImAhC+SAr55BfUnA9D+b2y/R25aG3xw0KSLaUkmd678E/a0J00wYTbxPln+OlRVzsR1psNGnDrSy1+g+v9pXPCMlACYKi9vvKVs9+H2vGzL7trl
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=hD80L64hAAAA:8 a=VwQbUJbxAAAA:8 a=qeNWEsG3IMKiSy4xu-4A:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751482AbeDFIBa (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 04:01:30 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50485 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751344AbeDFIB3 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 6 Apr 2018 04:01:29 -0400
X-Google-Smtp-Source: AIpwx49l8XOg6sstL8QgVSKCuCdSOEapjdfuYwhby3RrRElhDMayFASZYYqDmdtq7qTS3K3+28LAbQ==
Subject: Re: [PATCH] usbip: vhci_hcd: check rhport before using in
 vhci_hub_control()
To: Shuah Khan <shuahkh@osg.samsung.com>, valentina.manea.m@gmail.com,
        shuah@kernel.org, gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180405223149.24643-1-shuahkh@osg.samsung.com>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <2bbe1e03-82e6-49c4-ca5b-30ada36a6e5a@cogentembedded.com>
Date: Fri, 6 Apr 2018 11:01:26 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180405223149.24643-1-shuahkh@osg.samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello!

On 4/6/2018 1:31 AM, Shuah Khan wrote:

> Validate !rhport < 0 before using it to access port_status array.

    Why '!'?

> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
> ---
>   drivers/usb/usbip/vhci_hcd.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
> index 20e3d4609583..d11f3f8dad40 100644
> --- a/drivers/usb/usbip/vhci_hcd.c
> +++ b/drivers/usb/usbip/vhci_hcd.c
[...]

MBR, Sergei
