Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8263C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FC6120846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S//+78CZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FC6120846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754059AbeFTK6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 06:58:13 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34370 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753569AbeFTK6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 06:58:09 -0400
Received: by mail-lf0-f68.google.com with SMTP id e13-v6so3984459lfc.1;
        Wed, 20 Jun 2018 03:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AnL2rBDG0B32FOsnj5mfCd6FMhcOf6Plf5cFzqjkakc=;
        b=S//+78CZTLs9Yh64fI/X2AUaYfl/oJ+AjZoaPVo7vm0oBkRCj45MJM0Sv2bMeJ/ilw
         gqDsUJUQ8BG7WesjWXUdzhaqT6tS5fK3nRTCub32RSX9TJa6xf4kZLjIhRj6EtKNTAGU
         mbwZIvfu+1FZX7Q4d1/BaYmeL/Jeq71vH4cgn4koX1/34LgZ8n5iM308ztMODmypm9xR
         doDbgnUcAdkMZ4KwT94JyXerJGSmuAuKj718c059CxiCGcSSdd9LVpBsxe+XimFmBDnO
         QQl3hdE6HqE7myQkCr0Bb8LRPo41TZxFu2rGDfYh9Fj5LCccZdeE6TYzjZk4AE7t1cFj
         crMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=AnL2rBDG0B32FOsnj5mfCd6FMhcOf6Plf5cFzqjkakc=;
        b=taZ2nLoJyRBGCSyeRWtTSabJhMahuzING/ttDDgYBvXgoG5zlM0xqvI78jcwVPvipD
         hnlTHuq8EHWs1pp2wbWFcz/BJePA0uhHKYV9bXHbi20gAwEOrKdHXly/iG6VFWeMiAUk
         qhsTFayA+4GixoQHSdqNcrvHhIpaPOUvDVkBItGGCZi8OBaMh6JE5SOJF+aFz83K92Mw
         6hZi95WlAv+/3vUeKR4dOOaAFA5pOm+9DIPQhMH2UHZKO/11wiX8QcQtsrR2ZHAl/omj
         LeTaqXCCOc134lJ5X40FfOFd21wblzoX5LTVc4CzQzlD4dlc7KNNap2BUgxsZz9/C8Kq
         L8bw==
X-Gm-Message-State: APt69E14xd4yCbIAPNwmw/n5GQwNfbtc7DZ9SPPmGGOTRtaRrPGiRmOZ
        P4nbB+Nw8sqfX9M1kiegVK0=
X-Google-Smtp-Source: ADUXVKIaHWWi6H2l5K84OYRgqi7hDkudrXSrnnzvM+VKicaH7lnsXHxr6Jh93eEPRP0TNnZSQwNttQ==
X-Received: by 2002:a2e:905a:: with SMTP id n26-v6mr13422618ljg.33.1529492287832;
        Wed, 20 Jun 2018 03:58:07 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id y89-v6sm347909lje.74.2018.06.20.03.58.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 03:58:07 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.90_1)
        (envelope-from <johan@kernel.org>)
        id 1fVanz-0003ix-Kt; Wed, 20 Jun 2018 12:57:39 +0200
Date:   Wed, 20 Jun 2018 12:57:39 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Karoly Pados <pados@pados.hu>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: cp210x: Improve baudrate support for CP2102N
Message-ID: <20180620105739.GR32411@localhost>
References: <20180620093905.GP32411@localhost>
 <20180619091528.GN32411@localhost>
 <20180615212957.26539-1-pados@pados.hu>
 <0b27c3da292fa1f4b360614685fe8aa4@pados.hu>
 <b82f656ba4c2c05d86ae7149be4109c6@pados.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b82f656ba4c2c05d86ae7149be4109c6@pados.hu>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 09:51:41AM +0000, Karoly Pados wrote:
> > By the way, have you tried setting other baudrates except the ones you
> > explicitly allow for here? According to the data sheet more rates should
> > be available, so perhaps just handling cp2102n as cp2108 (e.g. by not
> > trying to report back the exact rate used) or by actually calculating
> > the resulting rate could be another option?
> > 
> > Can be done later of course, just curious if you tried it.
> 
> Yeah I know, I was thinking about this too while developing the patch. 
> Officially the cp2102 and the cp2102n are fully software compatible (aside
> from baudrate aliasing), but if the cp2102n chooses different baudrates for 
> the same inputs than the older devices would then they couldn't/wouldn't be
> compatible. So I concluded it must also be doing the quantisation.

Yeah, that's probably right, but the older devices do not support
rates > 1 Mbaud so that logic does not necessarily apply there.

> Maybe I am too naive and trust the datasheet to much. I'll do some
> measurements with my scope and let you know the results.

Cool. We can keep the old behaviour for < 1Mbaud, but it would be nice
to know if you can generate rates other than the 4-5 +1Mbauds rates that
were explicitly mentioned in the data sheet.

Thanks,
Johan
