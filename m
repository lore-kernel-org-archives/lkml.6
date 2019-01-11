Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101C8C43612
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5FB92177B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pc8kxKjr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbfAKJjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 04:39:09 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35494 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfAKJjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 04:39:08 -0500
Received: by mail-wm1-f66.google.com with SMTP id t200so1700615wmt.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 01:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0zsaqiFcpYXcCFsq+FAdMLlkTpsvPBWVOZxTGMUhgoM=;
        b=Pc8kxKjrXqxpNBROsHpISPINeN6qheusQQhAIklADat1GC2LXVcdnRTq5t9obDZ00V
         y/UZEhWPDF0j1+8vRi54ONhwN6AyabgK8iifakz/qrL7lFaxJwx6f3H5Ja9fVshsvxCh
         nwMlUnzI2NT3R0IR/0aGFnhDr3Hg+kvnVfCTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0zsaqiFcpYXcCFsq+FAdMLlkTpsvPBWVOZxTGMUhgoM=;
        b=Mgz4VoKno8Fm3iqhzMspH0jMsytx39sUlBFe6LIV/MQVe/P80WTrR58cNbu+oZdLNm
         aerwKvCrj36jspIpxsNHAqciCBcbrN+QvkXKEvhQ3g4l5mL7xw0yXBTSIv2cY7WaEHiH
         h3GGO+d4e2xvzYDp49qSccWxt3O73kkb673xh5joELa6TRP1htnveJvbglyNteVKHI57
         58sFJAUD+Q95rToian20MLqdfAxbKmB7xm3x+SQhHVMD21ZlULz0d3wMV5oJv/KLDWU6
         cPGD6uyP7j5Q7iowY/Gv57lkY2Dn+TM5/gUgMn8Oox3CtfFgKE7yL0NVDkJfBX45mPoj
         g+aQ==
X-Gm-Message-State: AJcUukcxAn62wRO+DOTJJHUHs98HQ8x4cFFsLen26nrPVA1gXhoPEwSq
        58hTOxy9SQfxfVAxQKW132adVQ==
X-Google-Smtp-Source: ALg8bN67P7vgoMl0PMJxpWcYivyBDHXNTowY5OD5ejJ409LH5XkyZ5FjRtxfFYUblCZ64cvSnHMsgw==
X-Received: by 2002:a1c:1a8a:: with SMTP id a132mr1595849wma.109.1547199545827;
        Fri, 11 Jan 2019 01:39:05 -0800 (PST)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id t5sm12963321wmg.43.2019.01.11.01.39.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 01:39:04 -0800 (PST)
Date:   Fri, 11 Jan 2019 09:39:02 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Jens Wiklander <jens.wiklander@linaro.org>, mpm@selenic.com,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Bhupesh Sharma <bhsharma@redhat.com>, tee-dev@lists.linaro.org
Subject: Re: [PATCH v2 2/4] tee: optee: add TEE bus device enumeration support
Message-ID: <20190111093902.hfxb67txjhhlegzu@holly.lan>
References: <1547123097-16431-1-git-send-email-sumit.garg@linaro.org>
 <1547123097-16431-3-git-send-email-sumit.garg@linaro.org>
 <20190110141856.p3evqyf34py74gkg@holly.lan>
 <CAFA6WYPHmtY4N9ruGLZ70FNeiDCbQE-fs+EP2px-S+GEj2nPTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYPHmtY4N9ruGLZ70FNeiDCbQE-fs+EP2px-S+GEj2nPTw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 12:52:19PM +0530, Sumit Garg wrote:
> On Thu, 10 Jan 2019 at 19:49, Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> > > +static int get_devices(struct tee_context *ctx, u32 session,
> > > +                    struct tee_shm *device_uuid, u32 *shm_size)
> >
> > Missing const on device_uuid?
> >
> 
> I don't think we should have a const for device_uuid here as this is
> shared memory struct pointer which is dynamically allocated and used
> to fetch device UUIDs.

Agree. Perhaps device_uuid is misnamed though (part of the reason I
misread this is that it is singular so I though it was a single UUID
travelling into the TZ).

> > > +     rc = get_devices(ctx, sess_arg.session, device_shm, &shm_size);
> > > +     if (rc < 0)
> > > +             goto out_shm;
> > > +
> > > +     device_uuid = tee_shm_get_va(device_shm, 0);
> > > +     if (IS_ERR(device_uuid)) {
> > > +             pr_err("tee_shm_get_va failed\n");
> > > +             rc = PTR_ERR(device_uuid);
> > > +             goto out_shm;
> > > +     }
> > > +
> > > +     while (idx < shm_size / sizeof(uuid_t)) {
> >
> > This is a very uncommon way to write a for loop ;-).
> >
> 
> Ok, will add "num_devices" variable.

num_devices might add readability but that is not what I meant.

The most idiomatic way to write somthing that loops for every valid index
value is:

	for (i=0; i < limit; i++)

You wrote it like this:

	int idx=0;

	/* lots of code between initializer and first use */

	while (idx < limit) {
		/* more code */
		idx++;
	}

Sure, they are equivalent but the idiomatic form is easier to read.


Daniel.
