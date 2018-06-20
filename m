Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95671C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ADB120846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8+15x+3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ADB120846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752595AbeFTKu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 06:50:59 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35545 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750827AbeFTKu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 06:50:58 -0400
Received: by mail-lf0-f65.google.com with SMTP id i15-v6so4256080lfc.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 03:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=5uh/OWJirFtI9uVSLX4zUj1SjtSeO7N1ckTYZpVzWu0=;
        b=V8+15x+3TrOlRCECXX6D8ZNMP9Pn42ij2doDHZ4J5HZcNzMSD/FoqRy7JeRxHMwrNL
         XDNXwnrkkcuv0DPimjUS7ShlHGy908ikQmrpbQbcTKK6yPfhWSN/7jW9YAscdNhkp47X
         B7pwGROlnGbZegSSGn1ouAUoRVTc87hHp8I+0kfHMe32mZZGuvSRnqZca3TYQhjCy+o7
         MCF7ShQWCgl0yRsA9g8IrQB3HI9e5BgSZOeHVY/RGsSJ2Xv1GENUGzRb80w/CZDiF9uL
         ctavVKlkmLbfzqJtPeNO91p2CnUJOZGbq8ge4iFa4cJAxb7hQFRhFd+FLzBW0X+31MJH
         afTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=5uh/OWJirFtI9uVSLX4zUj1SjtSeO7N1ckTYZpVzWu0=;
        b=N8lLm0p820bNMVOFiGlPaR1p415vFncq0Aff/mvn6MIUz9a8Jll0O4CcpL72UtXSHp
         oQDztvQfVJmVZzt83Ndfjw187mSbBPQcz4LZziT6GNpW+WUGchKPcXzvO6YcE4Ouqz3C
         s6+cKUUI4YQhSV4wFJkUoPZeqRP4pGWMdOBH4s8Ay51zaU7Dv4jd5cCicW8PGnJPeDwq
         uyUkBDhHSuRhxjWfJZjDHhZz/QBDrH8HpyikGC6fxGYP/IxxbUY19fSlKBUSEmdYJXr5
         pz1vy88IkX0GNNmHoPtMGCmawMfsicwaxL3fFbMVb4iPnTTizYGB0vf1F78BaIXzarzO
         Qvbw==
X-Gm-Message-State: APt69E2nymDnCyW9wEKi1cCd/9ozmgGzx3QsmaT7fSTQm9MHpHjVrhkk
        RXxw2EVmFz6b/b5nCZv+N2i0fkHM8eTu1Mw9sM4=
X-Google-Smtp-Source: ADUXVKL6q7JF8bvh2aUNkJMQzoyi5eC7Vsqhrj1QVaEoYXCP2Cu3rLDsYdz6wx5al5y3SUOWofMeSSGHsWGiofCRDQ4=
X-Received: by 2002:a19:c004:: with SMTP id q4-v6mr12056271lff.16.1529491857037;
 Wed, 20 Jun 2018 03:50:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:56c8:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 03:50:56
 -0700 (PDT)
In-Reply-To: <20180620085835.ei5lhoo3ybmojvhj@quack2.suse.cz>
References: <20180620081535.207936-1-arnd@arndb.de> <20180620085835.ei5lhoo3ybmojvhj@quack2.suse.cz>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 20 Jun 2018 12:50:56 +0200
X-Google-Sender-Auth: ZL4QUhFZS0t3Nu068lC2A8gHPKw
Message-ID: <CAK8P3a2KDhqtKMfyXSj2E1-ookQBG5nL9V5cZZvVm_PdSutY5Q@mail.gmail.com>
Subject: Re: [PATCH] udf: convert inode stamps to timespec64
To:     Jan Kara <jack@suse.cz>
Cc:     Jan Kara <jack@suse.com>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
        "Steven J. Magnani" <steve@digidescorp.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Steve Magnani <steve.magnani@digidescorp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 10:58 AM, Jan Kara <jack@suse.cz> wrote:
>>
>>  void
>> -udf_time_to_disk_stamp(struct timestamp *dest, struct timespec ts)
>> +udf_time_to_disk_stamp(struct timestamp *dest, struct timespec64 ts)
>>  {
>>       long seconds;
>>       int16_t offset;
>
> Thanks for the patch! This function needs fixing up as well - 'seconds'
> variable needs to be time64_t now. I'll fix it up and take it to my tree.

Thanks a lot for spotting my mistake and fixing it up!

      Arnd
