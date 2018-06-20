Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A6FC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 03:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78CBC20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 03:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AU0nDi0W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78CBC20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754216AbeFTDWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 23:22:16 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:43783 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753906AbeFTDWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 23:22:12 -0400
Received: by mail-lf0-f66.google.com with SMTP id x13-v6so2611740lff.10;
        Tue, 19 Jun 2018 20:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=tcu+z1f4pHczcg7/t/knjmTwDTJGzSqkdPt1gh6g/Zo=;
        b=AU0nDi0WRaoZ7il34wUVg+tgFr2aM0xYbEDzAlMcmovpYdk9Bh9GCv6E1sGfc9tbfN
         uV8uIVB29ffTaYu3Mr6KG9pVcAPIxt61pczJftDKbJlYmAGJC/FJQUlH+FLCXAOqDnZ4
         EV3zo8STQ6CbT60dW3DM6WUXbaRkftdq6c/LdV6sIgrDwl8W26vAY1ALeB7CZTNoXbrK
         c7XX00BG4cEji7uPbI62gMHkY42DzWovcXkF9h9KV9yTh9BN3+Bhrte/E6WES0CtqZdU
         YxYmP5z57PXNj4XUWkTK0U4pa/63uaE0CMyVXS+Gu0Mk2IV05/tYO3QQv+XC6dIJ6iXd
         cjBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=tcu+z1f4pHczcg7/t/knjmTwDTJGzSqkdPt1gh6g/Zo=;
        b=MrLPa1wpJFUHsV8aF4gnkXucOXzUc1BQO7myIrbDdeSyPEPBODVid+NTUtlYN0qRDj
         1tfT26OJcuHWJtqy+gOOyQTxKMWHvumGPtCeS+qHO7PfrxXkphdPR4vCqmf5WaHfPScL
         jzImD5ByrSYUcfuMSDrzPH8tT5b/8p94/U/YfN8C7TDQRbtbNSoMJtkcbqDspHAvgto7
         IXxBqPXwY1q+i7HwUFT2D+rtKQ2d7orwtzMf2yyTWS8L5MH5GeIOtVBunoSAMihyFCnH
         EwsuZW5KxaRIug1qnOuvw0+eiqefq+h0xPzlLtIPRSh0te4iEZf6Up1L21N0cxjwLsTO
         yW2w==
X-Gm-Message-State: APt69E3Yp/opZbG1PAkrztwI7LNkd0UIb7De2q0z6B2BcF33ZQP7nOSj
        IvXkSwCrFHQG90I1g7zfDUVxOhCrZapa0i4c+iE=
X-Google-Smtp-Source: ADUXVKJLNc3iij9kpyCBYkRblPym210iV++k9BVNs1HU03SsZw3pKE37nZdXc9fmK7D5EL4iTjK3tnK99fIwyeqzGAY=
X-Received: by 2002:a19:8fd4:: with SMTP id s81-v6mr198995lfk.118.1529464930813;
 Tue, 19 Jun 2018 20:22:10 -0700 (PDT)
MIME-Version: 1.0
References: <1528804105-24100-1-git-send-email-allen.lkml@gmail.com>
 <b40f794f-16b6-0369-cb0d-bbb5b12aa46a@suse.com> <20180619131041.6v3blgpegciu6fyi@twin.jikos.cz>
In-Reply-To: <20180619131041.6v3blgpegciu6fyi@twin.jikos.cz>
From:   Allen <allen.lkml@gmail.com>
Date:   Wed, 20 Jun 2018 08:51:59 +0530
Message-ID: <CAOMdWS+pc5EQ6DNKz3eF2U=N_omV6q5H6L6=sWLjEKXKA9D8iQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: stop using get_seconds()
To:     dsterba@suse.cz, nborisov@suse.com, linux-btrfs@vger.kernel.org,
        Chris Mason <clm@fb.com>, jbackik@fb.com, dsterba@suse.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > On 12.06.2018 14:48, Allen Pais wrote:
> > > The get_seconds() function is deprecated as it truncates
> > > the timestamp to 32 bits. Change to either ktime_get_seconds()
> > > or ktime_get_real_seconds()
> >
> > nit: In your patch you are only changing them to get-real-seconds. So
> > the "ktime_get_seconds() or" part of the changelog is unnecessary.
>
> Updated, and changed the subject line to "btrfs: replace get_seconds with
> new 64bit time API"

Thank you.
