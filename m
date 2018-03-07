Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1675485-1520383410-2-3694484381918114131
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520383410; b=saqYVyi2s48HLi/veg9yDxt1AfONlAIFkhmgQ4wEMMGgxwv
    ER725OX6lBc+oDpjTeny+5nx/h8MhgQvtyqKN/pIrvoE7Itmb2HTUVklmvlMjGvv
    EKF5pn82zI2TuqlDhZnkzy8qXzbTPTvrTqCBd08dLKLzpBE3CrtsG2zVuFK5eOUx
    EbpFBvMSLJV++RePO1vC7TpAkxWjRER2CS+dEkwxm9JDD8+WH/qA76hyJeus8/l2
    7TfxhqZQtdXl86W90gT25oJSNewJDRE6+Yw8iCLM+eBiUhAABiG7DKJ+Z82/M2+S
    fGEbsdoj/+TF0grCzIc9sy4LNJb2uAv3ym431gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520383410; bh=s
    ftg7mmKhWrTHY8fJL4m8fr/hPwFAoOE5C5e8DZNJgI=; b=CAC59iXDn/CqRI0kO
    iTXAWeefUB+HXUaMDfY9s8f7u/3Xxy7Q2KrmOi74JZid2iYAmcC2NYMoasDqsIWU
    WU/mJeeAEWUfKpF3SZhynf7oMbVbMp+AnpxNMKLb5NJbfpyK/STEYZ0U1jOelTNr
    5hdvQN72/wr4PqiYGYc9LA7YlOuekzs+qUO1bN/0CFlggGi46vZhKBOVnQ9EAdWY
    M2LF4VmkQFlOYqijFCvIl5DVgoMAhY2c+npXa0uYk/sA7efZvLuVMBNG+auM8pWy
    MOaKH3lTqsU2/Nvobc8qslk0viSEqAmZr9pKUJIgjXaGGTlAkm6m6tK6UmqjEwFv
    sU2gw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=hrbc3rfJ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=lkBz9JfI;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=hrbc3rfJ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=lkBz9JfI;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELt1UGlQXZICfHUqRB4R1+wMGy8tToxXyYfxMj/6KoTq50dWwsoaPU/EACpPu0ZAf98MGqyBkw==
Date: Tue, 6 Mar 2018 21:43:17 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 0/3] staging:iio:meter: Checkpatch cleanup for meter
Message-ID: <cover.1520382753.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: NeoMutt/20171215
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

This patchset fixes errors and checks found by checkpatch.pl in the
staging/iio/meter. These series fixes:

* Removes the use of 4 digit octal by replaces IIO_DEV_ATTR_CH_OFF by
        IIO_DEVICE_ATTR;
* Removes unnecessary macro;
* Aligns open parenthesis;

Changes v2:
- Aligns one extra open parenthesis in Patch 3.

After apply this patch series, meter going to be checkpatch

Rodrigo Siqueira (3):
  staging:iio:meter: Replaces IIO_DEV_ATTR_CH_OFF by IIO_DEVICE_ATTR
  staging:iio:meter: Remove unused macro IIO_DEV_ATTR_CH_OFF
  staging:iio:meter: Aligns open parenthesis

 drivers/staging/iio/meter/ade7753.c         | 18 +++++++------
 drivers/staging/iio/meter/ade7758_trigger.c |  6 ++---
 drivers/staging/iio/meter/ade7759.c         | 18 +++++++------
 drivers/staging/iio/meter/ade7854-spi.c     | 40 ++++++++++++++---------------
 drivers/staging/iio/meter/meter.h           |  3 ---
 5 files changed, 43 insertions(+), 42 deletions(-)

-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
