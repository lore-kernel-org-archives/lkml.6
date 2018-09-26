Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=FROM_WORDY,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F818C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 057512086E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:23:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 057512086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diasemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbeIZVhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 17:37:20 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.2]:38630 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726937AbeIZVhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 17:37:19 -0400
Received: from [85.158.142.104] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-a.eu-central-1.aws.symcld.net id 57/FF-23311-784ABAB5; Wed, 26 Sep 2018 15:23:51 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRWlGSWpSXmKPExsUSt3OpsW7bktX
  RBr9vWVk0L17PZtG1eieLxeVdc9gsFi1rZbZ4svAMkwOrx7yTgR77565h99j5vYHd4/MmuQCW
  KNbMvKT8igTWjA0Hv7EXLGatOHLmAnMD4w6WLkYuDiGB9YwS/z69Ye5i5ARyKiT6lnwBs3kF3
  CR2rdrJBGKzCVhITD7xgA3EZhFQldi0pxesRlggQGLr9Pdgg0QEehglNh5Zwg6SYBZIklj7tg
  dqkKDEyZlPWCDiEhIHX7yAWmYgcXpBI1hcQsBeYvr7q0BxDiBbX6LxWCxE2FDi+6xvUCXmEl3
  TpzJPYOSfhWTqLCRTFzAyrWK0SCrKTM8oyU3MzNE1NDDQNTQ01jXSNTHRS6zSTdRLLdVNTs0r
  KUoESuollhfrFVfmJuek6OWllmxiBAZ0SiGTzg7GTwvTDzFKcjApifIq+KyOFuJLyk+pzEgsz
  ogvKs1JLT7EKMPBoSTBa7gYKCdYlJqeWpGWmQOMLZi0BAePkgivCUiat7ggMbc4Mx0idYpRUU
  qcVwUkIQCSyCjNg2uDxfMlRlkpYV5GBgYGIZ6C1KLczBJU+VeM4hyMSsK8XiBTeDLzSuCmvwJ
  azAS0eELPCpDFJYkIKakGRrHvblz9VxWVlx1u31m24lTs7LMcN82PGcj+npe7sIeNw3TShKtz
  09xlrlwTmm1p27ySbcvUsyF34mVZPj3aaeFj/Sr03OqUopii1vT5m8sePRT7eHp/h/URCW6bh
  O7fKlK9Mpb9r1PWLBZdN/loFnenc2JHvVWB/vqtX0uOcnBa1silrD30VYmlOCPRUIu5qDgRAK
  Nux8LiAgAA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-18.tower-229.messagelabs.com!1537975430!361960!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.14.24; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 2814 invoked from network); 26 Sep 2018 15:23:50 -0000
Received: from mailrelay2.diasemi.com (HELO sw-ex-cashub01.diasemi.com) (94.185.165.51)
  by server-18.tower-229.messagelabs.com with AES128-SHA encrypted SMTP; 26 Sep 2018 15:23:50 -0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 SW-EX-CASHUB01.diasemi.com (10.20.16.140) with Microsoft SMTP Server id
 14.3.382.0; Wed, 26 Sep 2018 16:23:50 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22379)      id
 2A0513FAF0; Wed, 26 Sep 2018 16:23:50 +0100 (BST)
Message-ID: <cover.1537975081.git.Adam.Thomson.Opensource@diasemi.com>
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date:   Wed, 26 Sep 2018 16:23:50 +0100
Subject: [PATCH 0/2] usb: typec: fusb302: Resolve fixed role power configuration
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-ServerInfo: sw-ex-cashub01.diasemi.com, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 26/09/2018 13:22:00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This small patch set updates the fusb302 driver to correctly report CC line
status during attach, when the device is configured as source only or sink only
(non-DRP), so that TCPM state machine correctly proceeds with contract
establishment. In addition, a trivial typo with regards to the OFF toggling
state for the device is corrected.

Changes are based on usb-testing (ae8a2ca8a221)

Adam Thomson (2):
  usb: typec: fusb302: Correct spelling mistake for toggling state
  usb: typec: fusb302: Resolve fixed power role contract setup

 drivers/usb/typec/tcpm/fusb302.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

-- 
1.9.1

