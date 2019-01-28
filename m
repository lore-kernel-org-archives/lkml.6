Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8D6C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2AAA20879
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="QkwceJg2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389921AbfA1Qph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:45:37 -0500
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25306 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389463AbfA1Qpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:45:32 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1548693911; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=LuxZqiAhTmrEGYf100dkixk9HR9OLtx3zxJFF8Mes8uIiFheGfzaavoIf1ef+Ou1+XNGPXxWgAOoM4NMjpLP+z1R5xxZfCPYaubNCoPcOej7iUKp07epDoYjBzhfHDmGkG7bn8UZHjkHq968wa8FYpnYMq62L7+a19zZKe0R4nY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1548693911; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=/ocmoCVAUwgmUREFsy+ld0mubWacyF6BNsUB4nzEnmM=; 
        b=PaYDgHQg03751fxq+BzUdH3Rptrp4MXFeziU4giLy0wboiFdEm1NvaO8IjsE8azPLGHsHJpd6QMxYqqmJyi/CCnJv+K17x2jOtqbrk9G7/dFWDkZt6xNNcfsSUnzKc7SmYXPZH38R1hSUmBb6EWDxNBVoCkhnMSjkdQh8cMOlIY=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=subject:to:references:cc:from:message-id:date:user-agent:mime-version:in-reply-to:content-type; 
  b=a++7rL1uovTb5js/K0Vwmq202gyHEmGuXNbVbFeNAN1AJYqTum1+f4gZ2zkYL7ZmU0Pgq2eMV9/f
    aSdk2DyxYhMuj/hd/dS0ZRvw3dmiN3XUihTmdfmlJoxnrUQO/oyQ  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1548693911;
        s=default; d=zoho.com; i=zhouyanjie@zoho.com;
        h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        l=501; bh=/ocmoCVAUwgmUREFsy+ld0mubWacyF6BNsUB4nzEnmM=;
        b=QkwceJg2FNzhMKqiRe39Tk3If49ThFr4cKHl29IqkzHx329ZvhNq4Lsw6ZJDLV4/
        G8qyGwW1LZkg+XnMu74hAZseH20FKIML+NCUGHlULX+5rG/UHsVFpg40BshZ3PNeCh/
        HhprqXdPx5WcMw0/mOotpa7S9vOS3oACQ+7I++34=
Received: from [192.168.88.133] (171.221.112.7 [171.221.112.7]) by mx.zohomail.com
        with SMTPS id 1548693909299708.5010229795901; Mon, 28 Jan 2019 08:45:09 -0800 (PST)
Subject: Re: [PATCH v2 1/2] Serial: Ingenic: Add X1000 suppor for the UART
 driver.
To:     Greg KH <gregkh@linuxfoundation.org>
References: <1548667176-119830-1-git-send-email-zhouyanjie@zoho.com>
 <1548683821-120924-1-git-send-email-zhouyanjie@zoho.com>
 <1548683821-120924-2-git-send-email-zhouyanjie@zoho.com>
 <20190128162245.GA25853@kroah.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, paul.burton@mips.com, jslaby@suse.com,
        mark.rutland@arm.com, syq@debian.org, jiaxun.yang@flygoat.com,
        772753199@qq.com
From:   Zhou Yanjie <zhouyanjie@zoho.com>
Message-ID: <5C4F318C.20505@zoho.com>
Date:   Tue, 29 Jan 2019 00:45:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
In-Reply-To: <20190128162245.GA25853@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am very sorry, I understood wrong before.

On 2019=E5=B9=B401=E6=9C=8829=E6=97=A5 00:22, Greg KH wrote:
> On Mon, Jan 28, 2019 at 09:57:00PM +0800, Zhou Yanjie wrote:
>> Add support for probing the 8250_ingenic driver on the
>> X1000 Soc from Ingenic.
>>
>> Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
>> ---
>>   drivers/tty/serial/8250/8250_ingenic.c | 13 +++++++++----
>>   1 file changed, 9 insertions(+), 4 deletions(-)
> Your subject lines are still identical for both patches :(



