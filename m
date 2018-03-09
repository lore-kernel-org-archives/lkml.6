Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1715849-1520639143-2-10228853290366076931
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
    t=1520639142; b=KzCo+IZYLZ9VTuDFcdfweVCB4rTBDXG9OQAyCHghfT4lzwk
    bW5aPRp0jkykTMZcYUlDHK/LodNpxtwW1trFN3uBgECbfJadysgnzDn8qWLZFLm/
    gW5JsbEBirO669l0Crkpdk/RxbBwKPJ22GfqxdWtzSDCiGEKSxRaQIdpsSh8S5aa
    XJ5kf0CWFaiLlZQxYvVy+42bFQ4A9ISHcMQL0T7KySipw42EOM6oCQEeVOb6ULml
    5m7PPHvC4DX7iKzvI7+LOsQHRUB4d9h6fqRM1RKDd/2nefgoTMTfutuqwiFYTru4
    LCFtCGYiZEJCr1MZDt+IrXmRKL482M5uXts+T2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520639142; bh=z
    CU5le0NfZc75LxqEUsWA+YO1O4kh+1dpv6XBFl+0Bk=; b=IbACX5kpv76tMySrc
    xJG3EIMz2G5DHRSgwEEU0p2TM334Y3B42/63K8syq4LV8GRKEoE0P1yYtJR5SwHC
    KwTGN3RMMx5ayUd5FUxx7S98Ssk2S5wqvHXZ1xncLYsgbgRqV4Da+cMlghLmq+/4
    xz16ROs8sgzUjt99arLnlWSdNAJoYCt8xwfrSTmIIJzqVJTyExzE+fIbWZznqv4n
    8ln43fKHxKF/zr/lE+T/JkSHtezIrXebVgdWND2NK2NEcYoh4UTBNbKswpBjY/xG
    v0Y4lAUEsZUQ0pevpWKn3y5b9daqH0s5UV7iV6IG+6oOHTNSbRbOPC5VDt0Bo3wA
    OI57Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=QSfSbKFW x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ObYrvlC/;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=QSfSbKFW x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ObYrvlC/;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELs3Yif10iaIdHUI8C1ro0N95bxI+e2EuVfICYOB0K0oXVqEg+Hejn/CTRlFE+76kQlN5VV6/A==
Date: Fri, 9 Mar 2018 20:45:29 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Graff Yang <graff.yang@gmail.com>
Subject: [PATCH 0/4] staging:iio:ad2s1210: Driver cleanup
Message-ID: <cover.1520638889.git.rodrigosiqueiramelo@gmail.com>
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

This patchset removes some unused #define directive and variables.
Additionally, it fixes two checkpatch problems. Finally, the last patch adds
struct documentation and comments to some part of the code. All of the changes
have the intention to improve the readability of new updates. 

Rodrigo Siqueira (4):
  staging:iio:ad2s1210: Remove end of line with '['
  staging:iio:ad2s1210: Remove unused #define directive
  staging:iio:ad2s1210: Remove old_data from ad2s1210_state
  staging:iio:ad2s1210: Add comments/documentation

 drivers/staging/iio/resolver/ad2s1210.c | 52 +++++++++++++++++++++++----------
 drivers/staging/iio/resolver/ad2s1210.h |  9 +++++-
 2 files changed, 44 insertions(+), 17 deletions(-)

-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
