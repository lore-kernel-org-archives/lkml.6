Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3253174-1523477784-2-13344382402322732222
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES endasv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523477784; b=tgS0+7aDXN9t5C7VyUoUgbRCjfjvZFBmVLGaZCQVlR3Rj11HEN
    ui9b/VsNr9fmyLYJHroJFOwRjkCGMobk/Hv5h+Bh51eemMVIynE5TUh4axyOn1N5
    +u1apfK3jGSiULanlkpNasFvNDD8xfaZyzsTfHEvi2jNjy2UcxSgMhhXhOAgKprk
    tkU9BGe8fsJ8Coj7zYEVE7GpyGeGz6w9UXo1NYiqXr9ppyCkniB4JikCPEOigLFS
    awtETa00byGRbW+VMc2Zuanx53iDQ6QtdrUk89NhH1JFYFJmT0hZMM/2LjsX3aOu
    ZWXc7G0Zy4z8REE2wsVuB4BnHd5EfZ4IRJ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523477784; bh=RoCQvQ5KhxrUGsOV7hLWHKNXmSah3T
    rfaBoBowvf13Q=; b=MXrnDY2P6jgu/g+BPEp0Yx0OBVUzIWOlE/RvCcnlEEk1A9
    YCPmuKVFGuYOsZAVFP6KKI5LnK4cfrT7txrmMuKEfJzbBqf7PK7ucAlLb/0Mbc0A
    o9uYDofM9FL8dDYl/r4hlFRVCcBb2xD8dpC5WRBDe5hHPYx+4a9/1WXNp+taNAjY
    oOBq6w08UPy9sjsNpbf5s2VfI2jO6Bom/OBWPsK3gZefWI9ZGkLAHvzDBbpgDj/D
    DTtnKdlblKE5AOCLvct+5fdTq0tBsUyMW8w4Ukf2TjR/BIl9YdjwNKHsxksdu7gO
    +ssT8cZfwKq3HchDpRZ4WGpKN1bBZH1xwCFl6lRg==
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
X-CM-Envelope: MS4wfCBTUgxu558YXBbl/iRdV/toEalg+w+zszMvl05ZEG8xqyEhCIs+NC3zO1m9xdUqr7NjEHs3S7n68iDBGW5tM9S3s/Gau4ZaUP5tPZ6J4WwWYuJr5tQB
    VkHzmFV/xQUG+NNSbr2ScS5Wj+MfaGAbuj+pqhDLwFrO8u8QUmAjkQ0JSlbBS8yPT7j7JIUe2zPZqLMdcseCZEu/mwNXQdWGBB2zkzrqqm94dWJowZLzVkIU
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=cm27Pg_UAAAA:8 a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=EosJnc-uYw2q1s0pUq4A:9 a=QEXdDO2ut3YA:10
    a=xmb-EsYY8bH0VWELuYED:22 a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933187AbeDKSxB (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:53:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33590 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933172AbeDKSw6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:52:58 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Micay <danielmicay@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 015/310] qlge: Avoid reading past end of buffer
Date: Wed, 11 Apr 2018 20:32:34 +0200
Message-Id: <20180411183622.956960719@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>


[ Upstream commit df5303a8aa9a0a6934f4cea7427f1edf771f21c2 ]

Using memcpy() from a string that is shorter than the length copied means
the destination buffer is being filled with arbitrary data from the kernel
rodata segment. Instead, use strncpy() which will fill the trailing bytes
with zeros.

This was found with the future CONFIG_FORTIFY_SOURCE feature.

Cc: Daniel Micay <danielmicay@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qlogic/qlge/qlge_dbg.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/qlogic/qlge/qlge_dbg.c
+++ b/drivers/net/ethernet/qlogic/qlge/qlge_dbg.c
@@ -765,7 +765,7 @@ int ql_core_dump(struct ql_adapter *qdev
 		sizeof(struct mpi_coredump_global_header);
 	mpi_coredump->mpi_global_header.imageSize =
 		sizeof(struct ql_mpi_coredump);
-	memcpy(mpi_coredump->mpi_global_header.idString, "MPI Coredump",
+	strncpy(mpi_coredump->mpi_global_header.idString, "MPI Coredump",
 		sizeof(mpi_coredump->mpi_global_header.idString));
 
 	/* Get generic NIC reg dump */
@@ -1255,7 +1255,7 @@ static void ql_gen_reg_dump(struct ql_ad
 		sizeof(struct mpi_coredump_global_header);
 	mpi_coredump->mpi_global_header.imageSize =
 		sizeof(struct ql_reg_dump);
-	memcpy(mpi_coredump->mpi_global_header.idString, "MPI Coredump",
+	strncpy(mpi_coredump->mpi_global_header.idString, "MPI Coredump",
 		sizeof(mpi_coredump->mpi_global_header.idString));
 
 
