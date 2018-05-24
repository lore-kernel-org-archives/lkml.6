Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1797295-1527159455-2-12432819827815072223
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
    1527159454; b=ClxFUXsuPZwn5oqGjPpvhm9QwLaZIe4ib+9qSeuk2HbcENyLAh
    uk8hmyfUJ5E17SmA49c9qvug9OiCEvxqJ/AixIZtyYiSuJznpfQaB91rcOMnLflv
    S/xHxhvNV3zuA3+fsXSG/bEVu+u7+kE+SXdWQAEh15wxQ5XW7jg5Kjtojh2u9Fpk
    Etl3ZVKAP9uZzZwQ+USw/YL/ke6iOsAHVqyLaNfAUTcnNoXzHdv6OgADUsDbGDR+
    cPDyXJ4p3qpuDuAVoXYLlmjg7ukWI13KpcaYJc1Z4BTBe1VypLY+bEfedljG68f0
    F8xgLgYmP8sAT1yDekAg6q7v3o4CNRdn7P7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527159454; bh=IU20MvH1XxGyB8WR4NUneHSQqJP9+F
    bOj/hiBKDRA0I=; b=ghAw9IdFmiIQLZcPx+a6ASRysklpJBVg0vq9+PoSiL7zF5
    gp5nQwhKmpsaDf8hEZsUQNVzRsW1veVOmVBymPaeeWTqF1BMoQwI5B+Z81CvKB8i
    PpT0GaGaML1cqLy25a5/h2ol84hAzmfrFYM0YTxNb4/h62BTYyW5ejFhq9NKLG7V
    Qah03kB6hDnwHC2AhraaQksRXY2QbS0Y2dNBEvxm5/eDEzgG1QVUdzkRBWBy7JzH
    I1lSdrjL50DkkILBqQULv0DA8cQeVgAtDR/ObcTtVdAmykWHkS5C5ZqN4twvFS32
    rYS7UoItMAQCJ/EjdvLPCP8j1cFayTYhlYuSQytw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=SsJnfVsY x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=SsJnfVsY x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfBiROddH7VZxLflF3YqepPFqt6bVTQJDHc9cSoZC2WjxM5d82u5gWi0yCITVTe8y54dUuqIaXjDGoYHHUTUeD3C/EZPBWO5pnprCAHwK0Cbl9s7yy8Yw
    FgowkpJvC3YpMLho+rf3iH9FVSisMkMoJUBH+BlV8xRJpvTFV5yQ0yM2a+HhBvmVwhBoY2PPQGRLeTt32QAxJahYUG0qFh79D31/RQ5OurEIBrMY6e4OoSTG
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=NCkSHYsgAAAA:8 a=iox4zFpeAAAA:8 a=yPCof4ZbAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=W1PD9-8m0bjWJ-XOqj4A:9 a=QEXdDO2ut3YA:10
    a=AnMw66Xr5OuzjdxB04dI:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030273AbeEXK5U (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:57:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:36158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030270AbeEXJ4O (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:56:14 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Doug Gilbert <dgilbert@interlog.com>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 110/165] scsi: core: return BLK_STS_OK for DID_OK in __scsi_error_from_host_byte()
Date: Thu, 24 May 2018 11:38:36 +0200
Message-Id: <20180524093626.469402002@linuxfoundation.org>
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

From: Hannes Reinecke <hare@suse.de>

[ Upstream commit e39a97353e5378eb46bf01679799c5704d397f32 ]

When converting __scsi_error_from_host_byte() to BLK_STS error codes the
case DID_OK was forgotten, resulting in it always returning an error.

Fixes: 2a842acab109 ("block: introduce new block status code type")
Cc: Doug Gilbert <dgilbert@interlog.com>
Signed-off-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Douglas Gilbert <dgilbert@interlog.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/scsi_lib.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -720,6 +720,8 @@ static blk_status_t __scsi_error_from_ho
 		int result)
 {
 	switch (host_byte(result)) {
+	case DID_OK:
+		return BLK_STS_OK;
 	case DID_TRANSPORT_FAILFAST:
 		return BLK_STS_TRANSPORT;
 	case DID_TARGET_FAILURE:
