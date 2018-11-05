Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D973C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F34602085B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Rt030h6/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F34602085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388202AbeKFHgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 02:36:46 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33621 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387768AbeKFHgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 02:36:46 -0500
Received: by mail-lf1-f65.google.com with SMTP id i26so7385967lfc.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 14:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iS9HcM7scadamVAkyGmxnkQhRhD2ci3kYLJ1wJh3zV4=;
        b=Rt030h6/y/mGymyVCvKnQiOzl9WMlaFRh7YniAVTPUg24ly9F5It7Wmn8wCdg/47nc
         JUIRTz2MzKp66QNpmeXFJwUgtojLJ4JRnWz6lM+kigI8L7jxtwiO7zlQkN8ZJ9yoibzV
         f+FBusGUiqgIZvysA0G+1T2bUCxpqUM8mQyu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iS9HcM7scadamVAkyGmxnkQhRhD2ci3kYLJ1wJh3zV4=;
        b=n4EYMlR5k+ff4G0o098fhTOlwnpUQwwEzopUPGG8a74TUxlbw9m6wJlu/RKrdZPVdn
         kGb8eRdKLYCyjMFoH2QZiNFeEs9Vr1EkU/y2W80828RHtPCRSo52wQnP47bGbW80pwO5
         6xOTOWjBNN012cC++zv7nbxE2SADAZu5wK9GY3x/BcC30saKvmgf5771mU/NqJTxSNf2
         ypI2qzelCgvR1uVRGAn3lDqaoG00TUg0jSvppgd4cs+hviDp5s7nlHL/FRE+X9xAbSB6
         zb6cCJGqyhntJnorLf11P83pupJLR1A6jN/j6jByWdrGwXFc7g7skME5703n46cJUWBl
         TxTw==
X-Gm-Message-State: AGRZ1gLYqrLNsGQKvtDpPgHnjbp8RCfHRLUsFYcTKoKDoUQIeuR4uyNg
        mQftUaK5KzmmxO9nnZhuhLJi83U68lOBkg==
X-Google-Smtp-Source: AJdET5fhJg1geO6e1sT8z2NkQgmZjo3faGK5YZqCya1sVOqYQuGfEH3+6kQP82kb96fb0mpbF6a8sA==
X-Received: by 2002:a19:4287:: with SMTP id p129mr14281927lfa.135.1541456092742;
        Mon, 05 Nov 2018 14:14:52 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id r69sm502541lfi.15.2018.11.05.14.14.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 14:14:50 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id t9-v6so6383925ljh.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 14:14:50 -0800 (PST)
X-Received: by 2002:a2e:9983:: with SMTP id w3-v6mr16710377lji.133.1541456089708;
 Mon, 05 Nov 2018 14:14:49 -0800 (PST)
MIME-Version: 1.0
References: <20181105050813.GP24195@shao2-debian> <CAHk-=wi8BNNTp+Xt4ROz1TqGgFT-c6-Hmmc9yW0B6p2FTFwJTg@mail.gmail.com>
 <f901e346-6203-371d-a39a-ed9231187570@suse.cz>
In-Reply-To: <f901e346-6203-371d-a39a-ed9231187570@suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 5 Nov 2018 14:14:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjZ1C2iL79jOuC9ysvX2oRpUjoqXirvY0NRuLC0eQ8nbg@mail.gmail.com>
Message-ID: <CAHk-=wjZ1C2iL79jOuC9ysvX2oRpUjoqXirvY0NRuLC0eQ8nbg@mail.gmail.com>
Subject: Re: [LKP] [mm] 9bc8039e71: will-it-scale.per_thread_ops -64.1% regression
To:     vbabka@suse.cz, Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>
Cc:     rong.a.chen@intel.com, yang.shi@linux.alibaba.com,
        kirill.shutemov@linux.intel.com, mhocko@kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        ldufour@linux.vnet.ibm.com, Colin King <colin.king@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lkp@01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 5, 2018 at 12:12 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> I didn't spot an obvious mistake in the patch itself, so it looks
> like some bad interaction between scheduler and the mmap downgrade?

I'm thinking it's RWSEM_SPIN_ON_OWNER that ends up being confused by
the downgrade.

It looks like the benchmark used to be basically CPU-bound, at about
800% CPU, and now it's somewhere in the 200% CPU region:

                  will-it-scale.time.percent_of_cpu_this_job_got

  800 +-+-------------------------------------------------------------------+
      |.+.+.+.+.+.+.+.  .+.+.+.+.+.+.+.+.+.+.+.+.+.+.+.+.+..+.+.+.+. .+.+.+.|
  700 +-+             +.                                            +       |
      |                                                                     |
  600 +-+                                                                   |
      |                                                                     |
  500 +-+                                                                   |
      |                                                                     |
  400 +-+                                                                   |
      |                                                                     |
  300 +-+                                                                   |
      |                                                                     |
  200 O-O O O O O                O                                          |
      |           O O O  O O O O   O O O O O O O O O O O                    |
  100 +-+-------------------------------------------------------------------+

which sounds like the downgrade really messes with the "spin waiting
for lock" logic.

I'm thinking it's the "wake up waiter" logic that has some bad
interaction with spinning, and breaks that whole optimization.

Adding Waiman and Davidlohr to the participants, because they seem to
be the obvious experts in this area.

                            Linus
