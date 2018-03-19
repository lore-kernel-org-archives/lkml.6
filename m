Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932861AbeCSMpn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 08:45:43 -0400
Received: from fallback.hitachi.co.jp ([133.145.228.49]:50864 "EHLO
        mailx.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932537AbeCSMpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 08:45:41 -0400
Message-ID: <5AAFA661.60103@hitachi.com>
Date: Mon, 19 Mar 2018 21:00:33 +0900
From: KAMEI Hitoshi <hitoshi.kamei.xm@hitachi.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
MIME-Version: 1.0
To: idryomov@gmail.com, sage@redhat.com, elder@kernel.org,
        ceph-devel@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] rbd: thick-provision image support
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds the thick-provision image support to
/drivers/block/rbd.c relating to https://github.com/ceph/ceph/pull/18317.
The rbd will not issue the discard operation to thick-provision
images, if applied.

The rbd should not discard any allocated blocks of thick-provision
image to ensure writing data to rbd images. So this patch
prevents from discarding allocated blocks on thick-provision
image.

This patch series creates sysfs file to manipulate thick-provision
status. If users write "1" to /sys/bus/rbd/devices/<dev-id>/thick,
then the image is changed to thick-provision image. And if users
write "0" to it, then the image is changed to thin-provision
image. I will add the code changing status for the rbd map command.

Hitoshi Kamei (2):
  rbd: RBD_DEV_FLAG_THICK rbd_dev_flags bit
  rbd: add 'thick' sysfs rbd device attribute

 Documentation/ABI/testing/sysfs-bus-rbd |  6 ++++++
 drivers/block/rbd.c                     | 37 +++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

-- 
2.15.1
