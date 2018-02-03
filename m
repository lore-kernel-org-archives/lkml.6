Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752826AbeBCRjN (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 12:39:13 -0500
Received: from mout.web.de ([217.72.192.78]:57230 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752795AbeBCRjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 12:39:06 -0500
Subject: [PATCH 2/6] hid-prodikeys: Delete an unnecessary variable
 initialisation in pk_probe()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <c388b4d8-fa43-1bf2-e27d-1a3a8d636118@users.sourceforge.net>
Message-ID: <fce3ae0c-3467-f6be-519b-79b592691153@users.sourceforge.net>
Date: Sat, 3 Feb 2018 18:38:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <c388b4d8-fa43-1bf2-e27d-1a3a8d636118@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:TvRHbrcs6BBPeFnrFr5dLTYXZb3opKgozjvb2EDDYfuzH/qhSJm
 e1RPqf1Gi/DJyEOpS+7UXa3IOHvCkhdfzb23ZKkxqI+PCyy+aX6W8yWqJcKrIOgXoh4kNhr
 vM7dQKp3uGSUBxstk3VtZGulvN5nobn6YqSV4J3auywRa/UIMqr4OcV3w5z/+x9K9M+r7Ci
 yAxNNV9u0hslUuo6o3Cxw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ln93N9jxdLE=:2UDYwfq8667/edl5mctKYl
 fjzfn97mQC98//bb1AVJJZUGwN4v9Kbx0WrZKDT4hbgc8k3kiLNVsFYy7DMqXtB/9e8noADEd
 l3IyhQTy9l1RHvacuqHxbJeXsov0XG3B08ZUC6c0wAhG9z3az78iXV0B+Li77Sd/GHa4Qnvpf
 MhpDpizAfqpXSwCO1wNisMnErfkzAxyx0giGDvON4rU1DqK0cqBM79ooIgI1fxFLlINux3R0i
 sZJnHwGTw7kahlGYyFzBd0/GDlmQO3tOwy0ZgsxtQjs6qr6gE71/+08/1RU8PXuac18ejFivh
 skmVKEyjDywn17eHlTj2FFPUuRgfZG/IobM8bUDQKyqiMfv8vajF2uEFrVaXPumrwqzVD/qFa
 2jDlPRva7iCt4XM3vsmS9Hb+unX5Au/BJcCMiehrhNS03qzHZNDM/oEFZyV7UY6bdCzlSj3a5
 90QEsEYSCVbRgR1+C+TTQqciGtb5+EzRHu9p5yYBa9kTMWj5h/bLnNaGpDfU3uTx4B+h5kPQB
 +RVyHe7BbSiN50+WuTUiMYT/cZo0wQ+qg1/T1k5OKvn+RPkUt8cT34XAy03ky1VsnobmCug7K
 RsP4+hLrzo7dS5jDfB2dDFSXfS3qCwv/7wVtNNcODk5K74kZ5gbgs6D0mm6xFCVZTbX0zOj9w
 aZJl5KuP4toF35f/sjC0kbt47gQfEAVO7C96E1JEU/YdYnogbYKhCPsedx3lF+m+vES6gAcIV
 nTbh2aZHbc+gS8LlgVUkwWRah7SP1P7E2oIbrJU6NUa83hh44cpBAQdHsC+YaI7tZCg1N6YiL
 YQEfakJ2V7NaRXkB4D0Np/4k0HEFhkOdQNBRvlu9o8g6RTA3UQ=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 3 Feb 2018 14:45:24 +0100

The local variable "pm" will eventually be set to an appropriate pointer
a bit later. Thus omit the explicit initialisation at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-prodikeys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-prodikeys.c b/drivers/hid/hid-prodikeys.c
index 9cad4973a67b..2e79dfc92162 100644
--- a/drivers/hid/hid-prodikeys.c
+++ b/drivers/hid/hid-prodikeys.c
@@ -798,6 +798,6 @@ static int pk_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	unsigned short ifnum = intf->cur_altsetting->desc.bInterfaceNumber;
 	unsigned long quirks = id->driver_data;
 	struct pk_device *pk;
-	struct pcmidi_snd *pm = NULL;
+	struct pcmidi_snd *pm;
 
 	pk = kzalloc(sizeof(*pk), GFP_KERNEL);
-- 
2.16.1
