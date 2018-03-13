Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3527955-1520957118-2-4171796850058579982
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520957117; b=osYpCsVxaPfho78sa/viMu+2Zq9hKX2gJk7FtiTzDKgKwE6
    /lfCwjkGCF+dzEk42m07jqgjeAJmMPjhnAlq/JWATicmQCwJfwSA1OoWcxoevkBT
    K6nPiRNx6KWF2LEyPhsB8DUNp5vXdSxd2tUKPAvGkWCJhvITkO+9Nu6TNNcI03IW
    BMFVp+A2UPrIQeJ/G9MmM8P7FuETIUwJwGXUlNfPsobEAGYI0B6hX69HUEEM3wtq
    0RfNr9i60df6X9PF1pqLVka2Svnq4Vfqx8eDrAkucDt//UELsZrlcuhpTkeWIos7
    GaclyhUMzTDIWyV7hvdCNUm+oPn4rvM0P/0d58g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520957117; bh=M
    9uoNCLYir8Ctfc5kHNvJg8emiHetZS85nNqRLq1b2w=; b=M69SE0Dsrj0wcqryN
    l0VBvkULw0Svg9lCrYzyCFo8fw20LylhngHOQBL4kAA/CPx7pYAh/kwvnWakEh74
    yhofHHGvrHMzu4I3eaP96ZXHdcB4ZxDFQoAFSlfBEo08ZdglcBaNdJIxMwZgX1Ac
    ruixUvvO/AcZ8FpYmkdw7gLndia3tY4wI5Ct/Meg1EA6WV4fnwB1Z1pazyFAT5zS
    HKqc3bOuteT170xZzYzPoY6zezewFd1TRFSaQj1Vf/+SG/2t+fFssnn86DCopPa0
    wgHVi+tcDFXZ0z01lPBETVVUrGUN9dlgLpAq7a0uDyNsLyWmp/YgUu6lfozOJqYc
    W0+MQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=r4N4zC5y x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=RSMZbPO4;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=r4N4zC5y x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=RSMZbPO4;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELuVe8R2+LyGH2Pj+hN89sHsJphwjvNm+7FjthVCfcHneCAy3l0ZJxZBQVbfbltInR58Q/2QwA==
Date: Tue, 13 Mar 2018 13:05:06 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Graff Yang <graff.yang@gmail.com>
Subject: [PATCH v2 0/3] staging:iio:ad2s1210: Rework read/write operation for
 fclkin and fexin
Message-ID: <cover.1520956563.git.rodrigosiqueiramelo@gmail.com>
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

This patchset changes the way that frequency of clock input (fclkin) and
the excitation frequency (fexcit) are exposed to the userspace. The
original code uses the IIO_DEVICE_ATTR to export the configuration of
fclkin and fexcit to the userspace which is not in agreement with the
current ABI. This patchset adds one channel per clock configuration,
updating the read_raw function by adding a handler for the new channels,
and introduces the write_raw function.  Furthermore, this patchset
removes the legacy code responsible for the read and write operation
related to fclkin and fexcit. Finally, this patchset uses parts of the
original code for handling frequency configuration as an attempt to
avoid problems.

Changes in v2:
 - Removes unnecessary switch case in the write_raw function.
 - Replaces the use of goto for direct return.
 - Removes definition with string.
 - Removes unecessary label.

Rodrigo Siqueira (3):
  staging:iio:ad2s1210: Add channel for fclkin and fexcit
  staging:iio:ad2s1210: Add frequency handler in read_raw
  staging:iio:ad2s1210: Add write_raw to handle frequency

 drivers/staging/iio/resolver/ad2s1210.c | 191 +++++++++++++++-----------------
 1 file changed, 92 insertions(+), 99 deletions(-)

-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
