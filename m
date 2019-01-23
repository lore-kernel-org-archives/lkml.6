Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36DD8C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07D4C21726
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKWS827i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfAWQOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 11:14:02 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:34793 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfAWQOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 11:14:02 -0500
Received: by mail-it1-f194.google.com with SMTP id x124so257918itd.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 08:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zEZeJ9/dMg9wpQvp73WiD2fz9QbrhtcszzSnsQ11AG0=;
        b=gKWS827i8Tc+cDWombpQIdPMy1wZnQoksTJZyxFjk0PzF7WTD3EjKNQKsGM6jUJWdv
         loKUSeBd5R5TAjuR1xH+cBF/H+oILDXzUvil+ebCBJ4AjMKY/COijd4HN/f/Lge4M/XE
         30fyC7Ykohd3cWliWm7TrPVSfMVK+UsGdPl3vvYz35RsQFU8kTNFqTBiA8x5UXZJuwXc
         O59Zp9/VUQUrQZPcTD7Bav3T/a87WFKQwiIJ9Y1ClAeXS2GVoMcBn0UGOqMlfpbIaVOD
         sRqBLOocID4mC0K13YemdG1kvqysRnd6x3bqujFFPSxmsvLUlqXVjnM3ZjDS3Od9aS99
         sW0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zEZeJ9/dMg9wpQvp73WiD2fz9QbrhtcszzSnsQ11AG0=;
        b=unMQJWIZOsV1Oy0JGW6T/oqFajc7VJq5K+l3P1aEV8plrTCd01R1sFPjyqglx9WizX
         yryE1R0YWovaBkcF2F2ESmqbgYGPBsKZXrEj8GRv+NjQmXXgWi54SC3IAhyaeiJNlwAh
         e5Ni/XldGffPQcycudEDp96p2RB5rtSDM4T4F/8/7IhKLsujPg1vWsA6CFUVnAXmWDrK
         Gopq6H7BM1Oud3NRXuE+Gs2rgsiNsnXkhRhhiXEi6ugNpk7Mamx5WRXD7PIoNyY8pnFv
         99k/qjy2O5Sqvb49oLsQ3VVcO8o1o5rQUXCCexkpuYL9UwVgr/TLwGX/KZhldX2oDSsO
         ynUA==
X-Gm-Message-State: AJcUukcaiLWiPLwwUiBAzY0M+VuuSMr+eYd9QXcdvFHtoCJ1gxboAjW7
        vtegNUC36gDJgIh93RQTHAm0kj9DKcgrV//LQcU=
X-Google-Smtp-Source: ALg8bN4MZtdOAOEOAXGn3f87ZIAk8z659PnEOwPoVuQgT13fHLK7H1TQkAoC9JO/cF6Rt15z0tRl+h4HGjWcC574eFo=
X-Received: by 2002:a24:cb07:: with SMTP id u7mr1962232itg.118.1548260041618;
 Wed, 23 Jan 2019 08:14:01 -0800 (PST)
MIME-Version: 1.0
References: <20190120161039.GA2808@bhar.linux> <20190122103134.GA32578@kroah.com>
In-Reply-To: <20190122103134.GA32578@kroah.com>
From:   Bharath Veda <linux.bhar@gmail.com>
Date:   Wed, 23 Jan 2019 21:43:50 +0530
Message-ID: <CAMwgTV7Q-56u4EMgGxDUE-Sc-8T=+QmSa6wvkdsYSJsVm-Hw7w@mail.gmail.com>
Subject: Re: [PATCH] staging: netlogic: replace ---help--- with help in Kconfig
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 4:01 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sun, Jan 20, 2019 at 09:40:39PM +0530, Bharath Vedartham wrote:
> > This patch fixes the checkpatch.pl warning:
> >
> > WARNING: prefer 'help' over '---help---' for new help texts
> >
> > Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
> > ---
> >  drivers/staging/netlogic/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Any reason you sent this twice?
sorry bout that. Made a typo on the mailing list ids.
