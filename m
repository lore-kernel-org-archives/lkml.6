Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC0DC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 12:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04EE421720
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 12:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qEwmGe0l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbeLZMLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 07:11:39 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44463 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbeLZMLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 07:11:38 -0500
Received: by mail-lf1-f68.google.com with SMTP id z13so10732229lfe.11
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 04:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yjMTMhJ41Jz5DlBO6zfblje/wD77JI0VsFIRBsesqY0=;
        b=qEwmGe0ldYzazj7gyCeG9546HbvVLqxrYdNcN7JoimFMrCxKwVEkpM1uVfnvJ/EDUr
         gFqjwoc7hCClygXkjI9QQpsDvCGwGKVPIVQ47+A62Slb+oWmyjuaxI94CpJgU542Bipt
         0LfbOJaNJFqPxDlynlu8bmlu6Ci3RmFgrXh0T9i3mkpQUeLJLCYPaggl+3R7phNeIfxL
         Q9J3KuySMLQPBkvHk5G0LWbMqA1tvJLmVSPoe74JU30ZX0mXOMaTNhBrnwCzn77rvtNu
         g9cWmgLU/eUNeHoqtzyHGv9i55Uzpwpdmc5EV9yYgSmmViX29OygTSNTGmH2yj/GQEqX
         IFEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yjMTMhJ41Jz5DlBO6zfblje/wD77JI0VsFIRBsesqY0=;
        b=T3q6ebrCGuoC0FE5kSmotbmGZ1Lcq9DAX/YE+SCu5+bGfffEq01CGYZ8fT17cGs5E9
         SO4A80ARSyOVwcz9825610sRmRwDGo7it9H+kQEf7ohTwaQCDcTxw8+/HKt0hR26ghA6
         PsSZoNwgNNpFmhJTiYxdec8N4p1fx1CKMxxTWPVniDVa+tDoMp5LzbVRPFHyqO0rnRUB
         KR4CuuZ6+REgTJ1XDxlHiN9woB7JQiOAvL66vGsPCgFqogFJdDEkX8c5EJHl31opmkx0
         tK8LQnudSPwlvoURhX+k551Y/7Rh609Os0bu2I4XYZ5SnzppH/gs0mZUsOWz14X+taqB
         uCcw==
X-Gm-Message-State: AA+aEWbAcHK/P0zweTpF4dMwmVwAQw5bA2r9+RvPAnQDZvslFL+HJRpl
        WrQ5EkOBqeQH2XANHEbF4yLrm+dYC69R/Q==
X-Google-Smtp-Source: AFSGD/U0WnvyrAaWqoRHO/+Kgd7Fnk4sbGiPGVIdPwt8Bw+FheIau5FElcfA6MTgkjDJ3L/M3oSL6g==
X-Received: by 2002:a19:c203:: with SMTP id l3mr9494987lfc.113.1545826296430;
        Wed, 26 Dec 2018 04:11:36 -0800 (PST)
Received: from localhost.localdomain (pool-109-191-228-208.is74.ru. [109.191.228.208])
        by smtp.gmail.com with ESMTPSA id q6sm7037684lfh.52.2018.12.26.04.11.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Dec 2018 04:11:35 -0800 (PST)
From:   Ivan Mironov <mironov.ivan@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        saahriktu <mail@saahriktu.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Ivan Mironov <mironov.ivan@gmail.com>
Subject: [RFC PATCH 0/2] Fix SDL 1.2 on emulated fbdev devices (broken in kernels >=4.19)
Date:   Wed, 26 Dec 2018 17:11:22 +0500
Message-Id: <20181226121124.1632-1-mironov.ivan@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Originally this issue was brought up on linux.org.ru forum by user
saahriktu, he is on Cc. He discovered that commit db05c48197759
("drm: fb-helper: Reject all pixel format changing requests") breaks
support of SDL1 programs, like various old games and emulators of old
game consoles. First patch contains fix for that commit.

I tried to reproduce the same issue in a VM under qemu, and found yet
another part of kernel code which prevents SDL1 apps from running
normally. Second patch in this series fixes this problem.

However, I still have few unresolved questions regarding this patches:
* Why simple revert of commit db05c48197759 fixes SDL1 support for
  saahriktu? I do not understand how this could work when SDL1 has
  hardcoded non-zero pixclock values, for which current code always
  returns EINVAL.
* How this worked before? How this is working for non-DRM fbdev drivers?
  fbdev support code in SDL1 is also very old by the way.

Also, it seems that at least in some cases both problems could be
circumvented by adding appropriate modes into /etc/fb.modes. But without
examining the kernel code it is not clear which values are correct. I am
not sure that such circumvention covers all possible cases, and it is
definitely far from any user-frienliness.

Ah, almost forgot this: the easiest way to reproduce both problems is to
install sdl-sopwith[1] and try to run it from console without X. At
least in Fedora 29, sopwith may be simply installed from standard
repositories.

[1] http://sdl-sopwith.sourceforge.net/

Ivan Mironov (2):
  drm/fb-helper: Bring back workaround for bugs of SDL 1.2
  drm/fb-helper: Ignore the value of fb_var_screeninfo.pixclock

 drivers/gpu/drm/drm_fb_helper.c | 153 +++++++++++++++++++++-----------
 1 file changed, 99 insertions(+), 54 deletions(-)

-- 
2.20.1

