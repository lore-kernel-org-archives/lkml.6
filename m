Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FC4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8A83206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDOvfHBT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729857AbeLNQLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 11:11:23 -0500
Received: from mail-lj1-f182.google.com ([209.85.208.182]:38693 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728998AbeLNQLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 11:11:23 -0500
Received: by mail-lj1-f182.google.com with SMTP id c19-v6so5359999lja.5;
        Fri, 14 Dec 2018 08:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=AB4542VKu0OZwQzDf08OY7H6FtP7wQdyisK+jumARBY=;
        b=FDOvfHBTrK+f1pt3yXJUJqgS6LN2Xu9wiQB+en6YmvHXTLRNzpzCP7grXrkNX9Lphc
         8/Ct3LP9rxGwjYG8FPkPpOz7/4Oc0yHGjglZbL/6eiow3rXLZl4J2TJfLfaQNMjgOJfq
         bqVYjpJwQoO2SuyDvIv/WkUp+wPnnjdklky+MA1VclvqyBxBF4PVfPkj/DquB+FtSoPD
         75ExnTiukXKwSeKHDl6DoWjf34l2zCtDV30HnJIzeoeQ6CQLQtg1LpHOFGVVkI/JEzW+
         /ovc8L/zbFzNXlehmN//L0CY2ge5knrmySLR/3YlizmoVF8B866WSdpRrFrqNiLRTVEO
         w/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=AB4542VKu0OZwQzDf08OY7H6FtP7wQdyisK+jumARBY=;
        b=AfNK6E/s5AXSTL+GUwc+8aVVFpGY6Gw9w1N/PgGWz40NM6RQqKg0bxyPufKeGG79wg
         10nLNcYQKJMK4SJu/CWL2NK9ZQ/6DZChEaGlWFdFt4o0cnJEnOB0JvOox+HItYKqKSPK
         tOenSSAy0bQsMzxKkhuJPXMuVQG5qUFhzP0a4MgbBAanleCA64tSWUw0+dkeC+2ES3aO
         NxUKWptL5Z6o1ZOqkQ43Olq/wTkT3gA7wFIMdoDLFArJG6wWR49uk0RDhsCBJZ25c0v0
         47CK7v8mpUauWyV7efU6Kx5uFD18rIzM5CySEU1sdYsxLvL1tJA8Nnai4ZFMefWBJrq5
         eg6Q==
X-Gm-Message-State: AA+aEWb/7xGZoj3WQY53fQ80jCSics3bsoKv5cdOK62ntNCa9zIdu3xk
        QKN+XZOWQNDXgzL16oif3aoZq0/r1ptOQ/lL/JINNSQ/xb8=
X-Google-Smtp-Source: AFSGD/Xl2qOJPMivPYcg7EI5eC4Vkfre6RiMQORm9aMFiMyo9W863vorI9PlW4jXfnaTgAzXtN/32IEbD56Pyt11OHQ=
X-Received: by 2002:a2e:908b:: with SMTP id l11-v6mr2201744ljg.150.1544803880821;
 Fri, 14 Dec 2018 08:11:20 -0800 (PST)
MIME-Version: 1.0
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 14 Dec 2018 17:11:09 +0100
Message-ID: <CANiq72=EefCCj=ErujVHZesn0aiO5aDT2tKobzUCVw3aTsRS0A@mail.gmail.com>
Subject: [linux-next] Request to add auxdisplay tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Can you please add the auxdisplay tree into linux-next?

    https://github.com/ojeda/linux.git auxdisplay

It is extremely low volume, but from time to time there is a patch.

Thank you!

Cheers,
Miguel
