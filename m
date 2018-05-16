Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-886641-1526503915-2-772741062660279094
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526503914; b=HiNdH7dCxZZadZ6NVt7IQIX720aiKGHEc7NTe43ElbQoe8K4zB
    Qsr4j3J4sjunVBSQjvGf3+HAK4b+axY+Wuh83Jo6SYTd6jUdqZXSxP/gYnpujVbe
    hutFvnhX2rMr1XzvoyZGm/C0X91B7xXEQlMkBMP/MXE9ewFD97i63umUmo9HAVvS
    7SYszKv1lBiRHTfRSmrSg6OGQrqDRa0dGJHhKceB9Bioi0CNV6hjU9bN0vSxTJRi
    c6t155or7tTvmjVBdMqtIUSR6DxM/cbG3Szrfg+lhzkPxI+9zepw4TBzGSDwIXZK
    06bZB/z8TJ82PSGjCxjjkKwOQtu2S7U/o5Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526503914;
    bh=tzN6wLySpiVeoVnxOVpmj9FkyYgWEi8hw/29G00NfQg=; b=KlkfCdINQ6JA
    RD7TSI7XQkD+V/C67SYIWPDvjKzoIJqQf8vP2m/vZkm0bT7Dm+7scRdpV98sI5+1
    w64bIaRICD/L27WN4aWUn7zkzN0S1Lq8JStEC8iCeKxImLKpZeo9l4RUHrelFpE/
    LQVoB592v50VscjkXLVA4cRIJq5TUvdX8E5UaRwCfGVtlsylY2RBX9K+3NFym4/3
    BLjyLceaqgq2wccQThjlLBO9f3TLZXqX/lnI8/OmldfG21WRxqKHfvbh7BmOnKOU
    qnFmnUWqBQf8+yNesokfa+D27x8IFur9ERbBd62MKmvPCQCtgOnzS8MOyYWAnFXA
    b35VO0cC9A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=codethink.co.uk header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=codethink.co.uk header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOAAmPISr65I+biCUuz4x7GpCvPbu1xfp8tZqXbrirCDUW4OnNTmUpqRCKpguKO/R2kYnUZaQr2MfHRb3lnXEgEDSLZ1X203qrCnxmoCFkVCKv5y+XxN
    ya8POxO5gLGbqfjo25LZLrPZsDA5vrdar+EZG0ddZoLQZWjOrcVlsQaridcOWPqT0NGFXGssMua0lxgprTlh6Crjo1HBZsdjd6adDbvtvf5uLoq71plUiGPY
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=rTDo_5_6WMYnJkmuBBkA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751379AbeEPUvw (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 16:51:52 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:51429 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751370AbeEPUvv (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 16 May 2018 16:51:51 -0400
Message-ID: <1526503907.9159.150.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 53/97] ALSA: pcm: Fix UAF at PCM release via PCM
 timer access
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
        syzbot+8e62ff4e07aa2ce87826@syzkaller.appspotmail.com,
        Takashi Iwai <tiwai@suse.de>
Date: Wed, 16 May 2018 21:51:47 +0100
In-Reply-To: <20180422135308.244077643@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
         <20180422135308.244077643@linuxfoundation.org>
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

On Sun, 2018-04-22 at 15:53 +0200, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Takashi Iwai <tiwai@suse.de>
> 
> commit a820ccbe21e8ce8e86c39cd1d3bc8c7d1cbb949b upstream.
>
> The PCM runtime object is created and freed dynamically at PCM stream
> open / close time.  This is tracked via substream->runtime, and it's
> cleared at snd_pcm_detach_substream().
> 
> The runtime object assignment is protected by PCM open_mutex, so for
> all PCM operations, it's safely handled.  However, each PCM substream
> provides also an ALSA timer interface, and user-space can access to
> this while closing a PCM substream.  This may eventually lead to a
> UAF, as snd_pcm_timer_resolution() tries to access the runtime while
> clearing it in other side.
> 
> Fortunately, it's the only concurrent access from the PCM timer, and
> it merely reads runtime->timer_resolution field.  So, we can avoid the
> race by reordering kfree() and wrapping the substream->runtime
> clearance with the corresponding timer lock.
[...]

This seems to depend on:

commit f65e0d299807d8a11812845c972493c3f9a18e10
Author: Takashi Iwai <tiwai@suse.de>
Date:   Wed Feb 10 12:47:03 2016 +0100

    ALSA: timer: Call notifier in the same spinlock

(But I'm not totally convinced that snd_pcm_timer_resolution() is
always called with the timer lock held, even after that.)

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
