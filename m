Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-807177-1523400291-3-17297602250543696559
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523400290; b=wP2A22FPRxU2XiDSZz8Jff5XXSQuPJxggctM3M8UtuvczyUi+X
    PyJQ45+zmZ/ZHGID8lWYhDt14BK+CPHgcEWIpUUYFkKACxiKNZ7bi15T2DZd7FTg
    qy+QtgUpHmo1mMaIGQ2fmlYOeUI5JivytgHsUcDL9aNIeOM+OUqr1IIFeO8rQnGm
    Hk1A0UGoTBxhhlk3rRn7PYwSi6JB2f/yLSI4DUyrRkd7rQ59q0GAjDw4IaRrIcvW
    e+2+EP3prpaOHeBo9f6seFaIHTLMpztPFftbIDUiHm07d0NVt0/JsetTAmfbUzS1
    hgiWWSdb1J4B4tYXq+ZM0SqnGeuFLaOIa8vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523400290; bh=DtaLSEhJn8UQT+IuEyVWlR5Se7Eku7
    rThDm+OYF3NwE=; b=JtgQlP8JzPSugF9i8AO8nao2uaGB2K65+YjBoI9vjcG0VS
    GhVgXZYIvJbrUVV0zxBT4fnh3304fDKsxKS9gJmQCR/jXP3s6kAWpONUoxP++CZ6
    EjG/oUEu5xisycO2RGXjCRw7rhK4j7aNES0o0rEy0LXIf83IYisCy83lqqN2Ace0
    y2FgRDRY6V73K8UnDo/481hwFnYQXp09qIf4oz7TvVKe+NP01A4kuwNOuU9CCT43
    urlrXUfyz72yPG8+zePB8qneAHoXmtpgirKgSQLKJbcs7c190ZSsxFTwHTkW3PuP
    lSChKZiephcAI+81uwCSAcGg03ZuphORulE5TGVQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEOq4izcmO9+AdHcZUX7UtQjH+pGZDT5r8WZZti4qbOIHt76rHS8s7Vl+QQzkJy6BMXcGB+3bxLmiV3Riw3Csa4wwnZBtDo6JEfid21SGLwX8KKk2B6i
    luxJkyBLL8FtcWwaf0uSNOXfrKz6r80f5ARPQPSEXuTvGAtmF6lSHRE9rNdL+3O/hF6nBIslwxK53w/9+saHFfxYwVsQxrA1ASWT7rxs1f7uz3M04ZYHbQsL
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=LD2kUS3hAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=4SiPEF0nf0Au0LVNftYA:9
    a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=RMwhbzCppy37cwDk:21 a=n2JqHAWrMti0Flh7:21
    a=QEXdDO2ut3YA:10 a=FTB9xuwByZgvWSGbqjUc:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932578AbeDJWjU (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 18:39:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45188 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932556AbeDJWjT (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Apr 2018 18:39:19 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 125/138] nfp: use full 40 bits of the NSP buffer address
Date: Wed, 11 Apr 2018 00:25:15 +0200
Message-Id: <20180410212916.718222404@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dirk van der Merwe <dirk.vandermerwe@netronome.com>


[ Upstream commit 1489bbd10e16079ce30a53d3c22a431fd47af791 ]

The NSP default buffer is a piece of NFP memory where additional
command data can be placed.  Its format has been copied from
host buffer, but the PCIe selection bits do not make sense in
this case.  If those get masked out from a NFP address - writes
to random place in the chip memory may be issued and crash the
device.

Even in the general NSP buffer case, it doesn't make sense to have the
PCIe selection bits there anymore. These are unused at the moment, and
when it becomes necessary, the PCIe selection bits should rather be
moved to another register to utilise more bits for the buffer address.

This has never been an issue because the buffer used to be
allocated in memory with less-than-38-bit-long address but that
is about to change.

Fixes: 1a64821c6af7 ("nfp: add support for service processor access")
Signed-off-by: Dirk van der Merwe <dirk.vandermerwe@netronome.com>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.c
+++ b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.c
@@ -68,10 +68,11 @@
 /* CPP address to retrieve the data from */
 #define NSP_BUFFER		0x10
 #define   NSP_BUFFER_CPP	GENMASK_ULL(63, 40)
-#define   NSP_BUFFER_PCIE	GENMASK_ULL(39, 38)
-#define   NSP_BUFFER_ADDRESS	GENMASK_ULL(37, 0)
+#define   NSP_BUFFER_ADDRESS	GENMASK_ULL(39, 0)
 
 #define NSP_DFLT_BUFFER		0x18
+#define   NSP_DFLT_BUFFER_CPP	GENMASK_ULL(63, 40)
+#define   NSP_DFLT_BUFFER_ADDRESS	GENMASK_ULL(39, 0)
 
 #define NSP_DFLT_BUFFER_CONFIG	0x20
 #define   NSP_DFLT_BUFFER_SIZE_MB	GENMASK_ULL(7, 0)
@@ -412,8 +413,8 @@ static int nfp_nsp_command_buf(struct nf
 	if (err < 0)
 		return err;
 
-	cpp_id = FIELD_GET(NSP_BUFFER_CPP, reg) << 8;
-	cpp_buf = FIELD_GET(NSP_BUFFER_ADDRESS, reg);
+	cpp_id = FIELD_GET(NSP_DFLT_BUFFER_CPP, reg) << 8;
+	cpp_buf = FIELD_GET(NSP_DFLT_BUFFER_ADDRESS, reg);
 
 	if (in_buf && in_size) {
 		err = nfp_cpp_write(cpp, cpp_id, cpp_buf, in_buf, in_size);
