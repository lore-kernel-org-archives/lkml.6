Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751961AbeB0W3n (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 17:29:43 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34220 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752210AbeB0W3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 17:29:40 -0500
X-Google-Smtp-Source: AG47ELvX84Rg0+WQrirkA6SIUNilzMH7fEIS6x93DpqP0W/0Wkw+akQOH7QxjaYNjhKgLh6I2aOcBA==
From: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
To: sathya.perla@broadcom.com, ajit.khaparde@broadcom.com,
        sriharsha.basavapatna@broadcom.com, somnath.kotur@broadcom.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        hernan@vanguardiasur.com.ar
Subject: [PATCH] emulex/benet: Constify *be_misconfig_evt_port_state[]
Date: Tue, 27 Feb 2018 19:29:23 -0300
Message-Id: <1519770563-20603-1-git-send-email-hernan@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note: This is compile only tested as I have no access to the hw.
No benefit gained except for some self-documenting.

add/remove: 0/0 grow/shrink: 0/0 up/down: 0/0 (0)
Function                                     old     new   delta
Total: Before=2757703, After=2757703, chg +0.00%

Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
---
 drivers/net/ethernet/emulex/benet/be_cmds.c | 2 +-
 drivers/net/ethernet/emulex/benet/be_cmds.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/emulex/benet/be_cmds.c b/drivers/net/ethernet/emulex/benet/be_cmds.c
index 1a49297..ff92ab1 100644
--- a/drivers/net/ethernet/emulex/benet/be_cmds.c
+++ b/drivers/net/ethernet/emulex/benet/be_cmds.c
@@ -19,7 +19,7 @@
 #include "be.h"
 #include "be_cmds.h"
 
-char *be_misconfig_evt_port_state[] = {
+const char * const be_misconfig_evt_port_state[] = {
 	"Physical Link is functional",
 	"Optics faulted/incorrectly installed/not installed - Reseat optics. If issue not resolved, replace.",
 	"Optics of two types installed – Remove one optic or install matching pair of optics.",
diff --git a/drivers/net/ethernet/emulex/benet/be_cmds.h b/drivers/net/ethernet/emulex/benet/be_cmds.h
index 09da2d8..e8b43cf 100644
--- a/drivers/net/ethernet/emulex/benet/be_cmds.h
+++ b/drivers/net/ethernet/emulex/benet/be_cmds.h
@@ -201,7 +201,7 @@ enum {
 			 phy_state == BE_PHY_UNQUALIFIED ||	\
 			 phy_state == BE_PHY_UNCERTIFIED)
 
-extern  char *be_misconfig_evt_port_state[];
+extern const  char * const be_misconfig_evt_port_state[];
 
 /* async event indicating misconfigured port */
 struct be_async_event_misconfig_port {
-- 
2.7.4
