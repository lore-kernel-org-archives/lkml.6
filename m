Return-Path: <ji_hun.kim@samsung.com>
X-Google-Smtp-Source: AG47ELuTPN2Wuxs8xcJCJP8qd5wQpTVcvrnC/n8LheAl+DSXh9Pkt7focZGGAClec7f4zBvzsqNw
ARC-Seal: i=1; a=rsa-sha256; t=1521437598; cv=none;
        d=google.com; s=arc-20160816;
        b=NNdRaHEWPoUtJZreT9zo+9NYr4Q/Omt7xxClkAGyQLPGpupYxCws/8qcpPOfEAvl3V
         ez/ozz8fgSxpSTgnYA5He7sbfVZvv+H4oruAStofgLE1uxL7czdw5sfb2l4fWUX167px
         CPEri2Yopm7gdz+8fGpvlHuOIrUnachJ7jeu3l1qEG2rXCOiIrSvpmrCVZHdzKFMFWem
         kseE9wuV10EU7qRLmzsh3TrsaSRmgH18ds1UuSuTQ+4gNZM1xlVIA2w12j6tavWXaHvd
         G6mS7YmWojq+qllbrq75wC3WR/fv7CedQyHgQkrl+h60XBdW/5M1h5q1TUq6j5RQc92H
         qzIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:dlp-filter:cms-type:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=rf69jUDJ/xP9mjsFfqYX8+R9Q8ZbXcXpuPtNNlJR4Xw=;
        b=E3MMKS3NthXiyVBSBTUEKIkVrzEqba/jwUvLdjgI0WBPw+A6GkhySqKFkp0g95Y5Lt
         ReCbH8lUmdLcCcsgfN3T1FOykn/VNQ+NlK7viM6K1DQlxTpGW8PG2/Fnmvba2QTFXK/e
         imeRm2sAD/l42/SE/S72IJSX1nSAvXGuttk8b5G/GVeXbzyNeiz95QNJJI/Qb0kiyH2d
         56IXJ2CUWapBWISTJd46M6eiJyf8NRkQmkADvmnKB4uztBV9Ty14CMkQt7H0h4J7ZUGH
         /+dCwcSTDgRA+AKoUftX1GJcm6EtFj+JvFWzjkoecmQ1dxjB9siO00stXin1d54ghhHt
         ZDCg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=Q16TgOaQ;
       spf=pass (google.com: domain of ji_hun.kim@samsung.com designates 203.254.224.33 as permitted sender) smtp.mailfrom=ji_hun.kim@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=Q16TgOaQ;
       spf=pass (google.com: domain of ji_hun.kim@samsung.com designates 203.254.224.33 as permitted sender) smtp.mailfrom=ji_hun.kim@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180319053316epoutp03960b83dba2d41b9f7b6094b072196c14~dO27CxJqA1719117191epoutp03Y
X-AuditID: b6c32a45-403ff70000001023-1b-5aaf4b9bfebe
From: Ji-Hun Kim <ji_hun.kim@samsung.com>
To: mchehab@kernel.org, dan.carpenter@oracle.com
Cc: gregkh@linuxfoundation.org, arvind.yadav.cs@gmail.com,
	ji_hun.kim@samsung.com, linux-media@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH v2] staging: media: davinci_vpfe: add error handling on
 kmalloc failure
Date: Mon, 19 Mar 2018 14:32:57 +0900
Message-id: <1521437577-8168-1-git-send-email-ji_hun.kim@samsung.com>
X-Mailer: git-send-email 1.9.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7bCmhe5s7/VRBtfmaVlc613IbPH633QW
	iz1nfrFbNC9ez2bRf3o7o8XWW9IWl3fNYbPo2bCV1WLZpj9MDpwe9/YdZvHYOesuu8emVZ1s
	HvvnrmH3+Pj0FotH35ZVjB6fN8kFsEel2mSkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpa
	WpgrKeQl5qbaKrn4BOi6ZeYAXaakUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVWKNjQ00jM0
	MNczMjLSMzGPtTIyBSpJSM34dOAIS8FVrooz/+cyNTDe5+hi5OSQEDCRWLJ8MjuILSSwg1Hi
	VLNUFyMXkP2dUeLlnHPMMEW/7/1jhkjsZpRYN+sxE4Tzg1Hi4eIDbCBVbAKaEhu7rzF2MXJw
	iAgYSPTOjQapYRY4zyjRc+wRM0hcWCBSYutNN5ByFgFViYnv+8AW8Aq4SuxrfswKsUxO4uSx
	yawgvRICU9gkru+cxQiRcJE4NWEjO4QtLPHq+BYoW1ri2aqNUDXVEguu7GCBsGskbv5fygRh
	G0v09lwAW8YswCfRcfgvO8g9EgK8Eh1tQhAlHhJX1x+GanWUmLN4HRskVGIlNjy5zzSBUXIB
	I8MqRrHUguLc9NRiowJDveLE3OLSvHS95PzcTYzgpKLluoNxxjmfQ4wCHIxKPLwOR9dFCbEm
	lhVX5h5ilOBgVhLhfXoFKMSbklhZlVqUH19UmpNafIjRFBgcE5mlRJPzgQkvryTe0MTSwMTM
	zNDcyNTAXEmcty3AJUpIID2xJDU7NbUgtQimj4mDU6qBcZVi9Ybd7/9YVTxW/Hmneo/kPDXj
	RWU3xGp2f0m5MUVZW5BHRv1b0TQzLj+uCNEPS5wrc7y0rtzN/CG5u1hNYjrDHR7GxNhF2slH
	yw7kSD3a73HJ13Ari3eAQPP7hkmx/yUML52VbWy+c27Cq4PK2hvLJqwIPp075bJMxyShz/tO
	dcZLucrcVGIpzkg01GIuKk4EAFhnXxtAAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnluLIzCtJLcpLzFFi42I5/e+xgO5s7/VRBs0fBS2u9S5ktnj9bzqL
	xZ4zv9gtmhevZ7PoP72d0WLrLWmLy7vmsFn0bNjKarFs0x8mB06Pe/sOs3jsnHWX3WPTqk42
	j/1z17B7fHx6i8Wjb8sqRo/Pm+QC2KO4bFJSczLLUov07RK4Mj4dOMJScJWr4sz/uUwNjPc5
	uhg5OSQETCR+3/vH3MXIxSEksJNRYvGynWwQzg9GiVuPJrGDVLEJaEps7L7G2MXIwSEiYCDR
	OzcapIZZ4DyjxN3Zx1lAaoQFIiXuzN4HZrMIqEpMfN/HDGLzCrhK7Gt+zAqxTU7i5LHJrBMY
	uRYwMqxilEwtKM5Nzy02KjDKSy3XK07MLS7NS9dLzs/dxAgMnm2Htfp3MD5eEn+IUYCDUYmH
	1+Houigh1sSy4srcQ4wSHMxKIrxPrwCFeFMSK6tSi/Lji0pzUosPMUpzsCiJ8/LnH4sUEkhP
	LEnNTk0tSC2CyTJxcEo1MG5+ZBo7t9wzyGT29Z5aZy4dpj37+6yd7ydyqx0Q/7y6fHaYWW3G
	FcnVGQ+sLA6t+V2rpvjlxYsX+j2pCw/2zO3dEjT/zsHKLRvTv1006KiMWPSw5tL5/NJ1f0oL
	An0OmXjP/PDGJ3HrPc42hWWW+r+Lr5xsuj/9kl9/2fm73Cr3pJe66Z39IKLEUpyRaKjFXFSc
	CABMTBueGgIAAA==
X-CMS-MailID: 20180319053315epcas2p3c61bd9a1bec8d67cde77765842a3205c
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180319053315epcas2p3c61bd9a1bec8d67cde77765842a3205c
X-RootMTR: 20180319053315epcas2p3c61bd9a1bec8d67cde77765842a3205c
References: <CGME20180319053315epcas2p3c61bd9a1bec8d67cde77765842a3205c@epcas2p3.samsung.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595068985971756322?=
X-GMAIL-MSGID: =?utf-8?q?1595342950989950737?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

There is no failure checking on the param value which will be allocated
memory by kmalloc. Add a null pointer checking statement. Then goto error:
and return -ENOMEM error code when kmalloc is failed.

Signed-off-by: Ji-Hun Kim <ji_hun.kim@samsung.com>
---
Changes since v1:
  - Return with -ENOMEM directly, instead of goto error: then return.

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
