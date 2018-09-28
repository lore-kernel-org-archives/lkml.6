Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C45DC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 23:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACDFE20657
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 23:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZL6cV10"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACDFE20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbeI2GYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 02:24:03 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40685 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbeI2GYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 02:24:03 -0400
Received: by mail-pg1-f195.google.com with SMTP id n31-v6so5504619pgm.7;
        Fri, 28 Sep 2018 16:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=merjcaXvPn8QqP1t7YSsSDLOqBWwKRj7EU/0b0XzcAU=;
        b=GZL6cV10MNt6qI8uP/LxseIZoZc8pBRlLuKUVz5IXm0AZA2atQHy2c8JT/wc6EpZqY
         yDPpWRVP+hBCAWLBtbvFeJKA7+zAfy8M3U6vbYcAnHELOJ6I+v1/5zScBRIWfISPyc1x
         Kx57dh04+GiN84JPTlxztFfpAY7+5dkN65xO1AK0SgZH4k3n7kmkqxU4EFWH4OtFAM8U
         Y99YwFxfaJrfGTZl05Vm9d7casq+AUAnUpb8f0U7StrurvcJbx9zQrLhPteVoqf2XlJ9
         osPzWR7pnC255VScEHcENjqdu+EH97Zh8F5c2WRL/K635XH9CwWbqxcuwirNpC55iJwS
         Pu6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=merjcaXvPn8QqP1t7YSsSDLOqBWwKRj7EU/0b0XzcAU=;
        b=B3/LaFkEuY6hP0OtU+WJKfB/Fh8KIu7aaggQvBTeLwkYGxUYKbKfcg6Yg95FStgisc
         Xh7bOaUr7vcvV1VzmuFAr68ymvR0OzQmLNQZs/rVEeqLQY+qpWrGGgaIJYzQ4iWlyRkU
         aeZVhQAz/W/BEq/QsVcg3+J947/DFdw8iqiKAZKRiIwDoG7n6eVkygWhlyL0tod1ynNe
         Gmk+FXueM+pC71lPFG/7aGj4F86pi98y7uhDDEut8M41OsiDIdbUggTeeSyI56P1ZUXY
         B7HpkoOAstyaP7LNzx5EqW4Yjz6RiGenkZp6BFT6UzmFi2j8JkJiMY4rWuVtj1w45FK1
         cutw==
X-Gm-Message-State: ABuFfohiCqQ5V12yCNovo2XCscRsIZUlKeMYzQedMnNS7trZxYAIEtPs
        A1Jyb+tHLSc4Q8WVn2EGk04=
X-Google-Smtp-Source: ACcGV60drRwU0TJIKawZXPgSsB0dA8o37iwD9AFKBbIa4Vc3ooVN5Amjx1BUNdSbh5oXQ3tWz2zbnw==
X-Received: by 2002:a65:6249:: with SMTP id q9-v6mr792656pgv.392.1538179074034;
        Fri, 28 Sep 2018 16:57:54 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id n80-v6sm14941664pfb.95.2018.09.28.16.57.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 16:57:53 -0700 (PDT)
Date:   Fri, 28 Sep 2018 16:57:51 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [git pull] Input updates for v4.19-rc5
Message-ID: <20180928235751.GA182564@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. Just a few driver fixes.

Changelog:
---------

Aaron Ma (1):
      Input: elantech - enable middle button of touchpad on ThinkPad P72

Andreas Schwab (1):
      Input: atakbd - fix Atari keymap

Anson Huang (1):
      Input: egalax_ts - add system wakeup support

Michael Schmitz (1):
      Input: atakbd - fix Atari CapsLock behaviour

Peter Hutterer (1):
      Input: uinput - allow for max == min during input_absinfo validation

Song Qiang (1):
      Input: gpio-keys - fix a documentation index issue

Diffstat:
--------

 .../devicetree/bindings/input/gpio-keys.txt        |  2 +-
 drivers/input/keyboard/atakbd.c                    | 74 ++++++++--------------
 drivers/input/misc/uinput.c                        |  2 +-
 drivers/input/mouse/elantech.c                     |  2 +
 drivers/input/touchscreen/egalax_ts.c              |  6 ++
 5 files changed, 38 insertions(+), 48 deletions(-)

Thanks.


-- 
Dmitry
