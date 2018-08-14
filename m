Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA527C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 727FF2172B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sargun.me header.i=@sargun.me header.b="OAGgfGa9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 727FF2172B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sargun.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387588AbeHNTxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 15:53:48 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37357 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387566AbeHNTxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 15:53:48 -0400
Received: by mail-ed1-f68.google.com with SMTP id b10-v6so10503606eds.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 10:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mVpf3iBLV5E1SlBkuM9FBYCPNdtJHu5pIFhXuPrdFo4=;
        b=OAGgfGa9zcKb03inrNyhw/L8kRdC2cBpPEP8u7XlPjzb3V55FAVfMF/QbHMw3u5ATK
         nWAxk9Sv1V59J+F8uj3a9GqBHo5rucRLmrtmQVrlf4Hq5ykFk5LYYdAD3m5w/BmJ7A/A
         eCPYSqBUse/FKj8gK4wrBO1z/9fGNUhnNkPq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mVpf3iBLV5E1SlBkuM9FBYCPNdtJHu5pIFhXuPrdFo4=;
        b=Hiu0SY7soUi8QLO8CImi8kIb1TcgbHwjqhh+/qayj88vrFKrpViKyK4CasnBMjVJ/+
         x7ezzHzEmkUXXwMSCT0BXX/WHXCf4myu2PuN7n8xosDGN8+MW8InWRQlBxluSB9aEPr0
         MNlHa8ST7K/PpkGwt7oGnDuX5SuiD1CHykvWcEy44Up7RBnvuyZ+lYrEalOprMVD0u5z
         aJa5C4X9zpZze0GEsjRXiEonor3iIHmFR1k0TOnim26w3nLZlkFm7vw5bEeLYlFuJRbN
         2U8mIkN62hBnGpL90qLC1+CRPfQ07OUM/qHKv0D7AksqvKh69ApYBshpS8NzIapP3WLh
         wOYw==
X-Gm-Message-State: AOUpUlGZTtb6kDTTK/3vaeaSjVhqrrPdCFIxyLl1QDqOAvOB7WMwpufq
        N0Q8kRjT9sLlXMe0jPgl/ABWMyz9REXsAuCktORhgw==
X-Google-Smtp-Source: AA+uWPzE94bCMp19qk0PFV4dkCYTkf+YcXMZye1P2h4JSiChJrunVIlnImM1DA9BNvDTRcp+2rKUWsU8Su5qCZUsbHA=
X-Received: by 2002:a50:86a1:: with SMTP id r30-v6mr28843744eda.138.1534266347634;
 Tue, 14 Aug 2018 10:05:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:906:35d3:0:0:0:0 with HTTP; Tue, 14 Aug 2018 10:05:07
 -0700 (PDT)
In-Reply-To: <8a325db8-e7eb-9581-2b77-fc987a165df7@schaufler-ca.com>
References: <8a325db8-e7eb-9581-2b77-fc987a165df7@schaufler-ca.com>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Tue, 14 Aug 2018 10:05:07 -0700
Message-ID: <CAMp4zn94SzqK_Q=de2E+Fpv5yeAhYv62XW-KU3=ghRma9d7Jvw@mail.gmail.com>
Subject: Re: [PATCH v1 00/22] LSM: Full security module stacking
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        SE Linux <selinux@tycho.nsa.gov>,
        "SMACK-discuss@lists.01.org" <SMACK-discuss@lists.01.org>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        James Morris <jmorris@namei.org>,
        "Schaufler, Casey" <casey.schaufler@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 10:53 AM, Casey Schaufler
<casey@schaufler-ca.com> wrote:
> LSM: Full security module stacking
>
> I'm calling this v1 not because it's the first version
> I've put out but because it's the first version I'm getting
> serious external pressure to get upstream.
Awesome work, I'm glad that this is getting further.

>
> The blob management part (through "LSM: Sharing of security blobs")
> is ready for prime-time. These changes move the management of
> security blobs out of the security modules and into the security
> module infrastructure. With this change the proposed S.A.R.A,
> LandLock and PTAGS security modules could co-exist with any of
> the existing "major" security modules. The changes reduce some
> code duplication.
>
> Beyond the blob management there's a bit of clean-up.
> Mounting filesystems had to be changed so that options
> a security module doesn't recognize won't be considered
> a fatal error. The mount infrastructure is somewhat
> more complex than one might assume.
>

Casey,
Do you think you can break out 1 into its own patch? It seems like
that'd be valuable to everyone.


What's your thought here if we ever introduce dynamic security
modules? It's nice that we now have a way around rolling back blobs if
one fails, but what if a new module was activated, would we just
resize the slab cache?
