Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FA2C04AB8
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 02:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 786CC20853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 02:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UDHMHQkZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 786CC20853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbeINHjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 03:39:01 -0400
Received: from mail-io1-f42.google.com ([209.85.166.42]:43571 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbeINHjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 03:39:00 -0400
Received: by mail-io1-f42.google.com with SMTP id y10-v6so4821241ioa.10;
        Thu, 13 Sep 2018 19:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m01j+zYdEcqFXGMBAO+X83VgqOg//XC4bSq/T18cbiI=;
        b=UDHMHQkZ8/sYjiqJJmvgmynpfmiPjpLSmBBh5lG2OyOtpMiVHC5WfL0M7pePUJj/Pf
         oRsP39ZPXVJCf8m7TmZJc3yTy6eJD3/FP7KlTk6ETAaVwI8IQT6p/IFTaCLyXIczeyvc
         o14Rfg/4gTO9cKoF2lC9+U3QpPCrV/onWr6PI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m01j+zYdEcqFXGMBAO+X83VgqOg//XC4bSq/T18cbiI=;
        b=nc/K0JuFoqyEFa8puq6YDNtZpzIxdZV/BaAa64zntN6NfN2PCDvQFxII3C4CdgoMHH
         yAhTKrG8m2o8LLTWt9w3AAz+UH7T0JJNfpB60prKo81uqxnVU8OvPphODz5D19wSdul7
         aTg114lrj5xCfwkM3m49oHqZKJHQ6WCFdL+zPj3qGHNmu83No7kQTDoT4RY6UFdUfbvM
         RKDN5WRZlwt3KWefUT6RcWMTRvp2X0Uo5DIjKW3TE3BHQplkKcaYnyj/IWrio5Rxd/N/
         vHNCV275XEVKw4mVRNEvw34plysbq9QtGKwL/B1/9v/GqCTeRL347i1I0oy5OwWfMq1V
         Jrgg==
X-Gm-Message-State: APzg51B4Fzh8XzYSSgDsQ6S+fQvc5ko9VRAqUySY4tZV1HU4bNx3dF70
        QyOH3FsJtE6VHNgqrMLqzdf1hnkETn4dUvxNDfY=
X-Google-Smtp-Source: ANB0VdbugZbrk2Pg+0zhVJyhoz2/uW8QAZSlAVDjRjzgZfngv0jycBptNQrLUYjHvd7dR81BBWWlQcs9bWmHTXH6/1s=
X-Received: by 2002:a6b:f815:: with SMTP id o21-v6mr9121241ioh.203.1536892009049;
 Thu, 13 Sep 2018 19:26:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180913140149.3c39485c@mschwideX1>
In-Reply-To: <20180913140149.3c39485c@mschwideX1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 13 Sep 2018 16:26:38 -1000
Message-ID: <CA+55aFxYR__1rfT--Vxkoh1RyA+g6pQs87H8tk7ajXW9L8p7tg@mail.gmail.com>
Subject: Re: [GIT PULL] s390 patches for 4.19 #3
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 2:02 AM Martin Schwidefsky
<schwidefsky@de.ibm.com> wrote:
>
> this is the first try to do a pull request for s390 with a signed tag.
> I keep my fingers crossed that the setup works as intended.
>
> I have used the 8A8FDAE0 signing sub-key of my 26AE5DD2 master key:

The signed tag looks ok, but you haven't actually pushed out your new
signing sub-key to the keyservers, so I can't actually verify it.

So a "gpg --send-key" would be a good idea.

              Linus
