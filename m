Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1199706-1519729212-2-14093480553121471914
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519729211; b=EJ2Q9DPgyAk32TT2kAuFjQpNSW8B0Ome7RsziIIkzoAUofK
    57Im+PYv6g/J7GQJij2VdYG7KwG3LhCfWU8eiyv6NLoSm01EDuN6s3vxCirZTXk5
    UgLXeBV36X/RlKZuqkJmo8Hf0Rn8rkFSY8mxEo3jba8HD7nepXGugWKw92AZc9x1
    yYP2IvmNCQq1Bw5E1tbcB6HobKMaE7JHDbYe8IN+PwsubMjqgTLaOERAvLgJ+Eel
    hFKIIgHenkRVgcZXU6nNaWpcvwHQnvobPLLkJuO0XPqE9xxMhLQgOndcg+qwyryt
    qDIT7yVmE0gvG8xUbuGLKO/dyhZJfC0uVFixssQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:content-type:subject:to:cc
    :from:message-id:date:in-reply-to:content-transfer-encoding
    :references:sender:list-id; s=arctest; t=1519729211; bh=rZvUQkvd
    uzX11wOsyz2H8P4W4kDmeRBb9SmV2DQ+b3Y=; b=tn6Jg19o450EftcBAjMedjsb
    wXrUWbrFPs1JGVmOVRQUbPUsGzqAo0GPPquGSVUZGnQIRg17H2tve5xAry1VoElw
    EtguS2ENTP5Evd7YAUEluuO5luqehrywMiBUBddHwjAz2a6ESgdo+5pBbP9OP3hV
    40WC5IQ1r50BPH/T8TqCKVPMtPBWS5koJa7rJroNXDqGvVtVGiv8JFFwsIDGjDZz
    n9zzXIPMzMdMEwasbK8knOzmfjP+NBp+C57t6j42MyxNrQ7XNXsHzlPms4gLoETb
    uEu5fR2Zm+wyJKwW3pOyarf0ZZrRiZ2UKvpO7Qz9B3klAcF6eV1PdunU0qHJJw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=AbkxZYxZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=AbkxZYxZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752627AbeB0K74 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 05:59:56 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:56364 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752101AbeB0K7w (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 27 Feb 2018 05:59:52 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180227105950euoutp01a743e4738f6cffe99f6df0a1f258d7c4~XKaWD-Sdm0233902339euoutp01M
X-AuditID: cbfec7f5-b5fff700000028a9-e0-5a953a24bd6c
MIME-version: 1.0
Content-type: text/plain; charset="utf-8"; format="flowed"
Subject: Re: inconsistent lock state with usbnet/asix usb ethernet and xhci
To: Oliver Neukum <oneukum@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        'LinuxSamsung SOC' <linux-samsung-soc@vger.kernel.org>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>,
        netdev@vger.kernel.org
Cc: Dean Jenkins <Dean_Jenkins@mentor.com>
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-id: <2d4b8902-1f39-723b-5187-8bacf8dfcea2@samsung.com>
Date: Tue, 27 Feb 2018 11:59:43 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
In-reply-to: <1519727870.18525.4.camel@suse.com>
Content-transfer-encoding: 8bit
Content-language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmleLIzCtJLcpLzFFi42LZduznOV0Vq6lRBivOq1o836hvcXnXHDaL
        Gef3MVksWtbKbHFsgZhF1+OVbA5sHru/NjF6rN9ylcXj8ya5AOYoLpuU1JzMstQifbsErozu
        L0fYCtr5KtqmrmVpYLzM3cXIySEhYCKxbVIvWxcjF4eQwApGia/v7zJBOJ8ZJabOPsICU7Vg
        RhsrRGIZo8Sv9SvBErwCghI/Jt8Ds5kFrCSe/WuFKnrOKLFj3TtWkISwgLfElEmLWUASIgIX
        GSV6GldBdWhJnP16HMxmEzCU6HrbxQYx1U6i48xpJhCbRUBV4vDS+cxdjBwcogIxEq//uIGY
        nAIGEnMX+0JMkZc4eOU51ERxiebWm2CrJAQ2sEk8WrySFaReQsBFYt9PJohnhCVeHd/CDmHL
        SFye3A1V388o8e//SyYIZwajxPqPrVBV1hKHj19khdjAJzFp23RmiKG8Eh1tQhAlHhLH/i9m
        hwg7SjzqzIaEww5GiQ/P/7NMYJSbhRRes5DCaxaSH2Yh+WEBI8sqRvHU0uLc9NRi47zUcr3i
        xNzi0rx0veT83E2MwKRx+t/xrzsY9/1JOsQowMGoxMPrIDMlSog1say4MvcQowQHs5II78rF
        k6OEeFMSK6tSi/Lji0pzUosPMUpzsCiJ88Zp1EUJCaQnlqRmp6YWpBbBZJk4OKUaGDfquej6
        rjjHO+Og1vrLnBNt925qPJGw0d/Lfpqc27WAwG/tevmnTQ9KurqsnTBDbFJXf3ii5OJPB5cf
        MNodfCEuQfQN61EHjeATDhkSj+fozi/obnvD/69pzz+3XIOgnu0m8u1r/h5Kn6Yy+ZeH1+y1
        Tcdn1O1trFize+GqoswvPpU/967irlFiKc5INNRiLipOBADqAciBFgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOLMWRmVeSWpSXmKPExsVy+t/xa7rKVlOjDBouWVg836hvcXnXHDaL
        Gef3MVksWtbKbHFsgZhF1+OVbA5sHru/NjF6rN9ylcXj8ya5AOYoLpuU1JzMstQifbsErozu
        L0fYCtr5KtqmrmVpYLzM3cXIySEhYCKxYEYbaxcjF4eQwBJGiYOTLjKDJHgFBCV+TL7HAmIz
        C5hJfHl5GKroOaPEivXXwBLCAt4SUyYtZgFJiAhcZJRoWXuUCaJDS+Ls1+MsEB27GCU+THwF
        lmATMJToetvFBrHCTqLjzGmwOIuAqsThpfPBVosKxEhM/bgRaB0HB6eAgcTcxb4QM+UlDl55
        DnWRuERz602WCYwCs5AcOwvJsbOQtMxC0rKAkWUVo0hqaXFuem6xkV5xYm5xaV66XnJ+7iZG
        YHBvO/Zzyw7GrnfBhxgFOBiVeHhnyE2JEmJNLCuuzD3EKMHBrCTCu3Lx5Cgh3pTEyqrUovz4
        otKc1OJDjNIcLErivOcNKqOEBNITS1KzU1MLUotgskwcnFINjHWTBD/Mf/RP7bN6iei1uPnz
        Zl85l/NfYTuXyATJ7Ypr31eIFFz93T9xR/R8/R1fXpyzPLSrR8OywGfrBK0N0R2dcRxCH2e+
        fVGrfOP8DkaBjDbFC1sVlUxs5T+7l24ul+k+6Li/tWT25wQR1ZVNRzpK3Z7Ea5k/ipiRKO58
        496Ct3+vXT74+YQSS3FGoqEWc1FxIgCI59umagIAAA==
X-CMS-MailID: 20180227105947eucas1p2c785249633c19b7927b5137932c20bf8
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180227072602eucas1p28dcdba711b3153820bd409d838cc63bd
X-RootMTR: 20180227072602eucas1p28dcdba711b3153820bd409d838cc63bd
References: <CGME20180227072602eucas1p28dcdba711b3153820bd409d838cc63bd@eucas1p2.samsung.com>
        <c15c90ef-ce1b-4dd7-1d9f-673deb01b6d2@samsung.com>
        <1519727870.18525.4.camel@suse.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Oliver,

On 2018-02-27 11:37, Oliver Neukum wrote:
> Am Dienstag, den 27.02.2018, 08:26 +0100 schrieb Marek Szyprowski:
>
>> I've noticed that USBnet/ASIX AX88772B USB driver produces deplock kernel
>> warning ("inconsistent lock state") on Chromebook2 Peach-PIT board. No
> Is that 32 bit?

Yes. ARM 32bit. Exynos5420 SoC (4 x CortexA15 + 4 x CortexA7 big.LITTLE 
CPUs).

>> special activity is needed to reproduce this issue, it happens almost
>> on every boot. ASIX USB ethernet is connected to XHCI USB host controller
>> on that board. Is it a known issue? Frankly I have no idea where to look
> No, it is not known.
>
>> to fix it. The same adapter connected to EHCI ports on other boards based
>> on the same SoC works fine without any warnings.
> Odd.
>
>> And the log with mentioned warning:
>>
>> [   17.768040] ================================
>> [   17.772239] WARNING: inconsistent lock state
>> [   17.776511] 4.16.0-rc3-next-20180227-00007-g876c53a7493c #453 Not tainted
>> [   17.783329] --------------------------------
>> [   17.787580] inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
>> [   17.793607] swapper/0/0 [HC0[0]:SC1[1]:HE1:SE0] takes:
>> [   17.798751]  (&syncp->seq#5){?.-.}, at: [<9b22e5f0>]
>> asix_rx_fixup_internal+0x188/0x288
> Looks like this triggers (in usbnet):
>
>          u64_stats_update_begin(&stats64->syncp);
>          stats64->rx_packets++;
>          stats64->rx_bytes += skb->len;
>          u64_stats_update_end(&stats64->syncp);
>
> That I considered to be called under lock.
> Could you comment this out for testing?

Yes, commenting this out indeed hides the deplock warning.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

