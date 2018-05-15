Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2893015-1526401311-2-1270287268702895632
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='dk',
  MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526401310; b=isKGhbRkU73FIyuKZrudYUBg8zugyDxiz0cnU0II3kFFQSYTGP
    lGFKMT9WMnLIFElGd7dw1DXzN3++6zUROuqVMDc73/PYixfZwbSjmd6YM/XoV6Ng
    XhCbpF6LebCQqrEqsTyWB4ApbNacbGy2uFh7HHQ9Sqwg82koRMuhapx3L26M7+5/
    bQQwTIV6urBAmtnwawG4XrkKaQ99EvPnW3AuWdDJ7Ae3Xa01RplSEwEUjhpmAsDV
    kkGEWOAiC39/H1vS9BhieX5Fzx0Pw+t9/s85FbtlYNzPxDmKYmz/ApcUM/Eez114
    qowJ06lWUFWrPm4hUda8oXPrPfX89oApWrfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:references:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526401310;
    bh=V+YlWid0/MCdkmg6hAcQCFaMBzckDhrDIgQfxXE5U68=; b=irfkPMcfluS6
    Ju5x6RPWaXZ1bkNmXE2a+Bz6yVT/rAm9B1i6j3MArFI5J53L0fiCcevz8PYo9IOE
    CkO0H0zFPBdOaooN9W0dyXdq+wgvbSPgzJaL5nAsLK/ZFMuDDg2jZmkWpkn4YQ4S
    bab241W+9j9R5pvdIopCfda5fFFftatTt+jyUSiW4pZBYG/XdwFRCNCLsWoqAX7L
    q3HmVAGf+dn/4FKJbD38Iwjo+lGHdb1FFanmYnes4teCgZOvZwq3ioJvVtl74Rsx
    cXt3GuSax0Z0niyti6TMdLeWYRvD22zGbg5PKfCqRQMgWl0te2LKlN1yn4fmrEut
    ZgjYriM4mg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=kernel-dk.20150623.gappssmtp.com
    header.i=@kernel-dk.20150623.gappssmtp.com header.b=UHmEK4O0
    x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.dk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=HRa3okFk;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.dk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=kernel-dk.20150623.gappssmtp.com
      header.i=@kernel-dk.20150623.gappssmtp.com header.b=UHmEK4O0
      x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.dk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=HRa3okFk;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.dk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKumbb3ZHFIgC97IhhxMtzfOEBXakLuzXutoBwUXKhJEOhBt2v5g52c+J5ZTtfVUBvyxXnYgTtXGUrYAFph4VKvVUp2Lv6K8mBZdqUFlKFWhDl+ma+yE
    FpCaehJZE8LqZBb+ZBHayGRhlg5ZoUUWVnYNkho3EbNAeQUUt4U25oVCTFisqrYORpnSGa1rgbAwQ5WeYQDaziIpIeSmEvXymsHVABj4ATi5keJceYQP9snO
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yMhMjlubAAAA:8 a=D19gQVrFAAAA:8 a=VwQbUJbxAAAA:8 a=sVA1pJQuRCTM7670jiIA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=W4TVW4IDbPiebHqcZpNg:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753977AbeEOQUp (ORCPT <rfc822;greg@kroah.com>);
        Tue, 15 May 2018 12:20:45 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:34624 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751309AbeEOQUm (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 15 May 2018 12:20:42 -0400
X-Google-Smtp-Source: AB8JxZpBfbXYSqJpOT3IaOlMxX7HAYX4k/SzmY784P1QleatSEV+JWoGyWxRHMmESws3wX0/tQvllA==
Subject: Re: [PATCH 1/2] Convert target drivers to use sbitmap
From: Jens Axboe <axboe@kernel.dk>
To: Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net, linux-usb@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        qla2xxx-upstream@qlogic.com,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc: Matthew Wilcox <mawilcox@microsoft.com>
References: <20180515160043.27044-1-willy@infradead.org>
 <20180515160043.27044-2-willy@infradead.org>
 <3a56027b-47bc-dcb8-a465-3670031572f1@kernel.dk>
Message-ID: <6ab7d206-ba46-6b1e-5210-4894ec4dc553@kernel.dk>
Date: Tue, 15 May 2018 10:20:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <3a56027b-47bc-dcb8-a465-3670031572f1@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 5/15/18 10:11 AM, Jens Axboe wrote:
> On 5/15/18 10:00 AM, Matthew Wilcox wrote:
>> From: Matthew Wilcox <mawilcox@microsoft.com>
>>
>> The sbitmap and the percpu_ida perform essentially the same task,
>> allocating tags for commands.  Since the sbitmap is more used than
>> the percpu_ida, convert the percpu_ida users to the sbitmap API.
> 
> It should also be the same performance as percpu_ida in light use, and
> performs much better at > 50% utilization of the tag space. I think
> that's better justification than "more used than".

Had to search long and hard for the perf numbers I did for percpu_ida
on higher utilization, but here it is:

https://lkml.org/lkml/2014/4/22/553

-- 
Jens Axboe

