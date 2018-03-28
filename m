Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2970238-1522264712-2-14812078312365800252
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522264712; b=mMZrMTvQYdTw+2I/xapcChiRylQrjb2jzggMfn5cx6epHXJ
    GCJgrddjSvhR1wBBEQXyqaIIsoXQKRUZ+J261UJe66Z6I++PQE/fjSgjGolboEmz
    2bwXRkrHiVKmi1j68C+y5VCNi2g/+8BnG70eima3QXbyo1ISQwHozmnI+h+ya9c4
    aV2tNET7YbCYTLnbBfDsbbg6Y2nWqJLmAEFWVBWvA9CDruCpjLu++kEIutWaSYtF
    zsuE34rdoGx99N/5o8ZeUvNUFLCXKPTHnnYUg+F5/AJ+GJXCt/t4R367vXOYPjS5
    knMq+2ov1RSAwjMpVQhY9fACmkxERVwaBWA1eyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1522264712; bh=emDCqCGNqljO83cMTsp7TbdmnMEZpjYNeLBe5Q
    32saA=; b=ht6Sl0Xko6Rr9B/K7dPzCHuGc0845bX4YEDupfErLFuIuSsCqhfpJW
    F2NT8JInXD9OqoBb4Cjt7vrhoedYk/O78FI0kJqj8hMYdu3uUsJOjsOXkH3cf5A+
    hP46A9QdoV37i1jzVaQrfGxTWxTPy6dFqmLOGRieTbml0ZXNYrnTh/M6LueKOruJ
    qrM9vhqDdAlpANAR0niPVA1cnIh1Dy2S9oqtOtwZhdKQ9pKb0sjvE9moSFhHsvIp
    b/nkR/m6CQhKpmLuVAlyOezKn3TTO2cyw1jR6fRW8GTEpYsz5Bo5dnnOs7U+tx/z
    Vs3pTEwgWzlpm0mEFS1GHuz3FoCjz1BA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=pun.org header.i=@pun.org header.b=NTu+e8bp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=pun.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=aUyZ4Umk;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=pun.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=pun.org header.i=@pun.org header.b=NTu+e8bp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=pun.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=aUyZ4Umk;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=pun.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfB9v7GyEQ/KaT0ZAr7CX7JRF3yhO1yJCaaVbHjOQDaXcsdfhAB5Gdnhho0aeNLWi2sZzXSAs7qCZE79z3KaJIJJKgdBxIEIaOl17Y9LVUS8D4sP2YNLg
    dPulIX9qoCY2VnAEFZmagyMHhfnwa9BwlmD5LD+d9+rlnAsUuP7o2OVwmAjjkgVN+yuiflp6GM7IdDV53VAfhL4ZANa3bqh4PfriS5bcd0RMn8IOH0lwmjrQ
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=VwQbUJbxAAAA:8 a=jZVsG21pAAAA:8 a=yMhMjlubAAAA:8 a=UqCG9HQmAAAA:8
    a=rkqxu5jn0iWrc8PMQs0A:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=3Sh2lD0sZASs_lUdrUhf:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753231AbeC1TS3 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 15:18:29 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:45325 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752455AbeC1TS2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Mar 2018 15:18:28 -0400
X-Google-Smtp-Source: AIpwx48PVcFdMWgszemlL0EUu1bvzuTNhmfLO3f1kU96og40svMY2abMqO1RV2fwN+auEOSmuP72MIwPFOyG5DNOZ9k=
MIME-Version: 1.0
In-Reply-To: <20180328120142.7ba72aa2@xeon-e3>
References: <20180305052408.19475-1-kys@exchange.microsoft.com> <20180328120142.7ba72aa2@xeon-e3>
From: "Joshua R. Poulson" <jrp@pun.org>
Date: Wed, 28 Mar 2018 12:18:06 -0700
Message-ID: <CABHrTi+pMjYX4jqaaXS=X02o7CbWBqdMMwcyrxo=BywV18n7WQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] Drivers: hv: vmbus: Fix ring buffer signaling
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: "K. Y. Srinivasan" <kys@exchange.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
        olaf@aepfle.de, Andy Whitcroft <apw@canonical.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, jasowang@redhat.com,
        Leann Ogasawara <leann.ogasawara@canonical.com>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Michael Kelley <mhkelley@outlook.com>,
        Stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v4.16-rc7&id=655296c8bbeffcf020558c4455305d597a73bde1

On Wed, Mar 28, 2018 at 12:01 PM, Stephen Hemminger
<stephen@networkplumber.org> wrote:
> On Sun,  4 Mar 2018 22:24:08 -0700
> kys@exchange.microsoft.com wrote:
>
>> From: Michael Kelley <mhkelley@outlook.com>
>>
>> Fix bugs in signaling the Hyper-V host when freeing space in the
>> host->guest ring buffer:
>>
>> 1. The interrupt_mask must not be used to determine whether to signal
>>    on the host->guest ring buffer
>> 2. The ring buffer write_index must be read (via hv_get_bytes_to_write)
>>    *after* pending_send_sz is read in order to avoid a race condition
>> 3. Comparisons with pending_send_sz must treat the "equals" case as
>>    not-enough-space
>> 4. Don't signal if the pending_send_sz feature is not present. Older
>>    versions of Hyper-V that don't implement this feature will poll.
>>
>> Fixes: 03bad714a161 ("vmbus: more host signalling avoidance")
>>
>> Cc: Stable <stable@vger.kernel.org> # 4.14 and above
>> Signed-off-by: Michael Kelley <mhkelley@outlook.com>
>> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
>
> What ever happened to this patch? It doesn't seem to be in char-misc, upstream,
> or stable kernel tree yet.
>
>
