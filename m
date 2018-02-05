Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753400AbeBERki (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 12:40:38 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:45430 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752738AbeBERk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 12:40:27 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180205174023euoutp01862b77554ec109b7b16956ce9da19705~QfrzKi-w52623226232euoutp01k
X-AuditID: cbfec7f1-f793a6d00000326b-83-5a789706d4f5
From: Kamil Konieczny <k.konieczny@partner.samsung.com>
Subject: [PATCH] crypto: s5p-sss.c: Fix kernel Oops in AES-ECB mode
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Anand Moon <linux.amoon@gmail.com>, linux-crypto@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <224788c7-426b-d3a9-d0a6-412d2b8afb75@partner.samsung.com>
Date: Mon, 05 Feb 2018 18:40:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-version: 1.0
Content-type: text/plain; charset="utf-8"
Content-language: en-US
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJKsWRmVeSWpSXmKPExsWy7djP87ps0yuiDHY0K1lsnLGe1WLO+RYW
        i+5XMhbnz29gt7h/7yeTxeVdc9gsZpzfx2SxbuMtdou1R+6yW/z/1czswOWxZeVNJo+ds+6y
        e2w7oOqxaVUnm8e/hVNYPPq2rGL0+LxJLoA9issmJTUnsyy1SN8ugSvj0zTegl6xigP3f7M2
        MK4Q6mLk5JAQMJH4O2k3C4QtJnHh3nq2LkYuDiGBpYwSJ87NhnI+AzmH37LDdBw6/hoqsYxR
        YtafX6wQzjNGiZXNm1hBqtgEzCUebT/DBGILCzhLtC2fxQxiiwjoSKx8uRisgVngC5PEw/4r
        YA28Am4SVzvusoHYLAKqEqe7/4E1iApESCyc+pQRokZQ4sfke2DHMgtoSrz4MgnKFpdobr0J
        ZctLbF7zlhlkgYTAfTaJGQcvQN3tIjF75lImCFtY4tXxLVBxGYnLk7tZIBr6GSWW3zjFDuFM
        YZQ4Pu0qVIe1xOHjF1khVvBJTNo2HWgFB1CcV6KjDRqUHhJtd3ZBlTtKXFw3hQ2kREggVmLr
        kqQJjHKzkPwwC8kPs5D8MAvJDwsYWVYxiqSWFuempxYb6RUn5haX5qXrJefnbmIEJqDT/45/
        3MH4/oTVIUYBDkYlHt4dqRVRQqyJZcWVuYcYJTiYlUR4na6XRwnxpiRWVqUW5ccXleakFh9i
        lOZgURLntY1qixQSSE8sSc1OTS1ILYLJMnFwSjUwsl79pKPz2OXZz6kpfKVdk587M59U51gc
        L6vaoxlxK2iKSNQcQ8dm1/VxPuLBcz1DnP9cD+sKCrt3v6BRxyaI7fnhHNPzC/8uuN2+RFCH
        RdFgWe5O8S+HjhkE/33vzeCx4uaMk2eP+5rsqyncfDs+clK5yJ9FOzJ822N33d1esGo964S9
        ypZvlViKMxINtZiLihMBJI0HPDwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPLMWRmVeSWpSXmKPExsVy+t/xy7ps0yuiDA7NY7HYOGM9q8Wc8y0s
        Ft2vZCzOn9/AbnH/3k8mi8u75rBZzDi/j8li3cZb7BZrj9xlt/j/q5nZgctjy8qbTB47Z91l
        99h2QNVj06pONo9/C6ewePRtWcXo8XmTXAB7FJdNSmpOZllqkb5dAlfGp2m8Bb1iFQfu/2Zt
        YFwh1MXIySEhYCJx6PhrNghbTOLCvfVANheHkMASRolt518zgySEBJ4xSrz+awxiswmYSzza
        foYJxBYWcJZoWz4LrEZEQEdi5cvFrCDNzAJfmCRu/5/KCJLgFXCTuNpxF2wDi4CqxOnuf2AN
        ogIREp0r57NA1AhK/Jh8D8jmAGpWl5gyJRckzCwgLtHcepMFwpaX2LzmLfMERv5ZSDpmIXTM
        QtIxC0nHAkaWVYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmbGIHRsO3Yzy07GLveBR9iFOBgVOLh
        3ZFaESXEmlhWXJl7iFGCg1lJhNfpenmUEG9KYmVValF+fFFpTmrxIUZpDhYlcd7ePasjhQTS
        E0tSs1NTC1KLYLJMHJxSDYwF26/VXN8591ypyqofh5knbI8obLa7y9RQfcs/f4ZnfXLcusn8
        +p7rFqcI7b/Sw2T6hWenzNu4TD4Dv/ln3opWcTUw1fNpC+/PW8bCsTuv64tGqbL41ikJ4SrL
        Enmi9m8pjr76+t3Bu/EzDJWq3samzrz55Ez8ruOfHET9H2X/VLJqCBfPOKHEUpyRaKjFXFSc
        CACVQ/VCggIAAA==
X-CMS-MailID: 20180205174022eucas1p101e8339284c1f0ac8f40f70c24de1c1f
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180205174022eucas1p101e8339284c1f0ac8f40f70c24de1c1f
X-RootMTR: 20180205174022eucas1p101e8339284c1f0ac8f40f70c24de1c1f
References: <CGME20180205174022eucas1p101e8339284c1f0ac8f40f70c24de1c1f@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


In AES-ECB mode crypt is done with key only, so any use of IV
can cause kernel Oops, as reported by Anand Moon.
Fixed it by using IV only in AES-CBC and AES-CTR.

Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
Reported-by: Anand Moon <linux.amoon@gmail.com>
---
Tested on Odroid XU4/HC1, kernel 4.15 with following command:

fallocate -l 128MiB /tmp/test.bin
dd if=/dev/urandom of=/tmp/testkey.key bs=128 count=1
sync
cryptsetup luksFormat --debug -q -d /tmp/testkey.key \
  --cipher aes-cbc-essiv:sha256 -h sha256 -s 128 /tmp/test.bin

The original report by Anand Moon:
https://www.spinics.net/lists/linux-crypto/msg31180.html

Oops reproduced with cryptsetup 2.0.0, kernel 4.15,
in .config in crypto API ECB support was turned off, and s5p-sss AES driver on.

cryptsetup is using aes-ecb and has req->info in aes_ctx set to 0x10,
which caused Oops:

[ 2078.683779] Internal error: Oops: 17 [#1] PREEMPT SMP ARM
[ 2078.689148] Modules linked in: algif_skcipher af_alg sd_mod sg
evdev uas usb_storage scsi_mod gpio_keys fbtft(C) spidev spi_s3c64xx
ipv6
[ 2078.701377] CPU: 1 PID: 15 Comm: ksoftirqd/1 Tainted: G         C
    4.15.0-rc9-xu4krck #1
[ 2078.709861] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[ 2078.715932] PC is at memcpy+0x80/0x330
[ 2078.719652] LR is at s5p_tasklet_cb+0x19c/0x328

 drivers/crypto/s5p-sss.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/s5p-sss.c b/drivers/crypto/s5p-sss.c
index 142c6020cec7..5c0496d1ed41 100644
--- a/drivers/crypto/s5p-sss.c
+++ b/drivers/crypto/s5p-sss.c
@@ -1926,15 +1926,21 @@ static void s5p_aes_crypt_start(struct s5p_aes_dev *dev, unsigned long mode)
 	uint32_t aes_control;
 	unsigned long flags;
 	int err;
+	u8 *iv;
 
 	aes_control = SSS_AES_KEY_CHANGE_MODE;
 	if (mode & FLAGS_AES_DECRYPT)
 		aes_control |= SSS_AES_MODE_DECRYPT;
 
-	if ((mode & FLAGS_AES_MODE_MASK) == FLAGS_AES_CBC)
+	if ((mode & FLAGS_AES_MODE_MASK) == FLAGS_AES_CBC) {
 		aes_control |= SSS_AES_CHAIN_MODE_CBC;
-	else if ((mode & FLAGS_AES_MODE_MASK) == FLAGS_AES_CTR)
+		iv = req->info;
+	} else if ((mode & FLAGS_AES_MODE_MASK) == FLAGS_AES_CTR) {
 		aes_control |= SSS_AES_CHAIN_MODE_CTR;
+		iv = req->info;
+	} else {
+		iv = NULL; /* AES_ECB */
+	}
 
 	if (dev->ctx->keylen == AES_KEYSIZE_192)
 		aes_control |= SSS_AES_KEY_SIZE_192;
@@ -1965,7 +1971,7 @@ static void s5p_aes_crypt_start(struct s5p_aes_dev *dev, unsigned long mode)
 		goto outdata_error;
 
 	SSS_AES_WRITE(dev, AES_CONTROL, aes_control);
-	s5p_set_aes(dev, dev->ctx->aes_key, req->info, dev->ctx->keylen);
+	s5p_set_aes(dev, dev->ctx->aes_key, iv, dev->ctx->keylen);
 
 	s5p_set_dma_indata(dev,  dev->sg_src);
 	s5p_set_dma_outdata(dev, dev->sg_dst);
-- 
2.16.0
