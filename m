Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42732C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A572083D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7A572083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbeH2SDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 14:03:04 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:38733 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbeH2SDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 14:03:04 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue103 [212.227.15.145]) with ESMTPA (Nemesis) id
 0LwXB1-1frM6v3k5f-018Jun; Wed, 29 Aug 2018 16:05:39 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     paulus@samba.org, linux-ppp@vger.kernel.org, netdev@vger.kernel.org
Cc:     mitch@sfgoth.com, mostrows@earthlink.net, jchapman@katalix.com,
        xeb@mail.ru, davem@davemloft.net, viro@zeniv.linux.org.uk,
        y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Guillaume Nault <g.nault@alphalink.fr>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Subject: [PATCH net-next 3/5] ppp: move PPPIOCSCOMPRESS32 to ppp-generic.c
Date:   Wed, 29 Aug 2018 16:03:28 +0200
Message-Id: <20180829140409.833488-3-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180829140409.833488-1-arnd@arndb.de>
References: <20180829140409.833488-1-arnd@arndb.de>
X-Provags-ID: V03:K1:Z166Put49TxilzTjYNNSB7kE5+9YI5G3ZB2jeW2XvEYKJ8Suz2l
 koLIO6sQKbb+qFpAWKqOkefts09VdMlBL9NEIZyRUdDPIlnPjKePRI14Fb9T14QynR7I1+Z
 6qgqesm00mq1vvtqworQiccZ4ck/QFwtBdPrRmSPrtiKfWXfn2qA/esEuJrkNdDLwK882bv
 mgj+Rp3PTUQNyfJQatrEQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TdmrHkWXbm4=:kjRlOQt/GA1KzJwHQAcvNg
 CfhKUq9O1fGeqTPNyWJ0Rx5tpSPptIdBFdXwOtValsDFHjPdOe7oZ5zcEQwfbzYED6ec1aVdr
 xh3RW71iKTOuUESXYS3gIa7DboGvagMbkmwTyLnrxuVQ1Z6H/enj2WUB53wi6NryU/ObeLRCY
 rcWFkZw09l+Zq8K/xdO6VTte29eaCfNqK057j3Or6LVMOLDFy1G9Iv2yj3yj7dOszSbrfTPkh
 iYM7/b2/5LhrJ/3OTvrjPObvjK09bebRP7frylagCYliJlVEvAMeDU8TLL1POYIKL47Bg2LV4
 DlXYJbSUBlk8nDDS15y1+lXfhlXjAGGc/iV+1jOrV8I3qS7bvegoIzMmXJIFYjDys/GMTF5+K
 K3Sf4d2j3EQowfTa+gYtVf+kEKtcbsfDfytBXLUmhQHk+qsDI7B3n+mpAVd8BImxmJ30WeKle
 5+2SEz19QjfmPd5nUukFdw4uvmem2mCAvb433Wyzxfos69VEMq+QRHz8Sk9L2/K8B3Lv9F1rP
 2Cd1UXsD1K94Gf4aO8pC1YzSdA/bruMYdKx5SOmOZ7FCl0nhmBPK0jKZ2mIrvaOVLNOzJKsKL
 Ln7gtK7QrgxnTvUiyofbYx3zZXixJs6sw5QuPB612qvaL18KHhUl4EV9f9Xk6tm7XkmBklz3m
 lmbTzuzQ2rvZRTj+TVMyY6/CBsq1WlMGZ96jI/5jCozXVn+9a7UtYybtDrP7dJCbPZ08=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PPPIOCSCOMPRESS is only implemented in ppp_generic, so it's best to move
the compat handling there. My first approach was to keep it in a new
ppp_compat_ioctl() function, but it turned out to be much simpler to do
it in the regular ioctl handler, by allowing both structure layouts to
be handled directly there.

Aside from moving the code to the right place, this also avoids
a round-trip through compat_alloc_user_space() allocated memory.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ppp/ppp_generic.c | 40 ++++++++++++++++++++++++++++++-----
 fs/compat_ioctl.c             | 32 ----------------------------
 2 files changed, 35 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index 41a6e9851a4a..8dfe8d47df95 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -274,7 +274,7 @@ static void ppp_mp_insert(struct ppp *ppp, struct sk_buff *skb);
 static struct sk_buff *ppp_mp_reconstruct(struct ppp *ppp);
 static int ppp_mp_explode(struct ppp *ppp, struct sk_buff *skb);
 #endif /* CONFIG_PPP_MULTILINK */
-static int ppp_set_compress(struct ppp *ppp, unsigned long arg);
+static int ppp_set_compress(struct ppp *ppp, unsigned long arg, bool compat);
 static void ppp_ccp_peek(struct ppp *ppp, struct sk_buff *skb, int inbound);
 static void ppp_ccp_closed(struct ppp *ppp);
 static struct compressor *find_compressor(int type);
@@ -557,6 +557,15 @@ static __poll_t ppp_poll(struct file *file, poll_table *wait)
 	return mask;
 }
 
+#ifdef CONFIG_COMPAT
+struct ppp_option_data32 {
+	compat_caddr_t	ptr;
+	u32			length;
+	compat_int_t		transmit;
+};
+#define PPPIOCSCOMPRESS32	_IOW('t', 77, struct ppp_option_data32)
+#endif
+
 #ifdef CONFIG_PPP_FILTER
 static int get_filter(void __user *arg, struct sock_filter **p)
 {
@@ -683,8 +692,14 @@ static long ppp_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		break;
 
 	case PPPIOCSCOMPRESS:
-		err = ppp_set_compress(ppp, arg);
+		err = ppp_set_compress(ppp, arg, false);
+		break;
+
+#ifdef CONFIG_COMPAT
+	case PPPIOCSCOMPRESS32:
+		err = ppp_set_compress(ppp, arg, true);
 		break;
+#endif
 
 	case PPPIOCGUNIT:
 		if (put_user(ppp->file.index, p))
@@ -2691,7 +2706,7 @@ ppp_output_wakeup(struct ppp_channel *chan)
 
 /* Process the PPPIOCSCOMPRESS ioctl. */
 static int
-ppp_set_compress(struct ppp *ppp, unsigned long arg)
+ppp_set_compress(struct ppp *ppp, unsigned long arg, bool compat)
 {
 	int err;
 	struct compressor *cp, *ocomp;
@@ -2700,8 +2715,23 @@ ppp_set_compress(struct ppp *ppp, unsigned long arg)
 	unsigned char ccp_option[CCP_MAX_OPTION_LENGTH];
 
 	err = -EFAULT;
-	if (copy_from_user(&data, (void __user *) arg, sizeof(data)))
-		goto out;
+#ifdef CONFIG_COMPAT
+	if (compat) {
+		struct ppp_option_data32 data32;
+
+		if (copy_from_user(&data32, (void __user *) arg,
+				   sizeof(data32)))
+			goto out;
+
+		data.ptr = compat_ptr(data32.ptr);
+		data.length = data32.length;
+		data.transmit = data32.transmit;
+	} else
+#endif
+	{
+		if (copy_from_user(&data, (void __user *) arg, sizeof(data)))
+			goto out;
+	}
 	if (data.length > CCP_MAX_OPTION_LENGTH)
 		goto out;
 	if (copy_from_user(ccp_option, (void __user *) data.ptr, data.length))
diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 142ca673b9cc..f518dc174dc7 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -413,13 +413,6 @@ static int ppp_sock_fprog_ioctl_trans(struct file *file,
 	return do_ioctl(file, cmd, (unsigned long) u_fprog64);
 }
 
-struct ppp_option_data32 {
-	compat_caddr_t	ptr;
-	u32			length;
-	compat_int_t		transmit;
-};
-#define PPPIOCSCOMPRESS32	_IOW('t', 77, struct ppp_option_data32)
-
 struct ppp_idle32 {
 	compat_time_t xmit_idle;
 	compat_time_t recv_idle;
@@ -447,29 +440,6 @@ static int ppp_gidle(struct file *file, unsigned int cmd,
 	return err;
 }
 
-static int ppp_scompress(struct file *file, unsigned int cmd,
-	struct ppp_option_data32 __user *odata32)
-{
-	struct ppp_option_data __user *odata;
-	__u32 data;
-	void __user *datap;
-
-	odata = compat_alloc_user_space(sizeof(*odata));
-
-	if (get_user(data, &odata32->ptr))
-		return -EFAULT;
-
-	datap = compat_ptr(data);
-	if (put_user(datap, &odata->ptr))
-		return -EFAULT;
-
-	if (copy_in_user(&odata->length, &odata32->length,
-			 sizeof(__u32) + sizeof(int)))
-		return -EFAULT;
-
-	return do_ioctl(file, PPPIOCSCOMPRESS, (unsigned long) odata);
-}
-
 #ifdef CONFIG_BLOCK
 struct mtget32 {
 	compat_long_t	mt_type;
@@ -1248,8 +1218,6 @@ static long do_ioctl_trans(unsigned int cmd,
 	switch (cmd) {
 	case PPPIOCGIDLE32:
 		return ppp_gidle(file, cmd, argp);
-	case PPPIOCSCOMPRESS32:
-		return ppp_scompress(file, cmd, argp);
 	case PPPIOCSPASS32:
 	case PPPIOCSACTIVE32:
 		return ppp_sock_fprog_ioctl_trans(file, cmd, argp);
-- 
2.18.0

