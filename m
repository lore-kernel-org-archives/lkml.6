Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753880AbeCYS2f (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 14:28:35 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:45205 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753472AbeCYS2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 14:28:32 -0400
X-Google-Smtp-Source: AG47ELu9w6p9mAQb6rhLAeSgTzTIh5Y0W/+G0tmmffEWeIS2YHzsJWMDrvBIs/MtaSRtp94e65K4VQ==
From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=
        <avarab@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=
        <avarab@gmail.com>
Subject: [PATCH 0/2] send-email: impose a delay while sending to appease GMail
Date: Sun, 25 Mar 2018 18:28:01 +0000
Message-Id: <20180325182803.30036-1-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.rc1.37.g46b2b28759
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GMail doesn't sort E-Mail by the "Date" header, but by when the E-Mail
was received. As a result patches sent to the git ML and LKML (and
friends) show up out of order in GMail.

This series works around that issue by sleeping for 1 second between
sending E-Mails.

If you're on the LKML and wondering why you got this, I figured
feedback from the other big user (that I know of) of send-email would
be helpful.

Ævar Arnfjörð Bjarmason (2):
  send-email: add an option to impose delay sent E-Mails
  send-email: supply a --send-delay=1 by default

 Documentation/config.txt         | 17 ++++++++++
 Documentation/git-send-email.txt |  4 +++
 git-send-email.perl              | 15 +++++++--
 t/t9001-send-email.sh            | 55 ++++++++++++++++++++++++++++++++
 4 files changed, 89 insertions(+), 2 deletions(-)

-- 
2.16.2.804.g6dcf76e118
