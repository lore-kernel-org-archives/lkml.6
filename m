Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2286252-1521051044-2-8659882274445554327
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521051043; b=eHANUEG804GUKEfej09CAMub/p6h1sdoZYtHD3OtSAo6KUK
    1s3tlb24orTQ1IRMedbMCZtLNMqnXJ91v8X0RLm4z5VP+aN/cOkdpGPWz4QC97g1
    q6SBhu4nbRSff1lxKqnO4r9YbO0GbT55YaE76fBXoyEu7I3hf7IARM0aQEdFpZE4
    M64FmVJtiOjF3yQEdX9zuFRR/2YSNHZ1c2SykS230s4q+tj1mYfK5Xl0WMvfjCGe
    ZtYaAIWiQwuSO/eDtJD8NeE1NyMG0HEXk8dMU/QZK/MHdvzZjKsDnwTA1qvxw9gx
    3bkPiXMx8xj/a6ncuBYLDGS1gZAgcqNOaV7Opfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521051043; bh=D
    lSzKJYWJpt0UmNgknoxo3YR7cm3YLLcWBcnNIk3qLQ=; b=e2gp6Kh5rZhUlWHiY
    gLsU8tmFgp1r4Z7he2QqmUsWBgHi7gGl2qlqzboyp12+DAxPb/uUzC7R5ICO5gwB
    muQFVcIxWJ5bwl/oBykADlKyXs8sq1C24eM27LwemeNe+jwb4mduJBZZBWUW9JtN
    KOVnBzYje9z0f1uBSMYnrDEG+DA9fWqPRF6rGpG3DdtRpHN5IeyjHO2vnUSpBVR2
    T+nDMbUqB3byiYkxxdeBg3VJNmbHpZBWK9ZMy/nA/U2zhK5UlUPBSe97C6mT+Xqt
    9sd+6nfkT3o5iGe5i827YsfXlMVd+SmOC7o2yDs8GDucoqldMZjZox8cR4e6O6U2
    zCOdQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=HxcSi2eJ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BG1u/85U;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=HxcSi2eJ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BG1u/85U;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELsAqE9m9vbm4D5vUOB/x+p8sfcrVE7c4CHzX1WFMrqiiXyN4UWaziqWOsWhoKLWOpsbkvrtrg==
Date: Wed, 14 Mar 2018 15:10:00 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Barry Song <21cnbao@gmail.com>, John Syne <john3909@gmail.com>
Subject: [PATCH 0/7] staging:iio:ade7854: Cleanup on I2C/SPI code
Message-ID: <cover.1521037060.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: NeoMutt/20180223
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
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
 daniel.baluta@nxp.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patchset reworks the I2C/SPI code from meter module. The set of
patches try to reduce the code duplication and make the communication
reliable. The current version of the module had many code duplications,
which make the code more error-prone and hard to read. Jonh Syne
identified some wrong error handling and fixed it in his patches; in
this series of patches I analyzed Jonh's fixes, and use it in the new
code.

It is important to highlight that meter module is under observation, due
to the lack of hardware and the old design of the chip. However, John
has the hardware for testing and interest to help to update the code
[1]. As a result, this patchset represents the first work effort to
update the meter module in the staging.

1 - https://marc.info/?l=linux-iio&m=152046885922153&w=2 

Rodrigo Siqueira (7):
  staging:iio:ade7854: Rework I2C write function
  staging:iio:ade7854: Rework SPI write function
  staging:iio:ade7854: Replace many functions for one function
  staging:iio:ade7854: Rework I2C read function
  staging:iio:ade7854: Rework SPI read function
  staging:iio:ade7854: Remove read_reg_* duplications
  staging:iio:ade7854: Add proper error handling condition.

 drivers/staging/iio/meter/ade7854-i2c.c | 236 ++++++++--------------------
 drivers/staging/iio/meter/ade7854-spi.c | 268 +++++++-------------------------
 drivers/staging/iio/meter/ade7854.c     |  44 +++---
 drivers/staging/iio/meter/ade7854.h     |  23 +--
 4 files changed, 160 insertions(+), 411 deletions(-)

-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
