Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932176AbeBGPwS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 10:52:18 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:36793 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754138AbeBGPwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 10:52:15 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180207155212euoutp0269b87e9f8659189aee6cc50976ee817c~RFf6dRLro1448914489euoutp02u
X-AuditID: cbfec7f5-f79d06d0000031c7-2a-5a7b20ab854c
From: Kamil Konieczny <k.konieczny@partner.samsung.com>
Subject: [PATCH v3] crypto: s5p-sss.c: Fix kernel Oops in AES-ECB mode
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Anand Moon <linux.amoon@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-crypto@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-id: <77384548-9870-40b8-46fc-4bd62747efd6@partner.samsung.com>
Date: Wed, 07 Feb 2018 16:52:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-version: 1.0
Content-type: text/plain; charset="utf-8"
Content-language: en-US
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsWy7djP87qrFaqjDO6+UrHYOGM9q8Wc8y0s
        Ft2vZCzOn9/AbnH/3k8mi8u75rBZzDi/j8li3cZb7BZrj9xlt/j/q5nZgctjy8qbTB47Z91l
        99h2QNVj06pONo9/C6ewePRtWcXo8XmTXAB7FJdNSmpOZllqkb5dAldG449ZTAXzJCreTnzI
        2sDYJ9LFyMkhIWAice3vFEYIW0ziwr31bF2MXBxCAksZJV73bWaHcD4zStxt/s0K03Fy4jdG
        iMQyRolV/88zQTjPGCX273jHBlLFJmAu8Wj7GSYQW1jATWLpnYdgO0QEdCRWvlzMCtLALPCU
        SeL9gYtgCV6gojdLXjGD2CwCqhLre9vZQWxRgQiJhVOfQtUISvyYfI8FxGYW0JR48WUSlC0u
        0dx6E8qWl9i85i0zyAIJgftsEhOvXGOGuNtF4uS0zSwQtrDEq+Nb2CFsGYnOjoNMEA39jBLL
        b5xih3CmMEocn3aVCaLKWuLw8YusECv4JCZtmw40lQMozivR0SYEUeIh8eHEd6hljhKfLkNc
        JyQQK9G1/hPTBEa5WUiemIXkiVlInpiF5IkFjCyrGEVSS4tz01OLTfWKE3OLS/PS9ZLzczcx
        ApPQ6X/Hv+5gXHrM6hCjAAejEg+vwYbKKCHWxLLiytxDjBIczEoivO7s1VFCvCmJlVWpRfnx
        RaU5qcWHGKU5WJTEeW2j2iKFBNITS1KzU1MLUotgskwcnFINjPqyyuueLgmRLp7x95XL58WN
        syemnV+S9lbsU/KfqTxz97c46ZxcNYWreMYUi81Htbgdt+75H8R14lPI/+4Cz10cWvwfRLy2
        ltTW8zPNuK8vJP3PSFG0O3bOa6tJHqu6GP7ITM2oLd77pW1K5NyXjL69vdoaCnPjxTKZDFvv
        Wt6T4wtc8vrqKiWW4oxEQy3mouJEALSFiYg+AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsVy+t/xa7qrFaqjDDqaWSw2zljPajHnfAuL
        RfcrGYvz5zewW9y/95PJ4vKuOWwWM87vY7JYt/EWu8XaI3fZLf7/amZ24PLYsvImk8fOWXfZ
        PbYdUPXYtKqTzePfwiksHn1bVjF6fN4kF8AexWWTkpqTWZZapG+XwJXR+GMWU8E8iYq3Ex+y
        NjD2iXQxcnJICJhInJz4jRHCFpO4cG89WxcjF4eQwBJGiWkfp0E5zxglTj86wgpSxSZgLvFo
        +xkmEFtYwE1i6Z2HYN0iAjoSK18uZgVpYBZ4zCTRe+YkG0iCF6jozZJXzCA2i4CqxPrednYQ
        W1QgQqJz5XwWiBpBiR+T7wHZHEDN6hJTpuSChJkFxCWaW2+yQNjyEpvXvGWewMg/C0nHLISO
        WUg6ZiHpWMDIsopRJLW0ODc9t9hQrzgxt7g0L10vOT93EyMwIrYd+7l5B+OljcGHGAU4GJV4
        eA02VEYJsSaWFVfmHmKU4GBWEuF1Z6+OEuJNSaysSi3Kjy8qzUktPsQozcGiJM573gCoWiA9
        sSQ1OzW1ILUIJsvEwSnVwFi7iyXm99PoqCu8M588e+t7Qds1MOzRs70/jAyD7i2yjzQO1P63
        Y+3U1lOc6k9O5/2OXzbp3Zy1zO9sjn++8X/ri5bztmn2bzh3lGfPnfHIVWH5nzenWv0VW/PY
        KzZFrhO395skukzTX2P7r8XbAh4Z1P7q/c5gvFbl1Kv/vtYCr/c1aeuv2mykxFKckWioxVxU
        nAgANehB8YQCAAA=
X-CMS-MailID: 20180207155211eucas1p2d8d04871aaeb49efc30909d46e47e028
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180207155211eucas1p2d8d04871aaeb49efc30909d46e47e028
X-RootMTR: 20180207155211eucas1p2d8d04871aaeb49efc30909d46e47e028
References: <CGME20180207155211eucas1p2d8d04871aaeb49efc30909d46e47e028@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In AES-ECB mode crypt is done with key only, so any use of IV
can cause kernel Oops. Use IV only in AES-CBC and AES-CTR.

Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
Reported-by: Anand Moon <linux.amoon@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Tested-by: Anand Moon <linux.amoon@gmail.com>
Cc: stable@vger.kernel.org # can be applied after commit 8f9702aad138

---
version 3:
Change commit message: drop 'Fixes: 8f9702aad138' as the error was
introduced earlier.

version 2:
Change commit message.

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
