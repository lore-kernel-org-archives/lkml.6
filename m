Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FADC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D31DD2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ODiLHj2Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387580AbeLQPLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:11:33 -0500
Received: from mail-io1-f49.google.com ([209.85.166.49]:39128 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbeLQPLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:11:33 -0500
Received: by mail-io1-f49.google.com with SMTP id k7so10210375iob.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 07:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oWSs3EIV2Wr0L4oOI6D2uYhifXZ4Zx3xwRrNb6Et7B4=;
        b=ODiLHj2QzaPuA7ppW8y7ehMafRZjhCJO3cvp+hqCXN46fFm0pvts9RnyODfO1rlsEE
         QjE5ycMsMD4k3Maj5BtWnAkphU3vHc1dkiFy7yq7h1U1o0dgQpj99477AFS5v3RzdXv3
         jJtSrDVer6uRqFgfs5MnZ4m4XChx03XjYG4R0/nOF2d15nmJ1zFl+nMQuHnJTxqT9Bfz
         w9eQp1d+WReQlvIdjO8CdF7eRlzgPqz9Go4g6jAaTO1Lobj9s65EkW60zoVCzUJcZVRJ
         ccTB0Vg5d1WA7DoYC3jtsrvjKjWS2FfOGjMocSUCEFN6Vo3+MUyJeeBLGPOiKrHtD3PD
         eP6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oWSs3EIV2Wr0L4oOI6D2uYhifXZ4Zx3xwRrNb6Et7B4=;
        b=BWZzHzhWXIgw/pt5dOQ15y0deicINdnhVGGBn1N9pplKhxtxpjyBu0cXlPvjjXp8Y9
         cZBcXREvVr1BWkRU0mLSJjq6oyBlW76vSoSYVnfXaUl/+DzqzPIUUl3FL0HopQzQEBQ4
         jzaqJ0LyrIzCZTPuZmcHTh5sptOdLqyCMenLfnZKtwJsIGu01yG6JQoTkYC+mTnPUKwX
         ZPfulp/zI45yqgMMOV+uA8hf6AJGsPcdZWnBVxFw3NByruqWSkDb3QVx8Z2CIdFOn0+m
         9pXXPsQWCAd5OrfAcZCm4oNL9Lw6qmpPIpjVdQZt0y1taNq6obEbnNsQTBXXizBwVeSa
         p24A==
X-Gm-Message-State: AA+aEWb19ueE5t5ZvCjQa9zj3ZWWrlqLkBpozeqtgEAY8skzfaRcz4aP
        uRe4iKACQOBMXPhYPRS4xhJFq93nyq43QlgInlpahQ==
X-Google-Smtp-Source: AFSGD/Vh7nRqHJJHTo9sQrv9Uvtscaa44zMatRePZ74IV7fBVIW6aUE0vmTk+ohuEP5hd2z0CsbziaLhk3Qjodbx5No=
X-Received: by 2002:a5d:8491:: with SMTP id t17mr11310127iom.11.1545059492175;
 Mon, 17 Dec 2018 07:11:32 -0800 (PST)
MIME-Version: 1.0
References: <0000000000005e47a2057d0edc49@google.com> <20181216190412.GE4170@linux.ibm.com>
 <CACT4Y+b+mSs2FV3BY+MsHDTPPgvPaCdMmJONd9c4zEU67CdmOA@mail.gmail.com>
 <20181217112916.GG4170@linux.ibm.com> <1583d5fc-34bf-3a81-363d-01a1085a7363@linux.intel.com>
 <CACT4Y+aKn4XsGVgt3ELGnnJcg6H-m+dSdV018dLvJhrpshycWA@mail.gmail.com>
 <20641819-e4fb-f3bd-34c8-c68106cccd0e@gmail.com> <20181217155958.2e9c4b24@redhat.com>
In-Reply-To: <20181217155958.2e9c4b24@redhat.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 17 Dec 2018 16:11:20 +0100
Message-ID: <CACT4Y+YzM-ud3JkAM9w7K3B9iuZXo0xg_Caujh33fjUy6cfu1A@mail.gmail.com>
Subject: Re: WARNING in __rcu_read_unlock
To:     Stefano Brivio <sbrivio@redhat.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        syzbot <syzbot+43f6755d1c2e62743468@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 4:00 PM Stefano Brivio <sbrivio@redhat.com> wrote:
>
> On Mon, 17 Dec 2018 06:57:35 -0800
> Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
> > Might be cause by commit b8a51b38e4d4dec3e379d52c0fe1a66827f7cf1e
> > fou, fou6: ICMP error handlers for FoU and GUE
>
> Most likely, yes.
>
> > Please Stefano take a look, thanks !
>
> Started one minute before your email, thanks for Cc'ing me though!


Which reminds me that we need to make KASAN work with VMAP_STACK (or
equivalent):
https://bugzilla.kernel.org/show_bug.cgi?id=202009
