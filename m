Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C027C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 17:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49C5F21473
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 17:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FfDkvOPG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49C5F21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbeHTVDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 17:03:34 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:52687 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbeHTVDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 17:03:33 -0400
Received: by mail-ua1-f74.google.com with SMTP id t22-v6so6282956uap.19
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 10:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1ovlQGkYHvOVXMYn2XNXpNdqox9/+NQ/7n5Lng2ePc8=;
        b=FfDkvOPG5NCAiCET8/hpfg3g2vDMJ4uWMJwvCNREJ0IhgylMxI7L9xkXYNFsjdpJvE
         yxtMvdC/KmT9pCUquy/zBZEzxjdiwoDuMXf6pPKiwGqkrM1QA7nrGYyBeX7rGU9kLG/9
         KprsXw7jXsnr3QsNX/5cUQQZy28PF4TJIEhbP5KoPoRJPgNWzMRt26+lhujj6wr72KRl
         dd4qBwSdV+BEVHy/KUgc+zsu7mX9aCkxioEM8BrVhhS1cXeWS8dZBe0ZZJL28PEmDjrB
         W1qpqv9mGxHezCDN9WYJNTtUtiLzIN2higHrXf0No5hNEvgw6NNl2ekmg3+YyiALdFIT
         ewOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1ovlQGkYHvOVXMYn2XNXpNdqox9/+NQ/7n5Lng2ePc8=;
        b=dqbQg1u3HwP6h+hpCCFhy5eLeIVfJlBK+NP2dycWmB9php2RF/P+co6knDv9ajaxko
         kUkDYYM+n8N5yR/zSxVdbtrYTdqnh42djKRYDJD9q1WgO/aPTTIf7cBDuW+FfyojrVEF
         g+DSbaYi1/1R7qG5hHG97Rju1ZxETVjGt3simhvwRXa42JXFNh9BwOdKS+dT+rpzzQPi
         Oj9rkMJZDdQmATQ3KDUAKWTrg9+bgOOO7ZDnrC/oFsvwwMAbAV9WyZuyoZzbfDniLWWA
         i9BQtYVJUZqny0Pd6hgEmCVGEX8/7BkuJ/UHUeaAPyOxzmEJ2YqgH8qVl5cj2htqUdGU
         ikyQ==
X-Gm-Message-State: APzg51B/wm0si5yaiH//d+QY7b2HJKtsPFNn3jV8eOPffg2ZOQeP4S4I
        PzelmumjqE0/litTfXbZ5V8HwWJwTRXy7ScPX+E=
X-Google-Smtp-Source: ANB0Vdb+w0o+hkOKwhWGRXgLHgaaYZa/ceUp1jJfXCDdG7yXZIDvuJSdR8MZQdAiXuOrrhySxY/eoFmSNAdJHngZ82s=
X-Received: by 2002:a1f:b907:: with SMTP id j7-v6mr1344458vkf.39.1534787218471;
 Mon, 20 Aug 2018 10:46:58 -0700 (PDT)
Date:   Mon, 20 Aug 2018 10:46:55 -0700
In-Reply-To: <4cdd4ab9ddd16f1fb168266643264595782fd890.camel@perches.com>
Message-Id: <20180820174655.75739-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <4cdd4ab9ddd16f1fb168266643264595782fd890.camel@perches.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: Re: Build failures with gcc 4.5 and older
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     joe@perches.com
Cc:     akpm@linux-foundation.org, dave.hansen@intel.com, efault@gmx.de,
        linux-kernel@vger.kernel.org, linux@roeck-us.net, riel@surriel.com,
        torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think we should take Joe's patch.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

(sorry for the lack of context, trying out the reply instructions from:
https://lore.kernel.org/lkml/4cdd4ab9ddd16f1fb168266643264595782fd890.camel@perches.com/)
