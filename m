Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9406C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0BF320882
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:49:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0BF320882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbeIKMrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 08:47:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:46034 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726482AbeIKMrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 08:47:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9B661AEF8;
        Tue, 11 Sep 2018 07:49:13 +0000 (UTC)
Date:   Tue, 11 Sep 2018 09:49:12 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID fixes
Message-ID: <nycvar.YFH.7.76.1809110944350.15880@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid.git for-linus

to receive fixes for HID subsystem; highlights:

=====
- functional regression fix for sensor-hub driver from Hans de Goede
- stop doing device reset for i2c-hid devices, which unbreaks some of them 
  (and is in line with the specification), from Kai-Heng Feng
- error handling fix for hid-core from Gustavo A. R. Silva
- functional regression fix for some Elan panels from Benjamin Tissoires
- a few new device ID additions and misc small fixes
=====

Thanks.

----------------------------------------------------------------
AceLan Kao (1):
      HID: i2c-hid: Fix flooded incomplete report after S3 on Rayd touchscreen

Andreas Bosch (1):
      HID: intel-ish-hid: Enable Sunrise Point-H ish driver

Benjamin Tissoires (2):
      HID: multitouch: fix Elan panels with 2 input modes declaration
      HID: core: fix grouping by application

Gustavo A. R. Silva (1):
      HID: core: fix NULL pointer dereference

Hans de Goede (1):
      HID: sensor-hub: Restore fixup for Lenovo ThinkPad Helix 2 sensor hub report

Harry Mallon (1):
      HID: hid-saitek: Add device ID for RAT 7 Contagion

Kai-Heng Feng (1):
      HID: i2c-hid: Don't reset device upon system resume

Sean O'Brien (1):
      HID: add support for Apple Magic Keyboards

Stefan Agner (2):
      HID: input: fix leaking custom input node name
      HID: core: fix memory leak on probe

 drivers/hid/hid-apple.c                 |  9 ++++++++-
 drivers/hid/hid-core.c                  |  5 ++++-
 drivers/hid/hid-ids.h                   |  6 +++---
 drivers/hid/hid-input.c                 |  5 +++--
 drivers/hid/hid-multitouch.c            | 19 +++++++++++++++++--
 drivers/hid/hid-saitek.c                |  2 ++
 drivers/hid/hid-sensor-hub.c            | 23 +++++++++++++++++++++++
 drivers/hid/i2c-hid/i2c-hid.c           | 11 +++++++----
 drivers/hid/intel-ish-hid/ipc/hw-ish.h  |  1 +
 drivers/hid/intel-ish-hid/ipc/pci-ish.c |  1 +
 include/linux/hid.h                     |  1 +
 11 files changed, 70 insertions(+), 13 deletions(-)

-- 
Jiri Kosina
SUSE Labs

