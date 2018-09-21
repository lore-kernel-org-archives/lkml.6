Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=FROM_WORDY,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DACBC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2163C21532
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:04:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2163C21532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diasemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390298AbeIUUxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 16:53:32 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.3]:53133 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728184AbeIUUxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 16:53:32 -0400
Received: from [85.158.142.98] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-a.eu-central-1.aws.symcld.net id DB/CE-25066-C6805AB5; Fri, 21 Sep 2018 15:04:12 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRWlGSWpSXmKPExsUSt3OpsW4Ox9J
  ogxPdYhbNi9ezWXSt3slicXnXHDaLRctamS2eLDzDZLFg4yNGBzaPeScDPfbPXcPusfN7A7vH
  501yASxRrJl5SfkVCawZi/v2shf0clUcX9/H3MB4gqOLkYtDSGA9o8SU5c/Yuhg5gJwKiTdb0
  roYOTnYBCwkJp94wAZiswioSly6cIwRxBYWCJN4eX0rM0iviEA3o8TJTU/ZQRLMAjUS3+ZPZA
  WxeQUcJBa+bmeCsAUlTs58wgJRIyFx8MULZhBbSMBA4vSCRrC4hIC9xPT3V5lBbpAQ0JdoPBY
  LETaU+D7rG1SJucSbqzOZJzDyz0IydRaSqQsYmVYxWiYVZaZnlOQmZuboGhoY6BoaGusaAUlz
  vcQq3US91FLd5NS8kqJEoKxeYnmxXnFlbnJOil5easkmRmBopxQyle5gnLY8/RCjJAeTkijvs
  VlLooX4kvJTKjMSizPii0pzUosPMcpwcChJ8JawL40WEixKTU+tSMvMAUYZTFqCg0dJhNcEJM
  1bXJCYW5yZDpE6xWjM8W7B/+nMHF+aOmcwC7Hk5eelSonzTgEpFQApzSjNgxsEi/5LjLJSwry
  MDAwMQjwFqUW5mSWo8q8YxTkYlYR5a0Cm8GTmlcDtewV0ChPQKVdAvuAtLklESEk1MFbpLPih
  fMbs1K0f2/grziQn/uVa7SFevFWn3KVUcyK/27ScXo3jq5s6vVfmyT5fea5p0ev3EdwdB78yd
  m3SZBCsTbq0d+qqn0wvuSzOZy+fefjHHZtzsUI1pf7c9cazxWI2PV566EBS56olotxL40Mi2M
  p/+ve8vM2izHDgWaHD00eucRN7+JRYijMSDbWYi4oTAU5mNYz5AgAA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-31.tower-223.messagelabs.com!1537542252!88391!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.14.24; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 24889 invoked from network); 21 Sep 2018 15:04:12 -0000
Received: from mailrelay2.diasemi.com (HELO sw-ex-cashub01.diasemi.com) (94.185.165.51)
  by server-31.tower-223.messagelabs.com with AES128-SHA encrypted SMTP; 21 Sep 2018 15:04:12 -0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 SW-EX-CASHUB01.diasemi.com (10.20.16.140) with Microsoft SMTP Server id
 14.3.382.0; Fri, 21 Sep 2018 16:04:11 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22379)      id
 8BEE73FBE5; Fri, 21 Sep 2018 16:04:11 +0100 (BST)
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date:   Fri, 21 Sep 2018 16:04:11 +0100
Subject: [PATCH] usb: typec: tcpm: Fix APDO PPS order checking to be based on
 voltage
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, <support.opensource@diasemi.com>
Message-ID: <20180921150411.8BEE73FBE5@swsrvapps-01.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-ServerInfo: sw-ex-cashub01.diasemi.com, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 21/09/2018 13:54:00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current code mistakenly checks against max current to determine
order but this should be max voltage. This commit fixes the issue
so order is correctly determined, thus avoiding failure based on
a higher voltage PPS APDO having a lower maximum current output,
which is actually valid.

Fixes: 2eadc33f40d4 ("typec: tcpm: Add core support for sink side PPS")
Cc: <stable@vger.kernel.org>
Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
Code based on usb-testing branch (ae8a2ca8a2215c7e31e6d874f7303801bb15fbb)

 drivers/usb/typec/tcpm/tcpm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 4f1f421..c11b3be 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -1430,8 +1430,8 @@ static enum pdo_err tcpm_caps_err(struct tcpm_port *port, const u32 *pdo,
 				if (pdo_apdo_type(pdo[i]) != APDO_TYPE_PPS)
 					break;
 
-				if (pdo_pps_apdo_max_current(pdo[i]) <
-				    pdo_pps_apdo_max_current(pdo[i - 1]))
+				if (pdo_pps_apdo_max_voltage(pdo[i]) <
+				    pdo_pps_apdo_max_voltage(pdo[i - 1]))
 					return PDO_ERR_PPS_APDO_NOT_SORTED;
 				else if (pdo_pps_apdo_min_voltage(pdo[i]) ==
 					  pdo_pps_apdo_min_voltage(pdo[i - 1]) &&
-- 
1.9.1

