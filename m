Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2878775-1520036374-2-2337655676533886235
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520036374; b=MqP94DT7rskSEKznXyFjUViujuenq05i9UhdsLjqCIPcPb0
    Yx2HGRS6BEfyUVySGaY6dVm/k3WqjhSnwZNW2j1GP+zOW8Bu9kyIPWc74DVblnL0
    xu9BjECLglbIpWnRCX0FPnpYlnq83Wo2SH9BanxVMnW5v9XnmzbLlUFlHi8+wOEz
    Ego2axvTkuo5WsLHzTNpMrfFgnDE+trNXbakEELXGCxUmy+i6ccFwchI3XYC4epY
    WrPML/DXxcPWG1e6ZScaIY3cdRLmT+Nh81sALawCqbtszMMK1dtGzMLCCZWaXrc9
    fXwm04pe1DC+bILz45Cg1AiBzfhalQL9dIk79FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520036374; bh=8RlhPBfhqzfj5lBP/RBvHW7Iz+6IdtheaMl7J8Hz5Cg=; b=I
    ocOuoWa4GR/LUtJ134RmaY4tOSOoPPXIno+1XYV/iTxKsWHoloIjLG0oN7VLCwUJ
    wyVtgoBoyBwWVK582hff5Jqbtk7QiUu5MouekEr9shNqxXrrqQN7GL9LrUyGDBpc
    2U4wmF2yPpyMEabaGrRu+xbpq2ZleVdIepZVvFr/ETxYhvEw/824mKXGkdPBW08Q
    s+EarxX4mDB2Lv8mKPr5Mx9UT18F/cJMA8lQp9b6raMwD0wj24kfnVtFgryZ7S1D
    8hF1V0cttIOsA4UVy33f27SnTUdROYJPSROQWVh8syOoddv5k0SHN5X+QIMeF9i1
    a2S7ETJS3w5bYJ6bo28dA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933324AbeCCATb (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 19:19:31 -0500
Received: from imap1.codethink.co.uk ([176.9.8.82]:41292 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932890AbeCCATa (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 19:19:30 -0500
Message-ID: <1520036364.2786.39.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 64/67] usb: uas: unconditionally bring back host
 after reset
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Oliver Neukum <oneukum@suse.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc: stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Date: Sat, 03 Mar 2018 00:19:24 +0000
In-Reply-To: <20180202140822.268335379@linuxfoundation.org>
References: <20180202140815.091718203@linuxfoundation.org>
         <20180202140822.268335379@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2018-02-02 at 17:58 +0100, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Oliver Neukum <oneukum@suse.com>
> 
> commit cbeef22fd611c4f47c494b821b2b105b8af970bb upstream.
[...]
> --- a/drivers/usb/storage/uas.c
> +++ b/drivers/usb/storage/uas.c
> @@ -1052,20 +1052,19 @@ static int uas_post_reset(struct usb_int
>  		return 0;
>  
> 	err = uas_configure_endpoints(devinfo);
> -	if (err) {
> +	if (err && err != ENODEV)
>  		shost_printk(KERN_ERR, shost,
>  			     "%s: alloc streams error %d after reset",
>  			     __func__, err);
[...]

This should be checking for -ENODEV, shouldn't it?

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
