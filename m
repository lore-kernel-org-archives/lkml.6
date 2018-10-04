Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1735C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62BDE2083F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sakoman-com.20150623.gappssmtp.com header.i=@sakoman-com.20150623.gappssmtp.com header.b="G3vv4KhN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62BDE2083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakoman.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbeJEAIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 20:08:00 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:37446 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbeJEAIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 20:08:00 -0400
Received: by mail-vs1-f66.google.com with SMTP id w8-v6so5836470vsl.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 10:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8ieiuBeguKNomYRbg+TroN9QXV27FRBvJ4kuTRgpOUE=;
        b=G3vv4KhNNqrGNE3HTgDa6Me742lxBuGKBufaGubbhgIe5oxx7QN1oaF1sYSKJKgt4h
         6n0+XVLrSUGRuRnRz8ppoP0cpQUWy2LueCnoLuwv44ze5eNjJuqszxmNUdLe/hkxBoqR
         ihQ9bErMNU1E7nQNrzy+5QfUhNCWZ/hSVegyuLkckH7OVKZA2DNc999nHEpKzOv6fLO3
         neu2m3U0GsKdYM3B0sYC2U1YbaENgYdtcwWKX6umyFlEdi3/NrmmXiKTw5frm3QTHTUR
         KXOkE43PCiG1i3ANLh7DZCxzSEpJiot+FYl+hW42jt6z1JiNMoYfqZNZ/3cKIB0YyJrZ
         5DJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8ieiuBeguKNomYRbg+TroN9QXV27FRBvJ4kuTRgpOUE=;
        b=SdlqR3U6cuRoZc6VGEHitWVdShi1cMnPDLE4716FUREi8evI23gOBpRwiHWidoWgUC
         aF5ViKF2I/LSWlGWHkDNQKO3I48o25t00vNRTDZtUGFiLB5wI8IyyLE4coVaBUcJ2F3x
         qnlT+mCeE3GlBvHRsWyNuEMxGToDOhd8PYtRuT3eqSc4UkzICwLCUaKy553kPllOm6Nz
         K1vHgpnjtkMjSULIHd5YKoE5b3SlKzBf6O4Utsr+Mpajjo3ExlLyyn6wREbNhkTmGMPV
         VZV+7khwpotiwtOgDAmwYHZ2prYYX7juPvAu6NppOAG5JUFH6H78+Q8dqe6sjhUt/DNV
         QPkQ==
X-Gm-Message-State: ABuFfoixudL21dIHjEIkSJkw5PIMBqK8DwCD861OKxHnYtNbMQUx0l2h
        kJjHdDcIMbGBdDQOlicJV2gVqJ5H/U3u1veeM0e74g==
X-Google-Smtp-Source: ACcGV60iqCrbDTDyq4zL+/TjQ58B2lGWthwpDx7Z7hh7Og75HiU7x2qpKlTOWMBF6F9CfBvCXU8y/PbPd5KF8QtHp3Q=
X-Received: by 2002:a67:468a:: with SMTP id a10mr2916164vsg.202.1538673228680;
 Thu, 04 Oct 2018 10:13:48 -0700 (PDT)
MIME-Version: 1.0
References: <20181004151501.280d8282@canb.auug.org.au> <CAOSpxdYzm6fTd88gP_OdrTuqbf-kJr3t+3ObPU9vMCHqYJSgHg@mail.gmail.com>
 <20181004170032.GA7344@kroah.com>
In-Reply-To: <20181004170032.GA7344@kroah.com>
From:   Steve Sakoman <steve@sakoman.com>
Date:   Thu, 4 Oct 2018 07:13:37 -1000
Message-ID: <CAOSpxdaoiZxGiHm85LW-Wz+aF_tMDpcqJKgso+NL3OsoL-DDCg@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the tty tree
To:     Greg Kroah-Hartman <greg@kroah.com>
Cc:     sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andreas Steinmetz <ast@domdv.de>,
        Eric C Gallimore <egallimore@ucsd.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 4, 2018 at 7:00 AM Greg Kroah-Hartman <greg@kroah.com> wrote:

> We should just get rid of the "unused" fields entirely.  They aren't
> needed here as this is not a structure that anyone really cares about.
> We can move things around a bit if the padding is an issue.
>
> I've reverted this patch first for now.  I suggest a patch to the uart
> core to drop the unused fields and fix up the samsung driver and then
> your patch can go on top of that.  Can you work on this?

Yes I can. Stay tuned . . .

Steve
