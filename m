Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-257181-1520339139-2-16700835051379714847
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520339139; b=gnkgWFGkqdTZR5mQxXCvCpHOqaTqGJRhvhKJeK8cMm+XjWk
    aCDUAEMiZwLAZyzK9Fgy566XyYoPFUPez7SLeRz0X7Yg9DhpLZ4K/X8efnrn9FaD
    8LhnhbLIqtcdAX97sHlITohrEPvylONA+jhwkMecnaC3y/R9Bh1FZGiXo6SV3aUO
    HiqqxwKIrmhirYhxO5lVn9joVpII7LE4mWkreVcXFKbIbuN7ZqLlAT/kmZErRyrr
    +CrMaEpNdu3VSw4Jut9cx7SuvwdKNIl7bUtTbhSLrX1Zxf40zUJQADnR5Wkz4sIG
    YHjfZLQTQS31HArZfcf9i2rJndbBwuQGYTYnKGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520339139; bh=+
    BFN/Cnxmed7TUwXNWLYkmCuD0i+X21LEHet4J0lRP8=; b=FVk7wssdVuLWxkwqp
    txahWt1GIW9JEKduF5jUi6Vy52sp+ZX6svxiI86ALrVCx3hWkrgFTe40WzVPGinI
    vAX9wDDUmTCJqO2n54tYLW5e7w5FTqZKMKTIT6eoUrkNKFq9r5DsPY5i7EXGdzT4
    q9gDb6UoT80CSEXy94Gco845VwAroDFRhn2hvp1GLCr8PhmfDGpyDNrkvz6FsrlL
    1N9SUIlNcjL1U5LDU7e973heg1hvV8rAK4NfVwV+X9uJfanqP5hPS4Rq2wlPrNmG
    NH3V5Yvs7D9AdNwTHNreGS62AkE8ZCFGC49XApFwnWtM+dzMFURXiVcZR4pNMw1Y
    r5GRw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=AbZ/3bcH x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=C+cd/Deg;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=AbZ/3bcH x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=C+cd/Deg;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELso0CdFtJz5+7z1+tfhe6iJOSfwbawzSajZ7DZic5TBd0PVM3lL+FJBac8pErQSk+WXL4er4A==
Date: Tue, 6 Mar 2018 09:25:26 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 0/3] staging:iio:meter: Checkpatch cleanup for meter
Message-ID: <cover.1520338980.git.rodrigosiqueiramelo@gmail.com>
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

After apply this patch series, meter going to be checkpatch 

Rodrigo Siqueira (3):
  staging:iio:meter: Replaces IIO_DEV_ATTR_CH_OFF by IIO_DEVICE_ATTR
  staging:iio:meter: Remove unused macro IIO_DEV_ATTR_CH_OFF
  staging:iio:meter: Aligns open parenthesis

 drivers/staging/iio/meter/ade7753.c         | 18 +++++++------
 drivers/staging/iio/meter/ade7758_trigger.c |  4 +--
 drivers/staging/iio/meter/ade7759.c         | 18 +++++++------
 drivers/staging/iio/meter/ade7854-spi.c     | 40 ++++++++++++++---------------
 drivers/staging/iio/meter/meter.h           |  3 ---
 5 files changed, 42 insertions(+), 41 deletions(-)

-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
