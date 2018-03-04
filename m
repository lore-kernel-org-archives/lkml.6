Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2908601-1520178570-2-9031605270115374022
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520178569; b=WfVw56O3RUVzM/pPX+vSAJ6SFDZ5Cb2XAVsZgn/02c21sVc
    akomTCZ03Qef1gdLHEpRt08Gv8P1/1f08RuALYpMFth8uQj2OripVukhoZDiqo2t
    xEtorsjAySWlbRdfwFjArnPHMSwG8Aet/o62t2v/RndYPmaEofFdJHN8cV06PTVz
    KnfYnCwrD1xDcjtOabbPepqFFPwz/4ekfg+UTJwaRoPXjyV/NLDYbOKflBwOBiqh
    a6m0Vid7QPD2GXMY4AACjp7HYYQF1TrkvPGBapCpcm2OS7Nty8sbaVXkcUs43+h3
    mys3dKdEx8rr8Kpqp/tBQQWjTece6owf6sGAi0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520178569; bh=4
    7zYQCyBpYHUlzuwf528M4UswDxh29c2pVc5MU21KHI=; b=MV5+CfiHLjsx+J9A9
    hRnumrUCgY+v8F6BJG2GBsaTCpgjWA7fizXB0hJvkA+rToB6SDdF7/3U81NhSDe+
    /dXL2oogdbhbBYzaKrq2xma90rnd4eez4ywn35QxJnw+KPd+OM1dnbTFWG4Sbdr3
    5yyytB6g5A17tLWal5VBTewX0vNbJUAGlAZZuJ9bsh2V7SxxCezdh7K0MMC1YZcC
    Gp5x+v9bpY56bV5TN28iCtM/v+hDux3FSp9Nm36NuzLaMTOnV6AljaWjqOwP9YW8
    CamVo6ryuzdDmpkyZiMU7RfPj8SdUsfTsS6WvtRSvGP+4tQeVXuREBFd+dSnUbcT
    t8m0g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Gwo8SMAy x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=EYaWkBKJ;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Gwo8SMAy x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=EYaWkBKJ;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELv/CI1iMD6tmSik+l5N28ldi2MLlubGfdzZovba/8NerWXSYmIZC/GDnilJCh1q2Z3mLJZo7w==
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: alan@linux.intel.com
Subject: [PATCH 2/3] staging: media: Replace "cant" with "can't"
Date: Sun,  4 Mar 2018 21:18:26 +0530
Message-Id: <1520178507-25141-3-git-send-email-arushisinghal19971997@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520178507-25141-1-git-send-email-arushisinghal19971997@gmail.com>
References: <1520178507-25141-1-git-send-email-arushisinghal19971997@gmail.com>
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
Cc: devel@driverdev.osuosl.org,
 Arushi Singhal <arushisinghal19971997@gmail.com>, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com,
 sakari.ailus@linux.intel.com, mchehab@kernel.org, linux-media@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Replace "cant" with "can't".
"cant" is not same as "Can not" or "Can't".

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
---
 drivers/staging/media/davinci_vpfe/vpfe_mc_capture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/davinci_vpfe/vpfe_mc_capture.c b/drivers/staging/media/davinci_vpfe/vpfe_mc_capture.c
index bffe215..634d38c 100644
--- a/drivers/staging/media/davinci_vpfe/vpfe_mc_capture.c
+++ b/drivers/staging/media/davinci_vpfe/vpfe_mc_capture.c
@@ -444,7 +444,7 @@ static int vpfe_register_entities(struct vpfe_device *vpfe_dev)
 	for (i = 0; i < vpfe_dev->num_ext_subdevs; i++)
 		/*
 		 * if entity has no pads (ex: amplifier),
-		 * cant establish link
+		 * can't establish link
 		 */
 		if (vpfe_dev->sd[i]->entity.num_pads) {
 			ret = media_create_pad_link(&vpfe_dev->sd[i]->entity,
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
