Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-930196-1521534931-2-8700306457020341542
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521534930; b=wZAr5oivO1oKkeEawzf7L/yPgdXFGhs4zcaRXRRjXHwuvdG
    L46Fvsl4JAuBhaIRBdAza3n3UXL26yzYybWj/FYHGnO0YFrbI0BiDrJf6SWGvO46
    ZSbT9iU4m64K/REitUIRk1+qZ1gOWUNChs2UPqycdx7eYthWBjG99nEdZiyk0T+3
    eREXAFN5plTYRwUWlMA54N29cdoOF2vPVV1HANYnhdLP/QHbaZ02Yvo8iqjoUC4f
    1W0a1fOHUHlMIKcb4zLl1pQcnHGYGqZ1Ewj2/XGwxQjYpw2OmqoeG+/QbvuiT664
    enPfUwYmjCeQKx6hfiIuZqKdGeSypNZSHtqbIYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521534930; bh=QUssRfXYMNFkm9FhSke4VHDQX6
    TtrsK1n2XiDdfv0lM=; b=TLiPoSffGY+u8/u5GUN+DKFhA4LeyFmsxR9n6pM/dJ
    9xE1sDDnQnqVO5UH3XHeoBHLhV/MUT88Rl5OPppeyj1vQxaovzYqht6HsU1cr3+J
    0KAmGHCc9MlBQ1ZTMyYVATge/BXCsE2UPMqkQ3EjR89GcNiFqPdF6hDGRD05G3rA
    K6L+HYDJ+hweW7xw5pJtvB+Tg9fuKV/lzIjNBS1+lOAv6LXn2LIinR5NB2y5DEEh
    FK5E8EKRq9RYlzUB5QhxQ7Ou9UEH6YSVN1k8p7bz5DCfVLrvZPwQSZzc8x5LHP2H
    eLe8TLeEWUfDkQDYtQTkZQwt6IpWxWbowd7mMyeIWtjw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752142AbeCTIeI (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Mar 2018 04:34:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55002 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751687AbeCTIeH (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 20 Mar 2018 04:34:07 -0400
Date: Tue, 20 Mar 2018 09:34:05 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Richard Leitner <dev@g0hl1n.net>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stern@rowland.harvard.edu, linux@roeck-us.net,
        mathias.nyman@linux.intel.com, johan@kernel.org,
        felipe.balbi@linux.intel.com, ekorenevsky@gmail.com,
        peter.chen@nxp.com, drake@endlessm.com, joe@perches.com,
        Richard Leitner <richard.leitner@skidata.com>
Subject: Re: [PATCH v3] usb: core: introduce per-port over-current counters
Message-ID: <20180320083405.GA23588@kroah.com>
References: <20180314095109.18260-1-dev@g0hl1n.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314095109.18260-1-dev@g0hl1n.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 10:51:09AM +0100, Richard Leitner wrote:
> From: Richard Leitner <richard.leitner@skidata.com>
> 
> For some userspace applications information on the number of
> over-current conditions at specific USB hub ports is relevant.
> 
> In our case we have a series of USB hardware (using the cp210x driver)
> which communicates using a proprietary protocol. These devices sometimes
> trigger an over-current situation on some hubs. In case of such an
> over-current situation the USB devices offer an interface for reducing
> the max used power. As these conditions are quite rare and imply
> performance reductions of the device we don't want to reduce the max
> power always.
> 
> Therefore give user-space applications the possibility to react
> adequately by introducing an over_current_counter in the usb port struct
> which is exported via sysfs.
> 
> Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-usb | 10 ++++++++++
>  drivers/usb/core/hub.c                  |  4 +++-
>  drivers/usb/core/hub.h                  |  1 +
>  drivers/usb/core/port.c                 | 10 ++++++++++
>  4 files changed, 24 insertions(+), 1 deletion(-)

What changed from the previous versions?  Always include that below the
--- line so we have an idea of what is going on here.

v4?

thanks,

greg k-h
