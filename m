Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2389795-1520276968-2-5552373781614918902
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520276967; b=jcczrZmHTxqfR0iUdLKcuIkkQLmkOShanEGVBjzX8uKPBoc
    FLJn19aW7lg6vXcHIXhXCF/U6fout+oJ29jXxtwineowvv3MMVLrblB5UQaOUAKE
    lvEI5XmLLdmAwDU9xEsRTgBECGhrHz3PHa4lBo37hvv2KdSBGtZQWK3rY5yvzna8
    1ZyLgQKkPWOpqmFdx8/Cjs/j+9L/16LYs/LmMtGFN4+6Hvkmu6GVYLd39lsHivch
    0+521mQCXC7qQ4oSeXXcjYL2X7TXY9D+UwbE7I9EcfSs0+DmFDNBcrx3Dpiu73lc
    QiRHhd/5LUDSFcRWKWFoiEQVaQGtfbSx1byWwqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520276967; bh=jrk+tOYUoqnI4UoaT64qqArVjBfKqQRuKb+hE+nyQE8=; b=E
    BujGRJS0xhpnf8tOTYGjtgouu6mbXHk6oDJwlEVHJ3V5MgPk1asxKK+tgW9b66Fb
    SuVZJldscvfFd2Zzjs+oxN3e9GQoKz3fbUhJAN9EyEwZ27QsEYthjFyJP72cC2RI
    MV2H+EVcO36bm7F+swHVkd6gaNQnWDYZFQ1CRf2KZVph6sNG4DRBfMqV44rKhkkm
    bfcut+jvVKg1cuGg0Mjxc6a9jS/wZdL7+eQgauFtXff9+ppJisLmP2gpnnxSYPZE
    VneY56pROOyq2/PulMWDdBsSi4YOR53Xi5iqPoXHW54KO3dK33mgtZieOMoxtNrQ
    1g3JmPmjo2RsVtEa8p+tA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Wz9t3kJe x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Y/Ybo3Ea;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Wz9t3kJe x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Y/Ybo3Ea;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753018AbeCETJG (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 14:09:06 -0500
Received: from mail-pf0-f174.google.com ([209.85.192.174]:36040 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753001AbeCETJE (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 5 Mar 2018 14:09:04 -0500
X-Google-Smtp-Source: AG47ELsXrtFl8DF46BjGBD2wD3WkGoHL1yvloO548wGsOtZbd9LNkC5irXfNfSkYdq8dPzOdIl95Cg==
Message-ID: <1520276942.109662.9.camel@gmail.com>
Subject: Re: inconsistent lock state with usbnet/asix usb ethernet and xhci
From: Eric Dumazet <eric.dumazet@gmail.com>
To: Oliver Neukum <oneukum@suse.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>,
        netdev@vger.kernel.org, Dean Jenkins <Dean_Jenkins@mentor.com>
Date: Mon, 05 Mar 2018 11:09:02 -0800
In-Reply-To: <1520250367.3990.9.camel@suse.com>
References: <CGME20180227072602eucas1p28dcdba711b3153820bd409d838cc63bd@eucas1p2.samsung.com>
         <c15c90ef-ce1b-4dd7-1d9f-673deb01b6d2@samsung.com>
         <1519740421.7296.6.camel@gmail.com>
         <bac44c1b-d701-2f6b-5e1e-738befc25c9d@samsung.com>
         <1519744167.7296.8.camel@gmail.com> <1519744400.7296.10.camel@gmail.com>
         <1519747675.2649.3.camel@suse.com>
         <02679502-cf6e-8714-e879-50a922c5d976@samsung.com>
         <1520250367.3990.9.camel@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 2018-03-05 at 12:46 +0100, Oliver Neukum wrote:
> On Mon, 2018-03-05 at 08:45 +0100, Marek Szyprowski wrote:
> > Hi Oliver,
> > 
> > On 2018-02-27 17:07, Oliver Neukum wrote:
> > > Am Dienstag, den 27.02.2018, 07:13 -0800 schrieb Eric Dumazet:
> > > > On Tue, 2018-02-27 at 07:09 -0800, Eric Dumazet wrote:
> > > > > 
> > > > > Note that for this one, it seems we also could perform stats
> > > > > updates in
> > > > > BH context, since skb is queued via defer_bh()
> > > > > 
> > > > > But simplicity wins I guess.
> > > > 
> > > > Thinking more about this, I am not sure we have any guarantee
> > > > that TX
> > > > and RX can not run on multiple cpus.
> > > > 
> > > > Using an unique syncp is not going to be safe, even if we make
> > > > lockdep
> > > > happy enough with the local_irq save/restore.
> > > 
> > > Unfortunately you are right. It is not guaranteed for some
> > > hardware.
> > 
> > Does it mean that the fix proposed by Eric is not the proper
> > solution?
> 
> For asix it should work, but asix is unlikely to be the only driver
> with that issue. 32 bit recieves less testing nowadays.

Yes, although the lockdep part could be enforced in 64bit if we really
care.

I will send a patch using two different sync (one for RX, one for TX)


