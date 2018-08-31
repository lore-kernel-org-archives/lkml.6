Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4035EC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 11:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDBE420839
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 11:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="DinZr9wc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDBE420839
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbeHaQCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 12:02:10 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44553 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbeHaQCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 12:02:10 -0400
Received: by mail-ed1-f67.google.com with SMTP id s10-v6so8824306edb.11
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 04:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eKbNuiRflFTOoI075dTWihwFLTBIB+AUDOUAZ3tZLcQ=;
        b=DinZr9wcTy1Ezmdldomlv7NIWc/UmBDqC3RKYLlH+0iJeppEXo+3JlDisFiwdMEleg
         NRDS4cltr5prCSPqfe+SR4ppP7wlRKHFdKyK+8yjWitRuKdUUOEwPrzXGGmK/qrMCMbr
         HDWxJoupJSJbWUR/xkoCcc0DnoUky5vrTlH7gPaqRWdZ/b8Qd0c429k73W4p4J9TtKe9
         q+jxEm5B7Bo/J3mV2SMKWJDL7gKcVAUr5/sWnJqA0twxm+sWYPGGbE4ZmRljMhRrZtmS
         4EE5jEcAUhsYFjSN8H/EVxtE7otzdEIWWCNoK11spDNjK6fCGx+KVGNjvXAsNldHOLJX
         pZ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eKbNuiRflFTOoI075dTWihwFLTBIB+AUDOUAZ3tZLcQ=;
        b=GpZfSWICdlcXpiuNUSWLJjhQjF+Qu01j0T4dOSn3xCqD/WHyVaEOQrRdebtotCQklr
         KyotPy7BchPBEjaJwUbgIWFUQ7N8i3J48xPA/56CwJMr05f0gN0RO/zG8Ev05jzKZ3CT
         FrsgDF4vIPIGf7A2cXRxLbfIInu09RiPJ6LyPTq4HLmi7EElPnms6A3BhP1f6xj4FpFP
         12Q0sFjeOL88nrlZr1/34xBUi/J1INGTuWzbUo/v4V8ZMCBsNGZsgy0gUB9oF6Fvm3N2
         dLHNIyggsSntG3B1mYMwvf9If76QECbsW/ldfC6CrRTSSB8EaDUnKp5z7WNJR4QunAJR
         ZtGw==
X-Gm-Message-State: APzg51Df+uXcCGo0csQ2s1vAM+ADk2b0Su0N+7aa0RBJdUXRTVKtvFyL
        ZDi4mMTFL1sKBM1bwExs5J/AxA==
X-Google-Smtp-Source: ANB0VdZfRM18ygUFRa2y4OX4/dNqoFxq3DLMOaNLgNISZzPLeisCc7c6TVnga8UA1RTFRn2aRb95Sg==
X-Received: by 2002:a50:95dd:: with SMTP id x29-v6mr17819920eda.3.1535716501426;
        Fri, 31 Aug 2018 04:55:01 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id w41-v6sm4332832edd.92.2018.08.31.04.54.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 04:55:00 -0700 (PDT)
Message-ID: <1535716498.23560.78.camel@arista.com>
Subject: Re: [PATCH 1/4] tty: Drop tty->count on tty_reopen() failure
From:   Dmitry Safonov <dima@arista.com>
To:     Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org
Cc:     Daniel Axtens <dja@axtens.net>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Peter Hurley <peter@hurleysoftware.com>,
        Pasi =?ISO-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Neuling <mikey@neuling.org>,
        Mikulas Patocka <mpatocka@redhat.com>, stable@vger.kernel.org
Date:   Fri, 31 Aug 2018 12:54:58 +0100
In-Reply-To: <b6481bae-a5bd-139f-d193-198a02d24bd8@suse.cz>
References: <20180829022353.23568-1-dima@arista.com>
         <20180829022353.23568-2-dima@arista.com>
         <cbedde00-a0f4-6714-f7f4-a180dca15ce0@suse.cz>
         <1535559207.23560.55.camel@arista.com>
         <b6481bae-a5bd-139f-d193-198a02d24bd8@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-08-31 at 08:47 +0200, Jiri Slaby wrote:
> On 08/29/2018, 06:13 PM, Dmitry Safonov wrote:
> > > I would just do:
> > >   if (!retval)
> > >     tty->count++;
> > > here. Nobody from ldiscs should rely on tty->count.
> > 
> > I thought about that and probably should have described in commit
> > message why I haven't done that: I prefer to keep it as was as I
> > did Cc
> > stable tree - to keep the chance of regression to minimum.
> > 
> > I agree that your way is cleaner, but probably it may be done as
> > cleanup on top for linux-next..
> 
> Agreed, so care to cook it up as 5/4 in this series :)?

Sure, will resend v2 with that and all tested-by.

-- 
Thanks,
             Dmitry
