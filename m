Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2874C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CD6620879
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sYZgQbSt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CD6620879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729314AbeLMQRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 11:17:33 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:37838 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbeLMQRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 11:17:33 -0500
Received: by mail-ua1-f67.google.com with SMTP id u19so908680uae.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 08:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=3mEpdag4bGOhH2Q+HoSOgaAiuwcIxDYQ11QIwtVm9fU=;
        b=sYZgQbSt0XgmQxfv5MD4pzSGO3c9vgnZlz8572lWlallRf1hdevmOl1aTNWH+v5Wqf
         2XiPZ4mcFaFYWsZaGvKDn8RRsmCYOysmz6svTerV27hbSAUjNxbLXKEHysjvajN9O7s9
         081YBg+10adanEjHCs3FW/hMC3QvbnThHM1fja+ZBLgLQABJGY4h9jZFrdcQisNLb5po
         ruwnrtgZA3fmgnXJyIZv2mdh/brg4EvqeyLOSGM5R3UFZc87u3eRmHlk2UhL8gtwIlU8
         QmPZ577xdEcEYJHZ2nT2pQRidf4FnZsehVnaN4+0eOV8vsPzdrBtLgP0sKiG6dhQWC1I
         UbJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=3mEpdag4bGOhH2Q+HoSOgaAiuwcIxDYQ11QIwtVm9fU=;
        b=tgfHI8blljIOhA+602d6VKeEoLwAomDN6Y8TWOv1+0Pgu5LSHX8hXhAGLqYvDFQ7rw
         3jq7LCcx3HdMo1l+qwH/aY61ycsxQUUQS5nrpoGz/JuNOyF/kQdzwYZMizkD9KSnUJ70
         Q+8/RJBP7Enupl2jOqvp85+Oo8m9I8lYmwPi6WITw0wW4wXz+dMKd1lge5+kW1jUBmhG
         DwyxE5ygthppTtx7d3PDCOV75fgjF4VmihxfPVebwKn9FfBoFOvX3wgr51wCTdDuFV0Q
         D5qE7sQ4akAqiL6mQYz7JWUHWsc5A22vIYNJ/USCJXR9w/BlpBxDMrOehgKj1Xk15VaU
         Rw/Q==
X-Gm-Message-State: AA+aEWawVAmFiiVTJdJV+6m+957vHPwG8JstE4k/29ECpP9Jg4qD5ZKu
        w69k1ECvQSQ5Og1MBCZvzS8QDpaWxByzLu1JSilA/ng=
X-Google-Smtp-Source: AFSGD/XSCUUHtwvBIsCe320hNvh5fhUmXexEnoqnPY/aKQue4V8Heb6f98muc94Bf/0ms4oTkLU4l2JdzuR2rNHNLXo=
X-Received: by 2002:ab0:1425:: with SMTP id b34mr11199299uae.64.1544717851708;
 Thu, 13 Dec 2018 08:17:31 -0800 (PST)
MIME-Version: 1.0
Reply-To: whiteheadm@acm.org
From:   tedheadster <tedheadster@gmail.com>
Date:   Thu, 13 Dec 2018 11:17:19 -0500
Message-ID: <CAP8WD_bdE0Ee_YmnTJLvFo+Mf6_MfOPzezW4kq+zcKhuPe3urw@mail.gmail.com>
Subject: Re: Can we drop upstream Linux x32 support?
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I will also complain. I use the 32 bit x86 environment regularly for
testing. I have found several bugs and worked with upstream developers
to create fixes.

The developers never said anything like "this is a waste of time
because it was found on 32 bit". Instead, they were universally
supportive.

As an example, Thomas Gleixner said that the problem we found would
only show up on older hardware, and he affirmed that it was a bug that
certainly needed to be fixed ("NOHZ: Check for nohz active instead of
nohz enabled").

I actually think this is an _opportunity_ to engage aspiring kernel
programmers. Give them some guidance and have them actively test and
do simple maintenance of 32 bit x86. Yes, I am prepared to take the
lead on this if it is something you want to pursue.

- Matthew Whitehead
