Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A2DC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8623020868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="r6zHgA+f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8623020868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=telus.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbeK3S5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 13:57:32 -0500
Received: from cmta20.telus.net ([209.171.16.93]:36582 "EHLO cmta20.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726572AbeK3S5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 13:57:32 -0500
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id SdXngsaE2VltLSdXogRWJn; Fri, 30 Nov 2018 00:49:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1543564145; bh=GIFLzX05brnp7VCzWztVkNUPlce89SEzJycOr9HjSW4=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=r6zHgA+fr8HNj7W5Bw034vPDBV/pJ1U1OWilaA77xaCZlmGnoA0TfbP8iJJIlFmd0
         w2vi9yktj4QumLdrL+eigDYrxqhQYlS7Z93EGBXCTZv0aTvE2Op7MHmbwSid325NZh
         xDiT+7rLpZ05opqYKZpKpMZ34oslzY/zS0Fc6DhXBqFXmHFeK5EwCmUxU/0+uX48hc
         Ut47EsR6szkq9O4k/m7xKHg5J6NoFd6XdKK9Iu/njlG8s0mFknyu7W3+Oez9jCnD3M
         YCnqxFSkSQSr2++WJVww6hzP/ryywkRoeKM8jRfXLszpn/ZBYCWxZCbP5J6tnt2aSa
         8p9GaR9xjhS6Q==
X-Authority-Analysis: v=2.3 cv=d60kNirE c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=6kd9dKSLDcPQKLEMpDgA:9
 a=CjuIK1q_8ugA:10
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc:     "'Giovanni Gherdovich'" <ggherdovich@suse.cz>,
        "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Frederic Weisbecker'" <frederic@kernel.org>,
        "'Mel Gorman'" <mgorman@suse.de>,
        "'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "Doug Smythies" <dsmythies@telus.net>
References: Q8oEgsq1aDhAwQ8oJg8ZUI
In-Reply-To: Q8oEgsq1aDhAwQ8oJg8ZUI
Subject: RE: [RFC/RFT][PATCH v6] cpuidle: New timer events oriented governor for tickless systems
Date:   Thu, 29 Nov 2018 23:48:57 -0800
Message-ID: <001901d48881$29ea59d0$7dbf0d70$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdSDGEuEn5NKr78+TzWlxEKC0bSkgwFSVtCg
X-CMAE-Envelope: MS4wfPXplEbacC4x0niDUe36RKbBPgGzMfZ4OSB4ZxRJBNejFAZ1GhpC4995n12ifK9j9mt0KYNNwjZZKIp8nZj8mm0yPpQINgTqtumeBk3shAvA9elIGhO4
 F0YJ8H25ZB+42oRQB/Xuo+Xj97FstQlgLoVWRjj8uibQIOztmyjMFmbg/gZo24EhHLCCqdgJrS4EZeriejjHULNYoAN7tz/YxxolD544Jfs08k746j1LuRUC
 sUaH7izZ0Nv4+dAARF869o73PXAXG8omrT8bsrub8e60xagUMsAK+g+B3mDGZzzzxD3LlYrMa6tY43aXqI88bTezQ8LAugv+ByC8ZkBUlQfYSD54w4/XEu3q
 FeFKYOEC3c9F0tIHzaGy529n3Kk570QpbxGHRClR5FrLxoSQ2QxNPsIhTKoYmjNCLDGQNsVc0ZW/hdhEasiEdUK9hF/84u6/ienwSuoCMX7rbsnqJG41Bs9e
 5jYJ2IZEfZVca+7j
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On 2018.11.23 02:36 Rafael J. Wysocki wrote:

... [snip]...

> +/**
> + * teo_find_shallower_state - Find shallower idle state matching given duration.
> + * @drv: cpuidle driver containing state data.
> + * @dev: Target CPU.
> + * @state_idx: Index of the capping idle state.
> + * @duration_us: Idle duration value to match.
> + */
> +static int teo_find_shallower_state(struct cpuidle_driver *drv,
> +				    struct cpuidle_device *dev, int state_idx,
> +				    unsigned int duration_us)
> +{
> +	int i;
> +
> +	for (i = state_idx - 1; i > 0; i--) {
> +		if (drv->states[i].disabled || dev->states_usage[i].disable)
> +			continue;
> +
> +		if (drv->states[i].target_residency <= duration_us)
> +			break;
> +	}
> +	return i;
> +}

I think this subroutine has a problem when idle state 0
is disabled.

Perhaps something like this might help:

diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
index bc1c9a2..5b97639 100644
--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -196,7 +196,8 @@ static void teo_update(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 }

 /**
- * teo_find_shallower_state - Find shallower idle state matching given duration.
+ * teo_find_shallower_state - Find shallower idle state matching given
+ * duration, if possible.
  * @drv: cpuidle driver containing state data.
  * @dev: Target CPU.
  * @state_idx: Index of the capping idle state.
@@ -208,13 +209,15 @@ static int teo_find_shallower_state(struct cpuidle_driver *drv,
 {
        int i;

-       for (i = state_idx - 1; i > 0; i--) {
+       for (i = state_idx - 1; i >= 0; i--) {
                if (drv->states[i].disabled || dev->states_usage[i].disable)
                        continue;

                if (drv->states[i].target_residency <= duration_us)
                        break;
        }
+       if (i < 0)
+               i = state_idx;
        return i;
 }

@@ -264,7 +267,6 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
                        if (max_early_idx >= 0 &&
                            count < cpu_data->states[i].early_hits)
                                count = cpu_data->states[i].early_hits;
-
                        continue;
                }

There is an additional issue where if idle state 0 is disabled (with the above suggested code patch),
idle state usage seems to fall to deeper states than idle state 1.
This is not the expected behaviour.
Kernel 4.20-rc3 works as expected.
I have not figured this issue out yet, in the code.

Example (1 minute per sample. Number of entries/exits per state):
    State 0     State 1     State 2     State 3     State 4    Watts
   28235143,         83,         26,         17,        837,  64.900
    5583238,     657079,    5884941,    8498552,   30986831,  62.433 << Transition sample, after idle state 0 disabled
          0,     793517,    7186099,   10559878,   38485721,  61.900 << ?? should have all gone into Idle state 1
          0,     795414,    7340703,   10553117,   38513456,  62.050
          0,     807028,    7288195,   10574113,   38523524,  62.167
          0,     814983,    7403534,   10575108,   38571228,  62.167
          0,     838302,    7747127,   10552289,   38556054,  62.183
    9664999,     544473,    4914512,    6942037,   25295361,  63.633 << Transition sample, after idle state 0 enabled
   27893504,         96,         40,          9,        912,  66.500
   26556343,         83,         29,          7,        814,  66.683
   27929227,         64,         20,         10,        931,  66.683
 
... Doug


