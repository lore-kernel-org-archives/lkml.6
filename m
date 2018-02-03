Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752789AbeBCRnK (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 12:43:10 -0500
Received: from mout.web.de ([217.72.192.78]:60849 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752235AbeBCRm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 12:42:59 -0500
Subject: [PATCH 6/6] hid-prodikeys: Rename a jump label in pcmidi_send_note()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <c388b4d8-fa43-1bf2-e27d-1a3a8d636118@users.sourceforge.net>
Message-ID: <5f63f181-2b5a-911e-996c-6918e277a484@users.sourceforge.net>
Date: Sat, 3 Feb 2018 18:42:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <c388b4d8-fa43-1bf2-e27d-1a3a8d636118@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:xqPugCZO7uztNew5uRXTUQ46GItwYLBAkinr5geUKa2xrFPKKz+
 QierHVaag0hEJ8hg1mBzaHjDpNBoYM95QihnZZ53V0lGJzoG0toKJbzuVZwtKBxWU/5EGNI
 +FoGu+jQoSpGTL3N0D86jka1Sm5tIxXTJT+Psd19qzbZ94ZAACqaO26yPS7ZmC8kJFsi9bk
 LsriY+7yj35lBuNn5Q5cw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FOmC49ZgBNk=:BVWKz5toQHowaWcPotVQ1S
 NGA0/qETPFqDTYKZE9nWSOeyDYtVsTVj+4nKmSNeg/ZmTzd6s5SGdf2UaaTvId0TeV3Ke//uv
 71RzSOJOCOE3h91ZgdYwz1+w/zfNpBSWxhnelExIABanhIjZzB2khNAEFFq37HcTFSCPCc93L
 6NyOf49iKypjvT80uU8bSyKFN8r+GWuMTpAgDTEgaIsZTOVUpWesiLJxvQUynP4dreWoh1o4e
 mmNsrFWAgHb/lBgkcRqtGdXy9XXZfhkQmkyxoLO6q7VYMFSdA9Eze+v7aIxTCu/fZUCH4PnsE
 SJtj4KP8M7YpBhrjJtN8QZK8G2DrMU8sIvX/fOYWnyzPyIxk0AvNUZ8tpNZoKYff3UK694nLE
 DUOA1DIFn4IxENM5O3cg3SKFSDD8rZSHxBOUh6CPKa6DEuF9BG1UUEfUsXJ4+CE1H2CaPXWmI
 XCGVM9ho3qeq9Zi5bQAH9T1UeO0FdAEOoGmEy8wLgUB+Hz/bM8opaguXZQvPs6Na+D6b/OBI/
 l3yeMR4iUS6lyT62ZBI+seYMOJQyd2pwNz6BKlmZblmfW+RIGWNNvvpCMkHeZoWKFRXE/LLr3
 eCbuoM6ERhTMBKHjIyxryrFpEW1w4JApF93YGigwr0eQ+mt/QS4DHnd2MZYcTLfpjaT9v5nzF
 qUHOKEeB/yliMAIevDa7WCvMp66VQx+5u5B5QY2crJGpcQpxwb+UYjPsWTJ3oN4odUdtg4X4q
 Y4YEB77ZJTqyomah/8qV/Qm+t3SE8olrjkjZn3uzs5k0JxjXX3txLB8aLqrrQrFprRDB6ka/I
 vRDmPQb1oVXnfL1IaqXnHRHRQOjkYvjeBX5wYUyltiSvA13lm0=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 3 Feb 2018 18:10:00 +0100

An other label fits better to the jump target. Thus rename it.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-prodikeys.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-prodikeys.c b/drivers/hid/hid-prodikeys.c
index 1c62dddedd40..4596d97b61eb 100644
--- a/drivers/hid/hid-prodikeys.c
+++ b/drivers/hid/hid-prodikeys.c
@@ -228,11 +228,11 @@ static void pcmidi_send_note(struct pcmidi_snd *pm,
 
 	if (!pm->in_substream ||
 	    !test_bit(pm->in_substream->number, &pm->in_triggered))
-		goto drop_note;
+		goto unlock;
 
 	snd_rawmidi_receive(pm->in_substream, buffer, 3);
 
-drop_note:
+unlock:
 	spin_unlock_irqrestore(&pm->rawmidi_in_lock, flags);
 }
 
-- 
2.16.1
