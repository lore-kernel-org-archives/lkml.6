Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35B7C282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 23:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74A7C20855
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 23:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ci9BnSB5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfBJXkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 18:40:16 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45112 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfBJXkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 18:40:15 -0500
Received: by mail-ot1-f67.google.com with SMTP id 32so14600375ota.12;
        Sun, 10 Feb 2019 15:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rVq5HFuGARsY3L4LGjer8cDNMje00RF9md6WfL61e3M=;
        b=ci9BnSB5GlH9AWOYvAW3XQQ8dDtBpUtKvZy+HT+61xF4eH0t4vbO8C/lsG+UdhkvPt
         cY322sxWn+uM+ABPZChPBn7ofA0y6Q2/msGZp5zYMQ3RySXDQq3kTgWlHVT2mQZ+Ku6s
         HGZbgVW6lFpBpojhACSsIoYxYZFmYEcufituL9VwdLgkZ8zRLFVdhwTUMCtA9NGgAO8Z
         8sLxgWO4+IejmBSieXoO02+1d4fHMwxirX4dGidbvGAuiRtSgRZ4a/A1YifHFr8dJoYe
         q9E4cbUhuAcUYa9wh+s9Hcej0HP2O9pgNJV0PZJ43GGivWwwnhmZ88OOlC3YyY+up35t
         osRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rVq5HFuGARsY3L4LGjer8cDNMje00RF9md6WfL61e3M=;
        b=m9QVVk9pYtau5EDHEPyIl2rGAY0n+hoC0p0pUdE2qMwBZWJZnuxELgMHOWRIWQjDmB
         8rOEGxk7RuyPBrEw07ZfNXBx6mFHWbKIxlI+kQ3+IUuTz6obl+47rQWWEHYvteUhdLO6
         wJueoZUXaLGjdZ7XQFlxdbFq4g+g+BYK2pOqya0toYKMVjDvq3Yd76ekghkP1IfRi0ts
         t4604Yfwa+o9dAp3+CVbFekXuNQfWCXB7MNcShnMVMHkMVnnE7B9ktGgGPUQFv/3TquS
         R2R9Iu13EuUkh0KmF3BiFeG4ajvtqHPzAHxbEbJ6LweQyXNixzJDUzggOyIaGg/lqmbD
         9RwQ==
X-Gm-Message-State: AHQUAua+YaPg1c5FIXW8KgeFhiWOAl/zc0Zw66BWwZnjtrZyerTt6HkN
        IOUU0gipJ2WqWKhIc+GnMK5NC6WH
X-Google-Smtp-Source: AHgI3IZ4dXats+amI2ON/Pda/LHh0xmbl9GI/zeSvwJnzEE/FUDL3LLwD8B4XobfxIfIL13ApQgpcQ==
X-Received: by 2002:a9d:6b81:: with SMTP id b1mr18372059otq.212.1549842014113;
        Sun, 10 Feb 2019 15:40:14 -0800 (PST)
Received: from localhost.localdomain (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id v3sm4944269oib.57.2019.02.10.15.40.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 15:40:12 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>, idosch@mellanox.com,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        bridge@lists.linux-foundation.org, jiri@mellanox.com,
        andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v3 0/9] net: Remove switchdev_ops
Date:   Sun, 10 Feb 2019 15:39:58 -0800
Message-Id: <20190210234007.16173-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch series finishes by the removal of switchdev_ops. To get there
we need to do a few things:

- get rid of the one and only call to switchdev_port_attr_get() which is
  used to fetch the device's bridge port flags capabilities, instead we
  can just check what flags are being programmed during the prepare
  phase

- once we get rid of getting switchdev port attributes we convert the
  setting of such attributes using a blocking notifier

And then remove switchdev_ops completely.

Please review and let me know what you think!

David, I would like to get Ido's feedback on this to make sure I did not
miss something, thank you!

Changes in v3:
- dropped patches removing te need to get the attribute since we
  still need that in order to support different sleeping vs.
  non-sleeping contexts

Changes in v2:
- fixed bisectability issues in patch #15
- added Acked-by from Jiri where necessary
- fixed a few minor issues according to Jiri's feedback:
	- rename port_attr_event -> port_attr_set_event
	- moved SWITCHDEV_PORT_ATTR_SET closer to other blocking events

Florian Fainelli (9):
  Documentation: networking: switchdev: Update port parent ID section
  switchdev: Add SWITCHDEV_PORT_ATTR_SET, SWITCHDEV_PORT_ATTR_GET
  rocker: Handle SWITCHDEV_PORT_ATTR_GET/SET
  mlxsw: spectrum_switchdev: Handle SWITCHDEV_PORT_ATTR_GET/SET
  net: mscc: ocelot: Handle SWITCHDEV_PORT_ATTR_GET/SET
  staging: fsl-dpaa2: ethsw: Handle SWITCHDEV_PORT_ATTR_GET/SET
  net: dsa: Handle SWITCHDEV_PORT_ATTR_GET/SET
  net: switchdev: Replace port attr get/set SDO with a notification
  net: Remove switchdev_ops

 Documentation/networking/switchdev.txt        |  10 +-
 .../net/ethernet/mellanox/mlxsw/spectrum.c    |  12 --
 .../net/ethernet/mellanox/mlxsw/spectrum.h    |   2 -
 .../mellanox/mlxsw/spectrum_switchdev.c       |  36 +++---
 drivers/net/ethernet/mscc/ocelot.c            |  26 ++++-
 drivers/net/ethernet/rocker/rocker_main.c     |  30 ++++-
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c       |  30 ++++-
 include/linux/netdevice.h                     |   3 -
 include/net/switchdev.h                       |  28 ++---
 net/dsa/slave.c                               |  30 ++++-
 net/switchdev/switchdev.c                     | 107 ++++++------------
 11 files changed, 168 insertions(+), 146 deletions(-)

-- 
2.19.1

