Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26082C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 12:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0C85208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 12:02:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0C85208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbeH0Psl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 11:48:41 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:41083 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbeH0Psk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 11:48:40 -0400
Received: by mail-oi0-f53.google.com with SMTP id k12-v6so26730839oiw.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 05:02:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aQ1N6XwTc0jcSkbo53PijjZ3rYJKsRVQKWf6XE1Bn9E=;
        b=HBJxriD1NiE5TaXajqy0wo13wuJ25M5fP2NmLTCByE7S9bxqX7nBFiiewDg328/f/1
         zS1Laowrb24VMAuZzpenisPvfRwWqWJmhrrl+YrAjFw/R+Ba2aOX8nH1x/PRTjssjPYg
         9Oo3tfgVB4/2AsuE9COXJtcbdvCasr1F0fq20bES48ClCdUSP+SeHDblRQ1RfDWqOb9S
         3lkdy1vef8qiHoLScpFy/SFFCXQhaDY30n67p4VaHPA2CGbM0vJYAHqz/C0E0NKdJDtf
         d8kuMofKAIRucJYndzi/PwyaXkMH8Gj5Iy+8rNRPXALYiRy/0dLpUiHJJBwijdGTSGr9
         aJgw==
X-Gm-Message-State: APzg51DqgrHF+ONc7lTfLl+iK9qJfLtDaS0kMHKf4Qn++ZxLSlOGtcA2
        V3X8KmDwYVjWZPr0JIrlyAOVJ8Zu1BB9R4M7/gFLQg==
X-Google-Smtp-Source: ANB0VdarhYA6ATQlKYmqZqVEjkZP2EyoJKCMlmyEJlFmkO1VwV/ntsmGNT8avjqVF7eUsID8gGFdEFrCW7Ukzza+j4c=
X-Received: by 2002:aca:3bc2:: with SMTP id i185-v6mr12460569oia.156.1535371337482;
 Mon, 27 Aug 2018 05:02:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180824120001.20771-1-omosnace@redhat.com> <20180824120001.20771-3-omosnace@redhat.com>
 <20180824194703.h3mbuhrxzixmna4e@madcap2.tricolour.ca> <CAFqZXNvD_7psR+wM-GTXQ4bwK3w8=t7UnBidojB5XbmbE_K2oA@mail.gmail.com>
 <20180827114557.GN27091@localhost>
In-Reply-To: <20180827114557.GN27091@localhost>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 27 Aug 2018 14:02:06 +0200
Message-ID: <CAFqZXNuodMaEqD6psD375__abLVoe4-q6MrJjM8dT-c3ydcH6g@mail.gmail.com>
Subject: Re: [PATCH ghak10 v5 2/2] timekeeping/ntp: Audit clock/NTP params adjustments
To:     Miroslav Lichvar <mlichvar@redhat.com>
Cc:     Richard Guy Briggs <rgb@redhat.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 1:46 PM Miroslav Lichvar <mlichvar@redhat.com> wrote:
> On Mon, Aug 27, 2018 at 01:35:09PM +0200, Ondrej Mosnacek wrote:
> > On Fri, Aug 24, 2018 at 9:51 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > It appears this time_tai use of "constant" is different than
> > > time_constant, the former not mentioned by Miroslav Lichvar.  What is it
> > > and is it important to log for security?  It sounds like it is
> > > important.
>
> > The TAI offset is the offset of the clock from the International
> > Atomic Time, so basically the time zone offset. I suppose it can't
> > influence the audit timestamps, but changing timezones can still cause
> > all sorts of confusion throughout the system, so intuitively I would
> > say we should log it.
>
> It's not related to timezones. ADJ_TAI sets the offset of the system
> TAI clock (CLOCK_TAI) relative to the standard UTC clock
> (CLOCK_REALTIME). CLOCK_TAI is rarely used by applications. Setting
> the TAI offset effectively injects a whole-second offset to the TAI
> time.

Ah, I stand corrected then. In that case I think we don't actually
need to audit it, since it just changes how the time reported by the
CLOCK_TAI clock type will be different from CLOCK_REALTIME. Playing
with this value could cause some strange jumps in time for
applications that use it, but this seems like a very unlikely
situation. It really depends on how careful we want to be (vs. how
eagerly we want to reduce unimportant records), but this already looks
like logging it would be overdoing it...

Thanks for the correction, I really should RTFM more :)

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
