Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1356C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82DA920881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="g41TqVRc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfA1MpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 07:45:18 -0500
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25470 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfA1MpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 07:45:17 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1548679499; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=mxMCHgiBUD3CFSKRiYarXulIpnALi2Mrl3lIlhbU8DIxYQl48Iy9sHW25GNV0+7XVPkk3C7SqRJz1s0ZF3VcJ5P/n5Lp0hrA8jhoguoReL8YNxlxtc5sLeqeebHlR7Wu/IL+uSo8NW/EaDokHgMczmYmnuerDEo2+DqLOKfHNi0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1548679499; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=jqagdYoi8HFI5pRQmQKCDU+btcu8oXjva4wy+bETBqc=; 
        b=JFZmXDeyiNEnI9H8TlPNTUkZYeAnMEueF89Rm8iRTcTgNJ6TWl66dgJJCKICV8yIzvdnbKx93LRuucT3nga32v7CGuzh6B7SRmkB/DaggtBRUT7Sr/E2130gi7rlr/bEqzioPjmeE7gl8GX1vs9LzSSegWxU5Yp8W88aFdj/7Io=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=subject:to:references:cc:from:message-id:date:user-agent:mime-version:in-reply-to:content-type; 
  b=cGU8Tn95s/QyqfPKPYwzom6WMniccEIbVF/NpJnnCV8/qD27bv0h7j87L4FL5k+duxkpE/A8HjSS
    NzrP608Vdog8kR8C/OEJskdPiZ3mp1Lq0b01ovouUlLPsARY7LgV  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1548679499;
        s=default; d=zoho.com; i=zhouyanjie@zoho.com;
        h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        l=617; bh=jqagdYoi8HFI5pRQmQKCDU+btcu8oXjva4wy+bETBqc=;
        b=g41TqVRctb+dw5ICkeLKe3wo38a20gneG/uOdZefajiUirafeJFpc/Yl64hwk1HT
        4CWjS2CTFPxNipY6nIuttXEa9c5Ih4HRZVx42X919GwnyCAtRfu9PXMaq10MYFd0vJg
        lRqBNxiHoKkfdF55YCoevRybdYr2+DtD+dsvoiDA=
Received: from [192.168.88.133] (171.221.112.7 [171.221.112.7]) by mx.zohomail.com
        with SMTPS id 1548679496087827.6429985122878; Mon, 28 Jan 2019 04:44:56 -0800 (PST)
Subject: Re: [PATCH 1/2] Serial: Ingenic: Add support for the X1000.
To:     Greg KH <gregkh@linuxfoundation.org>
References: <1548667176-119830-1-git-send-email-zhouyanjie@zoho.com>
 <1548667176-119830-2-git-send-email-zhouyanjie@zoho.com>
 <20190128093059.GA31657@kroah.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, paul.burton@mips.com, jslaby@suse.com,
        mark.rutland@arm.com, syq@debian.org, jiaxun.yang@flygoat.com,
        772753199@qq.com
From:   Zhou Yanjie <zhouyanjie@zoho.com>
Message-ID: <5C4EF93F.9080706@zoho.com>
Date:   Mon, 28 Jan 2019 20:44:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
In-Reply-To: <20190128093059.GA31657@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My fault, I will fix these in v2.

On 2019=E5=B9=B401=E6=9C=8828=E6=97=A5 17:30, Greg KH wrote:
> On Mon, Jan 28, 2019 at 05:19:35PM +0800, Zhou Yanjie wrote:
>> Add support for probing the 8250_ingenic driver on the
>> X1000 Soc from Ingenic.
>>
>> Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
>> ---
>>   drivers/tty/serial/8250/8250_ingenic.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
> You sent two different patches with the same subject: line, yet they did
> totally different things.
>
> Please fix this up and resend with a better set of subject lines.
>
> thanks,
>
> greg k-h



