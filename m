Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19868C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D08DE21B24
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="xmcCQWPv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393011AbfBNSZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 13:25:19 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:42519 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732475AbfBNSZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 13:25:19 -0500
Received: by mail-ot1-f42.google.com with SMTP id i5so12120066oto.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 10:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+LwC+e/wfz0phwsvG3UA7Kxyo8TmV6yoBd0ExF7DlW4=;
        b=xmcCQWPvi1tk0wx/+640HuxnyKNJnavefeN7OquFeviACdB+I3NqbWlo91L0PAtpu5
         dkfsZFDXpnac5GQj9mR2JyrCdE/nqvVjjuapSYOpnTfpXQR4W8KdcCMmxx1Pw1FW+GdK
         hAyEznua/qD92KaKxMW+Gctzoswj4JliVw0t2unJCsxP2hq0mko/o8H15ftbOrKjwHDz
         V9vBTsDewBKoMSXzSFz1CIGExWB5ziAQOqO/lz2VshL6FqIdKqyZiQtYSMx3/b58rAKr
         WGs3KpMu2COOGyiAlGnMEgIbtBpudxVMdesC5okQpMLayZvGJxjzt3MK2ngjUfCbF6Bk
         Tx9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+LwC+e/wfz0phwsvG3UA7Kxyo8TmV6yoBd0ExF7DlW4=;
        b=kt9zDY6LsLvzvJI3xsGzdcOR+sp+mMm+8/KqDHGcS7M7M2H4I7te1TtmFG1b27wkhi
         54Dl9CvTe5GZkB4ZSm8vebwjZGdM/v5hTBza5oIE1PJbkH5eYLxv6BpZ/83JPX2abO6k
         iNnp/ICjXX4BH7edgu8oL78lwk94VnPJ3kPuLufzj6LEPy5PjUZ+bv8ONg1iKceoycsN
         Ee0idKlBFo5vo+OBjwTFRvC+5rLAurEjW/AxOVdg991RoRVrPwZRqeFITR+0/3vuJ3QW
         IwuDWBeUSUnx93NqGMTjhgxcZVjTh6jgA1Z9ebF4NFahqnqechXcCgtnkH7S646ZCU+8
         v48g==
X-Gm-Message-State: AHQUAuZazrRRbI9+6VoUmGC8VTmrwOLz9zhBFAANB11iJsUgtQJvBGfp
        zRro1sl2srk8iLUqRYF9mhDLVzjyz5LVj9V1c5rmuoVd
X-Google-Smtp-Source: AHgI3IbnVCugpE3Z3TuIXgzzpIW2bhHG1b8KnucO+K5F+0eWFNyJPwJNhrQScGtCUaNp7Uq9wSjup/Hte5V+E7+tXnM=
X-Received: by 2002:a9d:4c85:: with SMTP id m5mr1976349otf.367.1550168718363;
 Thu, 14 Feb 2019 10:25:18 -0800 (PST)
MIME-Version: 1.0
References: <CAPcyv4jyCDJTpGZB6qVX7_FiaxJfDzWA1cw8dfPjHM2j3j3yqQ@mail.gmail.com>
 <20190214134622.GG4525@dhcp22.suse.cz>
In-Reply-To: <20190214134622.GG4525@dhcp22.suse.cz>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 14 Feb 2019 10:25:07 -0800
Message-ID: <CAPcyv4gxFKBQ9eVdn+pNEzBXRfw6Qwfmu21H2i5uj-PyFmRAGQ@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF/MM TOPIC] The end of the DAX experiment
To:     Michal Hocko <mhocko@kernel.org>
Cc:     lsf-pc@lists.linux-foundation.org,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 5:46 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Wed 06-02-19 13:12:59, Dan Williams wrote:
> [...]
> > * Userfaultfd for file-backed mappings and DAX
>
> I assume that other topics are meant to be FS track but this one is MM,
> right?

Yes, but I think it is the lowest priority of all the noted sub-topics
in this proposal. The DAX-reflink discussion, where a given
physical-page may need to be mapped into multiple inodes at different
offsets, might be more fruitful to have as a joint discussion with MM.
