Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FAKE_REPLY_C,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE41C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5880208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kaiy2TRO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5880208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbeJPDNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 23:13:52 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51487 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbeJPDNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 23:13:51 -0400
Received: by mail-wm1-f68.google.com with SMTP id 143-v6so19953101wmf.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 12:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=xg2S62pKZT59+ka4mGMyb0JB66qBgKtk/Lge43FAT+k=;
        b=kaiy2TROeeqv8/bnczbDDI4/F6b4xQ+NOsag4LmKmQCy1ZlWJZjAGTECR7zYK4shLA
         Wu3Z1hq80qBHLSAmVId8/G0cXtH1qpJz7Ov15ZjADGjJ0dMAb6FJT4EIVy5drN8QXlEJ
         E6kshdfu/aURaMwZH6u/9O3N79KDd52u7pEc2jC3R2s61Y5tbXgihYgNwpnmW3KFA0SR
         XL2otemb03pnsPsQn6xybtUUZyZhlmKvbzHYHioCeKJsD/a5LsMRX6Ni2FivVKA8bQFb
         C4XS2Yf2cUaNDS6gRZkQaaTaz3h8FG7arldZYbt8MAhqNT0O86t9rAwqnABRC2wH12mv
         oCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=xg2S62pKZT59+ka4mGMyb0JB66qBgKtk/Lge43FAT+k=;
        b=fqtBOE4Orbpykn7r/p7vjhmFIFbEfGgWQIQX9jXdY04+87tR6YiTBnM3zWLBt0ZVj7
         P+EvyUmzDByH/yulsWCmhLx2bnkqij7h3z9tE+AULETOI6hJFS8M0GQlXGTXnvRpXBZv
         hIOqQ9mOwYFkb0wRp5u6+KxdMulG0rE3S1o4/MIWAM1Ku0FVAr+JfNYIcvbvHEaLMnNy
         becM5TkLLvNp3EMDHzYy29XtgJKwfg9iC40TwDFOTLigVIvV3A5k/vpMQjzRuVRmJiD3
         CgeVOuj9NvaS+LHfwW2mhXF4+UnoPg7xwXYzQkMcPHVknCP7g4uW4sbb3KQxbeu+XBVY
         OGHA==
X-Gm-Message-State: ABuFfojGTA1JPdevXjRseAAHt+/KzGxtXrJm4gWVqQfK6E/JiUhkSlsF
        blZfl9GHsF0L2UP4Vc7JGZ+YOVQ=
X-Google-Smtp-Source: ACcGV60j6aa609PWLAhSUZozw8iAXuXZnBCC075D74wV9vojr+ZkU/LhnmbjUM5jHWhKtY7nGnxEkw==
X-Received: by 2002:a1c:e583:: with SMTP id c125-v6mr14907797wmh.134.1539631633456;
        Mon, 15 Oct 2018 12:27:13 -0700 (PDT)
Received: from avx2 (nat4-minsk-pool-46-53-177-92.telecom.by. [46.53.177.92])
        by smtp.gmail.com with ESMTPSA id v16-v6sm9132122wru.31.2018.10.15.12.27.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 12:27:12 -0700 (PDT)
Date:   Mon, 15 Oct 2018 22:27:10 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     christian@brauner.io
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH v1 1/2] sysctl: cap to ULONG_MAX in proc_get_long()
Message-ID: <20181015192710.GA18693@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> int kstrtoul_bounded(const char *s, unsigned int base,
> char **trailing, unsigned long long *res)

NO! The whole point is not have million variants of slightly different
integer parsing functions.
Cap it in the sysctl -- noone would care.
