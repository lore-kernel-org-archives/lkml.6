Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1797295-1527158638-2-12865117770721133399
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527158637; b=PU1dgcKipC0KLy2r2avfQM8S4pJkHTlJTaFVPvHxrC8bcKKXwu
    ycV0CKomizVcMAlxpwxW/GZm1+GG/jYkmU5QHpGzfg/ZDNr+H9i7q7Rqep2J05E+
    sQfmmiLq7yrXxYzxmKu1/wy4WoLg2DbF++HD2dldY4J+doqobgSe8tqg2l9L0DeC
    8IfCNFb5V2Mcufwlyh6PHUx+FF1IxDqG0AV4EY1Oy93s6ZruuNZem4LOFVaKtOKh
    xW3B0sQj8/b9ldn9oSl4QlCAwUNB0QABaM2roRgrrGojaaDILaWgxxt2g9+jknUP
    CDKGHGNxBOz70yrAXzBvPB/otHDhQr4VTNoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527158637; bh=k/LgmGRLyScnzi0ssst2w36G/+Cjdt
    6k35NGKATXOJc=; b=HlWOqgO/UcRZhdBtb9Yfj9ZceCnehjGBTmXqy5Rt7jd+tN
    tiVlZlclOqD5t/ZtIEPoCDh3Lph8fZuXs/179PUr4pWR3yhHriuTvs++jwM3MPyp
    TPr/Vgr44IkAIpg+M7jebYVFUnHtBgFPetB5iFllxRGoomkWvzhsFxMf2A37comT
    +ruYvuyR4Xu6E34LxPrkuI/wrW3CyKw8lQRa+j4vg/u2MUqSWr89ssANzkQx2jn5
    3Ec07PyU/VuPwfRSsNjOrvS8KHM1wUFy/qIjIEzZjXmfHf57/IZs0/PErauybN0k
    c/Ft8dzOPKdv6pwTKH2hnSxkQTfqLYfwZkZ2njiw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=IfL9M1zS x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=IfL9M1zS x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLnC68aoJfDpGvD5OgCX15zWbfaWjm+QAOG86auftDBVbDwfeC/pNx+Fo2G3to5yBxdsMuxJwKG7HcDXZtCcPXNF+9dLjRgHd0uEZYpjl39biTjwhZeo
    QsOfw52nL1zrk3UWeI1ZI+qztP9zaeRF3VLTr9uN2oGe0X5/9Ug9MJrPSkux4Y8NMKTQ6KLoZZ12ElDwfYEMI+wHTPs+oEzdLAqZejZC1KZ5iMTjX6PUQxqd
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=pGLkceISAAAA:8 a=Q-fNiiVtAAAA:8 a=iox4zFpeAAAA:8 a=yPCof4ZbAAAA:8
    a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=WIANZK8Gtf-dEdyjr7cA:9 a=QEXdDO2ut3YA:10
    a=Fp8MccfUoT0GBdDC_Lng:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030574AbeEXJ6M (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:58:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:37972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030466AbeEXJ6K (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:58:10 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 120/165] scsi: lpfc: Fix frequency of Release WQE CQEs
Date: Thu, 24 May 2018 11:38:46 +0200
Message-Id: <20180524093626.861650361@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
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

From: James Smart <jsmart2021@gmail.com>

[ Upstream commit 04673e38f56b30cd39b1fa0f386137d818b17781 ]

The driver controls when the hardware sends completions that communicate
consumption of elements from the WQ. This is done by setting a WQEC bit
on a WQE.

The current driver sets it on every Nth WQE posting. However, the driver
isn't clearing the bit if the WQE is reused. Thus, if the queue depth
isn't evenly divisible by N, with enough time, it can be set on every
element, creating a lot of overhead and risking CQ full conditions.

Correct by clearing the bit when not setting it on an Nth element.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <james.smart@broadcom.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/lpfc/lpfc_sli.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -129,6 +129,8 @@ lpfc_sli4_wq_put(struct lpfc_queue *q, u
 	/* set consumption flag every once in a while */
 	if (!((q->host_index + 1) % q->entry_repost))
 		bf_set(wqe_wqec, &wqe->generic.wqe_com, 1);
+	else
+		bf_set(wqe_wqec, &wqe->generic.wqe_com, 0);
 	if (q->phba->sli3_options & LPFC_SLI4_PHWQ_ENABLED)
 		bf_set(wqe_wqid, &wqe->generic.wqe_com, q->queue_id);
 	lpfc_sli_pcimem_bcopy(wqe, temp_wqe, q->entry_size);
