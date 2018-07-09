Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66273C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2183220881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIAdlgHC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2183220881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933330AbeGIVez (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 17:34:55 -0400
Received: from mail-pl0-f45.google.com ([209.85.160.45]:46360 "EHLO
        mail-pl0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933060AbeGIVey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 17:34:54 -0400
Received: by mail-pl0-f45.google.com with SMTP id 30-v6so6601792pld.13;
        Mon, 09 Jul 2018 14:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=bcOtMZJUqptCPGlWoSIqioamV/s9oanGP5FH7uRk20w=;
        b=XIAdlgHC8JKs7RQ6KCe1IMxaNK/5bDsixnq1thF7jUEWyLn6FlAj8WdFU6p9oNz9se
         qyUBVpcQPxOhCYw37n6KHBaTOPpQuY8HbpTPCPRlYqYDY7sO0e8RO6YCpiJCE17CizR3
         qEUglPQN/TEPv5NTOZPDG6F1badOsf9M83gyUcuPIZ/QFNSS45ciwgJu7DSHxXNeGn/R
         iHO/jQn7XxWym1vf/nYiV0sKCymlwSW+2iaiYq/ACO5VIS5TN0MC0QRLc/KlfdM/tGhh
         yNFJ6mfzbGx0BuF1fGWFM1z4r02pcDwTB9sHolDHkracBtxSPQWKcmVN9kLa7K89jz1B
         FbOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=bcOtMZJUqptCPGlWoSIqioamV/s9oanGP5FH7uRk20w=;
        b=U0Sdo6pNagdQP3y30q75tpn47nCv4M/QH29zdbgBZs2sExbZN9Qc6ueb48B2G5LTko
         sa0ws7jRqVb1RJtsoSXiUWqCcDjbUgAuyCNGQaISkgIahaAnnH9+urTtx6Jd21QFJwbH
         jKz4hTBFH2Zlk7Z6VERT3Dy0o9YCXLDu0aVDVQnoiDDz4NEWaUGhVjolN/gHdJKxbWuG
         5K8xWiXAYs/0nSsP+gJhAhYQbFT7V4gzIaMoueiI+QRdFIEnvsnr8WRM+lKYqDP6Adhy
         69G0vdq1CeI+ctlMm+Ygjmp0EJ9QIc7ecVAXMunTqwmlanDp3l8Hur6O4IqPBwe7qBg8
         WTGg==
X-Gm-Message-State: APt69E1kIHE6EQLIrJ48Y3WitIvJk4TvdA3BfqEc2YHd/dLLxWj7ruFq
        WOntsrTBh2kDdAg7G9rQYKbUT8QhHq9stZJeXAQ=
X-Google-Smtp-Source: AAOMgpeCvjP7jMefu8Lnie1ZMlEaZc58fJ+cf89QqAyEN0otpJZ/3PmzRRa/dn0rVHkOXr19QgTlgCg3922YJbPXqW0=
X-Received: by 2002:a17:902:7e43:: with SMTP id a3-v6mr21885850pln.151.1531172093634;
 Mon, 09 Jul 2018 14:34:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:17c6:0:0:0:0 with HTTP; Mon, 9 Jul 2018 14:34:53
 -0700 (PDT)
In-Reply-To: <CAES_P+_k=fz3yMnVZni2hEnfSujctnT33zoN9-KsBLBeQaG_sA@mail.gmail.com>
References: <CAES_P+_k=fz3yMnVZni2hEnfSujctnT33zoN9-KsBLBeQaG_sA@mail.gmail.com>
From:   noman pouigt <variksla@gmail.com>
Date:   Mon, 9 Jul 2018 14:34:53 -0700
Message-ID: <CAES_P+_GTRcFya=N20+b+U=HOpv9gcpYkfJW_gU_i_2pH2hmMA@mail.gmail.com>
Subject: Re: devfreq relation with pm qos
To:     linux-pm@vger.kernel.org, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ dev freq maintainters.

On Mon, Jul 9, 2018 at 3:37 AM, noman pouigt <variksla@gmail.com> wrote:
> folks,
>
> I am trying to figure out the relationship between PM QOS
> with devfreq framework. I see this thread[1] where MyungJoo
> talks about QOS and devfreq but that control is through
> sysfs but I don't see any relation of pm qos (kernel/power/qos.c)
> with devfreq directly as devfreq is not calling any of the QOS
> api's. Is this intended?
>
> Isn't QOS value update using pm_qos_update_request has a
> direct relation with devfreq drivers i.e. setting the value to
> high or low selects the corresponding voltage and frequency
> setting in devfreq framework? I went through the devfreq
> drivers and couldn't find that relationship. Is this by design or
> I am missing something very obvious?
>
> [1] https://lwn.net/Articles/484161/
