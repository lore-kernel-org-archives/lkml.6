Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3029665-1521607169-2-9028268445448033497
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
    t=1521607168; b=wtHhgPxSgccZK3fda77mHs1awW7rUBoZDx1t6EFGGMB41cS
    36Gkt088zxWmo5PJ25Z/HrbT2VCB3uFZ2PbRgGMsb73vJpgK7DioSGSbLlVS2zCw
    SOxh/hfxv1tIRTI+MQMMofGfgoLhnB0LY0wE2PoAGZlem0Ee2bCX8bYw8Z0mbGkE
    LMQ+7noH9z+Sm0vuKA1m9Dh4w8RnqWAFjrm/3F1rzWZNdhhOMMLRfh6VI3/ku0m3
    xLP830rIHZHt3r+Q3aCSYXzCw7UW3uR4+AQHAWAapPZKI/KXpjaCQXO1NBIc3c2D
    Qq++NXTzuzxZmDBN9fKsza1jCMC7HOfBIkiEX1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521607168; bh=u
    i/m/op1rpI5PsW5iWy8Q7ByuLRveACzNceJfV5qf7Q=; b=r0jdaXdemdL90Zijr
    Ny3XktlWY5AM/rPtXu0SjRNwCGZIneb0JGOHZPE2F1fZSeNXBnvQLMyTJuoYAPVq
    MnwkSptuh58+7oYPvGxPQ7JH0ZE1MtJlFfFU6MN1xvgfhhULvdSb2Sa58ANvd0r3
    pIFgjimQmd7G0p4n6BzOL6/IX4Gqv4HgTwWc4aWFxY5ES651+gCQ6DkoVbL3u+E5
    plDme8MZMeI6pIxYPuBX73Zjm332G3u4Iio5dWvY6YUWzbXDtAN4HLCcEUNSeA6y
    S0n/ywcqfs8rb7CwgSMQnl+ge3pu04M1mLp0VKptUMMqFQGoWJ/Xqi6rMH5sTtHZ
    1PoGw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=lsquGteU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=samsung.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=lsquGteU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=samsung.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20180321043916epoutp01da106fb1e29ad2a2dac4b314a004a44e~d1aWrK35-0092400924epoutp01s
X-AuditID: b6c32a35-891ff70000001031-79-5ab1e1f3cc94
From: Ji-Hun Kim <ji_hun.kim@samsung.com>
To: dan.carpenter@oracle.com, mchehab@kernel.org
Subject: [PATCH v3 1/2] staging: media: davinci_vpfe: add error handling on
 kmalloc failure
Date: Wed, 21 Mar 2018 13:39:09 +0900
Message-id: <1521607150-31307-1-git-send-email-ji_hun.kim@samsung.com>
X-Mailer: git-send-email 1.9.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsWy7bCmnu7nhxujDCY2mVhc613IbPH633QW
 iz1nfrFbNC9ez2bRf3o7o8XWW9IWl3fNYbPo2bCV1WLZpj9MDpwe9/YdZvHYOesuu8emVZ1s
 HvvnrmH3+Pj0FotH35ZVjB6fN8kFsEel2mSkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpa
 WpgrKeQl5qbaKrn4BOi6ZeYAXaakUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVWKNjQ00jM0
 MNczMjLSMzGPtTIyBSpJSM14secte0Ejd8W7G8INjP85uhg5OSQETCTeP5rD1sXIxSEksINR
 4v7u2SwQzndGidfrzrLDVG1795URIrGbUeLB4cOsEM4PRomdm2ayglSxCWhKbOy+xghiiwgY
 SFy7+RasiFngPKNEz7FHzCAJYYFYiaezJ4DZLAKqEnt+NTCB2LwCbhLPpt1ngVgnJ3Hy2GSw
 ZgmBHjaJhc9+M0EkXCRezrsPdZOwxKvjW4BsDiBbWuLSUVuIcLXEgis7oObUSNz8vxSq1Vii
 t+cC2F5mAT6Jd197WCFaeSU62oQgSjwk/r/7wAhhO0pcmT0LbJMQ0MlL5rUzT2CUXMDIsIpR
 LLWgODc9tdiwwFCvODG3uDQvXS85P3cTIzitaJnuYJxyzucQowAHoxIP7wSJjVFCrIllxZW5
 hxglOJiVRHgPRQCFeFMSK6tSi/Lji0pzUosPMZoCQ2Mis5Rocj4w5eWVxBuaWBqYmBmZmhoa
 WJgoifMGBLhECQmkJ5akZqemFqQWwfQxcXBKNTDuttswu0vtS/ZPNw+XL7GTNqtq8140XV+0
 72u64PYYoz89FtFTF3Gs0Z2Rx3pmdc69ixtutP42vrRqYUTfDo/MU4x9txWl3I7XGN73+i3z
 J/rMSpPrPIrPEzmZIgNW+uSmvw7ZuOXmm6mHP7f9KrhW8q9F//3LUIfDAWIPX11XOJ14tUl0
 wu+3SizFGYmGWsxFxYkABlEtfUEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjluLIzCtJLcpLzFFi42I5/e+xgO7nhxujDHoey1lc613IbPH633QW
 iz1nfrFbNC9ez2bRf3o7o8XWW9IWl3fNYbPo2bCV1WLZpj9MDpwe9/YdZvHYOesuu8emVZ1s
 HvvnrmH3+Pj0FotH35ZVjB6fN8kFsEdx2aSk5mSWpRbp2yVwZbzY85a9oJG74t0N4QbG/xxd
 jJwcEgImEtvefWUEsYUEdjJKvFkR3cXIBWT/YJT4/OMUWIJNQFNiY/c1MFtEwEDi2s23rCBF
 zALnGSXuzj7OApIQFoiVeDp7AjOIzSKgKrHnVwMTiM0r4CbxbNp9FohtchInj01mncDItYCR
 YRWjZGpBcW56brFRgWFearlecWJucWleul5yfu4mRmDobDus1beD8f6S+EOMAhyMSjy8FmIb
 o4RYE8uKK3MPMUpwMCuJ8B6KAArxpiRWVqUW5ccXleakFh9ilOZgURLnvZ13LFJIID2xJDU7
 NbUgtQgmy8TBKdXA2PWb73tdCF//FC/RHS6XQ2WfaLXNmqYo+M+e0/T8xKk3lnqsE0/vD9QI
 Kdt4M8/tJkf75LYFZe/Kz/o5cRU2/g9rXebVO6/ga94lo8Dv9wy8U+rT3Kb1+Yie4Im7YXTD
 dMqcNZsfp9wu6jrz5+3nj8sC78tO26n89WfKn0+sNz/Vbvrlkj+nRImlOCPRUIu5qDgRALWq
 k1wZAgAA
X-CMS-MailID: 20180321043915epcas1p3955f5a57c6728cd1f386f805879fc3f2
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180321043915epcas1p3955f5a57c6728cd1f386f805879fc3f2
X-RootMTR: 20180321043915epcas1p3955f5a57c6728cd1f386f805879fc3f2
References: <CGME20180321043915epcas1p3955f5a57c6728cd1f386f805879fc3f2@epcas1p3.samsung.com>
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
Changes since v1:
  - Return with -ENOMEM directly, instead of goto error: then return.
  - [Patch v3 1/2] is same with [patch v2]

 drivers/staging/media/davinci_vpfe/dm365_ipipe.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/staging/media/davinci_vpfe/dm365_ipipe.c b/drivers/staging/media/davinci_vpfe/dm365_ipipe.c
index 6a3434c..ffcd86d 100644
--- a/drivers/staging/media/davinci_vpfe/dm365_ipipe.c
+++ b/drivers/staging/media/davinci_vpfe/dm365_ipipe.c
@@ -1280,6 +1280,9 @@ static int ipipe_s_config(struct v4l2_subdev *sd, struct vpfe_ipipe_config *cfg)
 
 			params = kmalloc(sizeof(struct ipipe_module_params),
 					 GFP_KERNEL);
+			if (!params)
+				return -ENOMEM;
+
 			to = (void *)params + module_if->param_offset;
 			size = module_if->param_size;
 
@@ -1323,6 +1326,9 @@ static int ipipe_g_config(struct v4l2_subdev *sd, struct vpfe_ipipe_config *cfg)
 
 			params =  kmalloc(sizeof(struct ipipe_module_params),
 						GFP_KERNEL);
+			if (!params)
+				return -ENOMEM;
+
 			from = (void *)params + module_if->param_offset;
 			size = module_if->param_size;
 
-- 
1.9.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
