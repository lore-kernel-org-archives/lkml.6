Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752796AbeBCRlH (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 12:41:07 -0500
Received: from mout.web.de ([212.227.17.12]:59098 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752235AbeBCRk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 12:40:59 -0500
Subject: [PATCH 4/6] hid-prodikeys: Delete an unnecessary return statement in
 pcmidi_send_note()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <c388b4d8-fa43-1bf2-e27d-1a3a8d636118@users.sourceforge.net>
Message-ID: <92011980-048c-f44b-a064-d2a917b2f51a@users.sourceforge.net>
Date: Sat, 3 Feb 2018 18:40:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <c388b4d8-fa43-1bf2-e27d-1a3a8d636118@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:A0ateQuqRSztQoEzyiAm8VEzdrflCrRky16fnYym91ikL8k76dq
 xojm/Gd11jeq5ArqvOvDTMuYY19xZUEpLfXvRn3jJ3r9OO1SrIkpNudegD7TvASfVXDZOHp
 3MDuMM4VJPxOnSTcJJZNl9ZtJ6vX8xJKx/ej9uPGCAoolFVgH+ez1tP/7P3DPpFQZZc28Nt
 YqxaYsfG2dmrDFFQ0DWQw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0wmw+7zsY6U=:IYlOxyOP/3NNWm9ZFP6xfR
 Ya/9Kxqgmj/zdkBu0ZYD+jQyYJc7qHTomdi650N0Q6AMaEI9rpnd0e2WaMU2ltV/V4qE4+tE/
 KYHRUWFqwWx8hZQOwRI6cHNtvwi1IHy11ezGGU9MH208XNXFK3hrBHvBGmlr74zMgRL/rHziE
 Fv7OkkITMmJQC5TOqfcZnAwyYwBhmMeMdJMyw/6p0VcGBl6bJxIUxh2zY66Mw7Pj2NPWK1fIO
 A3tLkm+dWCxx5x7swJnFPwP7d9M/jADEf53fudeauF7F29Te4qi35bRmgcp5XdbZq6DPxfR4h
 tWfIKrjUafTp5AnW6xCGTf1iZBD3rfBDwwSfsDrPps/dRDcfaBNol07LeFC5WOpFUuMzY0dzL
 f6a7BcZX0oBRaTN9avff0p8Y5Tsic0hfOxkLdsNTXoUhlIZsj+SxS4dhIl4YPKVY1OV5HUlGY
 hpuVDCaxX0V4vdhpnCMdrn6lC2souqy91fHzPtO+7Kpkbn24xhcVn4QuYW3xd2BWWmTvoYJx+
 QsMWdQv4oeYA+Sl/yRLW2pjmx1T13pDaE9Afs3qwkCzibSXFmDDHCSAmJAWxnmagOKGUFibY7
 UF25vmvHGDmw/VrdLB1kONy2SAoy24h25Pu5Q3pTkuN2+JcIuUU5wLt5sriWAedE4XfDNXsES
 jHF2GBfVWU/dj+x8NBXzF1yFmiykwz8V1N+rOAYOBC6KyBPtmAC6a604Nk1IWmJKNaPeEGMt1
 BjHTOa0j7T8nNg2qwfzmo8uWH0p9puNCFJEC2AVzqnlBLl7sUMyp8PiklCe8ey8hqOuy3S9K8
 aPagqCoIUSIitvCW5hmkJnsBUcN0vDu+B3Ir0GKcTxtzX3qOKs=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 3 Feb 2018 17:33:40 +0100

The script "checkpatch.pl" pointed information out like the following.

WARNING: void function return statements are not generally useful

Thus remove such a statement in the affected function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-prodikeys.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/hid/hid-prodikeys.c b/drivers/hid/hid-prodikeys.c
index 7672f723b268..c9eae92ad429 100644
--- a/drivers/hid/hid-prodikeys.c
+++ b/drivers/hid/hid-prodikeys.c
@@ -235,8 +235,6 @@ static void pcmidi_send_note(struct pcmidi_snd *pm,
 
 drop_note:
 	spin_unlock_irqrestore(&pm->rawmidi_in_lock, flags);
-
-	return;
 }
 
 static void pcmidi_sustained_note_release(struct timer_list *t)
-- 
2.16.1
