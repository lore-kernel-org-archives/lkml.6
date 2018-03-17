Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1672187-1521300520-2-5282152204956710700
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521300520; b=r5slnNT3ASArl+A2KeVcdDVcvlngeDFD4P6UVP78VIyrEIl
    Z6KY0cA3kb3wuG3hf4E3qxIeaVVzyyVwzMACjCSkM1Qu4ESs5gNa+QEyBRuMsrEz
    yM4V0ulMrpwr+s5k4gqCSrbjs0nWeIysCK+vVLjbWj7IWGDlP+Bfr11i6+wPaMtN
    ucntZ+emdu/GOilrXf5pg1a8vMWIOggu62PXndY0YLr1DLuYoz32WSf7zrlu8xdk
    2SFg1LIjtMTMlSh5tM+aKt31aYQRGGuwvhWKrUqxwXTOP6Ih8LZoDctBWrc89L3j
    mkcaQA+n0ugRciccdF+7AebW6ek8VeJachIvP5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521300520; bh=R
    7ucZlMr3Qv8FX/stf0kON6kKhBlnd6TV8QUZD0+YgM=; b=IlJ1y1qQEpsDJdvD5
    pO46TLN35h/8niZjq45a8SttscmACR+GSI1ygyqaXOpuQN8xmWsAV/YOM6A0mV76
    C9JUdPLNmuZG4WKqk3SvpfJopKVK+Rlyqu8n/u5ds09/jvU1DSfsMk7pQE7ixAbV
    SP4gUANEFXJpgUpiZDVvHPw7WbCopWQOzit/4gfJFt/A3OPB3gaHTdTm+UmIdOe9
    JuWiiXD2mAdS5nzRZNalc7uDq93fExdaT//IpiG7t0z35oGHeJxUfkspuLvteHLF
    V3EXjLNYhv3xM9EsIVk9SowgapXVJV6vIHznjfe0oCU+59ZG1duhOeBcjCr4/Njy
    BNoDg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=HKCNvOLn x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=bOWjM1oR;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=HKCNvOLn x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=bOWjM1oR;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELucetZnXHgDSdYPqZV4Ow6CyRqpE++z64wRl1zuySu5Mo4NGZfNuyTh8OjphVQjvSFR2hpypw==
From: Dmitry Osipenko <digetx@gmail.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH v1 0/5] Tegra Video Decoder patches for 4.17
Date: Sat, 17 Mar 2018 18:28:10 +0300
Message-Id: <cover.1521300358.git.digetx@gmail.com>
X-Mailer: git-send-email 2.16.1
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
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello media maintainers,

I've been postponing sending out these patches for awhile because I was
waiting for a review for the Tegra memory controller patches that would
allow to reset VDE HW properly and was hoping that they will get into 4.17,
but it's getting quite late now and seems 4.18 is the best bet now for the
proper VDE reset. So here is a small patchset that addresses couple of
minor issues that I've spotted over time.

Dmitry Osipenko (5):
  media: staging: tegra-vde: Align bitstream size to 16K
  media: staging: tegra-vde: Silence some of checkpatch warnings
  media: staging: tegra-vde: Correct minimum size of U/V planes
  media: staging: tegra-vde: Do not handle spurious interrupts
  media: staging: tegra-vde: Correct included header

 drivers/staging/media/tegra-vde/tegra-vde.c | 63 ++++++++++++++++-------------
 1 file changed, 34 insertions(+), 29 deletions(-)

-- 
2.16.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
