Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2505978-1525350805-2-7274203604236824536
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES daen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: to='UTF-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525350804; b=LGU1kQm/vTNbexjSofwV8EGO66dZmgXT72xN8u4b4U8OV6ZPMi
    49pL6lBMOkwbpSO/HeUfsqBZoRWcvoGsiwUj3NWk4PBSOwDbJ+Vr77PEriUy6o6a
    kAUU3851DFBcheb0zg0DPEGbMTS+hY2OSdpsbCJF1vuNJC97ymzPgOa59dlEdcQs
    cSWxSBJYI8HPzMxKlONmk402pAQSKmMXgIuXT1TJ6JOeC7h4d7DiE2T1ZkZE6OTA
    XNGOl/df2Wd5YuWMJUfnZurGPPzVBD6MIc8F0h343FVdPe9f/DXwwNk4HJtCizGf
    yTMpG8ve5lP9GHRvtlx2sfsogkJ+yv9fGYww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525350804;
    bh=pUjpxdYLAnjpDLKhK/PC0cBQSj29Uqo0JSzQTOth+5c=; b=b2dsZC4ZOdfT
    gL6LlNuZG/HJNnMUpmmadGcYEqiGFCBpa2vg8xbHUN2AXPi/TLET/ZoRDxBNXclN
    U3hHoE2D63Sq33Aol6cgQ12q/eI9MR+05jZjOF2zvHaHjCd3JKVYQb9x4daezLxt
    1g9buHUgC4GihXCva1MAK2Xwl4zfuju0E+a1llVc3xeh78CC9MC2jCofpXZHVw/A
    1W/Avsi1h9qe0jJvBPdw7NllEkCGkLKnk+5Wi4+FyFDHwVdiaTunEGvxQsQCuPT6
    U+rPt6xZLfgrVxRTlfTib3Fe3uAgUPhgQWCQjHMuuQellmohugSVipSgOA7YYcid
    MAhmGpAAIA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAi2BHDH+u2Wh8dIsopd1Z48iPKU7aOxCi9/b7hNb64/glwZcD8dUBOqYOg0bM3otJJv2G6mMONwEfR9mcyEUDdgJW07bjC4vCtaEzIkU3y+pZnBuTcc
    IDrqEYCZqzGY+gYDGs+mn90xTowibUq34fmmD1KLrPiYHhE8jz+C0dBv/o6T178bbc0zC7bE8/ENx2IgDcUYrFCXmi5rW/pIumj1dq61p85R7QOfS6bUnDEA
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=HuG4dGyOer_NdDDEMvYA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751781AbeECMdO (ORCPT <rfc822;greg@kroah.com>);
        Thu, 3 May 2018 08:33:14 -0400
Received: from foss.arm.com ([217.140.101.70]:40864 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751532AbeECMdN (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 3 May 2018 08:33:13 -0400
Subject: Re: [PATCH] tty: implement a rx led trigger
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-serial@vger.kernel.org
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
References: <20180503100448.1350-1-u.kleine-koenig@pengutronix.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <0c1bb915-bd92-4433-61ec-78fdba453396@arm.com>
Date: Thu, 3 May 2018 13:33:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180503100448.1350-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/05/18 11:04, Uwe Kleine-König wrote:
[...]
> @@ -157,6 +158,18 @@ struct device *tty_port_register_device_attr_serdev(struct tty_port *port,
>   
>   	tty_port_link_device(port, driver, index);
>   
> +	port->led_trigger_rx_name = kasprintf(GFP_KERNEL, "%s%d-rx",
> +					      driver->name, index);
> +	if (!port->led_trigger_rx_name) {
> +		pr_err("Failed to allocate trigger name for %s%d\n",
> +		       driver->name, index);
> +		goto skip_trigger;

Hmm, isn't that a rather awkward way to spell "else"? ;)

Robin.

> +	}
> +
> +	led_trigger_register_simple(port->led_trigger_rx_name,
> +				    &port->led_trigger_rx);
> +
> +skip_trigger:
>   	dev = serdev_tty_port_register(port, device, driver, index);
>   	if (PTR_ERR(dev) != -ENODEV) {
>   		/* Skip creating cdev if we registered a serdev device */
