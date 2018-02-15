Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755492AbeBOTai (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 14:30:38 -0500
Received: from mout.web.de ([212.227.17.11]:39655 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751104AbeBOTag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 14:30:36 -0500
Subject: [PATCH 2/2] cpufreq: powernow-k8: Delete an unnecessary return
 statement in two functions
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <4dd36236-fc39-19e6-c1a7-a094cf13469c@users.sourceforge.net>
Message-ID: <f673f072-86f3-ed72-e715-bed883551be4@users.sourceforge.net>
Date: Thu, 15 Feb 2018 20:30:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <4dd36236-fc39-19e6-c1a7-a094cf13469c@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:QpPPgSY/BJsWv7v3BsXhtQhkocKTTHpMms+EPL7lTi+rdk4yekM
 6CbdQKFTrc60v7vVZ6e448Khtkd+lBEBcVMyY2/9wew866O/7sE1FKMndMoxJIx2KmOinzA
 BZsYCeIqrY+P2+ntE0Co6RR0bPXKy1KfCWUYPnGOGJZ2mt5XA+r04nL+zViFR2ZLmX5zAZX
 +HvfwFdRaJB4vW6H7QuaA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LhVa1OE4k4M=:W4Rs9kVhl7UXq9xKGjeJ/H
 mEWUQoc2efy1Qujd82VeF7XcleKbrrb5lsJj0bSJ8DWz86QYvd4ECjXjoBv8W+NH8szcTI65N
 +NqiN0ozbd51Jlehrbnki6QRnyPlwJZhOw/pSl7EuN12FY2ZPDLAYGgPRvv/N/ulrX4fyDOGF
 bYMnyrYoZ1ibXgt5KQjkKJraJLVb6XARu/Db4YbsdDbir8nlwI89YsGMr4DEHfhy6CM/TdtQ3
 xNK5I0xBbOkcRawYtr6zlat7FBB6A5yJgKa8Atn8/bBPq4b3s8uqZ8fTsEm8cWWM+R7tH+Ohx
 fIyOlkCEc9dhImgnW42T2Efre9R+Ig4oSrIWtr0af9+tbDYJVgoVsb2u1zjPc1+btw4xuN/2a
 Px2xMSYcUaaKtkq501RiYSqi1jfpZ667WnT2VhMB41fVjbko/v/JD8ZkyGxbMQbTjIbaoPuPY
 EuquH4iD4ZtK9uo/F45TvFM9xeV+OfeXIvH/OTYNARIGIn2O7RgpeDta4NLXJwRhC73iZESpn
 OY8eTHbvDp/1+zTOzmj7FsGAxwVXcEYrqtczaIQzArAfMewRHpUXr8gCJk3sPVN4kwyP6YcIi
 2WVeRm4AupQ+U4W6d7M7lNKA0ETYdYaTNcO6BOoeXNQ+OaQ0fPT8I5LYkHdR7ceSGF93/4JEJ
 w4Fwr1KKwaQVLyxFvChwHwmrkqRx2UxfAuFUsGfDjs4bGbuVcV69lrAWb5CXz2tJlcWtnDvrh
 Q60SoCdXz9BFZIKtjX4saS16jdQJ2i13AE2db43DNLtaZfFfrNpkNHhLgZmIfimLz3xBB1OI+
 bJaj9nQmGlw2unQCoPN1f6PcFjyA4WZFmvO2CtHtk0eACAw56Y=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 15 Feb 2018 20:14:32 +0100

The script "checkpatch.pl" pointed information out like the following.

WARNING: void function return statements are not generally useful

Thus remove such a statement in the affected functions.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/cpufreq/powernow-k8.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/cpufreq/powernow-k8.c b/drivers/cpufreq/powernow-k8.c
index 460bf22a8a2b..782a8c2a359d 100644
--- a/drivers/cpufreq/powernow-k8.c
+++ b/drivers/cpufreq/powernow-k8.c
@@ -122,14 +122,12 @@ static int query_current_values_with_pending_wait(struct powernow_k8_data *data)
 static void count_off_irt(struct powernow_k8_data *data)
 {
 	udelay((1 << data->irt) * 10);
-	return;
 }
 
 /* the voltage stabilization time */
 static void count_off_vst(struct powernow_k8_data *data)
 {
 	udelay(data->vstable * VST_UNITS_20US);
-	return;
 }
 
 /* need to init the control msr to a safe value (for each cpu) */
-- 
2.16.1
