Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2341778-1520525393-2-10235366380836844959
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520525391; b=QWcCyK5tT8pFqDEZg372OHO4Uqh9wL4G9yxCwFMgbJEzkDy
    EsXE9nPYisKkQciJxcxL9Dxc8TMaW++CanK2jpuTqv0A6l2vMdX9zeNelJSO5gu4
    tNlsiOvY+/DEXGECHbjNiGO8kN8wz4GsnEc1cg62EUyQ0/QGjkJ5cyxFWXxNqUEx
    ne1mPfw91L7lZcuT02eGgOIDMn/oLOwqhHAvbssIGgtIW+LEeUKakWIz5npWx/n5
    OoSMnMBj+74b4W3NfmNzjySIJVRPDQUTNrfPXb1vrtU9INMswtbeN6/BmR9beAY3
    TIT3HFteNKQqoORdryQE3PkD91v7DQWToP7ggfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520525391; bh=frp8iI5C+Wgs7OYHArJ8FtqkpzDwCAR+6yI9O+Ldm+E=; b=P
    /+BFrKDdFQBa9PyOnMlhr3/p9YopsZzVWKRcgkHOfXnWnTXzuqEdiO19jUmnq3TY
    Y9RZQu2aWiQlfGw9E6KeN0yIi6OifYrjNm0lEPni0D5klGlZp5I7gBP10ZVlLJvr
    +D/7fEagnHwPNyX3/Gcy96/4pq9b/PDGQ87dh1eXTv6tMWu9VYC6qAlVIWajXSby
    RSuuF73JxOxFIeIEh6NS1sm8xg0/yVu+Wj9Ijb4IL9xYi85JJuwo5mop+c9rl28B
    9fa6+Bd5vYPbkuFQH7y+HHdxWyUx0FhCyeRnmJuRdt02X5cZta3rVTe0o4JiMKcL
    6znAWKF8XMBCU3yEMzt4g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=lechnology.com header.i=@lechnology.com header.b=nqczjCvb x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lechnology.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lechnology.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=lechnology.com header.i=@lechnology.com header.b=nqczjCvb x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lechnology.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lechnology.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755957AbeCHQJs (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 11:09:48 -0500
Received: from vern.gendns.com ([206.190.152.46]:48281 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755675AbeCHQJr (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 11:09:47 -0500
Subject: Re: [PATCH AUTOSEL for 4.14 04/67] dt-bindings: net: add TI CC2560
 Bluetooth chip
To: Sasha Levin <Alexander.Levin@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
 <20180308045641.7814-4-alexander.levin@microsoft.com>
From: David Lechner <david@lechnology.com>
Message-ID: <d3246708-4dd1-2a49-b3e5-7e459adc68d2@lechnology.com>
Date: Thu, 8 Mar 2018 10:09:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180308045641.7814-4-alexander.levin@microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/07/2018 10:57 PM, Sasha Levin wrote:
> From: David Lechner <david@lechnology.com>
> 
> [ Upstream commit 07c7edd0db441f83eeee087470add5be280cc018 ]
> 
> This adds a compatible string for the Texas Instruments CC2560 Bluetooth
> chip to the existing TI WiLink shared transport bindings. These chips are
> similar enough that the same bindings work for both. The file is renamed
> to ti-bluetooth.txt to make it more generic.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> ---

I don't see how this patch would be useful in older kernels since the
driver support for this compatible string was not added until v4.16.
