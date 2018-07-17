Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=FROM_WORDY,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAD2ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ACCE20C10
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:36:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ACCE20C10
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diasemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731721AbeGQPJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 11:09:22 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.66]:21861 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729621AbeGQPJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 11:09:22 -0400
Received: from [46.226.52.200] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-b.eu-west-1.aws.symcld.net id 45/70-19217-5EEFD4B5; Tue, 17 Jul 2018 14:36:21 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRWlGSWpSXmKPExsUSt3Opse7Tf77
  RBkcnCVo0L17PZtG1eieLxeVdc9gsFi1rZbZ4svAMkwOrx7yTgR77565h99j5vYHd4/MmuQCW
  KNbMvKT8igTWjFsrprMUrOOqmH90DWsD406OLkYuDiGB9YwSM0+9Ze9i5ARyKiSO7vjJCGKzC
  VhITD7xgK2LkYODRUBV4uHBEJCwsECYxNxrs1lAekUEuhklTm56CtbLLJAksfZtDzNIPa+Ag8
  TMOdUgYV4BQYmTM5+wQJRISBx88YIZYpWBxOkFjWBxCQF7ienvr4K1SgjoSzQei4UIG0p8n/U
  NqsRc4tGEuawTGPlnIZk6C8nUBYxMqxgtkooy0zNKchMzc3QNDQx0DQ2NdA0tLXUNzQ31Eqt0
  k/RSS3XLU4tLdIHc8mK94src5JwUvbzUkk2MwGBmAIIdjCe+JR9ilORgUhLl5a32jRbiS8pPq
  cxILM6ILyrNSS0+xCjDwaEkwcsDjA4hwaLU9NSKtMwcYFzBpCU4eJREeL/8BUrzFhck5hZnpk
  OkTjEac5xq7pnEzPHn/dRJzEIsefl5qVLivHdBSgVASjNK8+AGweL9EqOslDAvI9BpQjwFqUW
  5mSWo8q8YxTkYlYR5p4JM4cnMK4Hb9wroFCagU6SrwU4pSURISTUwGnAZf5rwUepeXmem5q7Y
  zHOTvui+Oy0kd0Qtn63gZu2xgyGLSx9JdSiV39I/JdDx26jkxIJHTsK2yqc7/n19Gx9Zvdeza
  0tm+czUuj33zUudFzT0hfMu05nzq6tFY1JswtZtpx5sPX+quP+rsdCScpZD3z6bdsZ5p3xi0r
  IM17m8eH+KcwqjEktxRqKhFnNRcSIANtVSzPICAAA=
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-4.tower-288.messagelabs.com!1531838180!4468578!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 5229 invoked from network); 17 Jul 2018 14:36:21 -0000
Received: from mailrelay2.diasemi.com (HELO sw-ex-cashub01.diasemi.com) (94.185.165.51)
  by server-4.tower-288.messagelabs.com with AES128-SHA encrypted SMTP; 17 Jul 2018 14:36:21 -0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 SW-EX-CASHUB01.diasemi.com (10.20.16.140) with Microsoft SMTP Server id
 14.3.382.0; Tue, 17 Jul 2018 15:36:19 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22379)      id
 80EEB3FBB7; Tue, 17 Jul 2018 15:36:19 +0100 (BST)
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date:   Tue, 17 Jul 2018 15:36:19 +0100
Subject: [PATCH] usb: typec: tcpm: Fix sink PDO starting index for PPS APDO
 selection
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <support.opensource@diasemi.com>
Message-ID: <20180717143619.80EEB3FBB7@swsrvapps-01.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-ServerInfo: sw-ex-cashub01.diasemi.com, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 17/07/2018 11:50:00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a bug in the sink PDO search code when trying to select
a PPS APDO. The current code actually sets the starting index for
searching to whatever value 'i' is, rather than choosing index 1
to avoid the first PDO (always 5V fixed). As a result, for sources
which support PPS but whose PPS APDO index does not match with the
supporting sink PPS APDO index for the platform, no valid PPS APDO
will be found so this feature will not be permitted.

Sadly in testing, both Source and Sink capabilities matched up and
this was missed. Code is now updated to correctly set the start
index to 1, and testing with additional PPS capable sources show
this to work as expected.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 drivers/usb/typec/tcpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
index 74e0cda..4f1f421 100644
--- a/drivers/usb/typec/tcpm.c
+++ b/drivers/usb/typec/tcpm.c
@@ -2238,7 +2238,7 @@ static unsigned int tcpm_pd_select_pps_apdo(struct tcpm_port *port)
 			 * PPS APDO. Again skip the first sink PDO as this will
 			 * always be 5V 3A.
 			 */
-			for (j = i; j < port->nr_snk_pdo; j++) {
+			for (j = 1; j < port->nr_snk_pdo; j++) {
 				pdo = port->snk_pdo[j];
 
 				switch (pdo_type(pdo)) {
-- 
1.9.1

