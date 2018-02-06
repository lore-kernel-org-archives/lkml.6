Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752761AbeBFQrn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 11:47:43 -0500
Received: from mout.web.de ([212.227.15.14]:57886 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752370AbeBFQrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 11:47:21 -0500
To: linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] HID: core: Delete an error message for a failed memory
 allocation in open_collection()
Message-ID: <92b58eb4-e68b-f7eb-d99e-5d0993ad18b6@users.sourceforge.net>
Date: Tue, 6 Feb 2018 17:47:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:/bnFmdwn6grJDi49/6+5I1JpzvAXCsmXqCVE16ZNXe1PwGv+mMY
 5av1hZ+SZrte330v3jIyJfILHYjbuZwnRivNs7JzwnB26qEsf3XpC8UKZ7ShD7KHJvCgnya
 Vbtv1zzxJN3O5W3QNMlbEM0fx875e7zBRRSnavIGJwffsNtYhL+I8i4KdZgCZXCG4VnwgIl
 8rhTb4TMw1MNbvpCmmBlg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ggFKpirjmBM=:9oDnknvedcUK/Ws4I7LIUw
 vd0pz0wtqghkXZNCgL8+RVLe4wGDhWYgy/tnJJNRiXZeuaHTBxisR0XQyXh4b+ChW+G6NdkiI
 D6Z4gERKmqAPsk7zRotvEgoQ8CGk9BqxQD5C3Yolwavb8Z+0wHbz1clPq9qABzEl0AarsFxhz
 ccweaXcZqJSNC/ksouXj0y9RPbe+/+Z243MxcPgiL9SGThO6yYnDPKQnXxxgbQJ+ne0MC+Y53
 WrFWLAzcyDLscJURpmv6gFzSGfWkJbLPuGgAMqzAkkGlYpF0q2mEUdJc5R3089ChmO+wmF/PL
 UHGwFFNNt5VzxxqmUnoMpiaHQidgRHOBTxRoQ3DMPG1T44fsd7acYefdZ3fwlWXXMbxUqU7qO
 Ge/VnNI2dwVgyQIsQbIgqaNxddgJKXgZVtGiUxFAPKIdoIFZVbJERFAAUOnEX13lsmqwncWDD
 vLNKSTaR+B3Gx6VqcRcZxLMIwptDBlIu2lzNwdzcOdHsngDn5daemArGM9BoxFmN/EJsnOBkC
 5bBdSrSxFq5oB5dJ6GzOg9amaHhAaktbE+p96agMTOI3PMcZpL7XpXTy42jQVetsS2I3UjhlI
 PhQuKT6E1dgn0Vhcbb5sfDxCbEnPb7BvV8C0siaNbJtgTsb3NK8iypF3rW2mhLrWIagJ+5R9b
 FjsQ+5530mihmvrgkEerkLJI2I3oMwpQ9Ua6e3ZxLPFY5QQj0YhZ3wwl+BCWvf0ZegOnbldNV
 UOgzHgDsNzSIBmDpBCKicxterdyWy3YpqRHjs9tkB8fIh6zPsmakKfTZmvp5EUbLPS6PXKbrF
 15KKCfs/QZg23ON5XoGJ4ov1M+tx4fC0c1xRC9F8obIokUM1Ug=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 6 Feb 2018 17:40:51 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index c2560aae5542..5ad5f52f6f9b 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -133,10 +133,9 @@ static int open_collection(struct hid_parser *parser, unsigned type)
 	if (parser->device->maxcollection == parser->device->collection_size) {
 		collection = kmalloc(sizeof(struct hid_collection) *
 				parser->device->collection_size * 2, GFP_KERNEL);
-		if (collection == NULL) {
-			hid_err(parser->device, "failed to reallocate collection array\n");
+		if (!collection)
 			return -ENOMEM;
-		}
+
 		memcpy(collection, parser->device->collection,
 			sizeof(struct hid_collection) *
 			parser->device->collection_size);
-- 
2.16.1
