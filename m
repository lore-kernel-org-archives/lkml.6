Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id OqP/CuxZGltFYAAAmS7hNA
	; Fri, 08 Jun 2018 10:29:19 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0B086606FA; Fri,  8 Jun 2018 10:29:19 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lP0rLIQS"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,FROM_EXCESS_BASE64,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 3C914601C3;
	Fri,  8 Jun 2018 10:29:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3C914601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752642AbeFHK3P (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 06:29:15 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:41376 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751056AbeFHK3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 06:29:13 -0400
Received: by mail-wr0-f193.google.com with SMTP id h10-v6so12834106wrq.8;
        Fri, 08 Jun 2018 03:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hsaCPRSQLlbvYO6lVkEgz29il2dP2PzctLQTEntecdk=;
        b=lP0rLIQS++47lKILgjrk0Xpacwgz+7ivTKm0PAE8Yd6HLrgHK1+s44nSN19CezeRHu
         uDHDpYj89ofPUU8Cia5gRmU5UmfoC5RKIXdzteJ5xIfcYCwvA3YCAF/6kx9xyT3w6ZdK
         F+7pZxUUyesIxdM/uZQakueik8wM8sd6/mqbf3GBT95bk1Y4mTtr/CG4UWAnYkbqLBzp
         GRG2JAosHz5PnhDtLioiEj8JSbiDDkUlgSf1yCUMynmz4Y6c5Le5zIuPSQMPXCry+FAE
         JkKFmaTNp6xx4O82o2RZWL4IxwV7Qh9cBkGokKE7pWC+CuWLeDy0FTypfeAj8+jVvHrW
         cUvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hsaCPRSQLlbvYO6lVkEgz29il2dP2PzctLQTEntecdk=;
        b=iXfNWLjF2HbVYLW2I8swfinNnaxoBS/jpK3gV4RPWrigbDItz5t6sMUVAe0C59dI0F
         aXgICSrjVmcRuDMnLMATw1RF76dOHG0XWltZnjQcTsdFw436AQL3P7R1yplOhmfdZvQL
         +OcnhRa44CMW9n9s2B6RIGwq/DvgV4TQ3u4UaJF+DuURJXUzhUL+5w8zMazktSstKo9R
         Gx/GDmuEQKfRDGuSZxLvWFmZwloxd1X6Fl1htHredWkYq0+kkflgKGriA8ln2ZSgHsuP
         GRIzWAg9ZDE1YzICMOcm8RY/8kCIOKykw7jxAxyzuoR266Y17RfElrL9kjAJINdVxV2m
         E61A==
X-Gm-Message-State: APt69E0IEga9z5eD7GBS9teDIwqBrcvqj138WJ27z7ZoYhwGadlbKQKm
        /eIbKsbqOeafKP0get531H8=
X-Google-Smtp-Source: ADUXVKJHMaoDLXWogrPWHcKarVJabLtOmrkMlCYXYHN0sLEzt66vWxy7rHk4zmtPGPQBkJYrPWVGTg==
X-Received: by 2002:adf:d204:: with SMTP id g4-v6mr4568709wri.229.1528453752278;
        Fri, 08 Jun 2018 03:29:12 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id d3-v6sm41616555wri.24.2018.06.08.03.29.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Jun 2018 03:29:11 -0700 (PDT)
Date: Fri, 8 Jun 2018 12:29:10 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        ibm-acpi-devel@lists.sourceforge.net,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ThinkPad T480s & thinkpad_acpi.ko
Message-ID: <20180608102910.24c2l43ffgwxalgq@pali>
References: <20180608081204.ztv4yb62szuyfsz6@pali>
 <CAHp75VfFA6ghuSeAAfcbRS47A12BCcQiAmBt_N5ejm8EsP+3yA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VfFA6ghuSeAAfcbRS47A12BCcQiAmBt_N5ejm8EsP+3yA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 June 2018 12:40:32 Andy Shevchenko wrote:
> On Fri, Jun 8, 2018 at 11:12 AM, Pali Rohár <pali.rohar@gmail.com> wrote:
> > Hi! I just found out that thinkpad_acpi.ko is not automatically loaded
> > on new ThinkPad T480s. Is there any reason for it? Manually calling
> > modprobe thinkpad_acpi is working fine, but I would expect that it
> > should be loaded automatically.
> >
> > Here is dmesg output after loading it manually:
> >
> > thinkpad_acpi: ThinkPad ACPI Extras v0.25
> > thinkpad_acpi: http://ibm-acpi.sf.net/
> > thinkpad_acpi: ThinkPad BIOS N22ET34W (1.11 ), EC unknown
> > thinkpad_acpi: Lenovo ThinkPad T480s, model 20L7S03000
> > thinkpad_acpi: radio switch found; radios are enabled
> > thinkpad_acpi: This ThinkPad has standard ACPI backlight brightness control, supported by the ACPI video driver
> > thinkpad_acpi: Disabling thinkpad-acpi brightness events by default...
> > thinkpad_acpi: rfkill switch tpacpi_bluetooth_sw: radio is unblocked
> > thinkpad_acpi: Standard ACPI backlight interface available, not loading native one
> 
> Did you run depmod -a?
> Is it present in the output?
> 
> There are three ways of enumeration as far as I can see from the driver's code:
> - by short driver name "tpacpi" (not likely our case)
> - by DMI matching (only for old BIOS'es)
> - by ACPI ID
> 
> So, does the ACPI contain one of the listed IDs?
> 
> #define TPACPI_ACPI_IBM_HKEY_HID        "IBM0068"
> #define TPACPI_ACPI_LENOVO_HKEY_HID     "LEN0068"
> #define TPACPI_ACPI_LENOVO_HKEY_V2_HID  "LEN0268"
> ?

DSDT contains only LEN0268. And so I found reason. I'm using Debian
which has only 4.9 kernel and LEN0268 identifier was added in git commit
a3c42a467a254a17236ab817d5c7c6bc054e4f84 for 4.10.

-- 
Pali Rohár
pali.rohar@gmail.com
