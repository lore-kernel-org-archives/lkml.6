Return-Path: <ji_hun.kim@samsung.com>
X-Google-Smtp-Source: AB8JxZrVLRQImSZhu+cqgHUZ62OANJ/c8SrQUTbb4JZIl0iO6/rTaFK+7RWkFg8YiKBhm8coz0WF
ARC-Seal: i=1; a=rsa-sha256; t=1525824783; cv=none;
        d=google.com; s=arc-20160816;
        b=PuSeYmeSBdXsCJvqT+BDUTaZYPzjnXWy9repjiKxFTeHePcavVxLnw68o9IabBocj5
         URsFBUTfwkSS33Bmxpd5LxPYGN4aEUiJvzG3b5oxY7J2GmQ1Bw0zF0z3bccfDIqo9Hr3
         w/jx0mng0GPEqbRqzZDNBLJTH6R9pBthfF/K8X/1TyKlPzphvOCbxCNhyi15E/d2zH4g
         VE8nPAgd564sQR7uvjUCOG72sxarfocViLQ75sDXYsW0u8LOKzZuqHL2KWfFy34yhknf
         VbAPVbkvlPD9xFdQHJn9EnTK9tOn+005uxKJ1SpW0mDf+WB4zjoBBzgmjL2XWYILpPC/
         CusA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:dlp-filter:cms-type:in-reply-to:message-id:date:subject
         :cc:to:from:dkim-signature:dkim-filter:arc-authentication-results;
        bh=VwXmao9gFIFoQK48udxebBeoZLVQLnIbsEdEoxxCrXI=;
        b=XY4M9heiodOGC4guqL2HN48ftzE0gENQ+2Au2u3H4ux9GZexmDlqfBuQgIGbabwA/r
         SJeYDjNSRyqgDeIlMamx2gPV728a+5NEKBkcEz9469WaDPNdLb57GJR6O76LsDgAL1/R
         NHHUOGRDGz2XSgPG7RHmiQtkIMESEZZwyxUPBZkuEtb/+yyjEl2McqIORixtmV+Q+Y4b
         4wuIUy7MiywNYMsKQJ6fgiK96yx6vLGt1Wj9GGLd73Ds1c/UCtoQI3sSwU3V6JzWWmkh
         I1Dj9TU9tNDeSKeLkYBFnviMUeAeGGClJDLiTB2anKwmCSrWnuV5HBDbZo+XlY5/guTI
         Y7+A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=LWmYPT2c;
       spf=pass (google.com: domain of ji_hun.kim@samsung.com designates 203.254.224.25 as permitted sender) smtp.mailfrom=ji_hun.kim@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=LWmYPT2c;
       spf=pass (google.com: domain of ji_hun.kim@samsung.com designates 203.254.224.25 as permitted sender) smtp.mailfrom=ji_hun.kim@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180509001301epoutp020db2fefeb5c446b161fc871ff601c335~s0Y3215Pt2755027550epoutp02s
X-AuditID: b6c32a45-8f3ff70000001020-fc-5af23d0c00ae
From: Ji-Hun Kim <ji_hun.kim@samsung.com>
To: peterhuewe@gmx.de, tweek@google.com
Cc: jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca, arnd@arndb.de,
	gregkh@linuxfoundation.org, javierm@redhat.com, sonnyrao@chromium.org,
	ji_hun.kim@samsung.com, enric.balletbo@collabora.com,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH 2/2] tpm: replace kmalloc() + memcpy() with kmemdup()
Date: Wed, 09 May 2018 09:12:37 +0900
Message-id: <1525824757-21835-2-git-send-email-ji_hun.kim@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1525824757-21835-1-git-send-email-ji_hun.kim@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHKsWRmVeSWpSXmKPExsWy7bCmmS6P7acog98flC3+TjrGbrHm9iFG
	i+bF69ksvq9ysVg4bTmjxcwZJxgt+k9vZ7TYekva4sQ5oKrLu+awWbzd95Pd4smZmYwW8371
	Mjnwevz+NYnRY3bDRRaPHXeXMHp8+BjnsWBTqce8k4Ee++euYfd4v+8qm0ffllWMHp83yXls
	/XybJYA7KtUmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0z
	B+h6JYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUrShoZGeoYG5npERkDaPtTIyBSpJSM04
	dfEka8EVtoqui3eZGxivsXYxcnJICJhIfNm6g62LkYtDSGAHo8Smi7MYIZzvjBI9Hw+zwVSt
	efWWHcQWEtjAKNG5zRmi6AejxPOFf5lBEmwCmhIbu68xgtgiAuoSEyafZAIpYhZYyiSx4chZ
	oEkcHMICrhJdSzVATBYBVYn12yRBynkF3CRmHFjCDrFLTuLksclg13EKuEs8m/Mf7DoJgfts
	Elu6vzNBFLlIrOnZA/WCsMSr41ugmqUlnq3ayAhhV0ssuLKDBcKukbj5fylUr7FEb88FsJuZ
	BfgkOg7/ZQe5R0KAV6KjTQiixENi9/H/UL87SrQt3QoNoVmMEh3Hr7JPYJRawMiwilEstaA4
	Nz212KjAUK84Mbe4NC9dLzk/dxMjOG1pue5gnHHO5xCjAAejEg+vxM6PUUKsiWXFlbmHGCU4
	mJVEeGWNP0UJ8aYkVlalFuXHF5XmpBYfYjQFBs1EZinR5HxgSs0riTc0NTI2NrYwMzI2NDFW
	Eudt8D0TJSSQnliSmp2aWpBaBNPHxMEp1cBYNWGV+c/fgt+ucak7G606vXBZkItxktgxy9f3
	L5sm1vL/m+qjLXc91aS15MG/ZVc+nMzZekPhyuqFZQftDx+ee4yN+a1lqYG6xLFeJ2Fph4Ny
	qZpqPwL4Vl6zfVJtnWSX3C9kpnlOWewLg0pzeNRbZivzOb0qFRmOoUcWbZ/cEeHLsfyATbYS
	S3FGoqEWc1FxIgD1ORoscQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrELMWRmVeSWpSXmKPExsVy+t9jQV0e209RBlsbWCz+TjrGbrHm9iFG
	i+bF69ksvq9ysVg4bTmjxcwZJxgt+k9vZ7TYekva4sQ5oKrLu+awWbzd95Pd4smZmYwW8371
	Mjnwevz+NYnRY3bDRRaPHXeXMHp8+BjnsWBTqce8k4Ee++euYfd4v+8qm0ffllWMHp83yXls
	/XybJYA7issmJTUnsyy1SN8ugSvj1MWTrAVX2Cq6Lt5lbmC8xtrFyMkhIWAisebVW/YuRi4O
	IYF1jBLf126Dcn4wSky9+4oFpIpNQFNiY/c1RhBbREBdYsLkk0wgRcwCS5kkWj7vACri4BAW
	cJXoWqoBYrIIqEqs3yYJUs4r4CYx48ASdohlchInj00GW8wp4C7xbM5/NhBbCKjm6cTzzBMY
	eRYwMqxilEwtKM5Nzy02KjDKSy3XK07MLS7NS9dLzs/dxAgM2W2Htfp3MD5eEn+IUYCDUYmH
	V2Lnxygh1sSy4srcQ4wSHMxKIryyxp+ihHhTEiurUovy44tKc1KLDzFKc7AoifPy5x+LFBJI
	TyxJzU5NLUgtgskycXBKNTAeWLB9x04vt8JVX3bZffjwmHeuUv3Zh3ET3y6WU1Pid9rqwnP9
	LUN1lHWNssy/nS5ZxvkLmm6ZR7KoWz7x+7n72IWnUxiU29g1DW9dYfHxVp5Vmaoj2M7qZFV7
	ZZn8n79ry87MOXibff3ZG23BklevqL35mTuTbcICTp8aT5/DZr+PmB1rkDugxFKckWioxVxU
	nAgAs+xtIlUCAAA=
X-CMS-MailID: 20180509001300epcas2p3971900d48408aef6a80f59b9480aac16
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180509001300epcas2p3971900d48408aef6a80f59b9480aac16
X-RootMTR: 20180509001300epcas2p3971900d48408aef6a80f59b9480aac16
References: <1525824757-21835-1-git-send-email-ji_hun.kim@samsung.com>
	<CGME20180509001300epcas2p3971900d48408aef6a80f59b9480aac16@epcas2p3.samsung.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599943245926622446?=
X-GMAIL-MSGID: =?utf-8?q?1599943247904779232?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use kmemdup rather than duplicating its implementation.

Signed-off-by: Ji-Hun Kim <ji_hun.kim@samsung.com>
---
 drivers/char/tpm/eventlog/efi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/char/tpm/eventlog/efi.c b/drivers/char/tpm/eventlog/efi.c
index 68f1e7e..3e673ab 100644
--- a/drivers/char/tpm/eventlog/efi.c
+++ b/drivers/char/tpm/eventlog/efi.c
@@ -51,10 +51,9 @@ int tpm_read_log_efi(struct tpm_chip *chip)
 	}
 
 	/* malloc EventLog space */
-	log->bios_event_log = kmalloc(log_size, GFP_KERNEL);
+	log->bios_event_log = kmemdup(log_tbl->log, log_size, GFP_KERNEL);
 	if (!log->bios_event_log)
 		goto err_memunmap;
-	memcpy(log->bios_event_log, log_tbl->log, log_size);
 	log->bios_event_log_end = log->bios_event_log + log_size;
 
 	tpm_log_version = log_tbl->version;
-- 
1.9.1
