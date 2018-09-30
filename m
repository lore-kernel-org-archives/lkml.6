Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA02AC004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 11:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79AA020833
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 11:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jb9D6ClE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79AA020833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbeI3SQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 14:16:58 -0400
Received: from mail-qk1-f174.google.com ([209.85.222.174]:45711 "EHLO
        mail-qk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728144AbeI3SQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 14:16:58 -0400
Received: by mail-qk1-f174.google.com with SMTP id m8-v6so1662998qka.12
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 04:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tOu4dr0SswemJsv4+s1j/Tq0nT8pBTCbeMNMFKU1XJM=;
        b=Jb9D6ClEKSgrfDabkSGsUvOE3m8tibcwc1NeXJQEzUsJjFMl9AODl5YSSRRjRPnhbS
         RPzGPzus2oTAoyP0hYn13rBq5xXfy1kUtUgWSU5vc6iUGhsl4wlZz0LKnGkGJdQ9SP9R
         HNhRetwjhpUr8frwBoCqZu7GO8g/3AXui7YmGEQ29GGUu5SoqVQgf8SUMHAUCJ0y6axx
         GvQ0DwyLahRVUXiQeYkwJPr0cI1suCbbOFKkbAQYPn53kO2p/iPb1sGQEBVZCcsXzxaK
         hT6ic7PSEJvxmI8eUgeIIxk2QJg0hlZJMcby/eQeWRtA2034BUgGnEwBEulKCwHNDyyg
         k9ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tOu4dr0SswemJsv4+s1j/Tq0nT8pBTCbeMNMFKU1XJM=;
        b=X7nUC8qXT2P9XyRmRiUXFZjidSv60FcxED0Sd9QYYvK98rqaepGfb/dyhhILYEBbp/
         QAM2M0oqDS3tsTfnbu12cJcoBXOu9qWc+80feM6khblBVvUSn12seS5cgXQfiUKR6uLb
         6SdkHJuEZ3jxWToAK+EZlYyTU7i5zb8omJ7rIu+t7vHhKGluKGhwODEPaIotKDAO1ZAW
         lAAZ9d+/x2tL7krjgZOZzknWiNvb1eVEX3KNVX0yhllMYnWFTYjMmQ5+C0wE5vP+ZcNf
         M0lYrLIpauIctXtMPBWsPT0o1Yso9urBUU14Pc8gCBBJn8YsegBVZLP/a5lOCzysST6Z
         MJRQ==
X-Gm-Message-State: ABuFfojfvYi9dhMgZhTFJRc6k6GlVho7l04bvGrLoLyVw57KYg8SHxUf
        UN39frzjzrnjklu0mrReMKAHFHflPdWH4pARulA=
X-Google-Smtp-Source: ACcGV62ot6xEyoeXO5eKxdJxrbl1WBL1GGoV/Y9dHH6vvTl+zRkZyuIrdVXhbaRanYDK72qGfVHzcXxwSPu1myVbfTk=
X-Received: by 2002:a37:6888:: with SMTP id d130-v6mr4801353qkc.192.1538307857062;
 Sun, 30 Sep 2018 04:44:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180928220131.31075-1-joe@perches.com>
In-Reply-To: <20180928220131.31075-1-joe@perches.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 30 Sep 2018 13:44:06 +0200
Message-ID: <CANiq72=2272s-AWZdp8HCMufpvL_QPNJpiKYOChcWGTDSMGNTg@mail.gmail.com>
Subject: Re: Bad MAINTAINERS pattern in section 'PARALLEL LCD/KEYPAD PANEL DRIVER'
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, willy@haproxy.com,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On Sat, Sep 29, 2018 at 12:03 AM Joe Perches <joe@perches.com> wrote:
>
> Please fix this defect appropriately.

Thanks, will send a PR.

Cheers,
Miguel
