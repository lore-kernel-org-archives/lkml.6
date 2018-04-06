Return-Path: <ji_hun.kim@samsung.com>
X-Google-Smtp-Source: AIpwx49ZjwsCQlyMPh887exuhFQdZKGX4oRc1PCWsKEI2DCY8xrEx2sTBQowwQsG6NAyyVku5Hqp
ARC-Seal: i=1; a=rsa-sha256; t=1522990664; cv=none;
        d=google.com; s=arc-20160816;
        b=l3RxIE+gnlXmaGjeLlW5c16WQMoTRU7g1Gigxx6S9amq3osUcxEgwecuCCPkM7bv7u
         Ko10Jq50qx5SKxnCaXyNdZJsBBFNW8uLWMJO9Ywpepq+rFyibXbO2Yx/bjD1azmxYFbW
         dKS6lkuLtUDWZkkuyhMTzANpTIHMunBkSfe3slgTrfKPNd9OS8KlvP2REcP37jQqK9Dw
         MfZjQZ0O3vzEZzxe9GToN8jdXIiCsT11aymVDEaVDcqDOs7v+Sgpw8ZinM7dkIqbxM6Q
         rF1pelmV+3dhi1yDNvUlyPu2wm+Stz2k0Iw2GNlNdQaZXMpYK/NLkpflH7tZAVQS8Cos
         AzkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:dlp-filter:cms-type:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=umVPonmx8hCPX1LF2yA9AChn87h2q0zhKcxt8oIyUCM=;
        b=latwC94Axr0NkGCmXZP8kVnQGV6n5spoO3WtTRundgyIqKBpayRxD4Cd6NpNzn/wlM
         uQpV3TQkd/VPGi1hKtcnprWPXh5BPDceAdeZyjassxqVlo+VHW904EJ/aS/MwQDVjvse
         G2BjbllpXjYg/pw+tAXQmwjk6zxfUN/IQITw7fn4gRPqpbP6HVMV/uRMPQlNeUWhMEDq
         sQVoizetNUii9CthncDKCosmCxOqax2zg1z169xcf4vCSbmbqmYLN4a3DMh8kKg8AiyH
         BCKVByBvcK7xiCzjtOwPoJk1942UY3T0DqZuCGYjFD2JtaK4rQUvQwZOW0Zereb9dQqR
         DW3A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=VmxKYAhn;
       spf=pass (google.com: domain of ji_hun.kim@samsung.com designates 203.254.224.34 as permitted sender) smtp.mailfrom=ji_hun.kim@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=VmxKYAhn;
       spf=pass (google.com: domain of ji_hun.kim@samsung.com designates 203.254.224.34 as permitted sender) smtp.mailfrom=ji_hun.kim@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180406045743epoutp04e1c7bf3d7be956b8f5dc1d9e27bb4dbc~iv-BdFavl0707107071epoutp04E
X-AuditID: b6c32a38-d5bff70000001082-eb-5ac6fe46b322
From: Ji-Hun Kim <ji_hun.kim@samsung.com>
To: gregkh@linuxfoundation.org
Cc: me@tobin.cc, sergio.paracuellos@gmail.com, quytelda@tamalin.org,
	dan.carpenter@oracle.com, y.k.oh@samsung.com, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Ji-Hun Kim
	<ji_hun.kim@samsung.com>
Subject: [PATCH] staging: ks7010: replace kmalloc() + memcpy() with
 kmemdup()
Date: Fri, 06 Apr 2018 13:57:20 +0900
Message-id: <1522990640-30706-1-git-send-email-ji_hun.kim@samsung.com>
X-Mailer: git-send-email 1.9.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCKsWRmVeSWpSXmKPExsWy7bCmvq7bv2NRBmdPKlq8/jedxWLPmV/s
	Fs2L17NZ9J/ezmix9Za0xeVdc9gsbrcdY7V4dHYWk8WlNf4WW7p+sDpwedzbd5jFY+esu+we
	++euYff4+PQWi0ffllWMHv9OMXl8uf6a0ePzJrkAjqhUm4zUxJTUIoXUvOT8lMy8dFsl7+B4
	53hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygC5UUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUl
	tkrRhoZGeoYG5npGRkZ6JuaxVkamQCUJqRlX7l1iLPjIVrFr63/2BsbXrF2MnBwSAiYSDV9W
	MXUxcnEICexglJhx4DOU851RYsGphSwwVV/XrQfrEBLYwCgxu0EFwv7BKHHwnTeIzSagKbGx
	+xojiC0iICfx5PYfZhCbGWTQ3fcmILawgL/En6032EBsFgFVieWnf4DV8Aq4Scy4ch1ql5zE
	yWOTWUGOkBCYwSbR/GAmE0TCRWL+9wtQtrDEq+Nb2LsYOYBsaYlLR20hwtUSC67sgJpTI3Hz
	/1KocmOJ3p4LUPfwSbz72sMK0cor0dEmBFHiIXFk0XtmCNtRYuvO6cwQL8ZKTDp9lX0Co+QC
	RoZVjGKpBcW56anFhgUmesWJucWleel6yfm5mxjBKUbLYgfjnnM+hxgFOBiVeHgzIo5FCbEm
	lhVX5h5ilOBgVhLh3f0HKMSbklhZlVqUH19UmpNafIjRFBgaE5mlRJPzgekvryTe0MTSwMTM
	yNTU0MDCREmcNyDAJUpIID2xJDU7NbUgtQimj4mDU6qB0W3Ts4df1iSXvd0taHtm4d83Jgau
	Bj+C3+m8+ZHxb/6Eypubcmp8VwtPbDG6nFzffubysctzzmVNU5+a8fuoqsKbCZJ934VrP68/
	dTSn5Ly2f++qvQ5sl3iqXQLn6a1pkzCsL4g5f+aaf7bIbN93H7/vmr563ez8wkPzpZhtw3dt
	evGT7QD3HTclluKMREMt5qLiRACEzSDRRwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnluLIzCtJLcpLzFFi42I5/e+xoK7bv2NRBk97OS1e/5vOYrHnzC92
	i+bF69ks+k9vZ7TYekva4vKuOWwWt9uOsVo8OjuLyeLSGn+LLV0/WB24PO7tO8zisXPWXXaP
	/XPXsHt8fHqLxaNvyypGj3+nmDy+XH/N6PF5k1wARxSXTUpqTmZZapG+XQJXxpV7lxgLPrJV
	7Nr6n72B8TVrFyMnh4SAicTXdeuBbC4OIYF1jBJz391khnB+MEpM2r2CBaSKTUBTYmP3NUYQ
	W0RATuLJ7T/MIDazwHdGiferweLCAr4SE05MA5vKIqAqsfz0D7AaXgE3iRlXrrNAbJOTOHls
	MusERq4FjAyrGCVTC4pz03OLjQoM81LL9YoTc4tL89L1kvNzNzECg2nbYa2+HYz3l8QfYhTg
	YFTi4c2IOBYlxJpYVlyZe4hRgoNZSYR39x+gEG9KYmVValF+fFFpTmrxIUZpDhYlcd7becci
	hQTSE0tSs1NTC1KLYLJMHJxSDYzmL7rXTj1UdvSajrSR9bFzd49/NNaf+eLjxd0uwk/zTJbM
	MO64MOuk81y7mZqvlkavzLMovrE6sjDi3vmdB73LH+moaMY5tV9zOP38T/Leguk78o4GPlp5
	UsJhVZHPlQafQ3s9LU1mbLY1tq2P4uwRSNpSr5k8898G1ekW9VbsL0oy2PParkYosRRnJBpq
	MRcVJwIArfqvFiICAAA=
X-CMS-MailID: 20180406045742epcas1p22ad1bad680b9526a81c7371b75ac1f1e
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180406045742epcas1p22ad1bad680b9526a81c7371b75ac1f1e
X-RootMTR: 20180406045742epcas1p22ad1bad680b9526a81c7371b75ac1f1e
References: <CGME20180406045742epcas1p22ad1bad680b9526a81c7371b75ac1f1e@epcas1p2.samsung.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596971458949990552?=
X-GMAIL-MSGID: =?utf-8?q?1596971458949990552?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use kmemdup rather than duplicating its implementation.

Signed-off-by: Ji-Hun Kim <ji_hun.kim@samsung.com>
---
 drivers/staging/ks7010/ks7010_sdio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks7010_sdio.c b/drivers/staging/ks7010/ks7010_sdio.c
index b8f55a1..c8eb55b 100644
--- a/drivers/staging/ks7010/ks7010_sdio.c
+++ b/drivers/staging/ks7010/ks7010_sdio.c
@@ -589,11 +589,10 @@ static int ks7010_sdio_update_index(struct ks_wlan_private *priv, u32 index)
 	int ret;
 	unsigned char *data_buf;
 
-	data_buf = kmalloc(sizeof(u32), GFP_KERNEL);
+	data_buf = kmemdup(&index, sizeof(u32), GFP_KERNEL);
 	if (!data_buf)
 		return -ENOMEM;
 
-	memcpy(data_buf, &index, sizeof(index));
 	ret = ks7010_sdio_write(priv, WRITE_INDEX, data_buf, sizeof(index));
 	if (ret)
 		goto err_free_data_buf;
-- 
1.9.1
