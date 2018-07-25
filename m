Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A969FC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5995520833
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="YGlQakAK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N3lno7Xk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5995520833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731798AbeGZAj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 20:39:58 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:34596 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731603AbeGZAj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 20:39:57 -0400
Received: by mail-ua0-f196.google.com with SMTP id r10-v6so6205849uao.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 16:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=66YPE/WuIOIkR1qo4wTLmMa0pCgKLWZEjeg75EMeYH4=;
        b=YGlQakAK31eKZLozBFGXWVJChVsJAN7L7Plju9sy8J/R2Q/Gqwoh4A4sWOrTq2UlC4
         Brqvre/lz/CgOjAjYjKIKXNwahDO78W93QzC7L2pPEDc0BZRGNMaq7D2+Na4txQNfKdu
         hL0tuBclaIH035WXvhiLHWLgRI+A2Xcj1GrMb8e9AvCsUVTFgZMDxVdBocxCSUQ7kuEr
         g7XMly08QZxJf1T3P9kuK+BqMB9plth3LaGwGoGVty3Cr9ziAhrI+mIygiY1ySrkT+cC
         rhoNSETWQOvPt8GVI+YiFfwUxiaP2OkL7hLbiros9aTNA84lhqthY0eY0hTCXAHPEeY9
         s58g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=66YPE/WuIOIkR1qo4wTLmMa0pCgKLWZEjeg75EMeYH4=;
        b=N3lno7XksRo4tP7bNvint6wQlM5SwfuxH8VwX84mIXjp79GX0/CVjqjVceICYnlCtx
         /ZebchsdH25a7fiWw5CVX/eQfebPGA18gGRY8r3H+FqifnPHfl1DxCWpbS0BQBt3/6BP
         4MxGMDZkPpWMznBaHS3O4ZsbZKBf9ZyoSy/rc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=66YPE/WuIOIkR1qo4wTLmMa0pCgKLWZEjeg75EMeYH4=;
        b=CQOxwHI0ulaoTmQzZWWCrkQjBmeBaOyLV6wndbcd+35kR/YzhOijYnGI5un1IFFI3k
         eNTxMj7DdAdA70/kFTBEj1VTlD+Ct4Ge1l+Rr9GftHCRNcZIHdF5sC9scaQqLa5Id2nP
         PSD65TslA+1Q0x/mo/ZsXhqoyiZH2Bo5vtwt9K0rpRY1jQgwXddlbKFN7M55KqJr19tx
         4MH53MwE3bNQEZ+4P1KtBF2QURvzd/BQmdWbHX7r3hAltssAUJw2jOSsOeBJybMjvSSf
         yFhTj7gx0H9n+BF8JEtXHD8e21hpmiLeiSTExpB6/do2Wma1ESpKmnnme8Nj9YMcezuO
         JSXw==
X-Gm-Message-State: AOUpUlHR1nqZh0cWuvZ8nuPqb7YmT2ulQSgP7dywiN9ezJkXygV/Q42I
        RvdAWSGj1NtZzANt6F9FImEKnm9qr87gejV/UfoaeQ==
X-Google-Smtp-Source: AAOMgpdQdMxMRf3jVuKsWwborjSDuuvc1z+pbNpof9pYlbBhW/QzdSoDUM44yJvAonY6GFegGwJGF96qUVMcFjOfwz8=
X-Received: by 2002:ab0:47e3:: with SMTP id w35-v6mr16245385uac.20.1532561159948;
 Wed, 25 Jul 2018 16:25:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:cd5:0:0:0:0:0 with HTTP; Wed, 25 Jul 2018 16:25:59 -0700 (PDT)
In-Reply-To: <20180724235636.60357-1-mka@chromium.org>
References: <20180724235636.60357-1-mka@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 25 Jul 2018 16:25:59 -0700
X-Google-Sender-Auth: _5rAeAejcFKJMLtdVqJ7NpON2Lk
Message-ID: <CAD=FV=UrbDtXnzvOimAmB8hn-ys3gbv6EHRqCdtbCpXKbFcoHQ@mail.gmail.com>
Subject: Re: [PATCH] thermal: qcom-spmi: Delete unused field 'prev_stage'
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 24, 2018 at 4:56 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> The field 'prev_stage' in struct qpnp_tm_chip is not used, remove it.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/thermal/qcom-spmi-temp-alarm.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
