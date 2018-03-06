Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-257181-1520339162-2-15433942585763059410
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES daen, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520339162; b=mi2qiq0u4iFzC1zcKJm3Shx2+y9CszzJx9bKZxsZzCql7kF
    abWcQjHRM4pGhtJzwr44QU6V3To9UjH0zYwlHqgFVrEy5sjXVAB4SvfSjbCECPPc
    gHf5F/ZMFSC4KM/Qcykjt1MtYwa0QRK8qHqPWMk8r6LucNSozxqq1KtZeXATAiub
    QulW7KIKuCGHfZ0sJMg8oTefyECJDmHHyTjHNKFE2eYUQM5D8kfTD3zV7c3Qh3IO
    47XUBTtMz1IR3/7Pu19pd5hBYVxw6h11412lYD181ieaLlwcHIgpK0wNhMvhruqS
    BNeZpXXMQ7F7rGAuqlBlCMKuy35wzIVDERzdu5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520339162; bh=u
    4YSCDZmK5F4lq+jgIYCTnwka+zwDNCykKysEpvmxoo=; b=Y5u3TuonumiRcZfMK
    hY4AKUF5hzHlS+mWkoAKhj2XicI8F/1LQZjQDrZOE35HzD4sk8YMx+8mCle29mbD
    jQiQqmjNLKjej3LK3E+3WzfxNsuprL8KWw5TDp7TtuOIgwJwgs3L8JSaCCRhY1dm
    V2CXO5mOoxqRdN4xswdxJdq6uxDll5LGDedlg8WmkcrQDjM3PnvKbdsV5xuA9aJg
    cRlA5UmmBzSLXlcCHaWwSwuZRYBcUMXz+qcGAbAHZwqjLFUtVNTOg//2/mT/aBvs
    m7l4UtEY2XNuk+avobA/PRDs8+/ND58GKltiN5GBQmzKG2KT+xhTnchagqNcpRHo
    pgeaw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=sc+sEhB4 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=SyRzo2CH;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=sc+sEhB4 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=SyRzo2CH;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELtclernXJMv7XN43qvwUYp1oTl6wvL7Qu5YMshkDPwh3DyXro0LhvEFgJO/6YoPkYIKDrQlwg==
Date: Tue, 6 Mar 2018 09:25:50 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 2/3] staging:iio:meter: Remove unused macro IIO_DEV_ATTR_CH_OFF
Message-ID: <d22093b4c22f6df9c6efc2e7f711417726719fee.1520338980.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1520338980.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1520338980.git.rodrigosiqueiramelo@gmail.com>
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

This patch removes the macro IIO_DEV_ATTR_CH_OFF. The macro
IIO_DEV_ATTR_CH_OFF is not required, due to the replace of it by the
direct use of IIO_DEVICE_ATTR in files staging/iio/meter/ade7759.c and
staging/iio/meter/ade7753.c.

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/staging/iio/meter/meter.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/iio/meter/meter.h b/drivers/staging/iio/meter/meter.h
index edf26302fa57..5ed59bf30a25 100644
--- a/drivers/staging/iio/meter/meter.h
+++ b/drivers/staging/iio/meter/meter.h
@@ -348,9 +348,6 @@
 #define IIO_DEV_ATTR_VPERIOD(_mode, _show, _store, _addr)		\
 	IIO_DEVICE_ATTR(vperiod, _mode, _show, _store, _addr)
 
-#define IIO_DEV_ATTR_CH_OFF(_num, _mode, _show, _store, _addr)		\
-	IIO_DEVICE_ATTR(choff_##_num, _mode, _show, _store, _addr)
-
 /* active energy register, AENERGY, is more than half full */
 #define IIO_EVENT_ATTR_AENERGY_HALF_FULL(_evlist, _show, _store, _mask) \
 	IIO_EVENT_ATTR_SH(aenergy_half_full, _evlist, _show, _store, _mask)
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
