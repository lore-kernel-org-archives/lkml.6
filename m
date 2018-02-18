Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751721AbeBRWBu (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 17:01:50 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36452 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751598AbeBRWBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 17:01:49 -0500
From: Hans de Goede <hdegoede@redhat.com>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/9] ASoC: Intel: sst: Fix Bay Trail suspend/resume issues
Date: Sun, 18 Feb 2018 23:01:37 +0100
Message-Id: <20180218220146.22485-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Here is a series fixing suspend/resume errors (and broken audio after
resume) on Bay Trail devices.

Cherry Trail devices also do not like being suspend while audio is
playing, but with different sypmtoms instead of SST_ERR_INVALID_STREAM_ID
errors, if a stream was playing (being allocated is fine, playing is a
problem) before suspend then after resume we get the following errors:

  [ 2312.389974] intel_sst_acpi 808622A8:00: sst: Busy wait failed, cant send this msg
  [ 2312.597976] intel_sst_acpi 808622A8:00: sst: Busy wait failed, cant send this msg
  ...

Until the stream is stopped and restarted after which things work fine
again. I've tried enabling the quirk this commit adds for Cherry Trail
devices too, but that does not help. If anyone has any clues about the CHT
problem, please let me know.

Regards,

Hans
