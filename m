Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964807AbeCHJhA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 04:37:00 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:43282 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755238AbeCHJg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 04:36:58 -0500
X-Google-Smtp-Source: AG47ELs5Ehu+lGeSRmRTMTHH28jLhovMUbSDJNth3UauIpNYpWGf9HeiYgoVXYm+1BwqJN/3/WRCqw==
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: ohad@wizery.com, bjorn.andersson@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: [PATCH 0/2] rpmsg: use put_device() if device_register fail
Date: Thu,  8 Mar 2018 15:06:06 +0530
Message-Id: <cover.1520501519.git.arvind.yadav.cs@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if device_register() returned an error! Always use put_device()
to give up the reference initialized. unregister device for
other return error.


Arvind Yadav (2):
  [PATCH 1/2] rpmsg: glink: use put_device() if device_register fail
  [PATCH 2/2] rpmsg: smd: use put_device() if device_register fail

 drivers/rpmsg/qcom_glink_smem.c | 3 ++-
 drivers/rpmsg/qcom_smd.c        | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
1.9.1
