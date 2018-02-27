Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1892792-1519748040-2-8811708276350701071
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519748039; b=oNpwZp/UycT37HL85K1eXeRTcFVVpKNrcBcqd5I9LuMhNwI
    M+/F+h8OtERyZWB4x0hxJGEmJfpVd+0p9nzO3qCSv4A18GrCO/ha17nVgWqu3tKl
    rX5RJ0v+TtFScr49fXZJjepn9CoQhkx+fGYVLSjfB6L8Otq1T4na0tkQc/2aWPG5
    rVipKUwTXzxv+U5AefXqO5B7TNIio95GjLzE0Ra7rWDilIhbGKxbR6ngyQdVQRjv
    HBhWD9miEyRM0cb78gzAT/zwMLoHCu/DJxTpjNPowUNK066+cvh0SNQMlTgVcq/B
    C1hJufLxfpA2D+F+7WevNTw7xFVmw6uXBHkwNJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519748039; bh=QGMUI23xn44egSoMXd4hTHcskedq/kZ7BZCYSauOz2U=; b=u
    RV/OHtCvbKbF9XBCzXB8kSDp/O2wIU/ybbpM6gtCkttOQ6ZTUJi+5rSnYrwn9pkl
    UOusH9sVI2Ov3LJae+XppJWQ+XBxBnxd7do3qVtndNmywhFPIw0U1RTmxqDPMMvY
    57aNzWIsHqMhTe9n3JcCEpaplfPr9yB4jI4fov7xLcTZlkpzCJheR7aYL8Pq5v0G
    2LDLxBTM1MLIwx8X0z+MIhzXUSxsLOzXWrd4klL2SsSQG/xTjBu5HI6WWPkZsC+c
    MRU8/t3GwemQpeWx19C8J0UYkdGXSLcEi+USI4++ya5olyoqwX4ih3nf1dh41Bdm
    j6G2ZGm52dkPWLCPbJa8w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752539AbeB0QNj (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 11:13:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:43434 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752446AbeB0QNh (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Tue, 27 Feb 2018 11:13:37 -0500
Message-ID: <1519747675.2649.3.camel@suse.com>
Subject: Re: inconsistent lock state with usbnet/asix usb ethernet and xhci
From: Oliver Neukum <oneukum@suse.com>
To: Eric Dumazet <eric.dumazet@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        LKML <linux-kernel@vger.kernel.org>,
        'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>,
        netdev@vger.kernel.org
Cc: Dean Jenkins <Dean_Jenkins@mentor.com>
Date: Tue, 27 Feb 2018 17:07:55 +0100
In-Reply-To: <1519744400.7296.10.camel@gmail.com>
References: <CGME20180227072602eucas1p28dcdba711b3153820bd409d838cc63bd@eucas1p2.samsung.com>
         <c15c90ef-ce1b-4dd7-1d9f-673deb01b6d2@samsung.com>
         <1519740421.7296.6.camel@gmail.com>
         <bac44c1b-d701-2f6b-5e1e-738befc25c9d@samsung.com>
         <1519744167.7296.8.camel@gmail.com> <1519744400.7296.10.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Am Dienstag, den 27.02.2018, 07:13 -0800 schrieb Eric Dumazet:
> On Tue, 2018-02-27 at 07:09 -0800, Eric Dumazet wrote:
> > 
> > 
> > Note that for this one, it seems we also could perform stats updates in
> > BH context, since skb is queued via defer_bh()
> > 
> > But simplicity wins I guess.
> 
> Thinking more about this, I am not sure we have any guarantee that TX
> and RX can not run on multiple cpus.
> 
> Using an unique syncp is not going to be safe, even if we make lockdep
> happy enough with the local_irq save/restore.

Unfortunately you are right. It is not guaranteed for some hardware.

	Regards
		Oliver

