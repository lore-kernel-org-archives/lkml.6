Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536A5C6778F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB92E20880
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PazNeWvw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB92E20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388726AbeGXVI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 17:08:29 -0400
Received: from mail-lj1-f178.google.com ([209.85.208.178]:43343 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388699AbeGXVI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 17:08:29 -0400
Received: by mail-lj1-f178.google.com with SMTP id r13-v6so4675477ljg.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 13:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=afsmkqbzM0laTKBiD5uerJtPWgYnNA5ry00NwSH90a4=;
        b=PazNeWvwtxTu7j8H9dNTf5PIiaDZFNcSxw/VwrbqNie0QvONvhGxUbkjhNLlAutZaf
         al2lmz/QANCyWv0jeEijfAZ3qETduIrEnW0Y2kg18WuS7YM4l5KnFaxTFSyCGJnYof3c
         3oTmJXGk6iCuFxKXu5OGp+QQpHoXeinjXtD4wD+pZLPcuQBQSSpPlHmqp7m/ycgYNCSw
         bBvFuL9VDDc44sepKmrHkceRTQRMQ7ZDJNljuV5/KFknXs5djxCZ3+WKPCoZd7ptKE13
         gRWcS27YbhUX0Iyf1jaBmWf742KwQIdz6mhNThW6NfWZTwmGaAqLp/ShHXY9hmQM08sD
         aORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=afsmkqbzM0laTKBiD5uerJtPWgYnNA5ry00NwSH90a4=;
        b=ogwtCAd6XxH8oBfH+VgfndZb3NuafONEAuNWSQcgkXgWi2SMPe+xNyfTixLdiBa3xE
         2jEv62YHUKBmTIn8sBa0fk0zPNAMOPNNXOV23Ga5zoFE2SxpTfNKys0hkKtTcSQ1ZSck
         yjgcuANhjMbj9isdy++QzR2m1/Jxkv1g1BUSXE1aC9YWVzns+WH4sMeNeqzlqVm/VXP0
         IvABrn/edOD5Cdm0X+hd7XE/CWEnyzAto5RWpa+8iYP7iiFLVAiibdOBxpWf1G6m6X1e
         w4Ta/3+m6JR7TED6z+JWyMyXodCt6YOhZuON4fYbrz1VL24kDa671dSLWYoG2WIgyn+p
         Ti3Q==
X-Gm-Message-State: AOUpUlHUACljDC28Q8fRvnvc2NWCrehvwe1Q4DEsnbfTyp8A3WeRGP/l
        KYrVK/SwtwoNZqx21SP7+/sWBvBwQ+GQrp4f6/YCuA==
X-Google-Smtp-Source: AAOMgpfZziB4Z9g1ZlYqF6xucjrg/B5cNUFMvJRqZUpmYt2EiDV1lFrfrMgGfc/pTOOUiFUTqR21ekeopiuj+5sYH34=
X-Received: by 2002:a2e:82cc:: with SMTP id n12-v6mr1446191ljh.58.1532462423805;
 Tue, 24 Jul 2018 13:00:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180718001455.140575-1-rkir@google.com> <20180718001455.140575-3-rkir@google.com>
 <20180721074611.GC6484@kroah.com>
In-Reply-To: <20180721074611.GC6484@kroah.com>
From:   Roman Kiryanov <rkir@google.com>
Date:   Tue, 24 Jul 2018 13:00:12 -0700
Message-ID: <CAOGAQerbVvG64uguOQ0nxv0-BPSMQxm6FH9AGupNm62DXtzLHQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] tty: Mark goldfish_tty_line_count as const
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Then why not just make it a #define?

With "const" the diff is smaller.

> No need to waste the memory of a variable, right?

I believe the compiler will produce the same binary for const and for
#define if optimization is enabled.
