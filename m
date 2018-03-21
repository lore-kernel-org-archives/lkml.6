Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3029665-1521607169-11-13864084411775585612
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES roen, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521607168; b=p5U6VocxrKx3WzxB9SZiRZ5ZkN/sMgqmAhKVF1ikmeKFyl+
    v7eKPFKxwMWRcBmz7GVo44pOpdIPwC/q8oTYvVX/BbI98eCTMbpjx1ZGvOYltiHm
    lxVP0VHm3Ts7I4htQH8elmd3mHTU6tteIneHoBUYC6uPTUfXQrmo2oWP+O/QrVHa
    On+KsX/yBNjX5ryN6KZQCU8EAVBHKAfZ7EPFqIbIUUoRgwIb7MhSXWdK80FtLfTE
    rLwbPdheHkO3I3SppvIDqW/wHfCd2VvGHCegT0tOQrRvhy0Fidq0MguyF/YGPTO4
    U3zhK4wc7Wo+ckh5W927pLeSIzO/s6U9t4TKEYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521607168; bh=J
    JW0NZmPwZCAk74u4bRXNRrfVTM1pqg5ES4Q637H3s0=; b=TZOuNymiQ7uv7haL5
    xZf/ZRg6vbjmW2dG6ZuTvLN25uB5BfT6aeltaJRcRs70ZZgblR4hDnc+Qkeor9NE
    IeNv2WfGY2E5DCnonmb3Rr1cE76waBV5HJy3SrE9zwyDQ95VEp0ZDoi555xWG4XN
    fhCDYr9RXkqyywzNu9hQBlBhAJ50p9PBzkK1NVzxOlPtylygXbqj/JqYbOJ6ofMh
    RWci76wSsEFTWri1STbRUDYH3dlZAbxGlNXl/UJHX7HP7dFFib6/EerMWhytUp51
    yumVZBny00zA3MQE4QNPdiy+ZRikIQ7Qhs2J3FpToXSQkpWHshTfsWQPgKs7lyi7
    7o5OQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=brImZq+G x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=samsung.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=brImZq+G x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=samsung.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20180321043919epoutp021efe184fdca151a9297de80df96a0ec2~d1aZB3R2d2258522585epoutp02J
X-AuditID: b6c32a48-9adff70000000ff0-45-5ab1e1f6b81a
From: Ji-Hun Kim <ji_hun.kim@samsung.com>
To: dan.carpenter@oracle.com, mchehab@kernel.org
Subject: [PATCH v3 2/2] staging: media: davinci_vpfe: add kfree() on goto
 err statement
Date: Wed, 21 Mar 2018 13:39:10 +0900
Message-id: <1521607150-31307-2-git-send-email-ji_hun.kim@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1521607150-31307-1-git-send-email-ji_hun.kim@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLKsWRmVeSWpSXmKPExsWy7bCmqe63hxujDDZdVra41ruQ2eL1v+ks
 FnvO/GK3aF68ns2i//R2Routt6QtLu+aw2bRs2Erq8WyTX+YHDg97u07zOKxc9Zddo9NqzrZ
 PPbPXcPu8fHpLRaPvi2rGD0+b5ILYI9KtclITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0
 tDBXUshLzE21VXLxCdB1y8wBukxJoSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYqsUbWhopGdo
 YK5nZGSkZ2Iea2VkClSSkJqxo/EJW8EOiYpJl1+xNDB+FOpi5OSQEDCRaGm5yNbFyMUhJLCD
 UeL21PXsEM53RolHl6+ywlQ9fXcEqmo3o8SMmxOhqn4wSvR8PgZWxSagKbGx+xojiC0iYCBx
 7eZbVpAiZoHzQEXHHjGDJIQFIiUOztrLBmKzCKhKHNt7BayZV8BNYu/0nywQ6+QkTh6bDBbn
 FHCXuDV9H9hqCYEVbBL7NkxngihykTj1ZQkjhC0s8er4FnYIW1ri2aqNUPFqiQVXdkANrZG4
 +X8pVK+xRG/PBbCDmAX4JDoO/wXq5QCK80p0tEEDxkOip+seM4TtKNG3+CkLxMezGCXe9ney
 TGCUWsDIsIpRLLWgODc9tdiowESvODG3uDQvXS85P3cTIzjpaHnsYDxwzucQowAHoxIP7wSJ
 jVFCrIllxZW5hxglOJiVRHgPRQCFeFMSK6tSi/Lji0pzUosPMZoCw2Yis5Rocj4wIeaVxBua
 WBqYmJkZmhuZGpgrifO2BbhECQmkJ5akZqemFqQWwfQxcXBKNTDG3j1//wTnuYq9LTwP2fgW
 dou3lsvkdpkZi9ZF+zRbrW049O1x97L5XAd+v96TXC4uqWfFs1xPTKVR/nF2+qJM4Ss+9fUq
 /ue+ih/LzHZ+wHXyLUdIaJhZTtiuefk+kYoJiZ+LPwf+zt7S8ynNwlLy36d/YQvlHtx9HHRw
 p9bstvkn1f8eXK7EUpyRaKjFXFScCAD+uW+SUAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPLMWRmVeSWpSXmKPExsVy+t9jAd1vDzdGGRyZK2ZxrXchs8Xrf9NZ
 LPac+cVu0bx4PZtF/+ntjBZbb0lbXN41h82iZ8NWVotlm/4wOXB63Nt3mMVj56y77B6bVnWy
 eeyfu4bd4+PTWywefVtWMXp83iQXwB7FZZOSmpNZllqkb5fAlbGj8QlbwQ6JikmXX7E0MH4U
 6mLk5JAQMJF4+u4IG4gtJLCTUWLdd8MuRi4g+wejxNV//awgCTYBTYmN3dcYQWwRAQOJazff
 soIUMQucZ5S4O/s4C0hCWCBSov/EFrAGFgFViWN7r4DZvAJuEnun/2SB2CYncfLYZLA4p4C7
 xK3p+6A2u0mcmbWGbQIjzwJGhlWMkqkFxbnpucVGBUZ5qeV6xYm5xaV56XrJ+bmbGIHBtu2w
 Vv8OxsdL4g8xCnAwKvHwWohtjBJiTSwrrsw9xCjBwawkwnsoAijEm5JYWZValB9fVJqTWnyI
 UZqDRUmclz//WKSQQHpiSWp2ampBahFMlomDU6qB0XXevDZL37U80yLlWiMSXiWvirjOtEB5
 2ysbFU+tnc9qruetSRbb73WuYH644afHu/nXd/74/+iizZIN/vGF3ap6XOpBDC5sW01Ot+y4
 vITrmNoE19TP0z9MvrTb6NjkwvubPeZeij8utv76l83TF6UFBEQkb4yY9WDR7t9r53749iFz
 0eOwgA1KLMUZiYZazEXFiQCNjhH1MgIAAA==
X-CMS-MailID: 20180321043918epcas2p3d7cc4cf4c6377171c53af63ff3aa2a9a
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180321043918epcas2p3d7cc4cf4c6377171c53af63ff3aa2a9a
X-RootMTR: 20180321043918epcas2p3d7cc4cf4c6377171c53af63ff3aa2a9a
References: <1521607150-31307-1-git-send-email-ji_hun.kim@samsung.com>
 <CGME20180321043918epcas2p3d7cc4cf4c6377171c53af63ff3aa2a9a@epcas2p3.samsung.com>
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 ji_hun.kim@samsung.com, arvind.yadav.cs@gmail.com, linux-media@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

It needs to free of allocated params value in the goto error statement.

Signed-off-by: Ji-Hun Kim <ji_hun.kim@samsung.com>
---
Changes since v2:
  - add kfree(params) on the error case of the function
  - rename unclear goto statement name
  - declare the params value at start of the function, so it can be free
    end of the function

 drivers/staging/media/davinci_vpfe/dm365_ipipe.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/media/davinci_vpfe/dm365_ipipe.c b/drivers/staging/media/davinci_vpfe/dm365_ipipe.c
index ffcd86d..735d8b5 100644
--- a/drivers/staging/media/davinci_vpfe/dm365_ipipe.c
+++ b/drivers/staging/media/davinci_vpfe/dm365_ipipe.c
@@ -1263,6 +1263,7 @@ static int ipipe_get_cgs_params(struct vpfe_ipipe_device *ipipe, void *param)
 static int ipipe_s_config(struct v4l2_subdev *sd, struct vpfe_ipipe_config *cfg)
 {
 	struct vpfe_ipipe_device *ipipe = v4l2_get_subdevdata(sd);
+	struct ipipe_module_params *params;
 	unsigned int i;
 	int rval = 0;
 
@@ -1272,7 +1273,6 @@ static int ipipe_s_config(struct v4l2_subdev *sd, struct vpfe_ipipe_config *cfg)
 		if (cfg->flag & bit) {
 			const struct ipipe_module_if *module_if =
 						&ipipe_modules[i];
-			struct ipipe_module_params *params;
 			void __user *from = *(void * __user *)
 				((void *)cfg + module_if->config_offset);
 			size_t size;
@@ -1289,26 +1289,30 @@ static int ipipe_s_config(struct v4l2_subdev *sd, struct vpfe_ipipe_config *cfg)
 			if (to && from && size) {
 				if (copy_from_user(to, from, size)) {
 					rval = -EFAULT;
-					break;
+					goto err_free_params;
 				}
 				rval = module_if->set(ipipe, to);
 				if (rval)
-					goto error;
+					goto err_free_params;
 			} else if (to && !from && size) {
 				rval = module_if->set(ipipe, NULL);
 				if (rval)
-					goto error;
+					goto err_free_params;
 			}
 			kfree(params);
 		}
 	}
-error:
+	return 0;
+
+err_free_params:
+	kfree(params);
 	return rval;
 }
 
 static int ipipe_g_config(struct v4l2_subdev *sd, struct vpfe_ipipe_config *cfg)
 {
 	struct vpfe_ipipe_device *ipipe = v4l2_get_subdevdata(sd);
+	struct ipipe_module_params *params;
 	unsigned int i;
 	int rval = 0;
 
@@ -1318,7 +1322,6 @@ static int ipipe_g_config(struct v4l2_subdev *sd, struct vpfe_ipipe_config *cfg)
 		if (cfg->flag & bit) {
 			const struct ipipe_module_if *module_if =
 						&ipipe_modules[i];
-			struct ipipe_module_params *params;
 			void __user *to = *(void * __user *)
 				((void *)cfg + module_if->config_offset);
 			size_t size;
@@ -1335,16 +1338,19 @@ static int ipipe_g_config(struct v4l2_subdev *sd, struct vpfe_ipipe_config *cfg)
 			if (to && from && size) {
 				rval = module_if->get(ipipe, from);
 				if (rval)
-					goto error;
+					goto err_free_params;
 				if (copy_to_user(to, from, size)) {
 					rval = -EFAULT;
-					break;
+					goto err_free_params;
 				}
 			}
 			kfree(params);
 		}
 	}
-error:
+	return 0;
+
+err_free_params:
+	kfree(params);
 	return rval;
 }
 
-- 
1.9.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
