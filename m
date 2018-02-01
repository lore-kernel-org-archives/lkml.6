Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752001AbeBAI5e (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 03:57:34 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:40157 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751772AbeBAI53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 03:57:29 -0500
X-Google-Smtp-Source: AH8x224N1ePhJ7UvHxUSn1sc7Sx7pXtOJt2diKqGj9b4OFNaiPRX90gJz+N+sGisJ5HPFBOq7Bu4og==
From: Oleksandr Andrushchenko <andr2000@gmail.com>
To: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc: jgross@suse.com, david.vrabel@citrix.com, boris.ostrovsky@oracle.com,
        otubo@redhat.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [PATCH] xen: fix frontend driver disconnected from xenbus on removal
Date: Thu,  1 Feb 2018 10:57:18 +0200
Message-Id: <1517475439-10541-1-git-send-email-andr2000@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

Hi, all!

While working on DRM PV frontend driver I faced an issue with
driver removal, e.g. when driver's .remove callback is called
the driver is already disconnected form the xenbus and it is not
possible to synchronize the process of removal with the backend.
Backend in my case is a user-space application, so this may explain
why backends which are kernel modules do not suffer from this:
it seems that user-space is clumsy and its states are not delivered
through xenbus fast enough.

The obvious way to fix this behavior is to disconnect frontend
drivers from xenbus _after_ their .remove callback is called.

Thank you,
Oleksandr Andrushchenko

Oleksandr Andrushchenko (1):
  xen: fix frontend driver disconnected from xenbus on removal

 drivers/xen/xenbus/xenbus_probe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.7.4
