Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5999BC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 13:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F142064E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 13:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="jfwprwTb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04F142064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbeJVVVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 17:21:21 -0400
Received: from mta-p3.oit.umn.edu ([134.84.196.203]:53440 "EHLO
        mta-p3.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbeJVVVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 17:21:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by mta-p3.oit.umn.edu (Postfix) with ESMTP id A23CC644
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 13:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=umn.edu; h=
        content-type:content-type:subject:subject:message-id:date:date
        :from:from:in-reply-to:references:mime-version:received:received
        :received; s=20160920; t=1540213370; x=1542027771; bh=DWAEIcheN3
        rq0e/58ySpgwnvyP2sMDGJRgJc97oMJc4=; b=jfwprwTb6F5aXgqmgJSVU7z1UD
        KQaGaTgmyeEHXnkKTdvjaaU156k0gsxYsWZv6FGimU7PK6pOm/dm0fg9xayxJSW/
        vYOgq160HRrQmC1eOG2YcYwO4TVCbZRc+YQy44kqJ4Z0PWS5EztB3+l59aQ/30zi
        KxDMMKIv5XIOpAu+s99Aqgsf2ytEf0gSHNa/ji2I8phu5xAfJvbwxLWP6FQHhAOw
        bWFnX3fSvOh65XhOueo291x+x8PkU4oJDIHO82tJaD1ll6JJjQVENpiM+HRwcf6D
        HL4ijJ83bHHohILY196FhClO+CbSQQMJyUZlqqLINF6wnmnA5gv8p0r9hlzw==
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p3.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p3.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4ZJK30G6sHl8 for <linux-kernel@vger.kernel.org>;
        Mon, 22 Oct 2018 08:02:50 -0500 (CDT)
Received: from mail-it1-f173.google.com (mail-it1-f173.google.com [209.85.166.173])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wang6495)
        by mta-p3.oit.umn.edu (Postfix) with ESMTPSA id 789795F5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 08:02:50 -0500 (CDT)
Received: by mail-it1-f173.google.com with SMTP id c23-v6so11704736itd.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 06:02:50 -0700 (PDT)
X-Gm-Message-State: ABuFfojsjE+6eACboM5PwdB65Rf1XUagcLHhf+H07BqlcF2TzJb0TV7Y
        Zv+DV/CMj5arEHo8oqeAT40RycTyk72M7TtvOOY=
X-Google-Smtp-Source: ACcGV62q0KjlyIiuUYrzsTkvDA3hAqlTQ3E+3xIlXmnL+TxTn29GEiOdIiUPuAtHa0e8usBaWWGHmWNpxJmumW/E93E=
X-Received: by 2002:a02:98d3:: with SMTP id c19-v6mr1501157jak.47.1540213370165;
 Mon, 22 Oct 2018 06:02:50 -0700 (PDT)
MIME-Version: 1.0
References: <1540058151-17116-1-git-send-email-wang6495@umn.edu> <20181022080449.GK2302@lahna.fi.intel.com>
In-Reply-To: <20181022080449.GK2302@lahna.fi.intel.com>
From:   Wenwen Wang <wang6495@umn.edu>
Date:   Mon, 22 Oct 2018 08:02:14 -0500
X-Gmail-Original-Message-ID: <CAAa=b7d9tV17gOa-kGR6soKHqF4UvZdBrFmV2ga4e=ra6xDrNg@mail.gmail.com>
Message-ID: <CAAa=b7d9tV17gOa-kGR6soKHqF4UvZdBrFmV2ga4e=ra6xDrNg@mail.gmail.com>
Subject: Re: [PATCH] thunderbolt: Fix a missing-check bug
To:     mika.westerberg@linux.intel.com
Cc:     Kangjie Lu <kjlu@umn.edu>,
        Andreas Noever <andreas.noever@gmail.com>,
        michael.jamet@intel.com, Yehezkel Bernat <YehezkelShB@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Wenwen Wang <wang6495@umn.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 3:04 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi,
>
> On Sat, Oct 20, 2018 at 12:55:51PM -0500, Wenwen Wang wrote:
> > In tb_ctl_rx_callback(), the checksum of the received control packet is
> > calculated on 'pkg->buffer' through tb_crc() and saved to 'crc32', Then,
> > 'crc32' is compared with the received checksum to confirm the integrity of
> > the received packet. If the checksum does not match, the packet will be
> > dropped. In the following execution, 'pkg->buffer' will be copied through
> > req->copy() and processed if there is an active request and the packet is
> > what is expected.
> >
> > The problem here is that the above checking process is performed directly
> > on the buffer 'pkg->buffer', which is actually a DMA region. Given that the
> > DMA region can also be accessed directly by a device at any time, it is
> > possible that a malicious device controlled by an attacker can race to
> > modify the content in 'pkg->buffer' after the checksum checking but before
> > req->copy(). By doing so, the attacker can inject malicious data, which can
> > cause undefined behavior of the kernel and introduce potential security
> > risk.
> >
> > This patch allocates a new buffer 'buf' to hold the data in 'pkg->buffer'.
> > By performing the checking and copying on 'buf', rather than 'pkg->buffer',
> > the above issue can be avoided.
>
> Here same comment applies than to the previous one - this is something
> that requires the attacker to have physical access to the system and
> requires him to either replace the firmware or the hardware itself with
> a malicious one and in that case protection like this here does not
> actually help because they can just overwrite it directly.
>
> BTW, just in case you send multiple patches to other subsystems as well
> it is good to have $subject contain summary of the fix in a way that one
> can distinguish between them. For example you sent 4 patches with all
> having:
>
>   thunderbolt: Fix a missing-check bug
>
> in the $subject. So for example I originally thought that you sent the
> same patch several times :)

Thanks for your suggestion, Mika. That is good to distinguish between
different patches :)

Wenwen
