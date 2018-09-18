Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE72C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86FF4214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Gj1HoET7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86FF4214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729911AbeIRTyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 15:54:36 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34919 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbeIRTyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 15:54:36 -0400
Received: by mail-ed1-f66.google.com with SMTP id y20-v6so2094747edq.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 07:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=blEy1DivUz7GrGajYEkGm20ItTWwhUqnm0A8GVT/Y8c=;
        b=Gj1HoET7Sc7yCCYb+h3FkycM1rL7xApCr9HB7/78omuxrFzGEE1T5EROKzknHNwwEt
         Y0VPgsviR2tEuPfAJzi0jkZuFtx87nl+Qnb9RiIeOYDjRWdYW9kjcO5c1+rjNh3EdAUE
         JgtunXgZZUlKQ2Oh+ZQdvhYQD7Kn7PT8W7XHvEOGVlWVbuQdi1j2k27rTooj+AH8Nj9S
         mKtSLXVQzIIQW0AqYLXWJUu5ChvqMsRPQBXZevC4psr5+MiumEdOZ8WeGPjno49xjTsD
         3DTzxvX3WOQnWaY3F33bEXfgERqx2Ethoe2zpfPc2suSfMCEJDvw4gmHKlKGhUZ5s0jS
         jgEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=blEy1DivUz7GrGajYEkGm20ItTWwhUqnm0A8GVT/Y8c=;
        b=uew7XJsBgIbTu383z7K7FvItGFLQ78Idaht4yS7rPERtJQ72Lk3iA2v1MbxjMPN2X/
         +pqjmqiV++zAcaA9tMiKM3eWUz/aLCjvQ5uFLPGaOgwuJ1FuAcU/8rpwJ52cQz8nTd7U
         GVZNr0IjPpV0q2w3jZe4e39B75pKb9ZR02yrNwh+IjXLv3+oWUrNyLsWG9heAuYnOVtk
         KxqfGcGA3kdXbJXhITmNV9W1IA423Yjh8CHkcYGEEFzUtpgZwD0qm8vCfwVBYQMolXvh
         s750o46gIOxaR3nI2vCufZLxxtyyip0Yg1wTOnZ99VoSXB51kTCNN6XsXwNsaL1HkC+y
         wRWA==
X-Gm-Message-State: APzg51Dt6/NkhIgxAPdgaSAj+wJMWUyGxzD4rvyvGEqPyZ12j9E/LWbb
        gopfHQrxYODRvNtcasmXbl+83Q==
X-Google-Smtp-Source: ANB0VdZrkC6W4bnA3RGn77SmAR5z24GqNwFyfzgAAK1gY2ukCRbcvPshMI/K33ZE9Ih2RMzHPewaNA==
X-Received: by 2002:a50:93c5:: with SMTP id o63-v6mr51159220eda.154.1537280505956;
        Tue, 18 Sep 2018 07:21:45 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id g19-v6sm149466edh.22.2018.09.18.07.21.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 07:21:45 -0700 (PDT)
Message-ID: <1537280503.21380.8.camel@arista.com>
Subject: Re: [PATCHv5 6/7] tty/ldsem: Add lockdep asserts for ldisc_sem
From:   Dmitry Safonov <dima@arista.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Daniel Axtens <dja@axtens.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Neuling <mikey@neuling.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Nathan March <nathan@gt.net>,
        Pasi =?ISO-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>,
        Peter Hurley <peter@hurleysoftware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rong, Chen" <rong.a.chen@intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Jiri Slaby <jslaby@suse.com>
Date:   Tue, 18 Sep 2018 15:21:43 +0100
In-Reply-To: <20180918134954.GF23431@kroah.com>
References: <20180917235258.5719-1-dima@arista.com>
         <20180917235258.5719-7-dima@arista.com> <20180918134954.GF23431@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-09-18 at 15:49 +0200, Greg Kroah-Hartman wrote:
> On Tue, Sep 18, 2018 at 12:52:57AM +0100, Dmitry Safonov wrote:
> > Make sure under CONFIG_LOCKDEP that each change to line discipline
> > is done with held write semaphor.
> > Otherwise potential reader will have a good time dereferencing
> > incomplete/uninitialized ldisc.
> 
> Note, I don't see patch 5/7 here, did it get lost?  Please fix that
> up
> for the next resend of this series.

Oh yeah, sorry, I've screwed up the Cc tags for that patch:
https://lore.kernel.org/lkml/20180917235258.5719-6-dima@arista.com/

Will resend.

-- 
Thanks,
             Dmitry
