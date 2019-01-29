Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF0CC282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 03:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B6B22175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 03:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="N6u0mCrU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfA2DzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 22:55:21 -0500
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25442 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfA2DzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 22:55:21 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1548734064; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=QEpU8bWFph62kKfCnXn+eSk+M9BeluF2LshOymLaLXXQ1F4rFcMQP3rAxVSRzvStkb7ZK9WxKDFr5/x6SbWPA6/QHcUAc3HSM0HldO/WCyhxTa+OK4c//OYwyAbB2UTrdvdEKF3NmN1QbhtEX+5NZhQOvYC/BYIHLO3Q9txmYZo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1548734064; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=U5yoyaHBVp2qbYHG+RBH/l0ZLYlkJKTGzAq1KmxoWTs=; 
        b=DQEL3K953TMDtjatGIgIX9ZbfgByyLC8MBg0gfHzMmvblTEkBY01hpP76N2l8Jgaezq3SX4svvo3ltQ2WQiJxLBOZsZ8np0XlZqfX/tWUdcDq3JvFb+mdel6K2OmjQKlNZl3BERIS1lHq3MupmlkiWobP7YT8gl0pNBPKpZ20sY=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=subject:to:references:cc:from:message-id:date:user-agent:mime-version:in-reply-to:content-type; 
  b=DANO3d4v8bwBfvgvN2ER3+uZOjqRsNIrI0tKlZQTcwduFyg/AqOnaW0ZM+NQkw+U6sDfexDBuZBA
    ctClt0Z46FVXrRq1ATECXKx/umTnPa0imy1FZ4soPCjE0opWOhvF  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1548734064;
        s=default; d=zoho.com; i=zhouyanjie@zoho.com;
        h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        l=803; bh=U5yoyaHBVp2qbYHG+RBH/l0ZLYlkJKTGzAq1KmxoWTs=;
        b=N6u0mCrUUL5v14i1FoUh853NYqycFuJ2psnhLHs/wLhJ/SCrKOuAXhMbWOOg02RO
        83nCi4sfgcKvF8bmWSACZ+FG3BKnhhPOkuYKqEUvSQ7c0NC5OJbfXVYCHk67DP87d3T
        aH/8O6OWrHKbhZ7tNN6u7LK74jp3Tns+9u+Peqps=
Received: from [192.168.88.133] (171.221.112.7 [171.221.112.7]) by mx.zohomail.com
        with SMTPS id 1548734062028920.2554336423026; Mon, 28 Jan 2019 19:54:22 -0800 (PST)
Subject: Re: Add Ingenic X1000 RTC support.
To:     Paul Cercueil <paul@crapouillou.net>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
References: <1548696599-53639-1-git-send-email-zhouyanjie@zoho.com>
 <20190128201014.GB18309@piout.net> <1548708484.7511.3@crapouillou.net>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, a.zummo@towertech.it,
        robh+dt@kernel.org, paul.burton@mips.com, mark.rutland@arm.com,
        syq@debian.org, jiaxun.yang@flygoat.com, 772753199@qq.com
From:   Zhou Yanjie <zhouyanjie@zoho.com>
Message-ID: <5C4FCE52.2040001@zoho.com>
Date:   Tue, 29 Jan 2019 11:53:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
In-Reply-To: <1548708484.7511.3@crapouillou.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OK, thanks for your suggestions. I'll drop this patch.

On 2019=E5=B9=B401=E6=9C=8829=E6=97=A5 04:48, Paul Cercueil wrote:
> Hi,
>
>> Hello,
>>
>> This seems like a useless renaming to me, can you elaborate a bit more?
>>
>> I'd also like to have Paul and Lars-Peter comment.
>
> According to the patchset, the RTC in the X1000 does not behave any=20
> different
> than the one in the JZ4780 SoC. Therefore patches 1/2 should be dropped.
> In your devicetree bindings, just use the "ingenic,jz4780-rtc" compatible
> string instead. The same goes for all the drivers (e.g. the uart one).
>
> I don't really mind the renaming, maybe replace "Ingenic JZ47xx SoCs"=20
> with
> just "Ingenic SoCs" since XBurst is just the name of the CPU inside these
> SoCs.
>
> Regards,
> -Paul
>



