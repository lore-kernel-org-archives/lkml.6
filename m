Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9302C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE072083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="L0J8hE4v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BE072083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbeHaQ3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 12:29:45 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38540 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbeHaQ3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 12:29:45 -0400
Received: by mail-ed1-f65.google.com with SMTP id h33-v6so8906862edb.5
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 05:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rSkv2aqTja5O91+368KmBvNqtebcNoI2t0dcsqV7LjU=;
        b=L0J8hE4vclIEeXsj2IZTx1/sWEO7v6VojGgbV/VPmrhbL0FeUFgKuaR6SXUUrI7ejI
         s6VfxlWtc9805EcyNiRtMjIZBgxmE6lNphqdQ59uwTHfQEeCjUSaQX8bpGEdQZY8JTmR
         JOv1+n0WwoJD38zLzEZdVabxhAceM1uxI2NrA1TrdhJzxPbV/RY2Xocs/pXXHxkCokFS
         yPweOZHkqhd062DhKuOHwP8hGbnkSyvYQgcen7xHJXZEGv5IfvNhXjjTNRSY0GkAEjsk
         AMKgWX1WVekIAveR1agMYWuf//n6tl5Oy/oqgPGn1IE4uDzsKk+hvLJF0jmtXS75C/5P
         rpKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rSkv2aqTja5O91+368KmBvNqtebcNoI2t0dcsqV7LjU=;
        b=NGh2Bicgbd98wLO7CbpM4Fon7m11AcYUJydQJbjiQAAkD8+1/XBwuOiy7j8irCQoO7
         Q3oyK+oBRMHxUe3hgkHmH2rlrT0LQNqKKJIFFhrGYZLSKe2XdJe0mubqwEBl537ozNyS
         LqYAI+4R4CsmnA6KhOzdaTKNY1D2ln+jW+zXHSTYg4TZfJp3qrYcptXCTVX90frfYNUm
         6gN/E80ZXNJXGfz55bOXLrBU1DdH2oiWSHTT0pIGWdRlnubTqtwBI7O8Z3WEALj680pw
         AeLV6UiZmnNYbCy2pFgXhS5IoHaeiVBZGTw6QETZSRuURf7+JHppy1FLZcRZuj2j1e7D
         JlGA==
X-Gm-Message-State: APzg51DAcTmPbfu9d/OSNfj2+4RQY0a0+LAXa+h70lIVV/5OGqDH1+Ab
        SuK4WIbyipWxzFUqXVt9HyPFpA==
X-Google-Smtp-Source: ANB0VdaRSWpQu0m7K5aiZ7967MuHZmJRbEYeCPCzfNHOiiWYw0HfZdRhLo1adPB4FRuPPLGB419ppQ==
X-Received: by 2002:a50:9ac5:: with SMTP id p63-v6mr17791201edb.112.1535718148770;
        Fri, 31 Aug 2018 05:22:28 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id q26-v6sm3077536eda.72.2018.08.31.05.22.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 05:22:27 -0700 (PDT)
Message-ID: <1535718146.23560.80.camel@arista.com>
Subject: Re: [PATCH 3/4] tty: Lock tty pair in tty_init_dev()
From:   Dmitry Safonov <dima@arista.com>
To:     Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org
Cc:     Daniel Axtens <dja@axtens.net>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Peter Hurley <peter@hurleysoftware.com>,
        Pasi =?ISO-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Neuling <mikey@neuling.org>,
        Mikulas Patocka <mpatocka@redhat.com>
Date:   Fri, 31 Aug 2018 13:22:26 +0100
In-Reply-To: <125964f4-ce26-ce43-b788-d3dbaef139b4@suse.cz>
References: <20180829022353.23568-1-dima@arista.com>
         <20180829022353.23568-4-dima@arista.com>
         <22935dc9-a9fe-5fc8-4c97-3f5c7b07b8c3@suse.cz>
         <1535560111.23560.61.camel@arista.com>
         <125964f4-ce26-ce43-b788-d3dbaef139b4@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-08-31 at 08:54 +0200, Jiri Slaby wrote:
> On 08/29/2018, 06:28 PM, Dmitry Safonov wrote:
> > On Wed, 2018-08-29 at 16:46 +0200, Jiri Slaby wrote:
> > > On 08/29/2018, 04:23 AM, Dmitry Safonov wrote:
> > > > It's safe to not lock both here - done to silence attempt
> > > > lockdep
> > > > assert in
> > > > tty_ldisc_open(), which will be added with following patch.
> > > 
> > > SOrry, could you elaborate here? I don't follow...
> > 
> > Sure, 4/4 patch adds lockdep_assert_held() into tty_ldisc_open().
> > Currently ldisc in tty->link isn't locked, which according to code
> > shouldn't be an issue, as far as I can see.
> > 
> > So, this patch silences lockdep warining by holding the semaphore,
> > which is slowpath anyway and doesn't case any new contention.
> 
> Eh, no... Adding a lock just to make lockdep happy is a no-go. The
> locking in tty is already complex enough.
> 
> > (actually, not holding the semaphore for slave might be an issue if
> > one
> > opens slave before it's fully initialized, but I'm not sure if it's
> > possible).
> 
> If that turns out to be a problem, we can apply the patch. BUt unless
> it
> is proven to be so (be it code review or a reproducer), let's leave
> the
> locking as it is.

Ok, than for v2 I'll just remove lockdep_assert() from
tty_ldisc_open().

-- 
Thanks,
             Dmitry
