Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-212613-1521781717-4-4517149866368657916
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES daen, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521781717; b=PKVOvv0RyMUINc8NV9uUsjYwnzhwYaFKXmE78jaEjX2Tkzd
    e7keGGBqFAwJ3JhNolX22H32y8VPVtZiBNHxFBh7UnN+xf5iOWdq6omaqtivKi+H
    D63U/wefxfQGw74VT4uR5yLw1kIApKTfxdW6kbCwSon2jEn2QwbrvJM+ip8qyq8N
    5Z85LIEu2vGV6sUMbj8bF71z7SBhUFMp2i8C567veH5Jko3wvBZ2s/LKWK0WjhKi
    +Nq+FnUGlGoswJE6Sf3+2f57+BtMGozoLcTLPdlsS5yBJo3kjtcH/Ir3kKSG7Iny
    ddMWkzwfonPIF1CJx4QruTfJrVJC8577eIhXhTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521781717; bh=C
    CVnq7MXKq7Zn8+n+W0h2GsiDbMD50Jz2fKcWBWEi5s=; b=JgqwQh/GMdVHJYMUc
    POJH3+8+3yc9qeC8BjPGANHG8XE7nAl7ws//aa/q0llwfGxCYP5GYY/deQsBYRl5
    d0UonJYDYXV6LzpwXQq5BbvWol6lOlV166ecth9YUqVSKuMJmgH8bHItYe3NjhaF
    TdJZPe/UVfevGpUVvOg08/O/vZbyZCPhnAw7E2eJdbz6FPspYe83Tmrpr4tEkjvK
    zVq8G4IwfohLloWcF2/IbyRKNkfTJ2tuhP4OWTDy6RJCjSHqmRXRlEYya4hPXkK5
    Ui19PWWXLJ/6DgaSy+4M7w1T/3WSfiwyeWNJWSj1WgT2CvofRAWCq3TkXmP7aHE5
    L/hrA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH 1/7] staging: ks7010: Fix line over 80 characters.
Date: Thu, 22 Mar 2018 22:07:39 -0700
Message-Id: <20180323050745.28903-1-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180322172014.GA6801@kroah.com>
References: <20180322172014.GA6801@kroah.com>
X-Provags-ID: V03:K0:IUHT0SblspCvhBER43vZobQxfPTykIUsq2kRcDU7Rasozl4mCEC
 JqBpsws5giwgsCULmf5nbHvngcPgV/V17bvWj5Uk6MF+KvFx9kUGXWT5gwaG1gOm+ULo4wv
 b+kuv6QUiKdhDTdZ8haWy6+dQ6ed2BF9tggLe6IzLlajkaq1fcM33Onr9yvfLhzueWzvMcW
 W6OTzJGZhi5t5t7p0vNGg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gR22Q0bMXRI=:+6BF7JH823TRWRnd86BnPD
 UHcuq4PCCeLnbUi/L6E2tt2qXC//kC0a2QVwga+A5q7W+W0o2lGAuUOLncBLAfOSc/KUFS/1f
 mlXeKCBIAouaJc4d97nNztPpiQj483vytpIHeqbQu5lGOJsM+8QIh0ejlfEaz9el/eu+gC7TV
 PaOIbvs+0Nsh/wCEfNbj2qRDgyaKNQk07aQdPv9D0+PcIUsKYRZdwPk6ckyR+/yPlLa0XcYvp
 WPxSmIxZ5z/9deXfSc0IP/IS6KjIdcLUbntyBPGP0GGngBF4P1ZOGZDLcG+38l8p697tP1sNC
 knf+vNPQWkDQGRenzxoh8PeO1VQ0SCs03SGNwC1VWjpxHVP1iNTKh3aAnF13hgzKBeVCCZg1S
 ILih2Zlpf6tHTjd/rjAKhbUld88HtmPjby5DTsahYnQBYTNwrE2q31sCHB1ddecDQwGjRWe5O
 0Oc9cbQjwa1hebB9YsBbcRVA00pRK5cnJFQMnPFwqQLc7G6QgRtv62Lb9LapObKhw1Q1C9aZ4
 +CN4pPP0Yqf+DVxmavhrmvjZcJ0a6HOM6yT7of7+ka+VSJvHE6fj59ffIluHds4fKppjg+all
 PtnJKoHCgZmIdYdgQKvu9ntkLAD6lZcnuNmJa5W3UDXYgR4HXMXVrsQrP+NUQh+CQKIwC9Cp8
 qDkYvO8UjmJJEhr6PeH4j9UVKJ4Wg+EQyQBjaIJriIEbaSwu8EkKsJuMdy4Z79VnRU8qHF2XU
 o7qj/gk9JJC0RiFCZkiUnAKUcF+NXj0hggBodg==
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
Cc: devel@driverdev.osuosl.org, driverdev-devel@linuxdriverproject.org,
 linux-kernel@vger.kernel.org, Quytelda Kahja <quytelda@tamalin.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

There is no reason for comment describing the BSSID check for loop
to be spaced so far to the right.  Move it above the for loop.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 3ef9126ab810..534cca95bfb9 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -777,7 +777,8 @@ void hostif_scan_indication(struct ks_wlan_private *priv)
 	ap_info = (struct ap_info_t *)(priv->rxp);
 
 	if (priv->scan_ind_count) {
-		for (i = 0; i < priv->aplist.size; i++) {	/* bssid check */
+		/* bssid check */
+		for (i = 0; i < priv->aplist.size; i++) {
 			if (memcmp(ap_info->bssid,
 				   priv->aplist.ap[i].bssid, ETH_ALEN) != 0)
 				continue;
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
