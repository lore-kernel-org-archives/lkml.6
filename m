Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2210789-1523852147-2-3144170636751240712
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523852146; b=bEZBFWBLMo32i3gXCMM1rB7h8R8Af/wD8xq0I3u4O3hjkktlnR
    Wsm8izQAAPFyzKne+m5q3C7f9HnuhUnUj89aq7WpbdvCm2DL4bRU8bUU+IKBv+CG
    yjef1k6Qde0QsHLvVwXkI/WCoZNC4TiUgGaYgAaIxA5lKUzK7vsNIVG5rvkDxkE0
    0+6obtEwpeNj/gyte46CE6Qes/GJmVLU2OS3c9lrxFfrGfChVNV4xTg1xSYPPqyS
    WTDGQ0dE0gHkXVCYO2VhHnvF4yDXrOIMUYT5OyVF+7WuoToOquubRpdkMXMEfZRU
    HfMv+8bT/2kv8PseFdL+swnicwLjpTu9JEOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523852146; bh=575sV
    raK5CY7JfYf48kTmQGlE8O6d7l6iousR9AorUs=; b=QFblUL4IGrgUVLY6p/P8p
    zS09XpIj/O3qg3m9/FUFExKrOfsY/O8Ix1MWlkcbaOr8aeJa1TZDih+8U5FXjZc1
    TqhqjfOyT/KzjhO580m3/c5xCosI6UtaVoqwHhsFMJI6okIkcS8Rtiyiv2qu9CDa
    5QmeICvm0ix6bpKXhOLaUAG52Ut6QcGWpcz/HFg37tV+x783TcuFi00/M5Yojd0A
    o4wsp3v+64BbBG38Zl/57el6PnJC0R4INOsUyAI+NbtcrIhJLMOBKr1rmwTTSk0Z
    dOD/Rnzev+1eQ43LgmPwd7IoXfLIzLHS2VYB7ElPuIW5acsmmJ6ZyunEVjdxxbWH
    g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIADMaYj+E1f3hBWtnyRNgOse12ySt3DllSdVkR5Dctg1XixFBESkzZLx/cg+7MfHcyYleyG9+h7s4GZCpxsu0n5djCskaE/iSoZr1LOZwKIA1jfsjoL
    wxQhaE46CQr2hAOAJnVgYbuVspQHw4PpjgJUNyXvh8O49KPgEeK5yQOc3uc3gGqsZj/XEpbKvp1jNp8b7TRbTwhvFOsnWl0dx5VDvUBBsksnGtq+dB90AlCd
    w/8o2g87TJTZM+HkZkzcZg==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=QyXUC8HyAAAA:8 a=ySfo2T4IAAAA:8
    a=CjxXgO3LAAAA:8 a=JfrnYn6hAAAA:8 a=DDOyTI_5AAAA:8 a=oi7UH26-gwVt6PgjNQsA:9
    a=CjuIK1q_8ugA:10 a=ZUkhVnNHqyo2at-WnAgH:22 a=1CNFftbPRP8L7MoqJWF3:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: James Simmons <jsimmons@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 Oleg Drokin <oleg.drokin@intel.com>, NeilBrown <neilb@suse.com>
Subject: [PATCH 21/22] staging: lustre: llite: correct removexattr detection
Date: Mon, 16 Apr 2018 00:15:10 -0400
Message-Id: <1523852111-17321-22-git-send-email-jsimmons@infradead.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1523852111-17321-1-git-send-email-jsimmons@infradead.org>
References: <1523852111-17321-1-git-send-email-jsimmons@infradead.org>
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
Cc: "John L. Hammond" <john.hammond@intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In ll_xattr_set_common() detect the removexattr() case correctly by
testing for a NULL value as well as XATTR_REPLACE.

Signed-off-by: John L. Hammond <john.hammond@intel.com>
Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-10787
Reviewed-on: https://review.whamcloud.com/
Reviewed-by: Dmitry Eremin <dmitry.eremin@intel.com>
Reviewed-by: James Simmons <uja.ornl@yahoo.com>
Signed-off-by: James Simmons <jsimmons@infradead.org>
---
 drivers/staging/lustre/lustre/llite/xattr.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/lustre/lustre/llite/xattr.c b/drivers/staging/lustre/lustre/llite/xattr.c
index e835c8e..1a597a6 100644
--- a/drivers/staging/lustre/lustre/llite/xattr.c
+++ b/drivers/staging/lustre/lustre/llite/xattr.c
@@ -94,7 +94,11 @@ static int ll_xattr_set_common(const struct xattr_handler *handler,
 	u64 valid;
 	int rc;
 
-	if (flags == XATTR_REPLACE) {
+	/* When setxattr() is called with a size of 0 the value is
+	 * unconditionally replaced by "". When removexattr() is
+	 * called we get a NULL value and XATTR_REPLACE for flags.
+	 */
+	if (!value && flags == XATTR_REPLACE) {
 		ll_stats_ops_tally(ll_i2sbi(inode), LPROC_LL_REMOVEXATTR, 1);
 		valid = OBD_MD_FLXATTRRM;
 	} else {
-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
