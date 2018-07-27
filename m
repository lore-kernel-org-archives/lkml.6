Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733EDC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 00:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AE7020891
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 00:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EaxUM/Wg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AE7020891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732093AbeG0BaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 21:30:21 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42100 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731774AbeG0BaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 21:30:20 -0400
Received: by mail-pl0-f68.google.com with SMTP id z7-v6so1507084plo.9;
        Thu, 26 Jul 2018 17:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=8MijZOt7Zmvv8yWnOJ2uyYM5u1dHnMhSPr4188OjB58=;
        b=EaxUM/Wg97CziM3Ug/lKum3z+2EQZkI2CEtBBV8PIjkmm1fpr4mZHGTz+oJQvfipBC
         TigK8KTz2D9ivos/rhPvkUroZW29zV/ghWSur2x4c07BfJNlyhYMYgIOYapx0gDjVJ53
         9jhFiNQcTaJsJd5/0SH/uMX9o0g73uc5foc46JMhUL0u4sy9a07pWfyKXyrc86vXn75l
         IeK/0Ey18QP2kDYWnpnlzXF/va647JiLxgQY8Wkk4HNiYB9gNk4IfQB6zciyHdf/j43p
         uj/QWl1TT9QDVyu6nAQOd/Nc+VWsPcwj+q5Aen8xTx9yAUmuTds5mAsLQv0AaKIIP6Wh
         YR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=8MijZOt7Zmvv8yWnOJ2uyYM5u1dHnMhSPr4188OjB58=;
        b=SGMzFn2LL1grKkqcaRqeX80U0IsfKf2/hY+uRcSyACswLPnAzhfJq45klM9wqa8hFe
         LAPV8zNAJOv6Phesrk7qYozUGl1UX6nBqOKWsamvvQZOGZx7fD8I8Qhd2lx9aEzjTSvw
         el1arL/t2OD+98s+UQN1euDS+InQBCU2BuR5HaSP9G92m5Vb0Xl8rNeGgHazjiQyXs0a
         PHtzu3tDHMxOjWSfL0AEPLUdhY7KlHXnHH0tsxcUoVq7nX5u2pV0TJDwIDMdOcbQ/UVM
         o5ZClXJFLMTYpXGgipQatp0bYl/8WwbevZic+5INy4caQ1qu4VxyeQRizfbAqqIcOL3b
         eBig==
X-Gm-Message-State: AOUpUlEH3IH6Co9t5Z8twrOx108x9H/jGXK4vLLmNgOqFnQA/YnLgsvr
        C2ZioZ8WY0UKmhsS/c7TVDc=
X-Google-Smtp-Source: AAOMgpdZA28rJWcQkQDiwIzZqpKsCmCHN6dS4pcJ7019k/e31rVL2cu+HVEtDgag+6ZQVEKA1NKo8Q==
X-Received: by 2002:a17:902:bb90:: with SMTP id m16-v6mr3840185pls.50.1532650268921;
        Thu, 26 Jul 2018 17:11:08 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id a15-v6sm3814272pfe.32.2018.07.26.17.11.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Jul 2018 17:11:07 -0700 (PDT)
Date:   Thu, 26 Jul 2018 17:11:05 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v4.18-rc6
Message-ID: <20180727001105.GA93787@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem:

- a couple of new device IDs added to Elan i2c touchpad controller
  driver

- another entry in i8042 reset quirk list.

Changelog:
---------

Chen-Yu Tsai (1):
      Input: i8042 - add Lenovo LaVie Z to the i8042 reset list

Donald Shanty III (1):
      Input: elan_i2c - add ACPI ID for lenovo ideapad 330

Geert Uytterhoeven (1):
      MAINTAINERS: Add file patterns for serio device tree bindings

KT Liao (1):
      Input: elan_i2c - add another ACPI ID for Lenovo Ideapad 330-15AST

Diffstat:
--------

 MAINTAINERS                           | 1 +
 drivers/input/mouse/elan_i2c_core.c   | 2 ++
 drivers/input/serio/i8042-x86ia64io.h | 7 +++++++
 3 files changed, 10 insertions(+)

Thanks.


-- 
Dmitry
