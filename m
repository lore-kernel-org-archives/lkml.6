Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094FFC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE05620844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rRmicLnC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE05620844
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405105AbeHATFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:05:43 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:51208 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405086AbeHATFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:05:41 -0400
Received: by mail-it0-f65.google.com with SMTP id e14-v6so10757020itf.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 10:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qOq4WvBmeZlY85xBt25SnCQUzD/nMxJn7FGpt0yo1Hg=;
        b=rRmicLnCJGJEUiX6v39D+iUQ9QJPnGd/SzYYkBYkqeY/OvpADhk/vYTq5xk64cMvcs
         g5YZG+N7oikaLh7i0ZxuT+eQGg67RqgtL+99lUybiZRguZvkvqvgMBWrrud/85+VOqvx
         PNenZrtqVJHE0NesUstQfV/VQA0QwOqe9t8xWMkIBKNbVgx1dyIGAUR8RofvRPAAY/Oq
         8n0r8gSTdhAVSfsFX7HRNmrnDkXAoYETvyb2tWgNCpMb7X5sOw2FiMGeieTkrRB79Rkh
         SOeCGmAGreOTm/E8HbQOl5Zaf4qoQKsxSLAJNoSDd2ATp5/Oi06J8BozExHBIpTnycg+
         Xbxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qOq4WvBmeZlY85xBt25SnCQUzD/nMxJn7FGpt0yo1Hg=;
        b=Fa507h75Njz05Qj3ym5qokFiSC2ldGLl8jOsVY4NtI5Z6kLJJWgrZJMVP3xkla7gch
         wIypYL4HNEpjRSGxgPfNu+5QAbZgVRvqWQ14hwys59rS3VsJ3a8bvOj6jQTaE4VT0bv/
         3mlT9oJB833Qddd84AwNeWMIOFKpiU8ZsM0mjV5Xrwa1GGcldEdKupS/3Ul121QSHr+r
         DfAdJ9J+GJQHmzr5ycaKYQzpXsXhUEY8SJ6IGbw1b7H3FVnMQP5T7GcBjptZjAzSKQ+q
         n7bY2q19428Z8qyf1iJTjjTmPCDE81qRMLG8hBCw8k29L/e0peORlOpGLJyrjQqIC24+
         y9Hg==
X-Gm-Message-State: AOUpUlFVma1/cbkGszeY7iOkRlg/UfNJCvr1Y6MXVY2hHWb4yydGPdXE
        tbMuowCdqjkgfkQj8PTX3u7hv/klUwtYReYYSdq3bA==
X-Google-Smtp-Source: AAOMgpd/Rlsj2INJ2Y3xelF8qiA9JmxstdN70WNXP5/tVnhi9+Z0d9K9Gdw7rR+TbA7e1Ph+j4DedMhe8ocLFrprEKg=
X-Received: by 2002:a24:6f0e:: with SMTP id x14-v6mr4272363itb.139.1533143940871;
 Wed, 01 Aug 2018 10:19:00 -0700 (PDT)
MIME-Version: 1.0
References: <e3b48104-3efb-1896-0d46-792419f49a75@virtuozzo.com>
 <01000164f169bc6b-c73a8353-d7d9-47ec-a782-90aadcb86bfb-000000@email.amazonses.com>
 <CA+55aFzHR1+YbDee6Cduo6YXHO9LKmLN1wP=MVzbP41nxUb5=g@mail.gmail.com>
 <CA+55aFzYLgyNp1jsqsvUOjwZdO_1Piqj=iB=rzDShjScdNtkbg@mail.gmail.com>
 <30ee6c72-dc90-275a-8e23-54221f393cb0@virtuozzo.com> <c03fd1ca-0169-4492-7d6f-2df7a91bff5e@gmail.com>
 <CACT4Y+bLbDunoz+0qB=atbQXJ9Gu3N6+UXPwNnqMbq5RyZu1mQ@mail.gmail.com>
 <cf751136-c459-853a-0210-abf16f54ad17@gmail.com> <CACT4Y+b6aCHMTQD21fSf2AMZoH5g8p-FuCVHviMLF00uFV+zGg@mail.gmail.com>
 <01000164f60f3f12-b1253c6e-ee57-49fc-aed8-0944ab4fd7a2-000000@email.amazonses.com>
 <CANn89i+KtwtLvSw1c=Ux8okKP+XyMxzYbuKhYb2qhYeMw=NTzg@mail.gmail.com>
 <01000164f64bd525-be13e04f-18a9-4f7f-a44b-0c0fcec33b71-000000@email.amazonses.com>
 <bf435a04-b689-ec5a-f5df-f47807b43316@gmail.com> <CACT4Y+akncPCAZ2pUX3xEpUPELQAei1XzYByB8Dohfz-Ve0k5w@mail.gmail.com>
In-Reply-To: <CACT4Y+akncPCAZ2pUX3xEpUPELQAei1XzYByB8Dohfz-Ve0k5w@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 1 Aug 2018 10:18:49 -0700
Message-ID: <CANn89iKSwt-1j_p3XvoMTv2NpjJsiv6p7c=xkYKG+zDzcS9hgQ@mail.gmail.com>
Subject: Re: SLAB_TYPESAFE_BY_RCU without constructors (was Re: [PATCH v4
 13/17] khwasan: add hooks implementation)
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>, jack@suse.com,
        linux-ext4@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        David Miller <davem@davemloft.net>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev <netdev@vger.kernel.org>,
        Gerrit Renker <gerrit@erg.abdn.ac.uk>, dccp@vger.kernel.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ursula Braun <ubraun@linux.ibm.com>,
        linux-s390@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 9:47 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> Proving with numbers is required for a claimed performance improvement
> at the cost of code degradation/increase. For a win-win change there
> is really nothing to prove.

You have to _prove_ it is a win-win.

It is not sufficient to claim it is a win-win.

Sorry, but I do have bugs to take care of.
