Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86892ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 22:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F7C62064D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 22:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fikSmEQa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F7C62064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388253AbeGWXUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 19:20:32 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40316 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388077AbeGWXUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 19:20:32 -0400
Received: by mail-wm0-f66.google.com with SMTP id z13-v6so577152wma.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 15:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4lzxdUzQjGT+2u99IpVWmcY6frX1xjf8jlPpXaH4TCk=;
        b=fikSmEQax0Oga927EzBB48WsjqQX5OGQefd/aj3SJumvJ3zmcSy6WoddxCIgIFuAjb
         Hw85848JskInQihPy9oJbWYiHmEIU78XH7eKAIwAtKw/1NI8dnkAH3MNKXFMQBLuiETF
         PH8KXBtJ7Fh4iSRytlRs4whl9sQeaC1BoEGXtcS+RNDBfymeQwWS+6s9kJT6wZlC1X7z
         HV682/rOZ3gzLTx56tDsEmlZ7vR6YnJPaEcte9rUx56qMHfdIS2oIuNt9gBYsyL450hp
         Q7TRii5TXaKTESwj2xQ2mBeyUE0KI70ihR1zSdcAz3erYOYFsbGwAs/zSJVE67l7K9Lt
         D6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4lzxdUzQjGT+2u99IpVWmcY6frX1xjf8jlPpXaH4TCk=;
        b=TzZW3/sgA6t8BKamMA5bjCI1olrCvvFbbGfvV+FGHFLEdtxzfXeCDWXNqsio9Tfx0P
         gQrd4vobYxPSe3t6VfoLwWuI3/OJ7vE2pf+EqkqW45iODQtcQhOkrMebSiTETw+jU7ZK
         RN7UWWvtWYzh9bx+m0w9foFHmyYpSplBUSYJ7yaK8e5pAfMFeg19q0vLUqPW5K+KesB3
         9TbX77+Hgje864Fc7cAXnrnHyTPOd6rUSFy4Hgsa/GhqbNRIPsQNqcik81UY2uvTm18z
         g43NsqgQeAtr9EKryA4rwsWIVE7HG54gPFltMrgCd6QPH4ctYAw5ki1YH5YyhGTkCTRQ
         J//Q==
X-Gm-Message-State: AOUpUlFKt6dp7TiASF7zEi6DmAV6jPfojILGXK5SIK7vi9vEG17Y+vg0
        gnbXSGzOfvgOkI8jyYtUoty0gcYTpMUzlUolfso=
X-Google-Smtp-Source: AAOMgpe4HclUbY7tVZJBeMDodSL5tjHy0RW3FjOaUbNZJXsUTeRenl/7K1+lkX8gW5uUId5flxVm6eshBsVoBaUTzVM=
X-Received: by 2002:a1c:e041:: with SMTP id x62-v6mr369454wmg.155.1532384232226;
 Mon, 23 Jul 2018 15:17:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:7507:0:0:0:0:0 with HTTP; Mon, 23 Jul 2018 15:17:11
 -0700 (PDT)
In-Reply-To: <87tvoppqwa.fsf@notabene.neil.brown.name>
References: <874lkmw54j.fsf@notabene.neil.brown.name> <61e255fa-ece4-5566-d63a-730aaa25f18c@gmail.com>
 <87sh85uzu3.fsf@notabene.neil.brown.name> <a3bb28f9-1185-3dbb-1a1f-1bfe03a8798c@gmail.com>
 <87efjnvpjl.fsf@notabene.neil.brown.name> <CAN8TOE9Pr2i4tXu8mGuY7xSY5bU_r7UhQ9SxfqYg_M4YDUt0ew@mail.gmail.com>
 <87tvoppqwa.fsf@notabene.neil.brown.name>
From:   Brian Norris <computersforpeace@gmail.com>
Date:   Mon, 23 Jul 2018 15:17:11 -0700
Message-ID: <CAN8TOE-+XpeQ0eLEW3YdAGGtuw5reeuJRZvnMb+QquJycJWLQA@mail.gmail.com>
Subject: Re: [PATCH] mtd: spi-nor: clear Extended Address Reg on switch to
 3-byte addressing.
To:     NeilBrown <neil@brown.name>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        David Woodhouse <dwmw2@infradead.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Mon, Jul 23, 2018 at 2:45 PM, NeilBrown <neil@brown.name> wrote:
> On Mon, Jul 23 2018, Brian Norris wrote:
>> On Mon, Apr 9, 2018 at 6:05 PM, NeilBrown <neil@brown.name> wrote:
>>> On Mon, Apr 09 2018, Marek Vasut wrote:
>>>> On 04/08/2018 11:56 PM, NeilBrown wrote:
>>>>> were added to Linux.  They appear to be designed to address a very
>>>>> similar situation to mine.  Unfortunately they aren't complete as the
>>>>> code to disable 4-byte addressing doesn't follow documented requirements
>>>>> (at least for winbond) and doesn't work as intended (at least in one
>>>>> case - mine). This code should either be fixed (e.g. with my patch), or removed.
>>
>> I would (and already did) vote for removal. The shutdown() hook just
>> papers over bugs and leads people to think that it is a good solution.
>> There's a reason we rejected such patches repeatedly in the past. This
>> one slipped through.
>
> Hi Brian,
>  thanks for your thoughts.
>  Could you just clarify what you see as the end-game.
>  Do you have an alternate approach which can provide reliability for the
>  various hardware which currently seems to need these patches?
>  Or do you propose that people with this hardware should suffer
>  a measurably lower level of reliability than they currently enjoy?

I'd suggest following the original thread, which I resurrected:

[PATCHv3 2/2] mtd: m25p80: restore the status of SPI flash when exiting
https://lkml.org/lkml/2018/7/23/1207
https://patchwork.ozlabs.org/patch/845022/

I suppose I could CC you on future replies...

My current summary: I'd prefer the hack be much more narrowly applied,
with a big warning, if we apply it at all. But if we don't merge
something to narrow the use of the hack, then yes, I'd prefer a
degraded experience for crappy products over today's status quo.

Brian
