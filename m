Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1445372-1521814908-2-17172023038151839382
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521814908; b=Ik5xl0mAqCPkq10dYAUuWAQbiShF6+a48zhacgDx2fURVNz
    YcJzf1uK5XZog7EY4iWCJYtWTgaN74DoLLy91Cm5H4I4ALp+Uo3I+TxLupp3qvAl
    6J5wTlT/in/xKLTNjJFz+9+6yhPzsKxq4LAFRzl68S2f9VYxCckaWqEKdF9kdD+V
    5v+ab2T5cGOvcvW0NXAoYCEQRWJzK68t9kXrFHGyqVYgMuLbPlXNejnFogQ8n/ND
    NMOpZVWlAp+mKTlhq6T2g0iwX+Z/H3OyYU8BgKmpTJItKIhrZ1vFdESdlmUvROQY
    0ZMe3tPOM7Mg7pIl95F1Mks6om/wkzNUtviaY9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521814908; bh=1
    /VWhnwooI49s9Vgr9nar3sXRKIBhFJiATMO+7PifNY=; b=EqwbtKovm9KPOcRT/
    lcvDqXQ4EoBZBMoKsaOqX6P7Rhw5l9sIP2NRaFnLkHmJvzm/QDFtlFkB6zQUNna6
    dtRbrOmCUjxP4420FSGLxTK1r8vH1t5uwN6p/zfrYq0URwfRvDHEtH0dXz9wiFR5
    jAGXR+7roYLkHuYKXVnAbx8XErk1bgEe4m6pRKQDv8LIc+ZaGAgZzI14v+MGwdRD
    l9S9Yas2CSIoH9VW5ff7KBZV3hSQPC7bBBsTAGMo0wkwq3Ma0eanHXkqBj/pJz/3
    p1r3YKAFC5VofeZJJqxtdM8b9wwC8AcmaO5kkbVBzm/ai8mE7xO/zQ4NC+Zneouk
    HwItQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Bf7FP6GK x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=t9uZnDWl;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Bf7FP6GK x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=t9uZnDWl;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx48E2GiaK/Eua5K6McdsXi2Lt4gwgYyyzBUXYWbWe7VMgcwnu+vDVOxIIBWB1rI9Gn0BlUSuuQ==
Date: Fri, 23 Mar 2018 11:21:34 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: John Syne <john3909@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, Barry Song <21cnbao@gmail.com>
Subject: [PATCH v3 0/8] Cleanup on I2C/SPI code
Message-ID: <cover.1521813782.git.rodrigosiqueiramelo@gmail.com>
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

Changes in V2:
 - Reorganize the patchset to make easier to backport fixes.
 - Adds two commits at the beginning of the patchset. First, fixes bugs
   related to wrong verification in read/write I2C operations. Second,
   adjust the incorrect amount of data read.
 - Removes unnecessary code in read/write functions for SPI and I2C
   during the rework.

Changes in V3:
 - Adds clarifications related to authorship.
 - Adds 'fixes' tag on the first two patches message.
 - Removes unnecessary defines.
 - Updates commit messages to better describe changes.

John Syne (2):
  staging:iio:ade7854: Fix error handling on read/write
  staging:iio:ade7854: Fix the wrong number of bits to read

Rodrigo Siqueira (6):
  staging:iio:ade7854: Rework I2C write function
  staging:iio:ade7854: Rework SPI write function
  staging:iio:ade7854: Remove write_reg_* duplications
  staging:iio:ade7854: Rework I2C read function
  staging:iio:ade7854: Rework SPI read function
  staging:iio:ade7854: Remove read_reg_* duplications

 drivers/staging/iio/meter/ade7854-i2c.c | 238 +++++++++-------------------
 drivers/staging/iio/meter/ade7854-spi.c | 268 +++++++-------------------------
 drivers/staging/iio/meter/ade7854.c     |  40 ++---
 drivers/staging/iio/meter/ade7854.h     |  16 +-
 4 files changed, 152 insertions(+), 410 deletions(-)

-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
