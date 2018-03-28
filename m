Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3011300-1522263709-2-17041279522117431082
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522263708; b=K/zWH9rj4/B47+LlJXuysj5Z9mWTBnRdP9Nm/4mv/y0tbrb
    ZoGQ1QQAaLQ7cajvncU1J1eQNamO7bTcyWM4+NowdJH17zbh48nY8+w7p7yrfnb6
    kmowWrOgJb78iCQmttWOjMi86jfOU9SE244mB5eOxoOmbcBB0RrrnSChemlA53yf
    +60hd3Ts2VoendJbJl/tMvUITFCs56Teiz7fQF1ysPPoB2gbyunSnvmMotrZMMQ0
    uAGxG1YeAuz/8S9NyizgDyEZmvWS+x19VUqsV0pDAgA4WRl5r8PFNyM405HllpQ/
    7KaUoGs8Ckk9Iq4MPRhyDJHRERpqgHcfoyp05FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1522263708; bh=Gzsa1p7iecG4GYql+SM7WbD/7ju/6n8dNzpN6f26nNs=; b=R
    KA+I6iNxBFjisZGmNttgVixxcFqlLIneXQnGz/5uD9+776ZicHEIidzz//wzs3XU
    n1GHO5UhuMCkXcE0MvSfRpLXyVjdZM3iC4BV0YXE1ku9IbgFUCusRrsAS022bakB
    j14Gl36b2ZMzuSgBBnoK2yxlIY6UdrpNdpjp647NQ1HsaX8hgGc8GTNY3mzfdFlg
    notFw3BGhWxB8KqCAKxhr4tE52te5AtViBfAGyVHb6rUiDrOYQbPa5PeGn+HSSft
    sqaEU8paROLo1vLxdkIEFVoYLlwmfTFjm+U3D/RRr4WgvSVL0QVGO24yh7xy7vAk
    NScL8lxkvlFY9Xmw0A6lQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b=c4t3YEC2 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=networkplumber.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=h18q7Grn;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=networkplumber.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b=c4t3YEC2 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=networkplumber.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=h18q7Grn;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=networkplumber.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfI43Rh7pExPdQow3tGd37TBBG2ljF0iWcTd2L6Dqz7ETcwXRHp2014+nF4Pcm4Ybz+2wwkQmzRq72tl3gCESuA+EoHP3T4sX2q8LpAb0R1CSWzCILnTx
    F+MEuP1EzuQS18dk0q2umxEpujwdWZdfwOaOaQGZ6YKeSK794K/GBi1jKqzyy/5EyMwb9GyzJBrLLKWDeCwmxD2H5BXG/FDXDS0PUrTesEeHQ+10zYBJ7LMP
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=yMhMjlubAAAA:8 a=UqCG9HQmAAAA:8 a=VwQbUJbxAAAA:8 a=E_-xDWRltKT_GDG8RqwA:9
    a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752377AbeC1TBq (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 15:01:46 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:41353 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752907AbeC1TBp (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Mar 2018 15:01:45 -0400
X-Google-Smtp-Source: AIpwx49DD2H1Do4IskMFkya77kh7qV2+jHPvZuMe82R7D31w4dxBs9qCqpJn8meBIgFKMpT3Zo3CTQ==
Date: Wed, 28 Mar 2018 12:01:42 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: kys@exchange.microsoft.com
Cc: kys@microsoft.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
        olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com,
        jasowang@redhat.com, leann.ogasawara@canonical.com,
        marcelo.cerri@canonical.com, sthemmin@microsoft.com,
        Michael Kelley <mhkelley@outlook.com>,
        Stable <stable@vger.kernel.org>
Subject: Re: [PATCH 1/1] Drivers: hv: vmbus: Fix ring buffer signaling
Message-ID: <20180328120142.7ba72aa2@xeon-e3>
In-Reply-To: <20180305052408.19475-1-kys@exchange.microsoft.com>
References: <20180305052408.19475-1-kys@exchange.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun,  4 Mar 2018 22:24:08 -0700
kys@exchange.microsoft.com wrote:

> From: Michael Kelley <mhkelley@outlook.com>
> 
> Fix bugs in signaling the Hyper-V host when freeing space in the
> host->guest ring buffer:
> 
> 1. The interrupt_mask must not be used to determine whether to signal
>    on the host->guest ring buffer
> 2. The ring buffer write_index must be read (via hv_get_bytes_to_write)
>    *after* pending_send_sz is read in order to avoid a race condition
> 3. Comparisons with pending_send_sz must treat the "equals" case as
>    not-enough-space
> 4. Don't signal if the pending_send_sz feature is not present. Older
>    versions of Hyper-V that don't implement this feature will poll.
> 
> Fixes: 03bad714a161 ("vmbus: more host signalling avoidance")
> 
> Cc: Stable <stable@vger.kernel.org> # 4.14 and above
> Signed-off-by: Michael Kelley <mhkelley@outlook.com>
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>

What ever happened to this patch? It doesn't seem to be in char-misc, upstream,
or stable kernel tree yet.
