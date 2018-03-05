Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1487138-1520250726-2-17507013922213414231
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
    t=1520250725; b=vl1aB5P58hqZNYY6eMl5x/zV6AbHt8qSfVh/A8r53JeT/QI
    sri9w8lcP2TQvZpmuMWxtYUamYqSUc0ZawC4O/Z/nUfWE7TauN0UuCOOZAOzE9D2
    bUFDv1F7R2W1/GgYXZbTQXZ3uTYk0vP2TMUsmoz476j+uzytWafcOVBCtCPdHqzo
    qySDQj5eZaGwu1Osl1fzu5o5y85+NQWeTiVTo1jVl6sXhAKsg3aezS/ccAzUI4ba
    hrp9Y6cqHFHePw65W8HEV1AHvJVAGYj4wJQhE84cBVXpe2KwTL2uk+3iD7nFlyZy
    i7u4ow50ggj7Ajo/MXywfkiKxOFUKq/5wTtw+pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520250725; bh=Gr0qZXJsl5krGHIHdzZ0cC/Z0+F6DENMxqHISDjbDfg=; b=C
    wWF//ijFcF7jzyIw+3Ef3KPlKAE5lLiJxUF2NHeqChMz3J9UR0alq9vDOO0Eunzd
    Tl3huk5Bn4dnaBJMxc2TY28NC9U8nJN3Rh4/sMPjuqJeylz/i70JmgtatDQJJxtj
    2lVI04nMAgvfi+eYAZt/M+iWhIAwkEly8jSSkqWCn3fu+cc2z5d/O3KAWnKydUWm
    YgVyHAVe3Xs/R72nQXv8LBWHs+fCHhOJK6PL0e6PW0plWIMGJ5CIa6UXBTfM49yn
    reGbaxuQyw5vRZwm0DLbR6yeL8mAPMn6VxOsSPrJCwhrCK4yaz5Gh+WowFqqqioM
    2kKjzHOZ47tS7yGyuejNw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933973AbeCELvp (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 06:51:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:57738 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933027AbeCELvn (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Mon, 5 Mar 2018 06:51:43 -0500
Message-ID: <1520250367.3990.9.camel@suse.com>
Subject: Re: inconsistent lock state with usbnet/asix usb ethernet and xhci
From: Oliver Neukum <oneukum@suse.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Eric Dumazet <eric.dumazet@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>,
        netdev@vger.kernel.org, Dean Jenkins <Dean_Jenkins@mentor.com>
Date: Mon, 05 Mar 2018 12:46:07 +0100
In-Reply-To: <02679502-cf6e-8714-e879-50a922c5d976@samsung.com>
References: <CGME20180227072602eucas1p28dcdba711b3153820bd409d838cc63bd@eucas1p2.samsung.com>
         <c15c90ef-ce1b-4dd7-1d9f-673deb01b6d2@samsung.com>
         <1519740421.7296.6.camel@gmail.com>
         <bac44c1b-d701-2f6b-5e1e-738befc25c9d@samsung.com>
         <1519744167.7296.8.camel@gmail.com> <1519744400.7296.10.camel@gmail.com>
         <1519747675.2649.3.camel@suse.com>
         <02679502-cf6e-8714-e879-50a922c5d976@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.12.11 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 2018-03-05 at 08:45 +0100, Marek Szyprowski wrote:
> Hi Oliver,
> 
> On 2018-02-27 17:07, Oliver Neukum wrote:
> > Am Dienstag, den 27.02.2018, 07:13 -0800 schrieb Eric Dumazet:
> >> On Tue, 2018-02-27 at 07:09 -0800, Eric Dumazet wrote:
> >>>
> >>> Note that for this one, it seems we also could perform stats updates in
> >>> BH context, since skb is queued via defer_bh()
> >>>
> >>> But simplicity wins I guess.
> >> Thinking more about this, I am not sure we have any guarantee that TX
> >> and RX can not run on multiple cpus.
> >>
> >> Using an unique syncp is not going to be safe, even if we make lockdep
> >> happy enough with the local_irq save/restore.
> > Unfortunately you are right. It is not guaranteed for some hardware.
> 
> Does it mean that the fix proposed by Eric is not the proper solution?

For asix it should work, but asix is unlikely to be the only driver
with that issue. 32 bit recieves less testing nowadays.

	Regards
		Oliver


