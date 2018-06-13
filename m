Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=BODY_8BITS,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 978ACC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 22:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52F8C208D6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 22:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JM9WrosU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52F8C208D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935712AbeFMWur (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 18:50:47 -0400
Received: from mail-lf0-f51.google.com ([209.85.215.51]:44303 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754498AbeFMWup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 18:50:45 -0400
Received: by mail-lf0-f51.google.com with SMTP id 36-v6so6382082lfr.11;
        Wed, 13 Jun 2018 15:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-transfer-encoding:content-disposition
         :message-id;
        bh=E6ttKx0PIJfExdBV7orDAg5oh9lh0DpSg3XvcxB8rjY=;
        b=JM9WrosUF/p3zQ1FQ47AVxNQxXBiKEU/sWx8v8Q+X6+A2OS9/SLobjbMI4CJgFw0H5
         m3Vxy9Kt+uZQVPXiGeh3X49/nvxQWlWnADvCxfANPK5a7Qeu5ElmceZoTLS26j0ngzjT
         tFQCKU+qBqDmYzGLp4aBo9i6R1SPQfAFDYpMnZDmWZIt/1KFQICAnxbC9YAHSOp0zOp5
         egk4/VBhER6D8hPYowP5G00ubJHtv7TQN9BjJhcb845H8NWYblP46LrVHtUwK4aUkeHK
         z7QJrN/ckVqZorvy11eaYbAb164eik4m+7xf5VivrFseJi8WsEcjXXchL8JGxCxRUEGA
         lT8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-transfer-encoding
         :content-disposition:message-id;
        bh=E6ttKx0PIJfExdBV7orDAg5oh9lh0DpSg3XvcxB8rjY=;
        b=nO6mEqwsjk09Vh1tcd30lz2xn3UWkg3qi7JgJ8gQtBxb5GZNsv6Kob1r8MJDGVXZgo
         K0CW0JYDNPlxil1uL0aRBBJCncH4rwMvVYbKMxys0H6aEmS4y5Rz9lfnOT0wp5+S69lJ
         Of+Qc7+00OEwQ15Khr1KMyf3h1mypYJZ4SWhZcVm2CcuSoYShuaSefTBTnRTFYO42O3h
         IuI/JGlslXFZO5/oKAUj5hkqEoamdz4Sv4C6PwWOkPsdCpbTN/hvotpZm8m3mff2bYLq
         /4yKTKCMR2P9D6YhDKBRPQFyGGzLSkjTGaUfCLgpO3X55esexKSTP3hhKBHxoJlw/grb
         uB6A==
X-Gm-Message-State: APt69E21oNIq+cOfl8YdZvO1lF5XMvMVtPEIuO9nRnNCxxD2099NN7Ql
        53pq/dnHnwkXOJPMyMs1oGioHzqh
X-Google-Smtp-Source: ADUXVKL4XecJa57nKqqzHVityM/aJX8q9/ERKHc3zvpv2bXJ2HHsLZ7/fiU/bJ/7hKimU4pNbLPZ2w==
X-Received: by 2002:a19:1797:: with SMTP id 23-v6mr4425676lfx.95.1528930243966;
        Wed, 13 Jun 2018 15:50:43 -0700 (PDT)
Received: from [192.168.1.101] ([176.116.252.109])
        by smtp.gmail.com with ESMTPSA id g62-v6sm790736lfk.54.2018.06.13.15.50.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 15:50:43 -0700 (PDT)
From:   Andrew Randrianasulu <randrianasulu@gmail.com>
To:     Bart Van Assche <Bart.VanAssche@wdc.com>
Subject: Re: Fwd: Re: kernel BUG at drivers/scsi/scsi_error.c:197! - git 4.17.0-x64-08428-g7d3bf613e99a
Date:   Thu, 14 Jun 2018 01:33:51 +0300
User-Agent: KMail/1.9.10
Cc:     "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>
References: <201806130602.59441.randrianasulu@gmail.com> <3ab38d8d65c34d4109195f29bae61429f30b13aa.camel@wdc.com>
In-Reply-To: <3ab38d8d65c34d4109195f29bae61429f30b13aa.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <201806140133.52354.randrianasulu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=82 =
Wednesday 13 June 2018 16:05:07 Bart Van Assche =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=BB(=D0=B0):
> On Wed, 2018-06-13 at 06:02 +0300, Andrew Randrianasulu wrote:
> > after retesting with git up to
> > 4.17.0-x64-11701-g4597fcff0704-dirty
> >
> > BUG line is gone , yet s2ram still not working:
>
> Hello Andrew,
>
> Have you already verified whether s2ram works again after having applied
> Jianchao's patch?

yes, double-verified (I put my machine to sleep while I also was sleeping).=
=20
Still running ok.

>
> Thanks,
>
> Bart.


