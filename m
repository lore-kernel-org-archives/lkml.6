Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753135AbeBFRco (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 12:32:44 -0500
Received: from mout.web.de ([212.227.15.4]:58694 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752898AbeBFRa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 12:30:59 -0500
Subject: [PATCH 2/2] HID: asus: Return an error code only as a constant in
 asus_start_multitouch()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <5289ace9-8927-9803-4692-c7c621ab0a8d@users.sourceforge.net>
Message-ID: <8408b92e-81fc-89d2-6bf3-e7948673fed6@users.sourceforge.net>
Date: Tue, 6 Feb 2018 18:30:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <5289ace9-8927-9803-4692-c7c621ab0a8d@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:J8khilqhjdFLW4FI7CIZY+Z8ytAGj+RfPcIWiOIgx7xOTePU5cT
 nO06V3MkUbJqtUAIlzHOEeaNB6Um3sb4xESYgTY0B5R4u/Q41420eyKYpz3CcPbyiJT1ZbA
 KcYb1+Qf+/XgDxkZ4jmIZNnyJhYB9dpKhR0/GzmFGxgI44Fg9mCPJGJeVAZ3LQst1URZoCJ
 hty2Yq5prJmDLq9ZgXjDw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qpvkx54ATdw=:FqU00HnsAQ4n2UPQx4TMpX
 VTzYyKsAzL+m9a5X5lJlXpQ0TM+lPhW2EkJ2/6dF9kiDjvocUq651dRiTeoLib6tlbTdMOT9K
 0qsVhtvzhPVXwqS3EIAoKeeNpnbTddehxLbCHiSSkBcEv/tMcRjz8ZfIoh42eVbiixFTJu//8
 8nKbSwHohHlcI27eDqHHjUQZ3ZS76RuV+jW7BNDkqUxcWaLSzSKoHFR+lhfQoBFAHbKNZfAQe
 ZO1NSFzVbDMDwmybEvQ/2lPN9BBAVDKBPJvWO/240T6ZTNdmJtwrm/EfP4SxBDdnbLXkI1N3B
 sy9MhZrzbmo6RqIL2C2rBChltU9ccIxA66uHV/CW5PcT7AxPd6yw/BQxwHopb+RYFHYcDmkf5
 6MaXVUDz9vlewFmGhAOQ5ZBpan489YinV4ikS290KCWXwCYk259suzeAUCRH0Qcin39zQSDOl
 YfBQm7w+F3GmyDYja5WyQwRcrySyfM31CjnrboQTV3qEu6V+kKpvp9/sHS+Js70WXwgjfBPvi
 9UPhUIVV3J9dbELkuXfdSDpmEPcbTKaAy0jv4GSGuWzEVZDTERQ4uof+EiXQ4ybkITe+u5vpb
 SBWEaMx+vbEbx/gKL8+TAyPbjUaX32qPmBLf6AYqiW8PlvVTl6a2iSgv2t3ejN1GEb84Q9Q37
 +5zITVfTVq19aXa868pIcAmAa6u7g6KBZKodyN2oQ/R+3YL6bqIHKBFdPjuRozH15FiW9QToP
 4FmjMbsO4iWTcVTNmUKEsCszMoC3qWakdTIzJ4HXYOa0dcy49ZbYmNjxr7snnV5nNHU6QN/Ki
 avYxmhiJviJPkn+ngTn1VXfgw8ipEz/OtdDxKm9mxjoKSWZq5E=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 6 Feb 2018 18:18:50 +0100

Return an error code without storing it in an intermediate variable.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-asus.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 9573e0b41922..5e143552dab9 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -564,10 +564,8 @@ static int asus_start_multitouch(struct hid_device *hdev)
 	const unsigned char buf[] = { FEATURE_REPORT_ID, 0x00, 0x03, 0x01, 0x00 };
 	unsigned char *dmabuf = kmemdup(buf, sizeof(buf), GFP_KERNEL);
 
-	if (!dmabuf) {
-		ret = -ENOMEM;
-		return ret;
-	}
+	if (!dmabuf)
+		return -ENOMEM;
 
 	ret = hid_hw_raw_request(hdev, dmabuf[0], dmabuf, sizeof(buf),
 					HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
-- 
2.16.1
