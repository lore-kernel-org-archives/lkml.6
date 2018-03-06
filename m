Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753547AbeCFLW1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 06:22:27 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42481 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753184AbeCFLWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 06:22:25 -0500
X-Google-Smtp-Source: AG47ELuNZqtNNK74k3ly/S4WKExqO9BKWLWZVFXpSsZ1ZPXqtc/XMc1mJOxmVgsZZFsgj5MPjFKaSVFT0j5KrMo+brg=
MIME-Version: 1.0
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Tue, 6 Mar 2018 12:22:24 +0100
Message-ID: <CAHUa44HqoQ2yxBzJsQQxb35h=S4suDB7qpoQXwsBhx_OXHyBMw@mail.gmail.com>
Subject: [GIT PULL] tee driver misc for v4.17
To: arm-soc <arm@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w26BMWTd014692

Hello arm-soc maintainers,

Please pull these tee driver changes. This fixes a a problem with
determining the max device id value for the privileged device. This is
only a problem if there's more than 16 tee devices registered. There's
also added support to report OP-TEE revision information.

The bugfix isn't urgent so I'm aiming for the next merge window.

Thanks,
Jens

The following changes since commit 661e50bc853209e41a5c14a290ca4decc43cbfd1:

  Linux 4.16-rc4 (2018-03-04 14:54:11 -0800)

are available in the git repository at:

  https://git.linaro.org:/people/jens.wiklander/linux-tee.git
tags/tee-drv-misc-for-v4.17

for you to fetch changes up to 5c5f80307ab27c53b56569245a0b12f4e3b577de:

  tee: optee: report OP-TEE revision information (2018-03-06 11:03:55 +0100)

----------------------------------------------------------------
Small fix and report OP-TEE revision information

* Adds one small fix correct max value of privileged device id allocation,
  this is only needed if there's more than TEE_NUM_DEVICES / 2 (16) tee
  drivers registered. One or two is a normal value.
* Reports OP-TEE revision information (major, minro version and build id
  if available)

----------------------------------------------------------------
Jérôme Forissier (2):
      tee: optee: GET_OS_REVISION: document a2 as a build identifier
      tee: optee: report OP-TEE revision information

Peng Fan (1):
      tee: correct max value for id allocation

 drivers/tee/optee/core.c      | 23 +++++++++++++++++++++++
 drivers/tee/optee/optee_smc.h | 10 +++++++++-
 drivers/tee/tee_core.c        | 14 +++++++++-----
 3 files changed, 41 insertions(+), 6 deletions(-)
