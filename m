Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2396152-1525968606-2-10929059990514250612
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525968606; b=du5d+HWa5NHQiUFlX7HoYnK0BjGiKUdfXrDN1jMkuds8jpM2n6
    FrEyYH62WLjdlRtR2Eu/3Ky+qUQzyHhlRIf3X+CNQHqaD/rVKhFXJxkGHRhxy7yH
    5js7pC74f0rMuyUp5vgQicqNfEGVGzVCtXXCs1S5TtVOhXunDzZcgjrFkDtv/wAL
    Uao56+zAsWtnQQODsGQraJqkIOSrer9Marpb34NAY1KnaVWbXA2R7z0ql7E1dmfy
    F8QmxgwifjB5UjB66+ZTUpWn+e+6Uw5e8fS/piLOR5wIlcCW2gIcjUWPPJu1YKPB
    0V+j1Zf98ymLn2rr9QmhXPbISm1YqTXv15Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525968606;
    bh=KmrmLwPthbGK8ixkwKeQLRBdJm4cALpVPC23k8xI12Q=; b=NgFnbtG8lnxZ
    hlNn89nvwKHDyzowR5YvqcCIsf3YwRsfGLNr+rzUMaPy6IotqStX2qJ+NcL03DiJ
    VZ2p9IrAATppmVsmrDUik0KC33u8qyszWGbnhgVbAiL4lnzU9GIUs7fOTaGtxlIX
    EzhXymKm9bGW7pB5PJcREoP0AZa+bBNPwoAH65R1B0R2R/DRENCbeeemXR2azQbX
    4+Vm8S4KNydqp5awYaUlduo2b54SUSBqUDDjBp/5IpUKWfSxyS5snwhjPp8WUr5b
    M0/1sFJNGpz50NfZznRxw3gNVCfzDH9hcxNN4ZuRetBGc68hpNkjrn6jAuSJ5Gam
    5KK2p/hHdQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=2Oh+25di
    x-bits=2048 x-keytype=rsa x-algorithm=sha256
    x-selector=merlin.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=infradead.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=2Oh+25di
      x-bits=2048 x-keytype=rsa x-algorithm=sha256
      x-selector=merlin.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=infradead.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLh0br7RhAvm03brjSkLqVLldEj1glbovKoj2kZCGqmnhWYExi4h1ECnlLUt+25+Ckx4aI05iJDqB1MGE+Hz93CjTDmomaNbdH/wsL3GYMYfSx6X0liG
    Rh1MgMZuN93Pd4yBTpbI8N6h6a26skPAHWbZFqrgkUnv125RtCqS7mXgV2Koqp5kYON6dRS6fDjQ76u0h02Oj6k2hiwfvnoFUjhXmPlwqveR1XX/QHsaMBLo
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=tMepLWK3MrXP0o1EOUEA:9 a=ISNlsAnQh35qn1Ay:21
    a=A4EsQ4VPg5xe9TC1:21 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965266AbeEJQKC (ORCPT <rfc822;greg@kroah.com>);
        Thu, 10 May 2018 12:10:02 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45236 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965030AbeEJQKB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 10 May 2018 12:10:01 -0400
Subject: Re: [patch v19 1/4] drivers: jtag: Add JTAG core driver
To: Oleksandr Shamray <oleksandrs@mellanox.com>,
        gregkh@linuxfoundation.org, arnd@arndb.de
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        joel@jms.id.au, jiri@resnulli.us, tklauser@distanz.ch,
        linux-serial@vger.kernel.org, vadimp@mellanox.com,
        system-sw-low-level@mellanox.com, robh+dt@kernel.org,
        openocd-devel-owner@lists.sourceforge.net,
        linux-api@vger.kernel.org, davem@davemloft.net, mchehab@kernel.org,
        Jiri Pirko <jiri@mellanox.com>
References: <1525967064-10760-1-git-send-email-oleksandrs@mellanox.com>
 <1525967064-10760-2-git-send-email-oleksandrs@mellanox.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a6ff3a11-3fe5-311e-3097-d6477ed86015@infradead.org>
Date: Thu, 10 May 2018 09:09:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1525967064-10760-2-git-send-email-oleksandrs@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/10/2018 08:44 AM, Oleksandr Shamray wrote:
> Initial patch for JTAG driver
> JTAG class driver provide infrastructure to support hardware/software
> JTAG platform drivers. It provide user layer API interface for flashing
> and debugging external devices which equipped with JTAG interface
> using standard transactions.

> ---
>  Documentation/ioctl/ioctl-number.txt |    2 +
>  MAINTAINERS                          |   10 ++
>  drivers/Kconfig                      |    2 +
>  drivers/Makefile                     |    1 +
>  drivers/jtag/Kconfig                 |   16 ++
>  drivers/jtag/Makefile                |    1 +
>  drivers/jtag/jtag.c                  |  273 ++++++++++++++++++++++++++++++++++
>  include/linux/jtag.h                 |   41 +++++
>  include/uapi/linux/jtag.h            |  105 +++++++++++++
>  9 files changed, 451 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/jtag/Kconfig
>  create mode 100644 drivers/jtag/Makefile
>  create mode 100644 drivers/jtag/jtag.c
>  create mode 100644 include/linux/jtag.h
>  create mode 100644 include/uapi/linux/jtag.h
> 
> diff --git a/drivers/jtag/Kconfig b/drivers/jtag/Kconfig
> new file mode 100644
> index 0000000..5e2c75b
> --- /dev/null
> +++ b/drivers/jtag/Kconfig
> @@ -0,0 +1,16 @@
> +menuconfig JTAG
> +	tristate "JTAG support"
> +	help
> +	  This provides basic core functionality support for jtag class devices

	                                                     JTAG class devices.

> +	  Hardware equipped with JTAG microcontroller which can be built

I'm having problems understanding the line above + first 1/2 of the line below.
Maybe something like:

	  Hardware that is equipped with a JTAG microcontroller can be
	  supported by using this driver's interfaces.

> +	  on top of this drivers. Driver exposes the set of IOCTL to the

	                          This driver exposes a set of IOCTLs to

> +	  user space for:

> +	  SIR (Scan Instruction Register, IEEE 1149.1 Data Register scan);

	                                              ^^^^? Instruction?

> +	  SDR (Scan Data Register, IEEE 1149.1 Instruction Register scan);

	                                       ^^^^^^^^^^^? Data?

> +	  RUNTEST (Forces IEEE 1149.1 bus to a run state for specified
> +	  number of clocks).
> +
> +	  If you want this support, you should say Y here.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called jtag.


-- 
~Randy
