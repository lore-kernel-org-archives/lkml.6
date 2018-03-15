Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4136612-1521108027-2-13467117892791173657
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, DCC_CHECK 1.1, FSL_BULK_SIG 1.316,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521108027; b=TbT5Jify8r6UXj5Cqn7W0ecRSt7H7HrafxSJ/zJwlEQ8kVG
    7azGi5Tl5BPCFrh+8LqCevGudT7aMXGqgAyhdl3aukFI3TbhYjJK2BN5uJfVWGDz
    VkpiTTg7uqmAgpCuJPNBpd7JiYoEmIuUTwq2oF1p8Sns5Ir7lSUOkl0uQqN9SPej
    OPfW4h5ue/zd5mI1bS1HovBu0W/u6TZrB/Fb1YBdgiOI3mGtj1UQsfnlMDvXj2rk
    jIWHaLRwN5EAtnH0lLnOAS+qekDjHopFnse11oZQeO5VZuA4caIGVKbi8sVzLD0x
    7iPSi0IeX7RGpsypR1fWF9cwR+OXbnUN+g/ehzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521108027; bh=ttg5mjh87cBMRzRUwDm+q/eyoTBOZYoVimbf9RbVJHA=; b=I
    8B9kb6OtFTZBStW9/+JxdqgX/WmcOizX01euvXzjTr3pyw5mUb9dA7BejC8CJPPT
    oABJse/br3TLI0rLWZWaBBLA3K5LD99pwytVK/QwbpICX04i+eqGdogguO2omlWX
    V8goPbSjReIgJE7bwxCGRhIRn8UdTKkOGAsq/al1jEZje+igam8JcUqbS6XWimUl
    jYX3xoWZ+8TbmY6nwWb8uXj+hZxlUJw8yNHSomwsYc2IcpVI2epJMvdl0Jhbdp3L
    F72kiBi2Hzm84EfXJaSkzrsO/mOyhj6dnNK3I7sOSpw7gZzTh1oCwtwRS2imzntI
    2ojXYMbaJch27DAzAfebA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751805AbeCOKAH (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Mar 2018 06:00:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:51044 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751512AbeCOKAD (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Thu, 15 Mar 2018 06:00:03 -0400
Subject: Re: [PATCH 00/16] remove eight obsolete architectures
To: David Howells <dhowells@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-input@vger.kernel.org,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-usb@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
References: <20180314143529.1456168-1-arnd@arndb.de>
 <2929.1521106970@warthog.procyon.org.uk>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <6c9d075c-d7a8-72a5-9b2d-af1feaa06c6c@suse.de>
Date: Thu, 15 Mar 2018 10:59:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <2929.1521106970@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/15/2018 10:42 AM, David Howells wrote:
> Do we have anything left that still implements NOMMU?
> 
RISC-V ?
(evil grin :-)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
