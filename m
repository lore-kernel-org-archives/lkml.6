Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965798AbeBMUlL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 15:41:11 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:37247 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965676AbeBMUlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 15:41:10 -0500
X-Google-Smtp-Source: AH8x226pfwUhJdLtfKcFBjzDV61IMF+3JqtjfYi+0uYf7fMqPyAUnaFXzSulytMRTEyjjUUy0o23Bw==
From: Markus Mayer <mmayer@broadcom.com>
To: Brian Norris <computersforpeace@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>
Cc: Markus Mayer <mmayer@broadcom.com>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] Update for the Broadcom STB DPFE driver
Date: Tue, 13 Feb 2018 12:40:37 -0800
Message-Id: <1518554440-21805-1-git-send-email-mmayer@broadcom.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series primarily introduces a new way of passing information from
the DCPU to the host CPU.

Previously, all communication was via the DCPU data RAM. This
communication mode is still supported. In addition, we now support
passing data via the message RAM. The driver will dynamically detect
which method to use upon receiving a reply.

The series also contains two fixes to the driver that have no direct
relation with the new communication feature.

Markus Mayer (3):
  memory: brcmstb: dpfe: properly mask vendor error bits
  memory: brcmstb: dpfe: fix type declaration of variable "ret"
  memory: brcmstb: dpfe: support new way of passing data from the DCPU

 drivers/memory/brcmstb_dpfe.c | 74 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 60 insertions(+), 14 deletions(-)

-- 
2.7.4
