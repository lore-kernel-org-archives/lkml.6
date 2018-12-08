Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630ABC04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1289020868
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:17:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1289020868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbeLHRRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 12:17:21 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38761 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbeLHRRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 12:17:21 -0500
Received: by mail-lj1-f195.google.com with SMTP id c19-v6so6148477lja.5
        for <linux-kernel@vger.kernel.org>; Sat, 08 Dec 2018 09:17:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pdAsGr0Y0KeFZkLQHQrrYZiVyn82yoSfEfPbtB32sEk=;
        b=k1acJ6D3sYbVy5xauuMk2gPKeooKu9TCV63xvdZWSFAJYuiSSMy7rVs8IEVDi7W4zH
         qcHl6EJy+JdmHfTP9geV0j/eDHdwLTAJey6Bx0K8TSfetecZ5Sdyc3BNnHklbYTgUFM0
         K6xH/n5ScOkYp27EePqKtRC/RvNGRaT7eRFtptPmMDaNtB6RlrSs3fPDHYcCSF+c/F1L
         e/rHzgkKh6nugzjL8HBD6sRuMNJavJjEuZLI2xbvwEyLUg+2C2GOdnGf4nzWGk/VomRK
         Rn9xGW/Bakz8jMdjjF9roXHevYYPC5LSsviX7sBHH9jyAzxEToCaws9qztDEBffdid0i
         e54w==
X-Gm-Message-State: AA+aEWZNBhKLBZtSA70b4exrnCxOWmlMESnB6eJMMDJvhbj6LsUm4FeC
        8Zw11Www6vbC7FrI+VjqDzq1NYZmNkvecOY1XQpOWgFx
X-Google-Smtp-Source: AFSGD/VndlWuH1c966alRG9QEsksc2eJ7Xgiykj6GL/bnBZ6JEkSjWqAFO2PPHU+7UKTe2egH66GHFjO9RtHJmIHre4=
X-Received: by 2002:a2e:9017:: with SMTP id h23-v6mr3201946ljg.71.1544289439269;
 Sat, 08 Dec 2018 09:17:19 -0800 (PST)
MIME-Version: 1.0
References: <20181207013410.7050-1-mcroce@redhat.com>
In-Reply-To: <20181207013410.7050-1-mcroce@redhat.com>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Sat, 8 Dec 2018 17:16:42 +0000
Message-ID: <CAGnkfhwTEmcPzi_6-N=ALoaD8u6kmsdSZbXDP1o5nMUpUY3z-Q@mail.gmail.com>
Subject: Re: [PATCH] vfat: don't read garbage after last dirent
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 7, 2018 at 1:34 AM Matteo Croce <mcroce@redhat.com> wrote:
>     the rest of the entries in this directory do notneed to be examined

I made a small typo, it should be "do not need"

Regards,
-- 
Matteo Croce
per aspera ad upstream
