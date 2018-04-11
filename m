Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2164128-1523445970-2-16476552111822319918
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, BODY_URI_ONLY 0.999, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523445969; b=ELP/a8h50Lu6ZUu3DpASIQj+bOpgrOE6T9E+HkTKTxLA7vIXID
    a/sSTVFfj5vG8PcA2IR8TqOtzwTBFy+NSvB1D/Ru5lbOHjEkj9TvwgbE+7x3KrvD
    SeHxO5wAQ3eWvTmhOcPjX2PRCYaF9dNziaRHtbMjoQs8P7PvRWljZBYW2i62/UYz
    NIjrW4TLyvkAZHv6LxbjVblovjGG1OV2tCNeCnet+ZhZUktMzTAXqReFK6g2nM0q
    xH5VgS7FbHdCxqSvnHfmTkKUE1DKNqBqNWT1OgTARR5SK6AtvFi6D6YrZ8BjJKrB
    cc7wEf3Jbcx5+L+HpCYg6dtANbYRmBfsQ4ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523445969;
    bh=mqfx/5M6vXeL1agyLut80nNN+rvr9qv6NogkqSw7l7Q=; b=ATme7r6IbBii
    H5S7dV3Rpi6a4ohTYVbT0Nf1IIFXS+yWldEblaGmuml1V7hrQbSMb57XML/rU9KG
    VK1goXijcfIiQ7xLy5g1NI4JAXKt2HVZb+WeX9GSTrDVptD+t88o0ea0pNjbyauY
    14RVrfyhuZhRUy7UhEc9zgfXEW7ohQCDvg6013nAg8aXQ8orEBahrbwO8uQgIEKK
    kLLO7BAICCYl3UKFRnB2MgzT8nG0O8gfK9RVrfVFsHHWzW5EOkKM/LtpIdmxodiD
    pa0ImMCqkI698RGg78NBXR9AFe+oVi4KrQdntWO0vXq7wuF7IVoUnlydZ2h5Mz5U
    zs6G5oy6Qg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKM6cKcngP258xiN9uIyYqDlBszrs/EMnIeJ987LOPI567XOamsnlSs2xm6H3jFVS3djLC1SGI4h8/bKhkDkS0bV3zgLtcMYEFQMN7nQFxEySZqcBPw5
    ZhQujGfVEYMa9S9xH045Q2APZE54+EPXSMHbf/tzOb/cEKhpvPH/gNY01ANB6Q360GCzdrhkb7XM8T6puKgeE8ktgafZv3YSpaYdW/E9SSnos1Odpx9fssCk
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=iox4zFpeAAAA:8 a=VwQbUJbxAAAA:8 a=FIlfo_QvmHo_qnBzRT0A:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=WzC6qhA0u3u7Ye7llzcV:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751961AbeDKLZu (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 07:25:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:42643 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751797AbeDKLZt (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 11 Apr 2018 07:25:49 -0400
Message-ID: <1523445938.22084.3.camel@suse.com>
Subject: Re: [PATCH] cdc_ether: flag the Cinterion AHS8 modem by gemalto as
 WWAN
From: Oliver Neukum <oneukum@suse.com>
To: Bassem Boubaker <bassem.boubaker@actia.fr>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org
Date: Wed, 11 Apr 2018 13:25:38 +0200
In-Reply-To: <1523445353-7631-1-git-send-email-bassem.boubaker@actia.fr>
References: <1523445353-7631-1-git-send-email-bassem.boubaker@actia.fr>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Am Mittwoch, den 11.04.2018, 13:15 +0200 schrieb Bassem Boubaker:
>     The Cinterion AHS8 is a 3G device with one embedded WWAN interface
>     using cdc_ether as a driver.
> 
>     The modem is  controlled via AT commands through the exposed TTYs.
> 
>     AT+CGDCONT write command can be used to activate or deactivate a WWAN
>     connection for a PDP context defined with the same command. UE supports
>     one WWAN adapter.
> 
> Signed-off-by: Bassem Boubaker <bassem.boubaker@actia.fr>
Acked-by: Oliver Neukum <oneukum@suse.com>
