Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751167AbeC2F35 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 01:29:57 -0400
Received: from atl4mhob10.registeredsite.com ([209.17.115.48]:33730 "EHLO
        atl4mhob10.registeredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750709AbeC2F3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 01:29:55 -0400
X-TCPREMOTEIP: 37.74.225.130
X-Authenticated-UID: mike@milosoftware.com
From: Mike Looijmans <mike.looijmans@topic.nl>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andrew@lunn.ch, f.fainelli@gmail.com, robh+dt@kernel.org,
        frowand.list@gmail.com, Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH v4 0/2] of_net: Implement of_get_nvmem_mac_address helper
Date: Thu, 29 Mar 2018 07:29:47 +0200
Message-Id: <1522301389-11034-1-git-send-email-mike.looijmans@topic.nl>
X-Mailer: git-send-email 1.9.1
References: <1521815074-30424-1-git-send-email-mike.looijmans@topic.nl> <20180323151101.GB24361@lunn.ch> <1522046489-19652-1-git-send-email-mike.looijmans@topic.nl> <1522144346-32367-1-git-send-email-mike.looijmans@topic.nl>
In-Reply-To: <1522144346-32367-1-git-send-email-mike.looijmans@topic.nl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Posted this as a small set now, with an (optional) second patch that shows
how the changes work and what I've used to test the code on a Topic Miami board.
I've taken the liberty to add appropriate "Acked" and "Review" tags.

v4: Replaced "6" with ETH_ALEN

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
