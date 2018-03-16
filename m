Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2051848-1521176333-5-9297415049366689134
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521176333; b=SdEaVSiLjw+fs5CbmvdSTFj+FhEZtM+e5VKiMfqwAbBv2uL
    9EYK74E8qjVhKfjhpPOqq7DElz1AQFpPN6G71Iq/frqKX3dfnDVK3h1CpzbFrgHe
    Syt1NpLaFEWmAbaL/utkzo6drZFcFwu4Yu/KR5RawoPLD6hxqtV0nvsrTqtshqwb
    Y1ouSHFAuyWtHcBNP5BK80RHndS7R84SP5N9gIMv2phzKQlltIXQSjZVc6uvQL/3
    bZqPiKz/rQ84V8Ojau1KtFBmizSV9L2EGxhdnqfRgiRk/fMIbZYjjNP7FodL6RrE
    WoCVEzbPaP/0+ZQPEETwQUMlZdh74bv50KdZB8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521176333; bh=C
    5DvFBFznRghHYkzhmuCM3AJEeaqZsrfCNtznB+pRSQ=; b=l10TM5KaxJGR6FDC9
    VLb/5joRmvhvFM75BKunHs/YRWl50Z+qJ9pJaKDvjZLq0H9hAsnKu2bmTdUva/xL
    p106qD3fcOsAXH4fPY6pnPK9t+7KHZFqqulxeCZ2giSmydnAcQGlfj+C8vrgoe08
    KIqq8G5JwXK8B6MtI73Hospt8/swW0pe5tGRSnFV95yMkFz59KUDBqrKIO8bmTmc
    wYFK0smkUg5pBRrsbI9inxVYPxfFHpvyAFIfQrpmxTEKliopsaotmYyZz2+F7GE5
    pjzEgVepCIBz9JCtGAxahhQkZB7gqgYvtQbw7I8o88lawivgmYBbRC0DE2NkivI7
    6Sv4A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=PT2noQ6Y x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=samsung.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=PT2noQ6Y x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=samsung.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20180316045842epoutp0392725ea4f58df57c4a446597b9c3afec~cTc4y5VID2363523635epoutp03L
X-AuditID: b6c32a48-9adff70000000ff0-9e-5aab4f012149
From: Ji-Hun Kim <ji_hun.kim@samsung.com>
To: mchehab@kernel.org
Subject: [PATCH] staging: media: davinci_vpfe: add error handling on kmalloc
 failure
Date: Fri, 16 Mar 2018 13:58:23 +0900
Message-id: <1521176303-17546-1-git-send-email-ji_hun.kim@samsung.com>
X-Mailer: git-send-email 1.9.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsWy7bCmuS6j/+oog/63qhbXehcyW+w584vd
 onnxejaL/tPbGS223pK2uLxrDptFz4atrBbLNv1hcuDwuLfvMIvHzll32T02repk89g/dw27
 R9+WVYwenzfJBbBFpdpkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5
 +AToumXmAN2jpFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVijY0NNIzNDDXMzIy0jMxj7Uy
 MgUqSUjNmHDoOEvBWq6K1492sTQwbuboYuTkkBAwkZg2q5Wpi5GLQ0hgB6PEyX+/oJzvjBKn
 vv1mhql6dvYtG0RiN6PE0r3zGUESQgI/GCXePXYFsdkENCU2dl8Di4sIiEk82vaKBaSBWeA8
 o0TPsUdgk4QFwiROHNjGDmKzCKhKHLz7lwXE5hVwk7jTd5wdYpucxMljk1lBmiUE/rJKdM3+
 xQaRcJF49/0ElC0s8er4FqgGaYlnqzYyQtjVEguu7GCBsGskbv5fygRhG0v09lwAO4JZgE+i
 4/BfoF4OoDivREebEESJh0THshusELajxKMbn1kgnoyVWDO5iWUCo+QCRoZVjGKpBcW56anF
 RgUmesWJucWleel6yfm5mxjBSUTLYwfjgXM+hxgFOBiVeHgzmldFCbEmlhVX5h5ilOBgVhLh
 9X8GFOJNSaysSi3Kjy8qzUktPsRoCgyOicxSosn5wASXVxJvaGJpYGJmZmhuZGpgriTO2xbg
 EiUkkJ5YkpqdmlqQWgTTx8TBKdXAWCQ5N6TptFqt++1m6Wgdxe2cegrnZuyeXu6l8kf4acMG
 mTtvaxc+dvmanHHx9L2Eu1PuZXm+S8/fo39EN8Hr8J7ittOucaF1UZxZSbzFHQUxvNZypp8e
 zPnw+v358s3bKnYs4m/dsl+XNWDnu5fd2bveLVX5+e7QyV9y0UwHdqp0mwXEsgfvUWIpzkg0
 1GIuKk4EAFWdAAg4AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHJMWRmVeSWpSXmKPExsVy+t9jAV1G/9VRBns2sVpc613IbLHnzC92
 i+bF69ks+k9vZ7TYekva4vKuOWwWPRu2slos2/SHyYHD496+wyweO2fdZffYtKqTzWP/3DXs
 Hn1bVjF6fN4kF8AWxWWTkpqTWZZapG+XwJUx4dBxloK1XBWvH+1iaWDczNHFyMkhIWAi8ezs
 W7YuRi4OIYGdjBIzup+zQDg/GCXa57WwglSxCWhKbOy+xghiiwiISTza9gqsiFngPKPE3dnH
 WUASwgJhEicObGMHsVkEVCUO3v0LFucVcJO403ecHWKdnMTJY5NZJzByLWBkWMUomVpQnJue
 W2xUYJSXWq5XnJhbXJqXrpecn7uJERgq2w5r9e9gfLwk/hCjAAejEg9vRvOqKCHWxLLiytxD
 jBIczEoivP7PgEK8KYmVValF+fFFpTmpxYcYpTlYlMR5+fOPRQoJpCeWpGanphakFsFkmTg4
 pRoY90QwqCrZspYcfTjr+J73WyXD322Jfbd3sWd17zqbr7Z2i7/NeJB8si+kto6Hk1971brJ
 ud+sky6pHzW9G5NY17Y8wXGV28oy9aT6mh3lKmeL+W6XvXLbJLsyLuXiqimHwiWUXp1/wmEw
 wXraEZOZM3iTcy4b5NX9cnF5pd82TarDVMmFs6hAiaU4I9FQi7moOBEAwAoIRxECAAA=
X-CMS-MailID: 20180316045841epcas2p34dc11231c65e2032e88ac7138db2daee
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180316045841epcas2p34dc11231c65e2032e88ac7138db2daee
X-RootMTR: 20180316045841epcas2p34dc11231c65e2032e88ac7138db2daee
References: <CGME20180316045841epcas2p34dc11231c65e2032e88ac7138db2daee@epcas2p3.samsung.com>
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

There is no failure checking on the param value which will be allocated
memory by kmalloc. Add a null pointer checking statement. Then goto error:
and return -ENOMEM error code when kmalloc is failed.

Signed-off-by: Ji-Hun Kim <ji_hun.kim@samsung.com>
---
 drivers/staging/media/davinci_vpfe/dm365_ipipe.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/staging/media/davinci_vpfe/dm365_ipipe.c b/drivers/staging/media/davinci_vpfe/dm365_ipipe.c
index 6a3434c..55a922c 100644
--- a/drivers/staging/media/davinci_vpfe/dm365_ipipe.c
+++ b/drivers/staging/media/davinci_vpfe/dm365_ipipe.c
@@ -1280,6 +1280,10 @@ static int ipipe_s_config(struct v4l2_subdev *sd, struct vpfe_ipipe_config *cfg)
 
 			params = kmalloc(sizeof(struct ipipe_module_params),
 					 GFP_KERNEL);
+			if (!params) {
+				rval = -ENOMEM;
+				goto error;
+			}
 			to = (void *)params + module_if->param_offset;
 			size = module_if->param_size;
 
@@ -1323,6 +1327,10 @@ static int ipipe_g_config(struct v4l2_subdev *sd, struct vpfe_ipipe_config *cfg)
 
 			params =  kmalloc(sizeof(struct ipipe_module_params),
 						GFP_KERNEL);
+			if (!params) {
+				rval = -ENOMEM;
+				goto error;
+			}
 			from = (void *)params + module_if->param_offset;
 			size = module_if->param_size;
 
-- 
1.9.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
