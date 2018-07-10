Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEADC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DC43208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UpHhklSm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DC43208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390186AbeGJSis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:38:48 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:32795 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389765AbeGJSir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:38:47 -0400
Received: by mail-oi0-f67.google.com with SMTP id c6-v6so44607620oiy.0;
        Tue, 10 Jul 2018 11:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WOWcUpbusD5bULjKVAZ9aEL4YhpKiM+cGrbxO6dVvBQ=;
        b=UpHhklSm5tqknxAqUzoVMfMGt5UZ5KN6MpMKXDj9ybDPCB+1CIWKBpM3RNIPNqwIRG
         3zvzRV+SncR2BZED3g/7fyhW6QkO9/wdAFdaIH2fHeF26jytatzVSjwikOCpmI4R4SUf
         lP66IEqeZvFs6Oga4xYzMRuhiQpG9YZix4qswL6Q71lXuf3n723xGGasJNPgUaKnnenT
         QVGL9g2P9skJjB6VgWMuZ6qWpCydL7l1rduoAAHzAJJHHUjas251GKYBEXJTEtzvHA6x
         B0CezrTYsrS7Pe486CYJRx/pIsoMZ44+EBznhW8I8VpgjBWEhUWx+aHCcx2ehhz7On/t
         rP0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WOWcUpbusD5bULjKVAZ9aEL4YhpKiM+cGrbxO6dVvBQ=;
        b=Lum3QP8T11RdHygqojEg2AgBeuqJB/vQ4nDWdNJOS8t8IO0QweQJ/xOKsDi/pJTi6r
         /eK7BmIa6Jp1s1hERPZwz/sVgFOIbGlZjMzJ0K2cRM7Wm/XigG2O5AvlMLjifwlHApvn
         f56v0pfl516jt5auvpPLMQZOhL4FWShwDOfSm8NTQzv0bDaU5r6dUN/gmTf7RD4nxDe0
         HA7xMq72lhlCNghNmFH5sSoQlIQFns7a7/WC1gJvD8sco31pUvd7R+2NLTv00rGLIZsU
         6RxuiMA9iSHgjAwsn2EXtefgAAXUXgGs9s/H99SGEb6Ka0EJAmFEWY9rmZ0XzSmJsct0
         Qo2Q==
X-Gm-Message-State: APt69E1YGBxw95/prhY6cZLE/+VCkYoFBL+sT90Dn88YFpU8W4C8Zs9S
        ml544JXBAexgtOy8z2LtjNJfYB8hQLw+WkEl4Cc=
X-Google-Smtp-Source: AAOMgpdFbnZUxIbtFtQH3g0se/A9o/wFzvKaNNiDrTiQ4Q+nEN5xLniWFWt6rwPDr6niStwc42k3vf0OBEh6WFOy/Vs=
X-Received: by 2002:aca:3407:: with SMTP id b7-v6mr28124753oia.345.1531247912801;
 Tue, 10 Jul 2018 11:38:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:9a35:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 11:38:32
 -0700 (PDT)
In-Reply-To: <CAKTKpr7wMiJL3NCHp-BkqNFPTDPAB7BxTvbvJagwYY97JCwqHQ@mail.gmail.com>
References: <20180621063338.20093-1-ganapatrao.kulkarni@cavium.com>
 <CAKTKpr5bNdo2oXb=Vsm4QytHN1Aw=n_oP7kJHV6yLHuKL-Udkg@mail.gmail.com> <CAKTKpr7wMiJL3NCHp-BkqNFPTDPAB7BxTvbvJagwYY97JCwqHQ@mail.gmail.com>
From:   Pranith Kumar <pranith.foss@gmail.com>
Date:   Tue, 10 Jul 2018 11:38:32 -0700
Message-ID: <CADYwmhGNtEbDBj8r-WMGfWJMWzkA_2Gc2hU8rsBYNs0OTuD+CA@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] Add ThunderX2 SoC Performance Monitoring Unit driver
To:     Ganapatrao Kulkarni <gklkml16@gmail.com>
Cc:     Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Will Deacon <Will.Deacon@arm.com>, jnair@caviumnetworks.com,
        Robert Richter <Robert.Richter@cavium.com>,
        Vadim.Lomovtsev@cavium.com, Jan.Glauber@cavium.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 4:56 AM, Ganapatrao Kulkarni <gklkml16@gmail.com> wrote:
> On Wed, Jul 4, 2018 at 3:44 PM, Ganapatrao Kulkarni <gklkml16@gmail.com> wrote:
>> Hi Mark,
>>
>> can you please review this patch?
>
> any comments on this patch series?
>

I had some comments on the second patch here:
https://www.spinics.net/lists/arm-kernel/msg664025.html

Thanks,
--
Pranith
