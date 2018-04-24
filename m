Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3372557-1524590365-2-16026495010783692578
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: cc='iso-8859-1', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524590364; b=ukVwdJ2kHcbhtxpscL4ygtRpyWIegkvhK3snJbRTRHTYDeeGVp
    k6DJ92P+SJ0jY4LGchIZ0awMWq9pmXrdHXU7GKPhgqUIjt0cnjmKuoEGXzFdwMBY
    OE7020TkN3XU86px3XMPa0gfos3wAE4RUzYsw1Dt+9zPJKunX4s0ihma+NhHQkoy
    uobiKiTkdTsUW8DVSI0qydjW6YvfAQBEwVFVDA0Cy8Ae1CpqMyrGnekyibo62q+V
    /PEIuRxiHUYU5ADBdZ8BCseAnrFgtWwBuoNnYuV5I7c8DHTMytYkWKZ8+VFgDgws
    caYFQPLVjBT+dGU8v2amDksysifjWTxNpuTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524590364; bh=7CTD8k2IwXD0T2UwK0BYYW4Q7N8/ns
    6XY9oORsae0JM=; b=U0RkyeZiAhIPx3CqhcNoQbPuz1z5BvEisjNyywwgesuuE+
    DrJI8Mds8WFIikYtJGeOhq3KLmMLnM88T4GrKrwHptDmKuC69sSW3QO5Gpwq4zPJ
    lywOzC9pV1y4Myk9m0uZkXHYq0f6yZ3mrtBBPLNXLxKcCq33TEdKabQcTezaz6TS
    uN5uj3XR8UUZvreJU+iIdoP2PPh4C00oYS7D0aNi2BpF7srjR2QX6kOdFJQx8glt
    z8vX6GzTwcU3hkYlK+r/9ch2DjqvoGoXqcg/XgPb9yJOrP8SJvb486TgMW2YRCAO
    RB6Un2e3T0JxhTy374G6IJOnVuXiPLuBLwf3AzmQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=gFRcxefD x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=oGFsz02+;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=gFRcxefD x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=oGFsz02+;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKb2Ft+AXKVgVmXbTYInG0/CuyfOQrN6WmcWQK/8SvOHDwpxzyNwA4jZPFSax83EqAGrkoLzlzHOmQkW0MQYeO66inW8GXUnekAb+r1TrFDSWnA9of6C
    sYEj2V2wG/zVo07pzdVsz0wWq7k6OC+D+bdWkEF0deZsWBHKkOXLKGT/pqkqpDd3Qd5p9mJHb7XYxSNr14oOUG76qFnc++R7rL+nF/X82nbJP0ySR0DloGS6
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=syGPXMiOTXFeQ0QcprIA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751995AbeDXRS6 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 24 Apr 2018 13:18:58 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:39497 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751698AbeDXRSy (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 24 Apr 2018 13:18:54 -0400
X-Google-Smtp-Source: AB8JxZq5zPu2kqmpZKlWXB5GWXwpYFWbDTpyDLWGvMu6fQlTN7kOCo2oPGzs2r6lbyUFijxaIMszKw==
Date: Tue, 24 Apr 2018 19:18:46 +0200
From: Johan Hovold <johan@kernel.org>
To: Shrirang Bagul <shrirang.bagul@canonical.com>
Cc: johan@kernel.org, linux-serial@vger.kernel.org,
        gregkh@linuxfoundation.org, Rob Herring <robh@kernel.org>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis
        <frederic.danis.oss@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 0/1] serdev: Support HS-UART serdev slaves over tty
Message-ID: <20180424171846.GD4615@localhost>
References: <20180424082954.11453-1-shrirang.bagul@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424082954.11453-1-shrirang.bagul@canonical.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

[ Adding some more people on CC. ]

On Tue, Apr 24, 2018 at 04:29:53PM +0800, Shrirang Bagul wrote:
> On systems using Intel Atom (Baytrail-I) SoC's, slave devices connected on
> HSUART1/2 ports are described by the ACPI BIOS as virtual hardware using
> HID's INT3511/INT3512 [1].
> 
> As a consequence, HW manufacturers have complete freedom to install any
> devices on-board as long as they can be accessed over serial tty
> interface. Once such device is Dell Edge 3002 IoT Gateway which sports
> ZigBee & GPS devices on the HS-UART ports 1 & 2 respectively.
> 
> In kernels before the introduction of 'Serial Device Bus (serdev)'
> subsystem, these devices were accessible using /dev/ttySx nodes. But,
> kernels since 4.15 can no longer do so.
> 
> Post 4.15, with CONFIG_SERIAL_DEV_BUS=y, serdev port controller driver
> handles the enumeration for the slaves connected on these ports. Also,
> /dev/ttySx device nodes for these ports are no longer exposed to the
> userspace.
> 
> This patch implements a new driver which binds to the ACPI serdev slaves
> enumerated by the serdev port controller and exposes /dev/ttyHSx device
> nodes which the userspace applications can use. Otherwise, upgrades to 4.15
> or higher kernels would certainly render these devices unusable.
> 
> Considering serdev is new and evolving, this is one approach to solving
> the problem at hand. An obvious drawback is the change in the tty device
> node name from ttySx => ttyHSx, which means userspace applications have to
> be modified (I know that this is strongly discouraged). For the same
> reason, I am submitting these patches as RFC.
> 
> If there are other/better ways of solving this or improving on the
> proposed solution, that will be most helpful.

Yeah, I don't think this is the right solution to this problem. It seems
we need to blacklist (or maybe even use whitelists) ACPI-ids until there
are drivers for the slave devices that would otherwise be claimed by
serdev.

> This patch is based on:
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git v4.17-rc2
> 
> [1] Enabling Multi-COM Port for Microsoft Windows OS 8.1 & 10 / IoT Core [Sec. 4.1]
> (https://www.intel.com/content/dam/www/public/us/en/documents/white-papers/enabling-multi-com-port-white-paper.pdf)

Thanks,
Johan
