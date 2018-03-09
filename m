Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1715849-1520639162-2-7535225774941257720
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520639162; b=Iq4sWrukU5jmZkSyxH/tMrx1AGDhrC8xibExiBxe2Wy+c6/
    BGkHj1qWhzCSfK2gKesv+8RmdsAHIWljnAW55sFD+8GxJRbI7ygngL4B9EPrdEas
    2f6Q71XRbSW4FyyhfhZ1H/ZPWv9eEci9pUIcQEH0k0Cub+PwIkZkWANa+/7BcIvS
    gsAPz9ARkLvIs6YbC8abWhS9ELyi6KVoO1YSyVksNSgW6Hu2FxmiWxemNfOJ4ybL
    IfL6usuZQmF+Qlhf4TuJZ2lwO2+dYj42fH+eCZ0ADCKGt4d9gr5Ws9Pd6NJ+jnUY
    exkI5z/0U5nHrazk8Mzd3fpz2OioxMAihWCApKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520639162; bh=j
    zo3XF/B74rB0jLn20QGSl50hS51ugDb3hfJRs7ziqc=; b=F1WxGqEzSEaxmd7O4
    Xms7P7FCPGEzxcjQcNBiODlZtenr8qYq0E+kJ+pfYTdhwwwqVXdfS7ldAahSyRhN
    isHEGAEnruu97ubST7fxMHvQOQYZKJclARZj5aOQkQJzwwB6710fegmluwxYi32s
    Czn/bwGcViE+6rMfREiuenyOJlFrb6phpnt6PZanopKOchVyHMRLdC56ljlF84ee
    YmyLYyt7TLcNhvjq3kzmEpmUU4oNmy/aid8CVBxVnsSpo8vKlujOQF6Ga5UAedUY
    Cd/A/IZrxVIC952HNbgfZEIqk/MlD+vqoSGit5zrWjL34CM67MsBorJvCW9u0Ws9
    6Z5Ug==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=YxzElS3b x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=AAFtMPQO;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=YxzElS3b x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=AAFtMPQO;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELs4AQG1hx6l7A2tDCVZnNm186Ub8HLHKgcf82L0MdmuTVMbKbTSkZdxI13FAnFPurgcBmRsvA==
Date: Fri, 9 Mar 2018 20:45:50 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Graff Yang <graff.yang@gmail.com>
Subject: [PATCH 1/4] staging:iio:ad2s1210: Remove end of line with '['
Message-ID: <b87fdd8b09ebee3fd29a8b65257e37eff7d8532b.1520638889.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1520638889.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1520638889.git.rodrigosiqueiramelo@gmail.com>
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

This patch fixes the checkpatch.pl check:

iio/resolver/ad2s1210.c:202: CHECK: Lines should not end with a '['

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/staging/iio/resolver/ad2s1210.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index f8baab061eba..0cdcd71e285b 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -165,9 +165,10 @@ int ad2s1210_update_frequency_control_word(struct ad2s1210_state *st)
 
 static unsigned char ad2s1210_read_resolution_pin(struct ad2s1210_state *st)
 {
-	return ad2s1210_resolution_value[
-		(gpio_get_value(st->pdata->res[0]) << 1) |
-		gpio_get_value(st->pdata->res[1])];
+	int resolution = (gpio_get_value(st->pdata->res[0]) << 1) |
+			  gpio_get_value(st->pdata->res[1]);
+
+	return ad2s1210_resolution_value[resolution];
 }
 
 static const int ad2s1210_res_pins[4][2] = {
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
