Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-523714-1520223495-5-13205818152192725232
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520223494; b=OGcHYFpSC4F2b4spKJpt9KQqevgk7Hm4aSALawsf/KLGQ/q
    RwwMUd8UOqQ9Iqw+flHsdB38P3BA2OiFEQGNnKRFBfzyodvycHc7x9RxlmpOzcfV
    sB8hBCnTQGeNAjC0fYpE+iDO7tN6PEKKXlL8ktzAahGYLMKy92ljMNIXVOB0oiyl
    XGg9OJXKPyFSamSeTlm5799upcwYN05KfeewSRJCy/XbTaKpQzdCp0KY7CwY+Pk5
    pY1LQcJcrVR9wA0yMINrfGgjzA67mg+qF2bFggDmL4/CHZpClBz+JXQWG7yPq1rq
    6EhQNeZkP+i9gx04T1SXRSpFi9O56v/lhC9Px+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520223494; bh=/
    ZERtZSsy/iXFNBCPHWE1pgp5ZeWMGVEbK5mqbt30Xo=; b=fAZWsNDKz4lMXHEWE
    HukMizlXpuyTV1NCOs9NQG9F2uyCtrk7iTGHckmtuSDmiWqlZ6YmxAVgE6TLG3Zo
    +uX8q0mXZ1F09NvkK9ohYva4Apj2MA8pZhwkrceF8J2uzo8JbULoeTGiesgl6PYA
    dU4wegAuj/QnB6tA17gGFHEGQ0wby0X5oiD98lSoazjvq83TmT6dXtDmYdOY337J
    c4X0n5G5/Bl4BzYiTLuyPXGqGPgDm+IS+72266oOVvDWws/Dh/kerIZy/0iDd+Go
    IxggmB32s/l7l3zUFwCHUaWwUYi6LjswbfhP2fOZRzT2ns7pDYrXxygOamap8Sl2
    mXguA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=dYsIY1t1 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=sdDce12e;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=dYsIY1t1 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=sdDce12e;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELs5bXGN9+perc30eDytUj+iiN2lnnpBWO4Jy0IRll6rlKQrGzGL02KVUqwfhOoj7tIjU99UFw==
Date: Mon, 5 Mar 2018 09:47:40 +0530
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH v3] staging: ipx: Replace printk() with appropriate
 net_*macro_ratelimited()
Message-ID: <20180305041740.GA23378@seema-Inspiron-15-3567>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: devel@driverdev.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Replace printk having a log level with the appropriate
net_*macro_ratelimited.
It's better to use actual device name as a prefix in error messages.

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
---
changes in v2
*In v1 printk was changed to pr_*macro(), which is used
in kernel instead of calling printk() directly. And for drivers,
dev_*macro() or net_*macro_ratelimited() should be used for calling
printk() directly.

changes in v3
*Indentation is not changed, as line is exceeding 80 characters limit.

 drivers/staging/ipx/af_ipx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/ipx/af_ipx.c b/drivers/staging/ipx/af_ipx.c
index d21a9d1..5ec6591 100644
--- a/drivers/staging/ipx/af_ipx.c
+++ b/drivers/staging/ipx/af_ipx.c
@@ -744,7 +744,7 @@ static void ipxitf_discover_netnum(struct ipx_interface *intrfc,
 			intrfc->if_netnum = cb->ipx_source_net;
 			ipxitf_add_local_route(intrfc);
 		} else {
-			printk(KERN_WARNING "IPX: Network number collision "
+			net_warn_ratelimited("IPX: Network number collision "
 				"%lx\n        %s %s and %s %s\n",
 				(unsigned long) ntohl(cb->ipx_source_net),
 				ipx_device_name(i),
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
