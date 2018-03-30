Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2920516-1522393793-2-7749699529053140342
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522393792; b=OTF5EY9O4V6ZUCylWtB+I3ydEHTq2zUJvkWVCcLLb3Y4ot7qFp
    vs6dI+0OieHppU2B6N8NUBLFkT7N0bcn/b1Ow4frR9RiAa+xnC+zeewY+/RwlVpC
    WUh8Bz0DwY0ZDKNd/ZOzvIXYZJCKn01qb0ZkgzoLZvSZYWh5nMEriIRv2n9HSbwz
    QD2lbYonoZ2iDzw4+z+tKt/Wyu+mIq5f7jFBKBg/CVodeB9rojmSCkzEkZAkW8Lw
    krk4/7ldBE34ytlqBQ8NodRB3MyPR1yLkKeTYPQxixxsbGsG/VK/9aFwqV8WF/OC
    YUELJW1dLDkUKgjfOug+6xhVvVcwp9h+jbyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522393792; bh=4xUZf
    2/YEjHa/wQCp8v6MrSJviukqBIxtzMG/XGx3/4=; b=OLoOy4yO7Gwr+3HoLdmrT
    eT7xsFyIWARoo5kDaivUrsZAah9u9Afph8550c9jM3y2tiziDRypZzxPOtNs5BcW
    coxsx3GPsTpQnvrUUSGI9GiWJlVPSVhRpWh749cxMf/RBEkBFot4/F0prloeDG0o
    8H047bLfb97q+6GVGLGLoz3i0WBk7FfFA8hcY4sZj2qqii+xOcr+WHaDpdI1eB4N
    H3q35OTueHshRhctj2lz8WXzgQBC7hZHY0gkTOWXAVSJL036MaETXWtEu2TXVt7h
    9otY7LJggKDPHPo3P5SeXlI9ZPGbUWRMq3ldppis0i6jzaAXSraTUNlsAx++ZRXx
    g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAvdHZUgqA4T8UYgZNVv7CU11pGEQVDpWYtTNo+Ze/g7nQQowWItQ+C685U4DcyegB+AuPY4OlYJvmabjhDfff8o4oW1MM+qExZ/5TsmfL6Y/+Lizs9E
    c6F6ZvsHn8vJflIaej1VVwqfKF+GvA3yzE9do0hXSw9yfArFdd6Tw0i3Fs1wwFOuSUV281QeX0g2oW05RcysJxzWGiBswTo6P0EgrO346yzwAibIk/OptEin
    qr0WrjZSp8UMbE2CBOToxg==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Feg6x53VAAAA:8 a=DDOyTI_5AAAA:8
    a=KjG7R9OqOhbJiQy3oYAA:9 a=CjuIK1q_8ugA:10 a=WvgAEFZ7fBLC38U1N6He:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH 16/76] staging: ks7010: Remove trailing _t from 'struct
 hostif_start_confirm_t'.
Date: Fri, 30 Mar 2018 00:07:39 -0700
Message-Id: <20180330070842.25224-16-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:8/s3DpoAQx/Cy2g/FPMHPYSRVl+i7ndY4CMlIyJj0EeKtKsgY9R
 mGVwypZ1lRtZ+u6cXtO09zWfp9cQ4yiwN+uBCp3j9gb0uzFSpXBvTNGNIPFRwHI8C1ZPHRK
 vqbr1/JZzvpuAEeZbwU4SJPBQaJHp/9za1aqC0gqoFS45/0pvrUeL5dP9d1+YYzNp7dCmLN
 hRuPrVRz9zp8SzujyFruw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KNowst18qKs=:9y9DDCymXnsKPivQA+jVsw
 DMsny89ssMTV4skEnWoTm/7fJRt1SF6ETQ2g46vC+kJoWN/fST8HCdh5acXgdUJQAdr32cFsM
 huax2GaXcmRt7FEcejBM5otS/Pb2iKuse2TLurxVR7ufd/xXWAP5kcof8+32Q3Jh0dPk3iAmU
 BSEERpDY+W4EiRyAiKBtB9KV6m+49IA96P0fntp7kxwO70b5ddAmUgs5TEmOfpbu/aKtvCPTG
 N7B4csF19KnfSbYyqv7CL7BywCCAl7PgiObeYFHSAIpnHk3dAV8dnMNkJYKceuGLpvrlIUMVF
 GLzC2PifbRaBMhWowJfW2L1IfMrY9eNcLdZrlWoiBgcTUMDIxFB6sYOt6AdBX9Pw/i5OjBSNt
 AublIdFEBhbhgeuGkZQ0UIxcS5jORZs/6CY3hpS1CeqDOtymLZ7h/m+RBFNosuN9lyHUV02R9
 QpqMbzpbx8aHir7oESYo/2h65ag8kkD4Lk5IewOPnNDg9KNZUl8fMfSlfrAdQ6ooswx0bke20
 vNOd0XFSG03PKQDXFDMze+/aHrR58qOcaZeYLFGMJKLIy8GIaObhjW8nq6d4jA/Saj8D7/Tjs
 WmJtfXmXK8jY76mrygio4uIveJUHFgnhwTSU39KXeSj/pTIivNH+9LtcJ8ByofmGC3XpxKtNR
 JulnJjE0Hs9hE1V9Cgz4Nrb0F+LkQwLu/Gjb3+6T8e9mgdK+q0YTKnyZkjKmtdmjmHdt8gSOQ
 0ICPbVxAe1IDnclh71PQxBHU5UZ4q4hIh5sacg==
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
Cc: devel@driverdev.osuosl.org, driverdev-devel@linuxdriverproject.org,
 linux-kernel@vger.kernel.org, Quytelda Kahja <quytelda@tamalin.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct hostif_start_confirm_t' with 'struct
hostif_start_confirm'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index b8b37afecd8f..fe85e22c4a5e 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -220,7 +220,7 @@ struct hostif_start_request {
 #define MODE_ADHOC          3
 } __packed;
 
-struct hostif_start_confirm_t {
+struct hostif_start_confirm {
 	struct hostif_hdr header;
 	__le16 result_code;
 } __packed;
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
