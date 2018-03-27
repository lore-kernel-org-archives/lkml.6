Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752069AbeC0Jx2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 05:53:28 -0400
Received: from atl4mhob12.registeredsite.com ([209.17.115.50]:47476 "EHLO
        atl4mhob12.registeredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751078AbeC0Jwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 05:52:33 -0400
X-TCPREMOTEIP: 37.74.225.130
X-Authenticated-UID: mike@milosoftware.com
From: Mike Looijmans <mike.looijmans@topic.nl>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andrew@lunn.ch, f.fainelli@gmail.com, robh+dt@kernel.org,
        frowand.list@gmail.com, Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH v3 0/2] of_net: Implement of_get_nvmem_mac_address helper
Date: Tue, 27 Mar 2018 11:52:24 +0200
Message-Id: <1522144346-32367-1-git-send-email-mike.looijmans@topic.nl>
X-Mailer: git-send-email 1.9.1
References: <1521815074-30424-1-git-send-email-mike.looijmans@topic.nl> <20180323151101.GB24361@lunn.ch> <1522046489-19652-1-git-send-email-mike.looijmans@topic.nl>
In-Reply-To: <1522046489-19652-1-git-send-email-mike.looijmans@topic.nl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Posted this as a small set now, with an (optional) second patch that shows
how the changes work and what I've used to test the code on a Topic Miami board.

v3: Add patch that implements mac in nvmem for the Cadence MACB controller
    Remove the integrated of_get_mac_address call

v2: Use of_nvmem_cell_get to avoid needing the assiciated device
    Use void* instead of char*
    Add devicetree binding doc

Mike Looijmans (2):
  of_net: Implement of_get_nvmem_mac_address helper
  net: macb: Try to retrieve MAC addess from nvmem provider

 Documentation/devicetree/bindings/net/ethernet.txt |  2 ++
 drivers/net/ethernet/cadence/macb_main.c           | 12 +++++--
 drivers/of/of_net.c                                | 40 ++++++++++++++++++++++
 include/linux/of_net.h                             |  6 ++++
 4 files changed, 57 insertions(+), 3 deletions(-)

-- 
1.9.1
