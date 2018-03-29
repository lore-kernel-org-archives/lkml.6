Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-460763-1522314623-2-9487587918432502739
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522314622; b=HRZvwok7XgkV9/ENz774MOJwJblQ+XIT2irIpPoAjyONg7hROW
    2lp5kflLPujvM+PrYP8kuymUoHxUxAf6qt4zkOWTAtdJ4/n9XlO8eQlP9fPrPMZE
    XQVHid0Vxu+74ZNaD6gClDeUQmZZt2rJ5+e2F25tCm496NQhl6BOFLHre0a2YQ+c
    uVgVWIp4Pln9g+FgKSVGkEHuQAk0IyZvTlfnqkBjKGj47eiZS7ZaPg7RA+YmK8vW
    i7k92H7A3IZTq6sAgkUlMYTahLeTsKtUgI+vUCqumOyP7K9IQqMHr8ibS7PzruHL
    CnIXL2DAVtp6rEdkrlxSqpwENiGnRdCWK/oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522314622; bh=XQz/F
    yVptEUW8YftZwVMdTxDN/BbZ/ys2wrLe8P+3+w=; b=mtRko0miJAQF7Bbjm90iX
    rIxViIdSHMVoLp83KtTeBH7FkK6JJWU3p27gVRWmLuYw2Db+n7hF7jBigar0J5ni
    FfXk89WWVmVo/APmpt4vPB9vlmcsW8CVxkQ1RWPbc1anKmCFCqlMk2LNHMNQth7r
    dpDhWnKpVRdBJthAgDVnA2K/xiU1WLCkuuhs0IZxC54wf56mHCqiKHWJCDFfWmYc
    dbWCMc8G86WsVx3Otk+MfhmP6NiEEergwFbPQn28DOu9yYYBSEyCiKchf7zJaeF5
    ca7MTFjdF3+TK6mbnVKeL5dxXesMFIpYXMWdAKnbqVY3o2l7pLFLEI2lm0T7lniV
    w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=TgK+5PyA x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ETzbZ3UO;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=TgK+5PyA x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ETzbZ3UO;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEKZgepScbMNBfqEd/ovSbofqBubxaN3uLXqCKTh0+TgKDvgdja/V5C7IayODl97X44LrLepXGEgXoeIaKSa6hrsAcvuaMcHmY7qw8Aqmx9CPJVeMVww
    GpcvuAzD3PC+xBLiYF8Ko9z/4DovVoNl4cGSGVK5+Gpc5XIEKELhFJZuTDPxrNTcI6PU6fL5jos6XX1ZliWM8DvWXN9IpKYd3AL60GQ1Xe25kmggzPK+KWRP
    dxsdRycvmZUy+4PsZs/o5A==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=MsQ-QqnFFZYA:10 a=v2DPQv5-lfwA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=DDOyTI_5AAAA:8 a=9EBvDAQEqJaQTFMUwpYA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx4/SrdsgyDM10WSRSFF4vPbD99TK/WEdf2ba/FwFxKOpG1nA6QUqngdeczRCUMmmDKT4Z/+TMA==
From: Shreeya Patel <shreeya.patel23498@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
 Michael.Hennerich@analog.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devel@driverdev.osuosl.org, daniel.baluta@gmail.com
Subject: [PATCH v6 0/6] adis16209 driver cleanup
Date: Thu, 29 Mar 2018 14:40:02 +0530
Message-Id: <cover.1522306893.git.shreeya.patel23498@gmail.com>
X-Mailer: git-send-email 2.7.4
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
Cc: Shreeya Patel <shreeya.patel23498@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patchset has been introduced for the cleanup of
adis16209 driver.
This patchset cleans up miscellaneous code fragments
and improves the code readability.
After the cleanup, driver is moved from staging to
mailine IIO subsystem directory.

Changes in v6
  -This patchset has some new patches introduced for more
cleanup and from the previous version, patch *[1/6] has
been included in this patch series.

Shreeya Patel (6):
  Staging: iio: adis16209: Indent the field definitions
  Staging: iio: adis16209: Prefer reverse christmas tree ordering
  Staging: iio: adis16209: Add blank lines
  Staging: iio: adis16209: Remove unused headers
  Staging: iio: adis16209: Use GENMASK
  Staging: iio: adis16209: Move adis16209 driver out of staging

 drivers/iio/accel/Kconfig             |  12 ++
 drivers/iio/accel/Makefile            |   1 +
 drivers/iio/accel/adis16209.c         | 330 +++++++++++++++++++++++++++++++++
 drivers/staging/iio/accel/Kconfig     |  12 --
 drivers/staging/iio/accel/Makefile    |   1 -
 drivers/staging/iio/accel/adis16209.c | 334 ----------------------------------
 6 files changed, 343 insertions(+), 347 deletions(-)
 create mode 100644 drivers/iio/accel/adis16209.c
 delete mode 100644 drivers/staging/iio/accel/adis16209.c

-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
