Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2795407-1522801461-2-12899784518733463521
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522801460; b=mM4jurrJj1VbtbrD5qXpND9vY/QnlfaWodxCi2EupicWoeWLWp
    0B5t1OZTVCKZBIcCAd3KVVCgrbk9aWrhoZbjB7yBk6BEq1fscJ6DSZWnsqDiygPT
    JcZHPxPxhNVnSDjX8sTxM9Zyp0aCQXI7voH1T5q6K0GYOsb0tuWTjqRqGZmsgaGX
    RQoe1VFSkbX9b8eJCc30LPreULs933x9JjdLBMlvMe7r1oUT04QNmbqeJBSomrLl
    2oeca1MXC/nCtRXRbnNuFCgHzq66OmIN3vuPvRGuVBmmDOI5G8bofLBzNZYCJubr
    VDlA0n1I/Uvg5GE8h1w34M30GVAbXDoZB+Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522801460; bh=MayEufJMe0oJATbM6SLK/Yosi/cRN3w+0SXl6gUojr
    g=; b=SpAPtEVlutfBzGujSv9d19mdxVHJxFQJdObHt+DdYywSVUteMlXGVuhVn2
    dRdyPov7na2PDhu5Bry4fVuHOhHzadHnrvTYBnTj7OvYRrg2HS4n1A2b7G7UNnPv
    Ap11P0iKx6eN10QWI2LzPZsTgq3s1IfaDibFc3IVJF8hLV6+64Ldn5E0WdK/n2Xr
    u2xEg4EwCIxN6RSr9wcWhcdrJ0RJ9G0GW4rDin9Wa609kotIGSVPLJm/LbLtM9cx
    PIbyFMGuchkiYtK/jJCdOPcEIS+fh7bLxr9FBfnOP0vXwmEwe8S/vroOxBmiu0Or
    PJXpCiOmx1jJCc35fNOpgVVvUa0Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=VQfHHYbg x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=YeoVE7we;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=VQfHHYbg x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=YeoVE7we;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAV1TxwFGNXtyGobXdj4Nk+EnsOeU6eTexfqA1x69tZUimHsuvPFLwZQhDAOJGUJW0Flo2xJRsMjtGg7G3aQRn+8yU8vQn7RAbBMvKqjlNgduppO+ukn
    OtDLXXQ9u8n2nB94aIpgR1rOQOQtSPmd2KBZbI6TaSihMqgkWhHiwdT/lgnZXxWDULEx3I8BuQYgFAsAJjJLARWJeHRCo8pO6pavUZPrkSEzWQkC2fjbjx99
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=qBLM2u2oz_EA:10 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=57SyGIRnAAAA:8
    a=XmsP5HhoteQGVB0mubQA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=YzT4AsKTxtEdF6UtD8mD:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756741AbeDDAYL (ORCPT <rfc822;greg@kroah.com>);
        Tue, 3 Apr 2018 20:24:11 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38367 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756608AbeDDAYI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 3 Apr 2018 20:24:08 -0400
X-Google-Smtp-Source: AIpwx49A4MxewlZdW8Ccfp6IlsTJA9UXrUSg96h9jh+H/JkwPVI23VND0SQ0Eg+hvi+iKFu8sg8E8KNjbxNAf5Oz1GQ=
MIME-Version: 1.0
In-Reply-To: <20170914132452.d5klyizce72rhjaa@dhcp22.suse.cz>
References: <1504672525-17915-1-git-send-email-iamjoonsoo.kim@lge.com> <20170914132452.d5klyizce72rhjaa@dhcp22.suse.cz>
From: Joonsoo Kim <js1304@gmail.com>
Date: Wed, 4 Apr 2018 09:24:06 +0900
Message-ID: <CAAmzW4NGv7RyCYyokPoj4aR3ySKub4jaBZ3k=pt_YReFbByvsw@mail.gmail.com>
Subject: Re: [PATCH] mm/page_alloc: don't reserve ZONE_HIGHMEM for
 ZONE_MOVABLE request
To: Michal Hocko <mhocko@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello, Michal.

Sorry for a really long delay.

2017-09-14 22:24 GMT+09:00 Michal Hocko <mhocko@kernel.org>:
> [Sorry for a later reply]
>
> On Wed 06-09-17 13:35:25, Joonsoo Kim wrote:
>> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>>
>> Freepage on ZONE_HIGHMEM doesn't work for kernel memory so it's not that
>> important to reserve.
>
> I am still not convinced this is a good idea. I do agree that reserving
> memory in both HIGHMEM and MOVABLE is just wasting memory but removing
> the reserve from the highmem as well will result that an oom victim will
> allocate from lower zones and that might have unexpected side effects.

Looks like you are confused.

This patch only affects the situation that ZONE_HIGHMEM and ZONE_MOVABLE is
used at the same time. In that case, before this patch, ZONE_HIGHMEM has
reserve for GFP_HIGHMEM | GFP_MOVABLE request, but, with this patch,  no reserve
in ZONE_HIGHMEM for GFP_HIGHMEM | GFP_MOVABLE request. This perfectly
matchs with your hope. :)

> Can we simply leave HIGHMEM reserve and only remove it from the movable
> zone if both are present?

There is no higher zone than ZONE_MOVABLE so ZONE_MOVABLE has no reserve
with/without this patch. To save memory, we need to remove the reserve in
ZONE_HIGHMEM.

Thanks.
