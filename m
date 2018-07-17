Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D64ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A29B2083B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHqsO+DA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A29B2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730052AbeGQQf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:35:56 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35210 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729706AbeGQQfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:35:55 -0400
Received: by mail-lj1-f193.google.com with SMTP id p10-v6so1460222ljg.2;
        Tue, 17 Jul 2018 09:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=lFtRCqmRQKWJIyBUo/kfNFOptp704zUUaAytJzgjXCM=;
        b=AHqsO+DAwSyGkg6qgjKTlsRPS+Vg+tR1RJtZBI3fn+VmoZXphHhYzMuWPzRaZ8ogFR
         +lteiZFNoetbbm0G1SPg7bZHjnoH6ihoA8M7KazZFGRIJ6Svzt+7y/D4frS2lxAG1U6v
         UjvXsPGl6hN3VGz6DG/xnIzmQzoaXwxdxon5o72p6i4e/jnXNhK0VLnguYzdUYUF1Nwn
         DcRc3bUN2dHS7ay48B/OSY8/bFLCet7Z7XsUgvZ4AzpkfZjPH4jE7y7jIQ9Yd/plBIPA
         gi7Xzamr7AItrbOcAUsTt/gxW2s8Fi+IoT2LGe/kcQyj0Yxtaiqzufwa3HZAp5jil3i9
         XRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=lFtRCqmRQKWJIyBUo/kfNFOptp704zUUaAytJzgjXCM=;
        b=JWVARb1m9zX7QoZbr8xzjLQLBtBCqU1RYNwkKU+DYgfjRrmR/n0GkczDlvbLdAD01g
         YU9TyMlEJGvT8WutOgZqvyi8L4hAhAeU+lBwXMLb//py76EcqkU324xQkTyi84lRmoZA
         ecpnR6cYtD8AOJT+fAilE6TIi5IdCor+yOPu2T5ScUXlmQD0/jiz5rxXijLq5duF+iSd
         Q/ZSXKJ8RWfvHLiL5WZkBZouc0fAPSME//jEwyztzvhOdD+eaFtfKqrRGQciBKBPJxOT
         H49Ue2SD5AunnbKx7WlutB5ECwBd71QB0UkZSncyGLJcMQUJ8mO+0B1e9eLee7RN4ufU
         XfMQ==
X-Gm-Message-State: AOUpUlE3QQ/kOp8cR15JnynlH/jWzoMJOnyiqVQTtPFVqBfj1m2C2n3h
        npIg/3IsS57CQSsheT9QcgmBUAyJ1RKnPfNXtkc=
X-Google-Smtp-Source: AAOMgpcQHCDHB/+bcguJ6p0XEXu/kc+gbjmxDW2/31eUnru0jiDvfyXPHfBBpycOb+87+Fc70PcJVRxVr/3PVGfTdS0=
X-Received: by 2002:a2e:1dc8:: with SMTP id w69-v6mr2017908lje.110.1531843352761;
 Tue, 17 Jul 2018 09:02:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 09:02:31
 -0700 (PDT)
In-Reply-To: <dbbb1882-65bf-dda9-eb26-a6217b240def@gmx.com>
References: <20180717135236.3673195-1-arnd@arndb.de> <dbbb1882-65bf-dda9-eb26-a6217b240def@gmx.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 17 Jul 2018 18:02:31 +0200
X-Google-Sender-Auth: P4WOHwtfFxdebA5LLu-bWbohfes
Message-ID: <CAK8P3a17Mik-J-PzjP2g7OzX-0ozTGnRxfw8tB4c+pKiRWoEaA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix size_t format string
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Su Yue <suy.fnst@cn.fujitsu.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 4:33 PM, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
> On 2018=E5=B9=B407=E6=9C=8817=E6=97=A5 21:52, Arnd Bergmann wrote:
>> The newly added check_block_group_item() function causes a build warning
>> on 32-bit architectures:
>>
>> fs/btrfs/tree-checker.c: In function 'check_block_group_item':
>> fs/btrfs/tree-checker.c:404:41: error: format '%lu' expects argument of =
type 'long unsigned int', but argument 6 has type 'unsigned int' [-Werror=
=3Dformat=3D]
>>
>> The type of a sizeof() expression is size_t, which is correctly printed
>> using the %zu format string.
>>
>> Fixes: 9dc16aad5660 ("btrfs: tree-checker: Verify block_group_item")
>
> My fault again. :(
>
> Is there anyway to make gcc report such problem even under x86_64?

I don't think so. However, if you post a patch to the mainling list, the
0-day bot should report any build regressions within a day.

      Arnd
