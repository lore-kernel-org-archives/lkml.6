Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98189C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D77120661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="mNRBezty"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D77120661
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbeHaQT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 12:19:56 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41136 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbeHaQTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 12:19:55 -0400
Received: by mail-ed1-f67.google.com with SMTP id f38-v6so8880221edd.8
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 05:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rZ4uRNrM3UyRgQOQa1fX/4aOyR+O/loC76aR75w/PNo=;
        b=mNRBeztyVXXazYdcP2AALn012l/wqniUBjxaFrdape/GB1QNtoWce4HqHP0tBaSpbu
         uWnp/pcdrJEK9zagW5AQDz7Y6IURqodk7+FTvCaZ+ADn63lH40Urj6XGXkw35TVeMIlf
         LHWwi6DEgHnJTEW6/e4t+0Hlnea06wIOJH263qBep5MeApko1IGjhNOL3dHpiHkURTlH
         2axyC3Eu1Xd/L/CLL9keuMoOCX0EPSv1I2Q5QdKhvG9bv8VwyToXz5CPWLZ125s55sfL
         +R++2qnfxRJrcnmmeVRaS/jQdgM+AWrV/HeyFAsVFbcjXF5FmU356UvBzDA9fo/VsW4N
         9UGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rZ4uRNrM3UyRgQOQa1fX/4aOyR+O/loC76aR75w/PNo=;
        b=G+D+2g6oWV+IZZsFHg1bda9nwz6VWDyQ0gi4+PSkSR8MXt2JMjovhmP/8Xt6SiZcqR
         moPLxGq1xejH7RMr0FdagllLP3wJmA1z49nmogYOcTpyYIcjhdogb76kqxMrs2j0QxJN
         Yp6melCWfNgz9wsganrYOVWUOzoJ1LmDV8LwMl7fdgVsJLPB7TFVZA1WZDLt4ktDhNHP
         bX2x2ovInm5CXoVfa8DD1aWDvyhHHz/a1OrhNQDGtNc03DFNl59L+z/CYYW2kav1Dswo
         a//Yn5Sa8+IlYg4Te+5frErhSUDFIxKSvouT9DBmak5fbBeFTYNb5Fq/Cba4gK0C/xWU
         /oAg==
X-Gm-Message-State: APzg51CLaRJmyPOHVZTKrDIV00Fa18Rb6Tm56hfOe4BB1DMT4fKLvMEg
        yEKWb+QS63C8Te9RXQrJqpTOTw==
X-Google-Smtp-Source: ANB0Vda5FzQb2Ze/P/Hptpqa0TXDvaXg0C1AZMP44+7ytWO2xx0K7IT5cm8Dpn8odWyfIUbocKawNg==
X-Received: by 2002:a50:e249:: with SMTP id o9-v6mr17848377edl.253.1535717562770;
        Fri, 31 Aug 2018 05:12:42 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id a19-v6sm6405014edd.69.2018.08.31.05.12.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 05:12:41 -0700 (PDT)
Message-ID: <1535717560.23560.79.camel@arista.com>
Subject: Re: [PATCH 2/4] tty: Hold tty_ldisc_lock() during tty_reopen()
From:   Dmitry Safonov <dima@arista.com>
To:     Jiri Slaby <jslaby@suse.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Daniel Axtens <dja@axtens.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Neuling <mikey@neuling.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Pasi =?ISO-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>,
        Peter Hurley <peter@hurleysoftware.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Date:   Fri, 31 Aug 2018 13:12:40 +0100
In-Reply-To: <02638897-952c-c21e-ff7d-fc72e093b764@suse.com>
References: <20180829022353.23568-1-dima@arista.com>
         <20180829022353.23568-3-dima@arista.com>
         <0cb6bb7c-776b-28d6-65a6-f5b496e32344@I-love.SAKURA.ne.jp>
         <5b5fa362-f5cf-53ab-044b-0577856b872d@suse.com>
         <19bf55bc-eca4-672f-8ce7-b72329207074@i-love.sakura.ne.jp>
         <02638897-952c-c21e-ff7d-fc72e093b764@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-08-31 at 13:21 +0200, Jiri Slaby wrote:
> On 08/31/2018, 01:17 PM, Tetsuo Handa wrote:
> > Also, noisy messages like
> > 
> >   pts pts4033: tty_release: tty->count(10529) != (#fd's(7) +
> > #kopen's(0))
> > 
> > are gone.
> 
> fwiw, thanks to 1/4…
> 
> Dmitry, could you note the message above to the commit log of 1/4, so
> that we know the patch fixed that and downstream can pick it up...
> 

Sure, will do.

-- 
Thanks,
             Dmitry
