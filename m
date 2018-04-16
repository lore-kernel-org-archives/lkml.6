Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2217916-1523852134-2-2981783441568914604
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523852134; b=hIGKK/gA5yoY0fRwTnuZPa+jvcoh4HSNugpWHLndXjnfyveHRC
    imYnuLPpIeKEH+Xmx3k8SPsk1Bx8Y484aJCuFvqCsrJDHweMzmZLPRg5GvbuhoZu
    H97yuQe+2N0VQpl1YFPt2AiV8N/KnG8x3R2+KGb/cOuwFmXz6iklvYzR7W+ULZ2y
    iZiPbUvske/EPxTdF3Kqisel+xi4574CNeYzB2z4xIFgOf+3KKQBQMN6F7o7JPMo
    YlIwqEmfWXCrzea4geTZHCQ4CHHj0yshkwkds8BtWm+JYXTcnYN6LkbNzMQwH9zZ
    riYpiyD2vBqbJI02u1T12Sc9czODhQvCbmaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523852134; bh=nQ0Xd
    5oq+gYergJUONf5xs0igdFVS5hRAvQUhM4AXwE=; b=VTVKaX1jRv2jxFmTxW3JN
    ajXXSBS3c0rqHGcwsko455Je22F0EUWTlnMgJ+VyrMtRWQ8YNOETC/pcuxhiOkA7
    ydLEJSfUgapcu4AY/WvIFTEQW3PdxurraQVUTlV9xAbxRETPpWUPf3ZfD0z9WI0X
    5hi2GoepiStAhl1V9kdfwwyfMunj5HohJUcXzSNHaiba4aAdNjsCY1ibNjlCNrxA
    ciuVVmjG5VK8NQfJOLoPaaeaLzusdIoMtQqa7cGsjVOwG+mVTtyPVhurA0UV+UPM
    QpfH6SjXB8ctv02hoE82/ocPdUZFyOx7HjAPTHtsxGUdNF7oi9bb8YiYYtxeSOsJ
    g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFBRwhxAXM9vnGudM39FtBsccWfctU2txP2caSfAVABuhEE0gkl1FLdCd61lCw76AoitD+Mo1vtRFFW8/gnaghwjRg1WqQEAY/j4nAXvGuMQ7MSB8keZ
    4X7bohzsP/+Fu4Ef/gFO3YqtWGGqlw/IiFf9OT+LytUD2A8+cRaQeH8AmRojnnxnsJPpqLqTa9lajIP3cQURUAxOZ+xIWsP7Q+v5p8baNpW0hzXMUtq/3rHi
    zedpNtIVl8a9Xy6HHWsAIg==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=QyXUC8HyAAAA:8 a=ySfo2T4IAAAA:8
    a=pGLkceISAAAA:8 a=JfrnYn6hAAAA:8 a=DDOyTI_5AAAA:8 a=JhO3BVmsq0lRYHTtuMkA:9
    a=CjuIK1q_8ugA:10 a=ZUkhVnNHqyo2at-WnAgH:22 a=1CNFftbPRP8L7MoqJWF3:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: James Simmons <jsimmons@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 Oleg Drokin <oleg.drokin@intel.com>, NeilBrown <neilb@suse.com>
Subject: [PATCH 08/22] staging: lustre: llite: add simple comment about
 lustre.lov xattrs
Date: Mon, 16 Apr 2018 00:14:57 -0400
Message-Id: <1523852111-17321-9-git-send-email-jsimmons@infradead.org>
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
Cc: Niu Yawei <yawei.niu@intel.com>, Bobi Jam <bobijam.xu@intel.com>,
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

From: Niu Yawei <yawei.niu@intel.com>

Simple comment added to ll_xattr_set.

Signed-off-by: Bobi Jam <bobijam.xu@intel.com>
Signed-off-by: Niu Yawei <yawei.niu@intel.com>
Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-8998
Reviewed-on: https://review.whamcloud.com/24851
Reviewed-by: Andreas Dilger <andreas.dilger@intel.com>
Reviewed-by: Lai Siyao <lai.siyao@intel.com>
Reviewed-by: Jinshan Xiong <jinshan.xiong@gmail.com>
Signed-off-by: James Simmons <jsimmons@infradead.org>
---
 drivers/staging/lustre/lustre/llite/xattr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/lustre/lustre/llite/xattr.c b/drivers/staging/lustre/lustre/llite/xattr.c
index 1b462e4..c1600b9 100644
--- a/drivers/staging/lustre/lustre/llite/xattr.c
+++ b/drivers/staging/lustre/lustre/llite/xattr.c
@@ -264,6 +264,7 @@ static int ll_xattr_set(const struct xattr_handler *handler,
 	CDEBUG(D_VFSTRACE, "VFS Op:inode=" DFID "(%p), xattr %s\n",
 	       PFID(ll_inode2fid(inode)), inode, name);
 
+	/* lustre/trusted.lov.xxx would be passed through xattr API */
 	if (!strcmp(name, "lov")) {
 		int op_type = flags == XATTR_REPLACE ? LPROC_LL_REMOVEXATTR :
 						       LPROC_LL_SETXATTR;
-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
