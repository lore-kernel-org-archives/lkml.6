Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4098225-1526051193-2-12597147625285608875
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='fr', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526051192; b=iEWFb0eP5ClzKM0EgdOE35d4VxLAjN8I1rvyVehyGwpvmAj3IP
    9j0MDTL84i7IeonjF9zxJG0DWq4YaUSJWviAKOURwQsW45LLTrbjxZ1bsTae23aO
    4cwqzFH6LTjVsD6YpvjqH1xErAzO5AGAX9vJT/dhbcST6811n75YGywJ4YW1YHBf
    U3sA5qr5AFcjKxGVvXw4hnSzcI0bgp1usU18buxOn4wM+hf5Rm9bHBeBPk04j2MU
    ucp4kzLg/iFjOi0nu7mB523rPSokvMivt2tll8PxljbYfc60/n09oCDJancWQRdQ
    Q7Sw7f8spVz+tEw+xtLqeDA15NriBZk7nKQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526051192; bh=RZEXP
    a/pQEnOK/XlA6ib94iBFg6opIUQ4wjMWw4xquo=; b=dG1vpwJtt9RxjNPoysxLN
    ipl6zUqYRu/Of9hERallGDelIC1zxvEuu387xJwwt/+g5mMVIgNT3fTsYCWkaKCt
    AxkFGJ+YOXQ8mlLXnG9yZYqMIHZo6N7Ob+JtIJbz89hQS3iOK50IPH3/9uvf9Rxg
    pI8JKWuudyNa1fBMUxxXp0AFwsUKChdHRaWPz6z35lYNYUUAQwewF0oEnWpQWodu
    /r15S1SgR/Ep9FjOOagWO2IJajVGkRvur/2FOpxu1sX8sQTvwpEsUX4vkLhoOEyN
    ctlDIkmb58ak1z9VT6C4/3aSrNCxAm4rAaDlNkpfalL01Uf2y7E3bIX7rKkT3g7d
    A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=wanadoo.fr;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=wanadoo.fr header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=wanadoo.fr;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=wanadoo.fr header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFf4PItFNRTdtm/SzUadIHOlK3g2YonzUJkiBGRtSI8AgHlL89WmkIkxujfJxd8hOSDoM4RWz5sy7Hdvd5j8LqBrTbrqtRb5TpMFeA0kreXvtaD2gKHV
    aF8QOR7RY5uuW8a1zM7ZrKPWkaFOh4CzH8Bh+I+Rz/lrzMfMu/Af0XwNJ37p+n0+qCNBQ1PwsSvN/a6hXMehnYvDChhuDs4Enh1+2NpXh23O7lw79SLCO7yT
    ygu3q1Pw6SNY/SB76WaLjw==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8
    a=chjP6sQugMFXrh-HTt0A:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-ME-Helo: ubuntu-CJ.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 11 May 2018 17:06:20 +0200
X-ME-IP: 86.244.116.1
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: alan@linux.intel.com, sakari.ailus@linux.intel.com, mchehab@kernel.org,
 gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
 chen.chenchacha@foxmail.com, keescook@chromium.org,
 arvind.yadav.cs@gmail.com
Subject: [PATCH 0/3] media: staging: atomisp: 
Date: Fri, 11 May 2018 17:06:15 +0200
Message-Id: <cover.1526048313.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.17.0
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
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

These 3 patches fixes (at least I hope) some issues found in or around
'lm3554_probe()'.

Please review them carefully. I've only compile tested the changes and
I propose them because they sound logical to me.

The first one, return an error code instead of 0 if the call to an
initialisation function fails.
The 2nd one reorders own some label are reached in order to have a logical
flow (first error goes to last label, last error goes to first label)
The 3rd one fix the use 'media_entity_cleanup()'. If this one is correct,
some other drivers will need to be fixed the same way.  

Christophe JAILLET (3):
  media: staging: atomisp: Return an error code in case
    of error in 'lm3554_probe()'
  media: staging: atomisp: Fix an error handling path in
    'lm3554_probe()'
  media: staging: atomisp: Fix usage of 'media_entity_cleanup()'

 .../media/atomisp/i2c/atomisp-lm3554.c        | 20 +++++++++----------
 1 file changed, 9 insertions(+), 11 deletions(-)

-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
