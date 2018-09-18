Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B93ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7437F214DD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="BwIX6Y5T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7437F214DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbeIRTr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 15:47:59 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34802 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727756AbeIRTr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 15:47:59 -0400
Received: by mail-ed1-f68.google.com with SMTP id u1-v6so2074106eds.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 07:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6fCNyjFM22TMUgBgUvDJbnGR5hgHHLEQi4ZZb34F2JE=;
        b=BwIX6Y5Tgq4Us08ZmpUZgLRLjJyJZcJBJwM3wXZhb2BKHKzJX4wv4BzYAVAd+o3NGv
         kNxIbPIxQl/slOuRywfgGcrqI5dM2mc0e/Q7Qmuk0FnVzr0scnvQIFtLhDXXk8SO5Pfv
         kn6zSx9NZBgMFPsKatybXqVRjhCS5V88Sq4d9JyWMuk+LvdEBc0pnyyDJg1JBU1s2FiW
         z+oqsqAki+RmZ/hnHmqfFh6IBGGdAOPehZ99NbZdeB5TWE+k/lem97g9WX6nLjRUHLaH
         y2viqJZU869wausXI8XDtuQtaysHUOukP9W+o73Q8IsSXadqrc+LLvQuxxZdMgYV+T+n
         wKsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6fCNyjFM22TMUgBgUvDJbnGR5hgHHLEQi4ZZb34F2JE=;
        b=r8s8LaCN3w0xqaG1BmBPaRiuOFvtguW9Lya5VEj4ynBmdWe1/o8HZgh/fiD3EU6HYJ
         YiE3aSWx+I4V3kfu/x6H8VJjlg6S8ikQvUw4+qn8/o9O8xZcFClMBCwqCjAl+akXaSDe
         6+J0XdgWEuChuMRKAMKBkUfejQjvZ6GbI4GJOalBfs21vWMdWxOVdUr1iQY4SBDTyJ8l
         y30aghgOJiV1iAyYMDO97jW16tODraKWJWdaIgumeNUDiGGc567DiHch/oiWodLmSzjY
         14M2j7gTu6xOtXKwUxTk5kz2053jmbDbPwOD+poXNIkmcwNYgwFK75+JxGgFPcNCuxG0
         GMIw==
X-Gm-Message-State: APzg51CLChSXGTPXzLQ3EJYR5UPN7yidgkKIlI6SWM/TlTc9t6HWT4PR
        AbiVZFS4Jgchdx7JZXT4mb6U0w==
X-Google-Smtp-Source: ANB0Vda9FhXU0XohM2U4iCpVU0dg7R0WKfGpGrcZnIQvp/Idi6nraT0twAwwdZZe0ILrsbZ96QJ1Hw==
X-Received: by 2002:a50:ac56:: with SMTP id w22-v6mr50444999edc.211.1537280110824;
        Tue, 18 Sep 2018 07:15:10 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id d23-v6sm130694eds.47.2018.09.18.07.15.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 07:15:10 -0700 (PDT)
Message-ID: <1537280108.21380.5.camel@arista.com>
Subject: Re: [PATCHv5 1/7] tty: Drop tty->count on tty_reopen() failure
From:   Dmitry Safonov <dima@arista.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Daniel Axtens <dja@axtens.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Neuling <mikey@neuling.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Nathan March <nathan@gt.net>,
        Pasi =?ISO-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>,
        Peter Hurley <peter@hurleysoftware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rong, Chen" <rong.a.chen@intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Jiri Slaby <jslaby@suse.cz>, Jiri Slaby <jslaby@suse.com>,
        stable@vger.kernel.org
Date:   Tue, 18 Sep 2018 15:15:08 +0100
In-Reply-To: <20180918134150.GC23431@kroah.com>
References: <20180917235258.5719-1-dima@arista.com>
         <20180917235258.5719-2-dima@arista.com> <20180918134150.GC23431@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-09-18 at 15:41 +0200, Greg Kroah-Hartman wrote:
> On Tue, Sep 18, 2018 at 12:52:52AM +0100, Dmitry Safonov wrote:
> > In case of tty_ldisc_reinit() failure, tty->count should be
> > decremented
> > back, otherwise we will never release_tty().
> > Tetsuo reported that it fixes noisy warnings on tty release like:
> >   pts pts4033: tty_release: tty->count(10529) != (#fd's(7) +
> > #kopen's(0))
> > 
> > Fixes: commit 892d1fa7eaae ("tty: Destroy ldisc instance on
> > hangup")
> > 
> 
> Minor nit, no need to have "commit" in this line, it's implied.
> 
> Also, no need to put an extra line here either.
> 
> I'll queue this patch up now, have some question about the rest...

Thanks, Greg, will have in mind further.

-- 
            Dima
