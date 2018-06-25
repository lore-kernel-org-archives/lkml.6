Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86ADDC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 07:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A7225547
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 07:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uATzpB2Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35A7225547
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752634AbeFYHsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 03:48:02 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34559 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752600AbeFYHsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 03:48:00 -0400
Received: by mail-pg0-f66.google.com with SMTP id y1-v6so113036pgv.1;
        Mon, 25 Jun 2018 00:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ogyKAoMRjvIakKgwsQm+pPeeTlRL2F3Jiux73o/n4F8=;
        b=uATzpB2QYBUEdOyDvmzphlapzwu3DrWZLBUeWIq8nXjvQMXxZ1Q8BF8rTD0e6q5T7F
         gYjxL58mUUjKj4dR7XTsDszkQpc9iDEvVk5emekO9WjwV1trBYjz5P72tj7vGtSH5ahj
         KvJDVV/TZsh4J8GQ+zhjhWdM80VxeVpCcMOOqykxSCPlAemHFNKxE0482npNg/gur1mV
         JYqnYl6cSjwKvWQvSPdBvkQRuUnl4XSJ/YrncgQl42xlcNYYXDMQB1lI7zR31GEQTsc0
         mN2ZtLfE3jotwFNpx8cfVHJCD992K9iGaTxe5is5dCni6lghF1IfPixI6sgYddTbC/Rk
         uwtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ogyKAoMRjvIakKgwsQm+pPeeTlRL2F3Jiux73o/n4F8=;
        b=titOT9OSPRnO3dFbiy2usWtuieHsxHR9tjqoNRtWKp+ynnRwR22FUtYD3NFKA1J0/n
         U3wOx65UkdruIl3AAb1n98X/TmydBM3+4o1eCv1Kz+Q93KsusXdbefx0ClA5b225hr/3
         /XTznbrzRyLBnkSRLXYyJuYczjHSSNXJ/At+BBaFfscfZRYGfHCCE/SlVMRydWcHyiUC
         IaKx84t9qQjkpGQivjKUtAbNTAtAT53nuIGe7mcguuCANaX5r4SKwkVprRZubze2a343
         33B8E/d2mPWECf3SuejLF3ZUZQy8vwLKXbFIx4wpcOksO06T6Sf2pW9Jfs9IZBIctJj6
         Qz1A==
X-Gm-Message-State: APt69E0dvY+gQoTiVTidlNvtZwgu96ZIYF14PRAoYF7d/za3F/oRozXk
        cQxxh7wzQ2c33rZ1oNVf6lY7
X-Google-Smtp-Source: ADUXVKI9Kps8vpdhaoPNqwcdTtdUHxiqwk+Lm//Aeml3xoN+CLdY1OGhYZ7sI4oBwUvFtfq1Q8i2zA==
X-Received: by 2002:a65:554b:: with SMTP id t11-v6mr9919837pgr.130.1529912879200;
        Mon, 25 Jun 2018 00:47:59 -0700 (PDT)
Received: from mylaptop.nay.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id p12-v6sm27350460pfi.175.2018.06.25.00.47.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 00:47:58 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Dave Young <dyoung@redhat.com>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCHv2 2/2] drivers/base: reorder consumer and its children behind suppliers
Date:   Mon, 25 Jun 2018 15:47:39 +0800
Message-Id: <1529912859-10475-3-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529912859-10475-1-git-send-email-kernelfans@gmail.com>
References: <1529912859-10475-1-git-send-email-kernelfans@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 52cdbdd49853 ("driver core: correct device's shutdown order")
introduces supplier<-consumer order in devices_kset. The commit tries
to cleverly maintain both parent<-child and supplier<-consumer order by
reordering a device when probing. This method makes things simple and
clean, but unfortunately, breaks parent<-child order in some case,
which is described in next patch in this series.
Here this patch tries to resolve supplier<-consumer by only reordering a
device when it has suppliers, and takes care of the following scenario:
    [consumer, children] [ ... potential ... ] supplier
                         ^                   ^
After moving the consumer and its children after the supplier, the
potentail section may contain consumers whose supplier is inside
children, and this poses the requirement to dry out all consumpers in
the section recursively.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>
Cc: Dave Young <dyoung@redhat.com>
Cc: linux-pci@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
---
note: there is lock issue in this patch, should be fixed in next version

---
 drivers/base/core.c | 132 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 129 insertions(+), 3 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 66f06ff..db30e86 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -123,12 +123,138 @@ static int device_is_dependent(struct device *dev, void *target)
 	return ret;
 }
 
-/* a temporary place holder to mark out the root cause of the bug.
- * The proposal algorithm will come in next patch
+struct pos_info {
+	struct device *pos;
+	struct device *tail;
+};
+
+/* caller takes the devices_kset->list_lock */
+static int descendants_reorder_after_pos(struct device *dev,
+	void *data)
+{
+	struct device *pos;
+	struct pos_info *p = data;
+
+	pos = p->pos;
+	pr_debug("devices_kset: Moving %s after %s\n",
+		 dev_name(dev), dev_name(pos));
+	device_for_each_child(dev, p, descendants_reorder_after_pos);
+	/* children at the tail */
+	list_move(&dev->kobj.entry, &pos->kobj.entry);
+	/* record the right boundary of the section */
+	if (p->tail == NULL)
+		p->tail = dev;
+	return 0;
+}
+
+/* iterate over an open section */
+#define list_opensect_for_each_reverse(cur, left, right)	\
+	for (cur = right->prev; cur == left; cur = cur->prev)
+
+static bool is_consumer(struct device *query, struct device *supplier)
+{
+	struct device_link *link;
+	/* todo, lock protection */
+	list_for_each_entry(link, &supplier->links.consumers, s_node)
+		if (link->consumer == query)
+			return true;
+	return false;
+}
+
+/* recursively move the potential consumers in open section (left, right)
+ * after the barrier
+ */
+static int __device_reorder_consumer(struct device *consumer,
+	struct list_head *left, struct list_head *right,
+	struct pos_info *p)
+{
+	struct list_head *iter;
+	struct device *c_dev, *s_dev, *tail_dev;
+
+	descendants_reorder_after_pos(consumer, p);
+	tail_dev = p->tail;
+	/* (left, right) may contain consumers, hence checking if any moved
+	 * child serving as supplier. The reversing order help us to meet
+	 * the last supplier of a consumer.
+	 */
+	list_opensect_for_each_reverse(iter, left, right) {
+		struct list_head *l_iter, *moved_left, *moved_right;
+
+		moved_left = (&consumer->kobj.entry)->prev;
+		moved_right = tail_dev->kobj.entry.next;
+		/* the moved section may contain potential suppliers */
+		list_opensect_for_each_reverse(l_iter, moved_left,
+			moved_right) {
+			s_dev = list_entry(l_iter, struct device, kobj.entry);
+			c_dev = list_entry(iter, struct device, kobj.entry);
+			/* to fix: this poses extra effort for locking */
+			if (is_consumer(c_dev, s_dev)) {
+				p->tail = NULL;
+				/* to fix: lock issue */
+				p->pos =  s_dev;
+				/* reorder after the last supplier */
+				__device_reorder_consumer(c_dev,
+					l_iter, right, p);
+			}
+		}
+	}
+	return 0;
+}
+
+static int find_last_supplier(struct device *dev, struct device *supplier)
+{
+	struct device_link *link;
+
+	list_for_each_entry_reverse(link, &dev->links.suppliers, c_node) {
+		if (link->supplier == supplier)
+			return 1;
+	}
+	if (dev == supplier)
+		return -1;
+	return 0;
+}
+
+/* When reodering, take care of the range of (old_pos(dev), new_pos(dev)),
+ * there may be requirement to recursively move item.
  */
 int device_reorder_consumer(struct device *dev)
 {
-	devices_kset_move_last(dev);
+	struct list_head *iter, *left, *right;
+	struct device *cur_dev;
+	struct pos_info info;
+	int ret, idx;
+
+	idx = device_links_read_lock();
+	if (list_empty(&dev->links.suppliers)) {
+		device_links_read_unlock(idx);
+		return 0;
+	}
+	spin_lock(&devices_kset->list_lock);
+	list_for_each_prev(iter, &devices_kset->list) {
+		cur_dev = list_entry(iter, struct device, kobj.entry);
+		ret = find_last_supplier(dev, cur_dev);
+		switch (ret) {
+		case -1:
+			goto unlock;
+		case 1:
+			break;
+		case 0:
+			continue;
+		}
+	}
+	BUG_ON(!ret);
+
+	/* record the affected open section */
+	left = dev->kobj.entry.prev;
+	right = iter;
+	info.pos = list_entry(iter, struct device, kobj.entry);
+	info.tail = NULL;
+	/* dry out the consumers in (left,right) */
+	__device_reorder_consumer(dev, left, right, &info);
+
+unlock:
+	spin_unlock(&devices_kset->list_lock);
+	device_links_read_unlock(idx);
 	return 0;
 }
 
-- 
2.7.4

