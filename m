Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1CBC04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 10:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADFDE20868
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 10:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bB38LrVh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADFDE20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbeLAVnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 16:43:43 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:32978 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbeLAVnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 16:43:43 -0500
Received: by mail-wm1-f68.google.com with SMTP id r24so3362735wmh.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Dec 2018 02:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kW/3doh0w9clgq1w8hmnMUJtNpoG6UCeMWP2KiW5JuE=;
        b=bB38LrVhWrQFEOcTON8NMeDpOtYXuqKKQgSua/RSxIqGfto1rYQ7M4+quPWIlxpXfX
         YSOqrqosrGjhqu2uzagovi06GDX10JPbPDvAe4DbIHUaUIwxXyw8AIKcTMpqanpJWPjm
         Vwpuws8u6KruvjTtaF4d0mrHGohEmwjFnwQlN/JKwMwZedXm3MS4XvEMICbiO0di4aX7
         ABCKj1uuah12U8RQ6Vt0DC05sLZMVGD/5v1X+hs8p5TwF+fDtZy//f8UQfhxeKfjNNE2
         DyKtlUhqsYsOEkAE7PtZERU93rsaZCTkuBDkrmXRldFy6n+540DGKE2WIzu/2nSPg6UV
         ET7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kW/3doh0w9clgq1w8hmnMUJtNpoG6UCeMWP2KiW5JuE=;
        b=EeI1EXDKNcngFRSm6Ix5gdw2qZ0/BFgOga7LoxZUgVwCFBhT/JWkULLV8hMlDNeTqH
         81P0bYYRgIxdlpF+xlfHErMvAB8Nv7Oa0b6JgDPoAuKm+SJZHHZIU8vztKZ3Qy5LgulA
         Es+anC2Db4+xMEKtOwuwf3utKPgeCqmYGv1asM0XOYRF4LEYJjEoLh3fNoYRgm7uwh+y
         pjwM6kaCpJX7l42ezuaPveJytofEU/YlY5IydnD4Dj3guSuF7M07BhEkSWGerVsQKZzf
         Bbzl9D4DsT/1VxI45X+mxxZ4NRVR4+ux/x+rVC2pkcXBTaGeDOhZV7WXM4EuJbXkSOQg
         g7Dg==
X-Gm-Message-State: AA+aEWaju3hFHf3wDosYawRI+Wx+U3w+XpHB+YeyMDR6ggolBasT4F1g
        hgQI5Nq1mSzcgXiRK7W/Cc+GswQEGfnG+TAP24RVOw==
X-Google-Smtp-Source: AFSGD/VVvsoZH1g5FlLlIsKkVHjQSbkrPNxuYwJ961k5CDrqgbezktFAtwVM8dX6wz6ukmHx6Y36kmwlVwYZgdEhGAE=
X-Received: by 2002:a7b:ce8e:: with SMTP id q14mr1996649wmj.10.1543660289347;
 Sat, 01 Dec 2018 02:31:29 -0800 (PST)
MIME-Version: 1.0
References: <20181130192737.15053-1-jarkko.sakkinen@linux.intel.com> <20181130192737.15053-10-jarkko.sakkinen@linux.intel.com>
In-Reply-To: <20181130192737.15053-10-jarkko.sakkinen@linux.intel.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Sat, 1 Dec 2018 11:31:17 +0100
Message-ID: <CAFLxGvyqkvAs4gnbdJuo2PikX75uKs6mZue7hoc7521S9+38bw@mail.gmail.com>
Subject: Re: [PATCH RFC 09/15] mtd: replace **** with a hug
To:     jarkko.sakkinen@linux.intel.com
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        boris.brezillon@bootlin.com,
        "linux-mtd @ lists . infradead . org" <linux-mtd@lists.infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 8:28 PM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> In order to comply with the CoC, replace **** with a hug.

Please explain in detail why the CoC forces us to avoid this word.
Your patch seems more like self-censorship.

-- 
Thanks,
//richard
