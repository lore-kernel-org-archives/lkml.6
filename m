Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE36C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 20:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D96AA20831
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 20:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAsQzxPw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D96AA20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbeKCFXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 01:23:53 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:35782 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbeKCFXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 01:23:52 -0400
Received: by mail-wm1-f52.google.com with SMTP id q12-v6so2881079wmq.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 13:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5R9Jc4VWn3gOQrRUye0Ljr/Cq0J69o0fBh6f7UCwJoQ=;
        b=YAsQzxPwFY8sI2fWeHLHRWIio7AL77hivqCiUSMYjZ4I39xjZv/JOrcolMQ0ZjnydO
         ehU6w98C0BGIlWyVeb+LePv+epXZHqSWAe4nN6P+qCEUOSpwyTA0y6QwJC9pAQ99aV+a
         UWf2wCcYEgX5Te3FhySKLs5lBVeBj+mN12rgX6DlZruiES/dhryRlO1EMBmE/BU/6RY4
         0PpJmmjmkW/+V5dbTkqAGKsy1a7NIfArQHwP2yEnkApT+Z3/jj8iRkBXfrzK+rVPWMc8
         YDnH2ffjgsuqgc/+NheAtXbrAVlnI110AQq+c/kiR1Xl1rh7c18A6IZhFonDPLfq2NSZ
         fitQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5R9Jc4VWn3gOQrRUye0Ljr/Cq0J69o0fBh6f7UCwJoQ=;
        b=QUOP+EsTjqAVOHhAG2HWYBtTtm9GlZ4xVXxAz8h4fGbD0UiQkyZdliczixPlD4jxi5
         9WcPL87mn7/0/rv8g0rBvyOmQeYDfZFqdmTxZMeBMZ50mm7TFv1dfjfInm9Hvje8PUNT
         deC0S1Jyr8V4Y5Fe9kNb29MZ6UE8oXYInvOirZk2GYHG3kOPkMySYL8m4kXZ1TyiBuIt
         4KXc3Ud9Ht4GhVt03WkT55/aOJom4PbL2EX1TYf30pOWCkj/CxiH2rRTIcw0+QmK7lPe
         C0nuY5mk5DV+p4nPktdhMeUJ9AjYfLENrd5c5OjQp5i+ABYdcxZE9c4VxWHAhMJujpy6
         EhTw==
X-Gm-Message-State: AGRZ1gJC6AS7tZj6btcloTbQ/4/LFM5uHA8VLDhxXnlcMAv+qSbYZ1eu
        Oep3CABJ3zRdmoHktTZr9zhIeUjgIoKETU5YiAM=
X-Google-Smtp-Source: AJdET5fS5r2MD39KNuJJc8rE7kvVsa0rsnnFCAW5A2EPqif3PzdDnAEoJaLmzHUJuCJW3l7DbfrV+X+uNyzzpr4g39w=
X-Received: by 2002:a1c:c502:: with SMTP id v2-v6mr55900wmf.17.1541189718298;
 Fri, 02 Nov 2018 13:15:18 -0700 (PDT)
MIME-Version: 1.0
References: <20181101225603.17806-1-nkela@cisco.com> <20181102000236.rqho7txtb7gv543t@zorba>
 <20181102003434.GW32577@ZenIV.linux.org.uk> <20181102140420.jiuhcsrahoeqe5vk@zorba>
In-Reply-To: <20181102140420.jiuhcsrahoeqe5vk@zorba>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Fri, 2 Nov 2018 21:15:06 +0100
Message-ID: <CAFLxGvy-0-A1Ta1vf=o4q0tcJAdr+uv9eQc7UrnwqF9NkJiWUw@mail.gmail.com>
Subject: Re: [PATCH] Make JFFS2 endianness configurable
To:     danielwa@cisco.com
Cc:     Al Viro <viro@zeniv.linux.org.uk>, nkela@cisco.com,
        xe-linux-external@cisco.com, LKML <linux-kernel@vger.kernel.org>,
        "linux-mtd @ lists . infradead . org" <linux-mtd@lists.infradead.org>,
        Rod Whitby <rod@whitby.id.au>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 3:04 PM Daniel Walker <danielwa@cisco.com> wrote:
> Do you have any thought on how to implement it ? I was think abstracting the
> endian functions in the nodelist.h

Yes, see what UFS does.

> static inline jint16_t cpu_to_je16(jint16_t x) {
>         if (check_big_endian()) {
>                 return cpu_to_be16(x);
>         } else if (check_little_endian()) {
>                 return cpu_to_le16(x);
>         }
> }
>
> but how would you setup the checking ?

Make it a mount option and store the endianness mode in the super block.

-- 
Thanks,
//richard
