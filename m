Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A47ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77EC420854
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqxmGABr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77EC420854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730684AbeGRVCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 17:02:09 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34502 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729742AbeGRVCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 17:02:09 -0400
Received: by mail-wr1-f67.google.com with SMTP id c13-v6so5902234wrt.1;
        Wed, 18 Jul 2018 13:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=gQt6XCMG+saLSmoFZPV5sQiwJFTqff0BNTC7bL0hgZ0=;
        b=SqxmGABrANXnVqdb9QAB+mVkFYf6c/UIJI50hGE+Rvb0VzlzYXK27DBKfBUNWmKZbW
         /O+2QYGa941FXVoyzEntoUCdfFh5pT4KyqeBW04jaADdl/PTTiFVmLzaALXJ6OBv7Fd8
         /LYn6wvWFNQ1tzNMwNPViKVL6BBintiBWV01Mxmuv2JB1UOJKK/1YrL5gUq/aAo7PKcg
         fxznMFPiKFn3cK0TtqvrCIasw1QRzFWZQXDaPCzL+IYOjxle45HW6+gDQEuAIjZnNedy
         2Sh9agWVvssb99BmR2WiuZ1HO4JLQH4KOzZkgomgV7FFEUm02JmhN171B2ofDZiYATcB
         kooQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=gQt6XCMG+saLSmoFZPV5sQiwJFTqff0BNTC7bL0hgZ0=;
        b=mTlectL3YnT8sjhbRc34VUVhcJL/qpDmneYAQduIN67fHCPCiVd6nXs7z19gtSp+Z9
         iAayOpcLyjHbf9A2NuQJvvAIwUbwN+4yhH4XJ5kbyzU2Q7pl3cMU39CMJSfyKJ9mdtPX
         t7SlocZWyJzmltdl18SfOf0sUEzj+8gCx3WktTVJTrkw9k1bP53qsgDeZ6uqvJv772Zs
         ddpBCgIM6oD5gxPA6ND4J/Pr5Nlab4vHZdM0+1e+ocUmQesHOggEdAIZfsSWaOWJ9n14
         Lc5K19znzyjj2PLdsgdGW24I/0LFqCI5FwwmQ0/TCDIzqGhT5JYFbk31Te1c6iKe+D7O
         79Iw==
X-Gm-Message-State: AOUpUlGUCrvIWJo3oZEpzoCyRr2gP1R4sMf/RG908WNb/ok53aiUME2Z
        UIpLcG2HCVFcR1CtPkxOmumnFwAFfHpLub8Nfbk=
X-Google-Smtp-Source: AAOMgpeuUxQkvAJEQCAv4pwSwxXBD+oVlXhN0qJib3L+HovvtJKylkZ5B/D/z2iZK/B5yIZ7GWlNBUv/U6oegWGiiXg=
X-Received: by 2002:adf:9b11:: with SMTP id b17-v6mr5422889wrc.119.1531945356135;
 Wed, 18 Jul 2018 13:22:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9784:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 13:22:35
 -0700 (PDT)
In-Reply-To: <20180718173621.GC30706@thunk.org>
References: <20180718014344.1309-1-tytso@mit.edu> <20180718015154.GE3489@thunk.org>
 <CACXcFmk7D5t9yg9VxhKZgMvqK-LmFF0d7Dh9A3hsoGTfzzeM8A@mail.gmail.com> <20180718173621.GC30706@thunk.org>
From:   Sandy Harris <sandyinchina@gmail.com>
Date:   Wed, 18 Jul 2018 16:22:35 -0400
Message-ID: <CACXcFm=URq_UnqdeEUAV0i6DSkvhE8VZW0KYcgQ=7601q_5NnQ@mail.gmail.com>
Subject: Re: [PATCH] random: addu a config option to trust the CPU's hwrng
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Sandy Harris <sandyinchina@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Developers List <linux-kernel@vger.kernel.org>,
        labbott@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Y. Ts'o <tytso@mit.edu> wrote:

>  For those people who are super paranoid and want a "true
> random number generator" (and the meaning of that is hazy) because a
> CRNG is Not Enough, my recommendation these days is that they get
> something like an open hardware RNG solution, such as ChaosKey from
> Altus Metrum[1].
>
> [1] https://altusmetrum.org/ChaosKey/

Yes & one of those can also solve any difficulty with random(4) at
startup. Another alternative, perhaps easier on some systems, is
Denker's Turbid trng:
https://www.av8n.com/turbid/paper/turbid.htm
