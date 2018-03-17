Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1090440-1521278161-2-13715738138293963676
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES ensk.us-asciiro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521278160; b=PN7Xp2Z0Gr98+A9pSa20GHpDPjaVR2X86UfPJ5pf0PDjaE1
    iLDEbtaj83SlKNMy9ZAlrtsgcmbezgEiXWBuj4QpjPe7G4cjDBeVrIXH+1sFGCI/
    m7kO/BCNekPsCzIcienU6tKFcy9tqFMvYl1WZ64klH7ZL2XNFaC9sFNg2UOCpIwk
    4bIlF5+NC1+cX7iPuKxSiFYSGykp/DJQsXSCPXeMme4d/Fq6qhLhioCk+CiaSYfc
    nlYM+Yf1M4rbQQKX0BkuNl+l3LdFXkU2u1b5H4t9n20XmsKIbMisd4ek/u0EuoVh
    WcxUcJWoC8m55FUgX7KkRA3Yhc4ZGJ6rODh9N7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521278160; bh=x
    fewiN065KPn/aKlF7NO4ZAT/WMc94O0Q0UwqbY5W54=; b=UgzbkXACm38i+W2O9
    M1fAVhX9ibiQPNQXHuzVF/UG+h2I5YBJNLtFMy+b3dxKEehfRYmgIxRZNAW5BLZF
    lNNvwDZ10xdUKJkL2uE92dkLgoo6Mu8tWDdKkkI+nDuii1P0H4AcspNDJFWsd6rh
    yc1l9HZgJ6UjQ+7zjuDEl1MMdcyUwcLqxWqvQ8r9ZIwwm2z/zUCxdNkeGvUs3BAj
    6d1x9kd3+sYfac7eGM7eLVf4TpH9tWn3FFJEXKi2yJX08FxeZzy14wSkWJoXMQDD
    MKJqDb6ojfhHpSmSrnh7WT9eDMlcERXFq+F05sqqf2Hh3RXhmSlnNDkteJOes0Fd
    U8H8g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=uayuXIcb x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=cBs2PLgi;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=uayuXIcb x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=cBs2PLgi;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELsHtTt/k4/G8vTITMH/PgkfbOPLQ/dfxN8bRccsIbIgPTvXEqB+f69+4/0p0zNALgfSvW3FGA==
Date: Sat, 17 Mar 2018 09:15:41 +0000
From: Justin Skists <j.skists@gmail.com>
To: devel@driverdev.osuosl.org
Subject: [PATCH] staging: lustre: Fix unneeded byte-ordering cast
Message-ID: <20180317091530.GA18271@tanglefoot>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Patrick Farrell <paf@cray.com>, NeilBrown <neilb@suse.com>,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fix sparse warning:

  CHECK   drivers/staging//lustre/lnet/lnet/acceptor.c
drivers/staging//lustre/lnet/lnet/acceptor.c:243:30: warning: cast to
restricted __le32

LNET_PROTO_TCP_MAGIC, as a define, is already CPU byte-ordered when
compared to 'magic', so no need for a cast.

Signed-off-by: Justin Skists <j.skists@gmail.com>
---
 drivers/staging/lustre/lnet/lnet/acceptor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/lustre/lnet/lnet/acceptor.c b/drivers/staging/lustre/lnet/lnet/acceptor.c
index fb478e20e204..13e981781b9a 100644
--- a/drivers/staging/lustre/lnet/lnet/acceptor.c
+++ b/drivers/staging/lustre/lnet/lnet/acceptor.c
@@ -240,7 +240,7 @@ lnet_accept(struct socket *sock, __u32 magic)
 			return -EPROTO;
 		}
 
-		if (magic == le32_to_cpu(LNET_PROTO_TCP_MAGIC))
+		if (magic == LNET_PROTO_TCP_MAGIC)
 			str = "'old' socknal/tcpnal";
 		else
 			str = "unrecognised";
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
