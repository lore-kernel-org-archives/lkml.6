Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08046C5CFC0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 09:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E082088E
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 09:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hQ6ZN4Xt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7E082088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754156AbeFPJlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 05:41:25 -0400
Received: from twosheds.infradead.org ([90.155.92.209]:53494 "EHLO
        twosheds.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754051AbeFPJlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 05:41:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=twosheds.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Cc:To:From:Subject:Date:References:In-Reply-To:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sW8TFt3v4oL5MpDKupuWG3zrdiHU+1FJ8ctK2gEG+GQ=; b=hQ6ZN4Xt5BLqcc7lNfQjMgKpj
        Z3iF0C/TtJ6Hu52iUTUWQUT19hjsIXV2MpZ60ND+qKTOzVA7tn6cz1hfUTfRq9BjmHwo4Dt73bWXS
        usGGpa08nT9O1MidocVgKz81pefIahjLWMtoKp/QtYz5BWYafOzEVIQbn9O56/TddYLVrgt25nDW9
        0oNjl072xUby1AhddJf+zrNu8htxW1ZgbyO9tOjSFuNfLuyBQagcoRrWq26OBcg0d9ntPynkQyzfL
        6Frjnjc/Ay0W0Gkatgq9WgQ9uRIPMBNlO9zkINDqG6pCOtzLF/iiyAyIZOpN3m0MMiqcC4nm/kzTu
        IL0qiT+Sg==;
Received: from localhost ([127.0.0.1] helo=twosheds.infradead.org)
        by twosheds.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fU7hs-0001c7-4m; Sat, 16 Jun 2018 09:41:16 +0000
Received: from 79.78.143.247
        (SquirrelMail authenticated user dwmw2)
        by twosheds.infradead.org with HTTP;
        Sat, 16 Jun 2018 09:41:16 -0000
Message-ID: <6b8e5744a34b1ee7d901feb52b2863c1.squirrel@twosheds.infradead.org>
In-Reply-To: <CAFLxGvz1Hdc5j9a706_ZUQywC0k7S2Lng5zAL=T8UsXP9MYRzA@mail.gmail.com>
References: <CD71A13FD89021478C0F0D323D55243A015AF10A@MX202CL04.corp.emc.com>
    <CAFLxGvz1Hdc5j9a706_ZUQywC0k7S2Lng5zAL=T8UsXP9MYRzA@mail.gmail.com>
Date:   Sat, 16 Jun 2018 09:41:16 -0000
Subject: Re: Recall: PROBLEM: JFFS2 Empty summary info causes OOPS
From:   "David Woodhouse" <dwmw2@infradead.org>
To:     "Richard Weinberger" <richard.weinberger@gmail.com>
Cc:     "Veluthakkal, Sreeram" <sreeram.veluthakkal@emc.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Somarouthu, Murali" <murali.somarouthu@dell.com>
User-Agent: SquirrelMail/1.4.22-21.fc27
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by twosheds.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Fri, Jun 15, 2018 at 9:13 PM, Veluthakkal, Sreeram
> <Sreeram.Veluthakkal@emc.com> wrote:
>> Veluthakkal, Sreeram would like to recall the message, "PROBLEM: JFFS2
>> Empty summary info causes OOPS".
>
> -ENOMSEXCHANGE

Nom sex change? Oh, I see. No, it never works in Exchange either AFAICT.
Only ever serves to draw attention to the "recalled" mail and make more
people read it. Perhaps that was the intent? :)


-- 
dwmw2

