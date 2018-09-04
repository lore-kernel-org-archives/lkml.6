Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494DEC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA2EF20869
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n3AOUEZV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA2EF20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbeIDLaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 07:30:07 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36045 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbeIDLaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 07:30:07 -0400
Received: by mail-pf1-f195.google.com with SMTP id b11-v6so1227930pfo.3;
        Tue, 04 Sep 2018 00:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=svu6c6Gb+2afHOTExqKRs13z01PtzHgjngZpaLueMPw=;
        b=n3AOUEZVllmg9dQBtKw6KU64LqjFTO8EdhZh33jvHBNV/kDbOlY4WIG4dFIf85cuWz
         R8lmAAxkgIHdwaSHlwQtKznr84ebYVz/fj9++8aGHxUB0IRIqk5QI32pmZuPRoz6siqu
         Bo1Ot0IONVHgYlm1Tj1DKD6GWbgJ00h9POBxX0AtK4L7sZYN8SGKBr+EvwoC9IX6nTHA
         3UkqqlSWJPFxLaJY3TcT/1WOadvaKhF0s7o6aKdowTKRpfcIa2ESsuSZdfYCQc4wo67y
         MSBc5NYlyBjy1XdckobYGo1LVRhsbSI1afOe16kvDQJGJ5fiP4qxffhqO9GCMl7YjaBk
         Uglw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=svu6c6Gb+2afHOTExqKRs13z01PtzHgjngZpaLueMPw=;
        b=GToC7dkcevqq2QFKBNgrmtzKmE6aahiB+P5Jf2LyVA1+m9OxvBcpZsMKBwedEqCMnc
         0UkzbN9ITFpEhc1BOcbNaZoFUgvU8KDuAd20JJgmAn/l+rom5ji0CPXqHFH7nlALz5E2
         V/gUUqg18mvVrTIZJyOE+gt42yHCo1db/puRHvCSHAPuB/xatBp8RtkwJrHjFreQQK9n
         FjB0w36UXr4nsmdR5O+SRRhWjR9p85u2d4LSSI4mazY99LJLm6QRvTzuOUNuGYo3kyaa
         e4VwA75KZB5MF1CoLVRDcpdv9QDOen1xOssEJvmWAS0oj/uYTO4x0O9rBA8zR/w7DMdr
         7HZA==
X-Gm-Message-State: APzg51DOjYYIZXPCJmBPyDNZkq7YGubeqbxjORJJ/28iluQNYh8JgVL8
        4bsotbU7Caqc1xt03cJbt3oM9uzv
X-Google-Smtp-Source: ANB0VdYAy2unobs/kFoJ/krmTPPrFmgyiUTVmKyYynlA+TS3UP4h5TeUHcURdQ1N0NO1G6hiZgowXg==
X-Received: by 2002:a63:d613:: with SMTP id q19-v6mr30167260pgg.327.1536044781105;
        Tue, 04 Sep 2018 00:06:21 -0700 (PDT)
Received: from localhost ([175.223.26.230])
        by smtp.gmail.com with ESMTPSA id e73-v6sm36104380pfb.153.2018.09.04.00.06.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Sep 2018 00:06:19 -0700 (PDT)
Date:   Tue, 4 Sep 2018 16:06:16 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Jiri Slaby <jslaby@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Daniel Axtens <dja@axtens.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Neuling <mikey@neuling.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Nathan March <nathan@gt.net>,
        Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>,
        Peter Hurley <peter@hurleysoftware.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        syzbot+3aa9784721dfb90e984d@syzkaller.appspotmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Subject: Re: [PATCHv2 2/4] tty: Hold tty_ldisc_lock() during tty_reopen()
Message-ID: <20180904070616.GA11702@jagdpanzerIV>
References: <20180903165257.29227-1-dima@arista.com>
 <20180903165257.29227-3-dima@arista.com>
 <20180904015139.GA4251@jagdpanzerIV>
 <7e62b122-3b9e-dc46-d99f-9055bb67d670@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e62b122-3b9e-dc46-d99f-9055bb67d670@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/04/18 08:30), Jiri Slaby wrote:
>
> >> Cc: stable@vger.kernel.org # depends on commit b027e2298bd5 ("tty: fix
> >> data race between tty_init_dev and flush of buf")
> > 
> > I believe there's a "Fixes" tag for that
> > 
> > Fixes: b027e2298bd5 ("tty: fix data race between tty_init_dev and flush of buf")
> > Cc: stable@vger.kernel.org
> 
> Nope, it would be translated as:
> Backport-first: b027e2298bd5
> :)

:) Ah, OK.
So this "Backport-first:" is for pre-4.9 longterm kernels.
As far as I can see linux-4.9.y picked up b027e2298bd5:

commit 55eaecffe3d663d02084023b9fc06d5f39b97389
Author: Gaurav Kohli
Date:   Tue Jan 23 13:16:34 2018 +0530

    tty: fix data race between tty_init_dev and flush of buf

    commit b027e2298bd588d6fa36ed2eda97447fb3eac078 upstream.

	-ss
