Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F828C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6FFB20C0D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:51:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6FFB20C0D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389442AbeGKP4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 11:56:08 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:59632 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387608AbeGKP4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 11:56:08 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue006 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MNRWv-1fkB8l1ngn-006vmU; Wed, 11 Jul 2018 17:50:42 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] extcon: max3355: include mod_devicetable.h
Date:   Wed, 11 Jul 2018 17:50:29 +0200
Message-Id: <20180711155039.3600663-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:ja/inuFXiyz+Lq3a7fs3SGmMKKGqpIm1yJGLWZ+eKMfqrbTaotY
 eHRTfK2KkPNTszia1aR4mKsbnbWrHSRJPyZoIWFxFYrcX+zMz6rvjLaaKdHNXNVpXAvcOpI
 hALcWID3bVMxqeVRaA2PTUaZKH73kn345fRajZ4kn1EIeCqBq7bpSBT77zo6uHMSE2k/hay
 qvzYZGT5knS+wVBg0XCtw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yMY7tsSdO48=:c5euJM0EGk9jXMirTwobeU
 GSOFUPwhiezae5zhaxCvXVU+WJar50r0TMgFo9orFhqFFelxfnaE4d7lWBdxeUWBZzaQwU6g6
 lNDn7NMOm0uuqMwHubrXRf2aktGJHTbXNRAGUKGLH/Qv2i+auBdlbxKoA+FsXrAKuWVaxJPFL
 bxIY+vRXb6papjD1SSfxsI+UxaCkTUnTTTAVXD0bY75l22x38Lhk011D3BwamY4ehI5NVk7FO
 O5DA2JjMdxEJoo07nSAfkwsAq1XuIUiwQn+ASUoWYL7t4Ac1/dRiwutiDSyjA3PHe/mYDCvvm
 ky0m3VIoGnCIwQ7Z5dtJBJAw1vBefuz3mr+ggjxjjxI+ekrATKnwHRcGCNLPSCiY/4hrg8s6m
 JB/6uVDkyMFQl9+jdPuFTG57pRExfy93uWjvPk1RBVQYillZsZyq6RBIcfxusaSBCfVB7zew1
 G185ZmfbhbJ8YV2QuhPeCAs/Vo7wCYZKIeQeC192n3foxWo2Zch/GCCxMQzpAnylzPPj/ZtgI
 b9wIIQZ+bY1ZpmuNoB3DNbvOdTHFJIl0zhB7CHdJPqL85Eu1dS1NT2H2dXVpqef7o4adjjDne
 zr7wqc0/QlDYBdfsyiiy5IpTavy+719o8jX+Nuv2T7NqoFh09c0EkMd7+tVfjcYLwsHeCr511
 D+P+j+2SEdplCWF0o72CO6AIX6rXacGS5LR/DJyWtOpbTRpFsgfnIewXcbnICsw0uJhw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Another driver turned up that is missing linux/mod_devicetable.h after
the device IDs are split out from linux/platform_device.h:

drivers/extcon/extcon-max3355.c:127:34: error: array type has incomplete element type 'struct of_device_id'
 static const struct of_device_id max3355_match_table[] = {

Fixes: ac3167257b9f ("headers: separate linux/mod_devicetable.h from linux/platform_device.h")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Greg, please add that to the char-misc tree that already has
other related patches.
---
 drivers/extcon/extcon-max3355.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/extcon/extcon-max3355.c b/drivers/extcon/extcon-max3355.c
index 0aa410836f4e..1335a476bfec 100644
--- a/drivers/extcon/extcon-max3355.c
+++ b/drivers/extcon/extcon-max3355.c
@@ -14,6 +14,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 
 struct max3355_data {
-- 
2.9.0

