Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B31CC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 19:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F145820834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 19:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Se32HkTJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F145820834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbeJZEbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 00:31:50 -0400
Received: from mail-lj1-f178.google.com ([209.85.208.178]:34717 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbeJZEbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 00:31:50 -0400
Received: by mail-lj1-f178.google.com with SMTP id c21-v6so3512767ljj.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 12:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aaKB1wdqehfUx/31EJMMpxGFKPnJ61f4bKzng+Laxe8=;
        b=Se32HkTJTXUqfQMZykD4psozzUDiW3HUuLrhdI8IOEShKKH4WmMI++Iil7PGqFxwPj
         Mo/GhRfqXOwPOzXIx7SzRACIdvhyVUSurlHI4pazGm7DZNHmZJNRAJZVDhjk5jRZdkAW
         4djMnEALHRP30ELy60gEkNXTFdEOdMM7ji5HE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aaKB1wdqehfUx/31EJMMpxGFKPnJ61f4bKzng+Laxe8=;
        b=KgbU5p3670u5xoPY2rOPP4KYfeyLrwZmoHWBgFkaNeJxluowMCFHI+AJQgbdzSnrRJ
         WnqHTart6ztYG0pGrtHvg36s5Gt/bn6BRCUm0SIPEi4A0SdWNMistEVA4NE1rnt6EhGH
         cUbrHREnHmXeM18aj80//E7Z2cZUh8b8Uu1+REhNyWPYcab51OVLSYXGUqMjjwps0CKw
         jMoBCivZpTeNmVOE+4+dvfW167xh2so6ob7Nucw5yvF0HNWA4G6yyu8aSsnToJVDUrlk
         gO84ZV8ZT/TXUh0s/n2b4e3c0XkRYOD/4Xhhbtj11yW1Ja4HcERLK5Vm5N+mUeO7HrOZ
         PGjw==
X-Gm-Message-State: AGRZ1gKZmlSwCIwZVi6kRXtNhxYkce4sRnsMSClBHGK4PCFtl5wXvPx3
        qoUbxDKLi9P8xzBbTVLp1vyHNe17LVPapA==
X-Google-Smtp-Source: AJdET5e0m+lV6pIE795H7LDgouyKIglRKIYqeG+5dR7OFNAWX2JtZ9da6CnH8ldwR6ZBmvjnotkI7Q==
X-Received: by 2002:a2e:908:: with SMTP id 8-v6mr378135ljj.1.1540497459889;
        Thu, 25 Oct 2018 12:57:39 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id f197-v6sm1411203lfe.49.2018.10.25.12.57.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 12:57:39 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id y22-v6so2765453lji.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 12:57:38 -0700 (PDT)
X-Received: by 2002:a2e:7f14:: with SMTP id a20-v6mr388062ljd.148.1540497458343;
 Thu, 25 Oct 2018 12:57:38 -0700 (PDT)
MIME-Version: 1.0
References: <20181025001857.GD32577@ZenIV.linux.org.uk>
In-Reply-To: <20181025001857.GD32577@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 Oct 2018 12:57:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiZNoi3q0sewCiX1LCUFhp33C+kOJEVY0b9o4wuHUJHAg@mail.gmail.com>
Message-ID: <CAHk-=wiZNoi3q0sewCiX1LCUFhp33C+kOJEVY0b9o4wuHUJHAg@mail.gmail.com>
Subject: Re: [git pull] more ->lookup() cleanups
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This (along with your alpha syscall cleanup and compat_ioctl cleanups) pulled,

              Linus
