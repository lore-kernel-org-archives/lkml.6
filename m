Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3460752-1519407321-2-17069466667460421438
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519407320; b=wYcFFLY+EnOYRUrnz0xO8NIz1dVHRYf4AG3GehMW8xi0DdT
    BDS2kcBnvyT02b+4WJBQ5UURIYxjfi6NajZ5rj+xmS6DfoW9DGAPF3zZaNI88TQU
    ONg5cgqJXqTZC93JeVak25a2J4K7zdati8NDD/A7VfCufiJOwomBipNxLnuVwYZ8
    8kzZlKXc97ait6CcvLqxShFx4U6kwoMiWq6CocSwisr5DDOKD30atQWWlkzKvF3I
    CnG6msZ8v/oIruZ0iguSjyhM6CeY06DEoDN7B+SfZeZuv0EAsbzvt0hxbpIcbbpd
    pHNlSIcAwITnRXPuSPo/v468i4nwXtzElQO7mLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519407320; bh=lee2AvmSDO/qJvTO1pLFlYpjNxoKYbT35Q/JWuVGPds=; b=B
    FwYvYdpA2TCigcxScHAZsgO+2qQmah3EXC6RYsEOuG8TxtzU/wSkuGVofSsyIqbC
    f5mXwqAvqiZrw+B1Jt21CNNgyltFTQ819iEwFwZgDjoGkiV31dqA/LpGkWQuNPSL
    wj20Er3JWBa9AhJyq1lEohisemSX1TtvWTqPfX82wqb3g7PCPPmN4vSJ5pt8nDuS
    6UwotceV/keah4XbCcVN+c4QeeB4sCiHlN5eU/863/rqmxbrcL7rTGUueYTNAx0r
    efRroS9I8tGYuZcHKmPserGl3XAxnKmu1ad16F28WtMmTuI6otRKfr22ixFzdiX5
    tiES6X98Sj3d68pfCunkA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751541AbeBWRfS (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 12:35:18 -0500
Received: from mga04.intel.com ([192.55.52.120]:4924 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751351AbeBWRfR (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 23 Feb 2018 12:35:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,383,1515484800";
   d="scan'208";a="20579330"
Message-ID: <1519407313.10722.127.camel@linux.intel.com>
Subject: Re: [RFC PATCH 2/2] serial: 8250_dw: support polling mode
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: John Garry <john.garry@huawei.com>, gregkh@linuxfoundation.org,
        slaby@suse.com, p.zabel@pengutronix.de, heiko@sntech.de,
        ed.blake@sondrel.com, jhogan@kernel.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com
Date: Fri, 23 Feb 2018 19:35:13 +0200
In-Reply-To: <1519324923-196857-3-git-send-email-john.garry@huawei.com>
References: <1519324923-196857-1-git-send-email-john.garry@huawei.com>
         <1519324923-196857-3-git-send-email-john.garry@huawei.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2018-02-23 at 02:42 +0800, John Garry wrote:
> It would be useful to make this driver support some
> 8250-compatible devices which have no interrupt line.
> 
> For these, we allow for no interrupt, and will fallback on
> polling mode.
> 
> Note: the 8250 dt bindings state that "interrupts"
> is a required property:
> "interrupts : should contain uart interrupt."
> 
> But the 8250_of.c driver can live without it. So
> this patch is going this way also.

It should be documented in the binding.

>  	if (irq < 0) {
> -		if (irq != -EPROBE_DEFER)
> -			dev_err(dev, "cannot get irq\n");
> -		return irq;
> +		if (irq == -EPROBE_DEFER)
> +			return irq;
> +		dev_warn(dev, "cannot get irq, using polling
> mode\n");
> +		irq = 0;

NO_IRQ _is_ 0. You need to do something like

if (irq < 0) }
 ... leave existing code ...
}

if (!irq)
 dev_warn(, "Use polling mode\n");

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
